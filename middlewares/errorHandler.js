exports.errorHandler = (error, req, res, next) => {
   if (res.headerSent) {
      return next(error);
   }

   res.json({ error: error.code || 500, message: error.message || 'An unknown error occurred' });
};
