const express = require('express');
const { body } = require('express-validator');
const authController = require('../controllers/authController');

const router = express.Router();

router.route('/login').post(body('email').isEmail(), body('password').isLength({ min: 4 }), authController.login);

module.exports = router;
