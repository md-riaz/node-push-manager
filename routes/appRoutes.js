const express = require('express');
const appController = require('../controllers/appController');
const { check } = require('express-validator');

const router = express.Router();

router.route('/:id/notifications').get(appController.getNotifications);

module.exports = router;
