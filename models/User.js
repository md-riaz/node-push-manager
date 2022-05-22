const db = require('../config/database');
const crypto = require('crypto');
const { getTimeStamp } = require('../utils/utils');

class User {
   static async getUser(email) {
      let sql = `SELECT * FROM user WHERE email = '${email}'`;

      let [rows] = await db.execute(sql);

      return rows[0] || null;
   }

   static async startSession(userid, ip) {
      const sessionId = crypto.randomBytes(32).toString('hex');
      const DateTime = getTimeStamp();
      let sql = `INSERT INTO token (uid, type, value, ip_address, updated_at, created_at) VALUES ('${userid}', 'Portal', '${sessionId}', '${ip}', '${DateTime}', '${DateTime}')`;

      await db.execute(sql);

      return sessionId;
   }

   static async getWebsites(userid) {
      let sql = `SELECT domain, created_at FROM website WHERE user_id = ${userid}`;

      let [rows] = await db.execute(sql);

      return rows || null;
   }

   static async addWebsite(userid, domain) {
      let sql = `INSERT INTO website (user_id, domain, created_at) VALUES ('${userid}', '${domain}', '${getTimeStamp()}')`;

      await db.execute(sql);

      return true;
   }
}

module.exports = User;
