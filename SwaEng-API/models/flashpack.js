// The Flashcard Pack model

var mongoose = require('mongoose')
,Schema = mongoose.Schema
,ObjectId = Schema.ObjectId;

var pjson = require('../package.json');

var card_model = {
    eng_word:String,
    swa_word:String,
    eng_pronounce:String,
    swa_pronounce:String
}

var flashpackSchema = new Schema({
    post: String,
    cards: [card_model]
},
    {
    versionKey: false
});

flashpackSchema.statics.findByName = function (name, cb) {
  this.find({ name: new RegExp(name, 'i') }, cb);
}

module.exports = mongoose.model('Flashpack', flashpackSchema);
