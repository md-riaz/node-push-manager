const express = require('express');
const subscriptionController = require('../controllers/subscriptionController');
const { check } = require('express-validator');

const router = express.Router();

router
   .route('/')
   .post(
      [
         check('subscription').isJSON().withMessage('Subscription is not a valid JSON'),
         check('app_id').isLength({ min: 1 }).withMessage('App ID is required'),
      ],
      subscriptionController.setSubscriptions
   )
   .delete(subscriptionController.deleteSubscriptions);

module.exports = router;
