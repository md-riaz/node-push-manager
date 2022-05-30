const fs = require('fs');
const db = require('../config/database');

class System {
   static getApiList() {
      const rawdata = fs.readFileSync('routes/routeList.json');
      return JSON.parse(rawdata);
   }

   static getDBApiList() {
      return db.query(`SELECT * FROM permission`).then((r) => r.fetchAll());
   }

   static getDBApiPermissions() {
      return db
         .query(
            `SELECT a.permission_id, a.group_id, g.name AS group_name FROM acl AS a JOIN user_group AS g ON a.group_id = g.id`
         )
         .then((r) => r.fetchAll());
   }
}

module.exports = System;
