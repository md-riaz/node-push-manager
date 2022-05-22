var app = require('express')();

app.get('/', function (req, res) {
   var date;
   process.env.TZ = 'Asia/Dhaka';
   date = new Date();
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
   console.log(date);
   res.send(date);
});

app.listen(3000, function () {console.log('Example app listening on port 3000!');});
