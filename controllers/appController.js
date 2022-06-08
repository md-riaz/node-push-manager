const { validationResult } = require('express-validator');
const HttpError = require('../utils/http-error');
const App = require('../models/App');

exports.getNotifications = async (req, res, next) => {
   const appId = req.params.id;

   const notifications = await App.getNotifications(appId);

   return res.json({ error: 0, message: 'success', data: notifications });
};

exports.setNotifications = async (req, res, next) => {
   const errors = validationResult(req);

   if (!errors.isEmpty()) {
      let errs = errors.array();
      return next(new HttpError(errs[0].msg, 400));
   }

   const { name, title, message, image, launch_url, schedule, time } = req.body;

   const scheduleTime = new Date(schedule + ' ' + time);
   const appId = req.params.id;

   const notification = await App.setNotifications(appId, name, title, message, image, launch_url, scheduleTime);

   return res.json({ error: 0, message: 'success', data: notification });
};
