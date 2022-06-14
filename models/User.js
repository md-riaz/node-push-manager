const db = require('../config/database');
const crypto = require('crypto');
const { getTimeStamp } = require('../utils/utils');

class User {
   static async getUser(email) {
      return db
         .query(
            `SELECT u.*, (SELECT GROUP_CONCAT(g.name) FROM user_group_relation AS r JOIN user_group AS g ON g.id = r.group_id WHERE r.user_id = u.id) AS group_name FROM user AS u WHERE u.email = '${email}'`
         )
         .then((r) => r.fetchArray());
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
      return db.query(`SELECT id, name, created_at FROM app WHERE user_id = ${userid}`).then((r) => r.fetchAll());
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

   static async createUser(name, phone, email, password) {
      const connection = await db.mysqlPool.getConnection();

      await connection.execute('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
      await connection.beginTransaction();

      try {
         let sql = `INSERT INTO user (name, phone, email, password, created_at) VALUES ('${name}', '${phone}', '${email}', '${password}', '${getTimeStamp()}')`;

         const [result] = await connection.execute(sql);

         const userid = result.insertId;

         await connection.execute('INSERT INTO user_group_relation (user_id, group_id) VALUES(?, ?)', [userid, '2']);

         await connection.commit();

         return userid;
      } catch (error) {
         await connection.rollback();
         throw error;
      }
   }
}

module.exports = User;
