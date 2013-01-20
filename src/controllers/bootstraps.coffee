Character = require '../models/character'
User = require '../models/user'

module.exports = 
  index: (req, res) ->
    User.find {}, (err, characters) ->
      res.send characters

