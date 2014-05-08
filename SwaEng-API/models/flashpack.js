// The Flashcard Pack model

var mongoose = require('mongoose')
,Schema = mongoose.Schema
,ObjectId = Schema.ObjectId;

var pjson = require('../package.json');

var card_model = {
    phrase:String,
    translation:String
}

var flashpackSchema = new Schema({
    name: String,
    cards: [card_model]
},
    {
    versionKey: false
});

flashpackSchema.statics.findByName = function (name, cb) {
  this.find({ name: new RegExp(name, 'i') }, cb);
}

module.exports = mongoose.model('Flashpack', flashpackSchema);
