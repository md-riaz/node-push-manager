const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

const authRoutes = require('./routes/authRoutes');
const siteRoutes = require('./routes/siteRoutes');
const HttpError = require('./utils/http-error');
const { errorHandler } = require('./middlewares/errorHandler');

const Authorization = require('./middlewares/authorize');
const { getRouteList } = require('./utils/utils');

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
app.use('/api', siteRoutes);
app.use('/api/auth', authRoutes);

// save route list to json file
fs.writeFile('./routes/routeList.json', JSON.stringify(getRouteList(app)), (err) => {
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
