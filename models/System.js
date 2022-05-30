const fs = require('fs');

class System {
   static getApiList() {
      const rawdata = fs.readFileSync('routes/routeList.json');
      return JSON.parse(rawdata);
   }
}

module.exports = System;
