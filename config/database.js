const mysql = require('mysql2');
require('dotenv').config();

class Database {
   mysqlPool;
   results;

   constructor() {
      const pool = mysql.createPool({
         host: process.env.MYSQL_ADDON_HOST,
         port: process.env.MYSQL_ADDON_PORT,
         user: process.env.MYSQL_ADDON_USER,
         password: process.env.MYSQL_ADDON_PASSWORD,
         database: process.env.MYSQL_ADDON_DB,
         dateStrings: true,
      });

      this.mysqlPool = pool.promise();
   }

   async query(sql, args = []) {
      [this.results] = await this.mysqlPool.query(sql, args);
      return this;
   }

   fetchArray() {
      return this.results[0] || null;
   }

   fetchAll() {
      return this.results || null;
   }

   numRows() {
      return this.results.length;
   }

   affectedRows() {
      return this.results.affectedRows;
   }

   insertId() {
      return this.results.insertId;
   }
}

module.exports = new Database();
