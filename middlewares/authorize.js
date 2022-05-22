const HttpError = require('../utils/http-error');
const { getTimeStamp } = require('../utils/utils');
const db = require('../config/database');

exports.authorized = async (req, res, next) => {
   const tokenBearer = req.get('Authorization');

   if (!tokenBearer) {
      return next(new HttpError('Authorization required', 405));
   }

   const token = tokenBearer.split(' ')[1];

   if (!token) {
      return next(new HttpError('Authorization required', 405));
   }

   const timeOut = getTimeStamp(new Date(new Date().getTime() - 30 * 60 * 1000)); // 30 minutes in the past
   // console.log(JSON.stringify(req.headers));
   try {
      let sql = `SELECT s.id AS session_id, u.id AS uid FROM user AS u JOIN token As s ON s.uid=u.id WHERE s.value = '${token}' AND (s.created_at > '${timeOut}' OR s.updated_at > '${timeOut}') AND type ='Portal' ORDER BY session_id DESC LIMIT 1`;

      let [rows] = await db.execute(sql);

      const session = rows[0];

      if (!session) {
        return next(new HttpError('Authorization required', 405));
      }

      // update session time
       await db.execute(`UPDATE token SET updated_at = '${getTimeStamp()}' WHERE id = ${session.session_id} AND type = 'Portal'`);

       // adding user id to request
       req.uid = session.uid;
   } catch (err) {

      return next(new HttpError('Could not authorize', 401));
   }

   next();
};
