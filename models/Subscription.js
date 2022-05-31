const db = require('../config/database');

class Subscription {
   static async subscribe(subscription, app_id) {
      const { endpoint, expirationTime, keys } = subscription;

      const connection = await db.mysqlPool.getConnection();

      await connection.execute('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
      await connection.beginTransaction();

      try {
         const [{ insertId: key_id }] = await connection.execute('INSERT INTO `keys` (auth, p256dh) VALUES (?, ?)', [
            keys.auth,
            keys.p256dh,
         ]);

         const [{ affectedRows }] = await connection.execute(
            'INSERT INTO subscription (endpoint, expirationTime, app_id, key_id) VALUES (?, ?, ?, ?)',
            [endpoint, expirationTime, app_id, key_id]
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
         const [result] = await connection.execute('SELECT key_id FROM subscription WHERE endpoint = ?', [endpoint]);
         const key_id = result[0].key_id;

         await connection.execute('DELETE FROM subscription WHERE endpoint = ?', [endpoint]);
         const [{ affectedRows }] = await connection.execute('DELETE FROM keys WHERE key_id = ?', [key_id]);

         await connection.commit();

         return affectedRows;
      } catch (error) {
         await connection.rollback();
         throw error;
      }
   }
}

module.exports = Subscription;
