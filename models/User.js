const db = require('../config/database');
const crypto = require('crypto');
const { getTimeStamp } = require('../utils/utils');

class User {
   static async getUser(email) {
      return db.query(`SELECT * FROM user WHERE email = '${email}'`).then((r) => r.fetchArray());
   }

   static async getUsers() {
      return db.query(`SELECT * FROM user`).then((r) => r.fetchAll());
   }

   static async getRolesRelation() {
      return db
         .query(
            `SELECT ugr.*, g.name AS group_name FROM user_group_relation AS ugr JOIN user_group AS g ON ugr.group_id = g.id`
         )
         .then((r) => r.fetchAll());
   }

   static async startSession(userid, ip) {
      const sessionId = crypto.randomBytes(32).toString('hex');
      const DateTime = getTimeStamp();
      let sql = `INSERT INTO token (uid, type, value, ip_address, updated_at, created_at) VALUES ('${userid}', 'Portal', '${sessionId}', '${ip}', '${DateTime}', '${DateTime}')`;

      await db.query(sql);

      return sessionId;
   }

   static async getApps(userid) {
      return db.query(`SELECT name, created_at FROM app WHERE user_id = ${userid}`).then((r) => r.fetchAll());
   }

   static async addApp(userid, name) {
      let sql = `INSERT INTO app (user_id, name, created_at) VALUES ('${userid}', '${name}', '${getTimeStamp()}')`;

      await db.query(sql);

      return true;
   }

   static async getRoles() {
      return db
         .query(
            `SELECT g.*, (SELECT COUNT(user_id) FROM user_group_relation WHERE group_id = g.id) AS total FROM user_group AS g;`
         )
         .then((r) => r.fetchAll());
   }
}

module.exports = User;
