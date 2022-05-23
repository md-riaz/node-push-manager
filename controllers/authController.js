const HttpError = require('../utils/http-error');
const bcrypt = require('bcrypt');
const User = require('../models/User');
const { validationResult } = require('express-validator');

exports.login = async (req, res, next) => {
   const errors = validationResult(req);

   if (!errors.isEmpty()) {
      return next(new HttpError('Please provide email and password', 400));
   }

   const { email, password } = req.body;

   const user = await User.getUser(email);

   if (!user) {
      return next(new HttpError('User not found', 404));
   }

   const isValidPassword = await bcrypt.compare(password, user.password);

   if (!isValidPassword) {
      return next(new HttpError('Invalid password', 401));
   }

   const ip =
      req.headers['x-forwarded-for'] ||
      req.connection.remoteAddress ||
      req.socket.remoteAddress ||
      req.connection.socket.remoteAddress;

   const sessionId = await User.startSession(user.id, ip);

   res.json({ error: 0, message: 'Login successfull', token: sessionId });
};
