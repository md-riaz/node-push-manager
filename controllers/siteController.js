const User = require('../models/User');
const System = require('../models/System');

const { validationResult } = require('express-validator');
const HttpError = require('../utils/http-error');

exports.getApps = async (req, res, next) => {
   const user_id = req.uid;

   const apps = await User.getApps(user_id);

   res.json({ error: 0, message: 'success', data: apps });
};

exports.addApp = async (req, res, next) => {
   // get errors from route validation
   const errors = validationResult(req);
   console.log(req.body);
   if (!errors.isEmpty()) {
      let errs = errors.array();
      return next(new HttpError(errs[0].msg, 400));
   }

   const { app } = req.body;
   const user_id = req.uid;

   const addApp = await User.addApp(user_id, app);

   res.json({ error: 0, message: 'App successfully added' });
};

exports.getApiList = async (req, res, next) => {
   const apiList = await System.getApiList();
   const DBApiList = await System.getDBApiList();
   const DBApiPermissions = await System.getDBApiPermissions();

   // filter out api list from db that are not in api list from file
   const apiListFiltered = apiList.filter((api) => !DBApiList.find((dbApi) => dbApi.api_path === api));

   // merge api list from db with api list from file
   const apiListObj = apiListFiltered.map((api) => {
      return { id: 0, api_path: api };
   });

   // merge api list with the permissions
   const apiListWithPermissions = DBApiList.map((api) => {
      const permissions = DBApiPermissions.filter((permission) => permission.permission_id === api.id);
      const groups = permissions.map((permission) => permission.group_name);
      return { ...api, groups };
   });

   Array.prototype.push.apply(apiListWithPermissions, apiListObj);

   res.json({ error: 0, message: 'success', data: apiListWithPermissions });
};

exports.getRoles = async (req, res, next) => {
   const roles = await User.getRoles();

   res.json({ error: 0, message: 'success', data: roles });
};

exports.getUsers = async (req, res, next) => {
   const users = await User.getUsers();
   const rolesRelation = await User.getRolesRelation();

   const usersWithRoles = users.map((user) => {
      const roles = rolesRelation.filter((role) => role.user_id === user.id);
      const userRoles = roles.map((role) => role.group_name);
      return { ...user, roles: userRoles };
   });

   res.json({ error: 0, message: 'success', data: usersWithRoles });
};
