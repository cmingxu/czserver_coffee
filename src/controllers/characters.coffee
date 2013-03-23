User      = require '../models/user'
Character = require '../models/character'

# Character model's CRUD controller.
module.exports = 

  # Lists all characters
  index: (req, res) ->
    Character.find {}, (err, characters) ->
      res.send characters

  # new character 
  new: (req, res) ->
    User.findOne {_id: req.query.user_id}, (err, user)->
      if err
        res.send "error"
      else
        res.render "characters/new", {user}
    
      
  # Creates new character with data from `req.body`
  create: (req, res) ->
    character = new Character _.extend(req.body, {user_id: req.user._id})
    character.save (err, character) ->
      if not err
        res.send character
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 422
        
  # Gets character by 
  show: (req, res) ->
    Character.findById req.params.character, (err, character) ->
      if not err
        res.send character
      else
        res.send err
        res.statusCode = 422
             
  # Updates character with data from `req.body`
  update: (req, res) ->
    Character.findByIdAndUpdate req.params.character, {"$set":req.body}, (err, character) ->
      if not err
        res.send character
      else
        res.send err
        res.statusCode = 500
    
  # Deletes character by 
  destroy: (req, res) ->
    Character.findByIdAndRemove req.params.character, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
