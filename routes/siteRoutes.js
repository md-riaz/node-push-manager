const express = require('express');
const siteController = require('../controllers/siteController');

const { check } = require('express-validator');

const router = express.Router();

// get user websites
router.route('/websites').get(siteController.getWebsites);
router
   .route('/websites')
   .post(check('domain').isLength({ min: 1 }).withMessage('Domain name is required'), siteController.addWebsite);

module.exports = router;
