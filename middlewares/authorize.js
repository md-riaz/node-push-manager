const HttpError = require('../utils/http-error');
const { getTimeStamp } = require('../utils/utils');
const db = require('../config/database');

class Authorization {
   static userid;
   static userGroupIds;

   static async checkPermission(req, res, next) {
      const request = req.originalUrl;

      const permission = await db
         .query(`SELECT * FROM permission WHERE api_path = '${request}'`)
         .then((r) => r.fetchArray());

      if (permission) {
         // check authorization
         const authorized = await Authorization.checkAuthorization(req);

         if (!authorized) {
            return next(new HttpError('Authorization required', 401));
         }

         // check permission
         const group_ids = Authorization.userGroupIds.map((g) => g.group_id).join(',');

         const check_permission = await db
            .query(
               `SELECT * FROM acl WHERE permission_id = ${permission.id} AND (group_id IN (${group_ids}) OR user_id = ${Authorization.userid})`
            )
            .then((r) => r.numRows());

         // if not permission
         if (!check_permission) {
            return next(new HttpError('Unauthorized access', 403));
         }
      }

      // permission granted
      return next();
   }

   // check permission and add necessary data to req
   static async checkAuthorization(req) {
      const tokenBearer = req.get('Authorization');

      if (!tokenBearer) {
         return false;
      }

      const token = tokenBearer.split(' ')[1];

      if (!token) {
         return false;
      }

      const timeOut = getTimeStamp(new Date(new Date().getTime() - 30 * 60 * 1000)); // 30 minutes in the past

      try {
         let sql = `SELECT s.id AS session_id, u.id AS uid FROM user AS u JOIN token As s ON s.uid=u.id WHERE s.value = '${token}' AND (s.created_at > '${timeOut}' OR s.updated_at > '${timeOut}') AND type ='Portal' ORDER BY session_id DESC LIMIT 1`;

         const session = await db.query(sql).then((r) => r.fetchArray());

         if (!session) {
            return false;
         }

         // update session time
         await db.query(
            `UPDATE token SET updated_at = '${getTimeStamp()}' WHERE id = ${session.session_id} AND type = 'Portal'`
         );

         const user_group = await db
            .query(`SELECT group_id FROM user_group_relation WHERE user_id = ${session.uid} ORDER BY group_id`)
            .then((r) => r.fetchAll());

         this.userGroupIds = user_group;
         this.userid = session.uid;

         // adding user id to request
         req.uid = session.uid;
         return true;
      } catch (err) {
         console.log(err);
         return false;
      }
   }
}

module.exports = Authorization;
