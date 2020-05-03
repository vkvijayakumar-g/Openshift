const express = require('express');
const app = express();
const bodyParser = require("body-parser");

const redis = require("redis");
const client = redis.createClient();

client.on('connect', function() {
    console.log('Redis client connected');
});

let count = 1;
const urlEncodedParser = bodyParser.urlencoded({extended:false});

var temp = "";
app.get('/', function(req, res) {
    res.sendFile(__dirname + "/"+ "index.html");
})

app.post('/send', urlEncodedParser, function(req, res) {
    client.set("name"+count, req.body.firstName, redis.print);
    count ++;
    const host = server.address().address

    res.send("<html><body><p>Happy Quarantine Days <B>"+req.body.firstName+"</B> !!!!</p></body></html>");
})

const server = app.listen(8080, function() {
    const host = server.address().address;
    const port = 8080;
    console.log("App listening to the address and port", host, port)
})

module.exports = app;