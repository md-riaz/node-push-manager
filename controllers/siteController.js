const User = require('../models/User');

const { validationResult } = require('express-validator');
const HttpError = require('../utils/http-error');

exports.getWebsites = async (req, res, next) => {
   const user_id = req.uid;

   const websites = await User.getWebsites(user_id);

   console.log(websites);

   res.json({ error: 0, message: 'success', data: websites });
};

exports.addWebsite = async (req, res, next) => {
   // get errors from route validation
   const errors = validationResult(req);

   if (!errors.isEmpty()) {
      let errs = errors.array();
      return next(new HttpError(errs[0].msg, 400));
   }

   const { domain } = req.body;
   const user_id = req.uid;

   const website = await User.addWebsite(user_id, domain);

   res.json({ error: 0, message: 'Website successfully added' });
};
