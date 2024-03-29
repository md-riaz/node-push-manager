const db = require('../config/database');
const webpush = require('web-push');
const { getTimeStamp } = require('./utils');

class Notification {
   static async send() {
      const notifications = await db
         .query(`SELECT * FROM notification WHERE scheduled = ? AND status = 0`, [getTimeStamp()])
         .then((result) => result.fetchAll());

      if (notifications.length == 0) {
         console.log('No notifications to send');
         return false;
      }

      notifications.forEach(async (notification) => {
         try {
            const subscriptions = await db
               .query(
                  'SELECT * FROM `subscription`WHERE app_id = ?',
                  notification.app_id
               )
               .then((result) => result.fetchAll());

            const sentNotifications = [];

            subscriptions.forEach(async (subscription) => {
               const { endpoint, auth, p256dh } = subscription;
               const subsReady = { endpoint: endpoint, keys: { auth, p256dh } };
               sentNotifications.push(webpush.sendNotification(subsReady, JSON.stringify(notification)));
            });

            await Promise.all(sentNotifications);

            const dbUpdate = await db.query(`UPDATE notification SET status = 1 WHERE id = ?`, notification.id);

            console.log(`Notification ${notification.id} sent`);

            return dbUpdate;
         } catch (error) {
            console.log(error);
         }
      });
   }
}

module.exports = Notification;
