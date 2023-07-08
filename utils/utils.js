process.env.TZ = 'Asia/Dhaka';

exports.getTimeStamp = (strDate = new Date()) => {
   let date = new Date(strDate);

   date =
      date.getFullYear() +
      '-' +
      ('00' + (date.getMonth() + 1)).slice(-2) +
      '-' +
      ('00' + date.getDate()).slice(-2) +
      ' ' +
      ('00' + date.getHours()).slice(-2) +
      ':' +
      ('00' + date.getMinutes()).slice(-2) +
      ':' +
      ('00' + date.getSeconds()).slice(-2);

   return date;
};

exports.getRouteList = (app) => {
   const getRoutesOfLayer = (path, layer) => {
      if (layer.method) {
         // return [layer.method.toUpperCase() + ' ' + path];
         return [path];
      } else if (layer.route) {
         return getRoutesOfLayer(path + split(layer.route.path), layer.route.stack[0]);
      } else if (layer.name === 'router' && layer.handle.stack) {
         let routes = [];

         layer.handle.stack.forEach(function (stackItem) {
            routes = routes.concat(getRoutesOfLayer(path + split(layer.regexp), stackItem));
         });

         // removed double routes
         return routes.filter((v, i, a) => a.indexOf(v) === i);
      }

      return [];
   };

   const split = (thing) => {
      if (typeof thing === 'string') {
         return thing;
      } else if (thing.fast_slash) {
         return '';
      } else {
         var match = thing
            .toString()
            .replace('\\/?', '')
            .replace('(?=\\/|$)', '$')
            .match(/^\/\^((?:\\[.*+?^${}()|[\]\\\/]|[^.*+?^${}()|[\]\\\/])*)\$\//);
         return match ? match[1].replace(/\\(.)/g, '$1') : '<complex:' + thing.toString() + '>';
      }
   };

   let routes = [];

   app._router.stack.forEach(function (layer) {
      routes = routes.concat(getRoutesOfLayer('', layer));
   });

   return routes;
};
