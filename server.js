const express = require('express');
const app = express();
const bodyParser = require("body-parser");

const urlEncodedParser = bodyParser.urlencoded({extended:false});

var temp = "";
app.get('/', function(req, res) {
    res.sendFile(__dirname + "/"+ "index.html");
})

app.post('/send', urlEncodedParser, function(req, res) {
    res.send("<html><body><B>"+req.body.firstName+"</B></body></html>");
})

const server = app.listen(8080, function() {
    const host = server.address().address;
    const port = 8080;
    console.log("App listening to the address and port", host, port)
})

module.exports = app;