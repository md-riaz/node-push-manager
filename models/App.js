const db = require('../config/database');
const { getTimeStamp } = require('../utils/utils');

class App {
   static async getNotifications(app_id) {
      return db
         .query(`SELECT * FROM notification WHERE app_id = ${app_id} ORDER BY id DESC`)
         .then((result) => result.fetchAll());
   }

   static async setNotifications(app_id, name, title, message, image, launch_url, scheduleTime) {
      const notification = db
         .query(
            'INSERT INTO `notification`( `name`, `title`, `message`, `image_url`, `launch_url`, `scheduled`, `app_id`, `created_at`) VALUES(?,?,?,?,?,?,?,?)',
            [name, title, message, image, launch_url, scheduleTime, app_id, getTimeStamp()]
         )
         .then((r) => r.affectedRows());

      return notification ? true : false;
   }
}

module.exports = App;
