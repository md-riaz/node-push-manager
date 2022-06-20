const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const cron = require('node-cron');
const webpush = require('web-push');

const authRoutes = require('./routes/auth');
const siteRoutes = require('./routes/site');
const subscriptionRoutes = require('./routes/subscription');
const notificationRoutes = require('./routes/notification');
const appRoutes = require('./routes/app');

const HttpError = require('./utils/http-error');
const { errorHandler } = require('./middlewares/errorHandler');

const Authorization = require('./middlewares/authorize');
const { getRouteList } = require('./utils/utils');
const Notification = require('./utils/sendNotifications');

require('dotenv').config();

const PORT = process.env.PORT || 5000;

const app = express();

// json parser
app.use(bodyParser.json());

// Allow CORS
app.use((req, res, next) => {
   res.setHeader('Access-Control-Allow-Origin', '*');
   res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PATCH, DELETE, OPTIONS');

   next();
});

// authorization check middleware
app.use(Authorization.checkPermission);

// Routes
app.get('/', (req, res) => {
   res.send('Requisting from ' + req.ip + ' ip address, go to /api/${action} to see the available actions');
});
app.use('/api/auth', authRoutes);
app.use('/api/subscription', subscriptionRoutes);
// app.use('/api/notification', notificationRoutes);
app.use('/api/app', appRoutes);
app.use('/api', siteRoutes);

// save route list to json file
fs.writeFile('./utils/routeList.json', JSON.stringify(getRouteList(app)), (err) => {
   if (err) {
      return console.log(err);
   }
});

// if route not found
app.use((req, res, next) => {
   throw new HttpError('Could not find this route', 404);
});

// this error middleware needs to be at the bottom of all routes
app.use(errorHandler);

// start the express server
app.listen(PORT, () => console.log(`Server started on port http://localhost:${PORT}`));

const publicVapidKey = 'BJthRQ5myDgc7OSXzPCMftGw-n16F7zQBEN7EUD6XxcfTTvrLGWSIG7y_JxiWtVlCFua0S8MTB5rPziBqNx1qIo';
const privateVapidKey = '3KzvKasA2SoCxsp0iIG_o9B0Ozvl1XDwI63JRKNIWBM';

webpush.setVapidDetails('mailto:test@test.com', publicVapidKey, privateVapidKey);

const cronRunner = async () => {
   console.log('running cron job at ' + new Date());
   Notification.send();
};

cron.schedule('* * * * *', cronRunner);
