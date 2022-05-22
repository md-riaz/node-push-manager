const express = require('express');
const siteController = require('../controllers/siteController');
const { authorized } = require('../middlewares/authorize');

const { check } = require('express-validator');

const router = express.Router();

// get user websites
router.route('/websites').get(authorized, siteController.getWebsites);
router
   .route('/websites')
   .post(
      authorized,
      check('domain').isLength({ min: 1 }).withMessage('Domain name is required'),
      siteController.addWebsite
   );

module.exports = router;
