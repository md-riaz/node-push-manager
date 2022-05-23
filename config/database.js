const mysql = require('mysql2');
require('dotenv').config();

class Database {
   mysqlPool;
   results;

   constructor() {
      const pool = mysql.createPool({
         host: process.env.DB_HOST,
         user: process.env.DB_USER,
         password: process.env.DB_PASSWORD,
         database: process.env.DB_NAME,
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
}

module.exports = new Database();
