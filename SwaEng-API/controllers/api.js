/* The API controller
   Exports 3 methods:
   * flashpack - Creates a new flashpack
   * list - Returns a list of flashpacks
   * show - Displays a flashpack
   */


   var Flashpack = require('../models/flashpack.js');

   exports.flashpack = function(req, res, next) {
    console.log('Making a flashpack out of %s,%s',req.params.name,req.params.cards);
    console.log('Making a flashpack out card 0 of %s',req.params.cards[0]);

    var cards = [];
    for (var i = 0; i < req.params.cards.length-1; i+=2){
      var card = {
        phrase:req.params.cards[i],
        translation:req.params.cards[i+1]
    };
    cards.push(card);
}
console.log(cards);
var newPack = new Flashpack({
    name: req.params.name,
    cards: cards
});
console.log(" new pack %s",newPack.name)
newPack.save();
res.send({
    "success": true,
    "id":newPack.id
});
return next();
}

exports.list = function(req, res, next) {
  Flashpack.find(function(err, flashpacks) {
    res.send(flashpacks);
    return next();
});
}

// first locates a flashpack by title, then locates the replies by thread ID.
exports.show = (function(req, res, next) {
  Flashpack.findOne({name: req.params.name}, function(error, thread) {
    var flashpacks = Flashpack.find({flashpack: flashpack._id}, function(error, flashpacks) {
      res.send([{flashpack: flashpacks}]);
      return next();
  });
})
});
