const express = require('express');
const appController = require('../controllers/appController');
const { check } = require('express-validator');

const router = express.Router();

router
   .route('/:id/notifications')
   .get(appController.getNotifications)
   .post(
      [
         check('message').isLength({ min: 1 }).withMessage('Missing notification message'),
         check('name').isLength({ min: 1 }).withMessage('Missing notification name'),
         check('schedule').isDate().withMessage('Invalid schedule date'),
         check('time').isLength({ min: 1 }).withMessage('Invalid notification time'),
      ],
      appController.setNotifications
   );

router.route('/:id/').delete(appController.DeleteApp);

module.exports = router;
