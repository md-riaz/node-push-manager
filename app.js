const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan')

const authRoutes = require('./routes/auth-routes');
const HttpError = require('./utils/http-error');
const { errorHandler } = require('./middlewares/errorHandler');
require('dotenv').config();

const app = express();

// PORT
const PORT = process.env.PORT || 5000;
console.log('check PORT: ' + PORT)

// json parser
app.use(bodyParser.json());
app.use(morgan('tiny'))

// Allow CORS
app.use((req, res, next) => {
   res.setHeader('Access-Control-Allow-Origin', '*');
   res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PATCH, DELETE, OPTIONS');

   next();
});

// Routes

app.use('/api/auth', authRoutes);

// test
app.get('/', (req, res) => {
   res.send('Good bye')
})

// if route not found
app.use((req, res, next) => {
   throw new HttpError('Could not find this route', 404);
});

// this error middleware needs to be at the bottom of all routes
app.use(errorHandler);

// start the express server
app.listen(PORT, () => console.log(`Server started on port http://localhost:${PORT}`));
