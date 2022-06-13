const express = require('express');
const { body } = require('express-validator');
const authController = require('../controllers/authController');

const router = express.Router();

router.route('/login').post(body('email').isEmail(), body('password').isLength({ min: 4 }), authController.login);

router
   .route('/register')
   .post(
      [
         body('name', 'Please provide a name').not().isEmpty().trim().escape(),
         body('phone', 'Please provide a valid phone number').isMobilePhone('bn-BD'),
         body('email', 'Invalid email address').trim().isEmail().normalizeEmail(),
         body('password', 'Password must be at least 6 characters').isLength({ min: 6 }),
      ],
      authController.register
   );

module.exports = router;
