var https = require('https');
var app = require('express')();
var fs = require('fs');
var server = https.createServer(
  {
    key: fs.readFileSync('/etc/nginx/ssl/privkey.pem'),
    cert: fs.readFileSync('/etc/nginx/ssl/fullchain.pem'),
    ca: fs.readFileSync('/etc/nginx/ssl/cert.pem'),
    requestCert: false,
    rejectUnauthorized: false
  },
  app
);

var io = require('socket.io').listen(server);

io.set('origins', '*:*');

var Redis = require('ioredis');
var redis = new Redis(6379, 'redis');
redis.psubscribe('*', function(err, count) {
  console.log('Redis Connected');
});

redis.on('pmessage', function(subscribed, channel, message) {
  console.log('Message Received');
});

io.on('connection', socket => {
  console.log('io.on: connected');
  socket.on('disconnect', function() {
    console.log('Got disconnected!');
  });
});

server.listen(6001);
