// The main application script, ties everything together.

var mongoose = require('mongoose');
var restify = require('restify');
var pjson = require('./package.json');

var app = restify.createServer({
  name: pjson.name,
  version: pjson.version
});

// connect to Mongo when the app initializes
mongoose.connect('mongodb://localhost/swa_eng_api');

app.use(restify.acceptParser(app.acceptable));
app.use(restify.queryParser());
app.use(restify.bodyParser());

// set up the RESTful API, handler methods are defined in api.js
var api = require('./controllers/api.js');
app.post('/flashpack', api.flashpack);
app.get('/flashpack/:name.:format?', api.show);
app.get('/flashpack', api.list);

app.get('/', function(req, res, next) {
    res.send('SwaEngAPI v:'+pjson.version);
});

app.listen(5000, function () {
    console.log("%s v:%s listening on port %d",
    app.name,
    pjson.version,
    app.address().port);
});
