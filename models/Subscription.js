const db = require('../config/database');

class Subscription {
   static async subscribe(subscription, app_id) {
      const { endpoint, expirationTime, keys } = subscription;

      const connection = await db.mysqlPool.getConnection();

      await connection.execute('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
      await connection.beginTransaction();

      try {
         const [{ affectedRows }] = await connection.execute(
            'INSERT INTO subscription (endpoint, expirationTime, app_id, auth, p256dh) VALUES (?, ?, ?, ?, ?)',
            [endpoint, expirationTime, app_id, keys.auth, keys.p256dh,]
         );

         await connection.commit();

         return affectedRows;
      } catch (error) {
         await connection.rollback();
         throw error;
      }
   }

   static async deleteSubscriptions(endpoint) {
      const connection = await db.mysqlPool.getConnection();

      await connection.execute('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
      await connection.beginTransaction();

      try {
         await connection.execute('DELETE FROM subscription WHERE endpoint = ?', [endpoint]);
         
         await connection.commit();

         return true;
      } catch (error) {
         await connection.rollback();
         throw error;
      }
   }
}

module.exports = Subscription;
