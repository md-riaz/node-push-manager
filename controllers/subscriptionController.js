const { validationResult } = require('express-validator');
const HttpError = require('../utils/http-error');
const Subscription = require('../models/Subscription');

exports.setSubscriptions = async (req, res, next) => {
   // get errors from route validation
   const errors = validationResult(req);

   if (!errors.isEmpty()) {
      let errs = errors.array();
      return next(new HttpError(errs[0].msg, 400));
   }

   let { subscription, app_id } = req.body;

   subscription = JSON.parse(subscription);

   const addSubscription = await Subscription.subscribe(subscription, app_id);

   if (!addSubscription) {
      return next(new HttpError('Subscription failed', 500));
   }

   return res.json({ error: 0, message: 'success', data: subscription });
};

exports.deleteSubscriptions = async (req, res, next) => {
   let endpoint = req.query.endpoint;

   const deleteSubscription = await Subscription.deleteSubscriptions(endpoint);

   if (!deleteSubscription) {
      return next(new HttpError('Subscription delete failed', 500));
   }

   return res.json({ error: 0, message: 'success' });
};
