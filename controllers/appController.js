const { validationResult } = require('express-validator');
const HttpError = require('../utils/http-error');

exports.getNotifications = async (req, res, next) => {
   return res.json({ error: 0, message: 'success', data: [] });
};
