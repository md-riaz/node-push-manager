const webpush = require('web-push');

const publicVapidKey = 'BJthRQ5myDgc7OSXzPCMftGw-n16F7zQBEN7EUD6XxcfTTvrLGWSIG7y_JxiWtVlCFua0S8MTB5rPziBqNx1qIo';
const privateVapidKey = '3KzvKasA2SoCxsp0iIG_o9B0Ozvl1XDwI63JRKNIWBM';

const initWebpush = () => {
   webpush.setVapidDetails('mailto:test@test.com', publicVapidKey, privateVapidKey);
};

module.exports = { initWebpush };
