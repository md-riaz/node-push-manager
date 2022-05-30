const User = require('../models/User');
const System = require('../models/System');

const { validationResult } = require('express-validator');
const HttpError = require('../utils/http-error');

exports.getApps = async (req, res, next) => {
   const user_id = req.uid;

   const apps = await User.getApps(user_id);

   res.json({ error: 0, message: 'success', data: apps });
};

exports.addApp = async (req, res, next) => {
   // get errors from route validation
   const errors = validationResult(req);
   console.log(req.body);
   if (!errors.isEmpty()) {
      let errs = errors.array();
      return next(new HttpError(errs[0].msg, 400));
   }

   const { app } = req.body;
   const user_id = req.uid;

   const addApp = await User.addApp(user_id, app);

   res.json({ error: 0, message: 'App successfully added' });
};

exports.getApiList = async (req, res, next) => {
   const apiList = await System.getApiList();

   res.json({ error: 0, message: 'success', data: apiList });
};
