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

   static async Delete(app_id) {
      const connection = await db.mysqlPool.getConnection();

      await connection.execute('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
      await connection.beginTransaction();

      try {
         await connection.execute('DELETE FROM app WHERE id = ?', [app_id]);
         await connection.execute('DELETE FROM notification WHERE app_id = ?', [app_id]);

         // delete subscriptions and their keys
         const [keyIds] = await connection.execute('SELECT key_id FROM subscription WHERE app_id = ?', [app_id]);

         const keyIdsArray = keyIds.map((keyId) => keyId.key_id);

         await connection.execute('DELETE FROM subscription WHERE app_id = ?', [app_id]);
         await connection.execute('DELETE FROM `keys` WHERE id IN (?)', [keyIdsArray.join(',')]);

         await connection.commit();
         connection.release();

         return true;
      } catch (error) {
         await connection.rollback();
         throw error;
      }
   }
}

module.exports = App;
