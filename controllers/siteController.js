const User = require('../models/User');

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

   if (!errors.isEmpty()) {
      let errs = errors.array();
      return next(new HttpError(errs[0].msg, 400));
   }

   const { domain } = req.body;
   const user_id = req.uid;

   const app = await User.addApp(user_id, domain);

   res.json({ error: 0, message: 'App successfully added' });
};
