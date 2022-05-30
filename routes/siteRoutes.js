const express = require('express');
const siteController = require('../controllers/siteController');

const { check } = require('express-validator');

const router = express.Router();

// get user apps
router.route('/apps').get(siteController.getApps);
router
   .route('/apps')
   .post(check('app').isLength({ min: 1 }).withMessage('App name is required'), siteController.addApp);

router.route('/routelist').get(siteController.getApiList);

router.route('/roles').get(siteController.getRoles);

router.route('/users').get(siteController.getUsers);

module.exports = router;
