/* The API controller
   Exports 3 methods:
   * flashpack - Creates a new flashpack
   * list - Returns a list of flashpacks
   * show - Displays a flashpack
*/


var Flashpack = require('../models/flashpack.js');

exports.flashpack = function(req, res, next) {
    console.log('Making a flashpack out of %s,%s',req.body.name,req.body.cards);
    console.log('Raw JSON %s',req.body.cards);
    console.log(JSON.parse(req.body.cards));

    var newPack = new Flashpack({
        name: req.body.name,
        cards: JSON.parse(req.body.cards)
    });
    newPack.save();
    res.send(JSON.stringify({
        "success": true,
        "id":newPack.id
    }));
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
