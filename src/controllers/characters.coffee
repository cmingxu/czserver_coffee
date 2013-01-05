Character = require '../models/character'

# Character model's CRUD controller.
module.exports = 

  # Lists all characters
  index: (req, res) ->
    Character.find {}, (err, characters) ->
      res.send characters

  # new character 
  new: (req, res) ->
    character = new Character
      
  # Creates new character with data from `req.body`
  create: (req, res) ->
    character = new Character req.body
    character.save (err, character) ->
      if not err
        res.send character
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500
        
  # Gets character by id
  show: (req, res) ->
    Character.findById req.params.id, (err, character) ->
      if not err
        res.send character
      else
        res.send err
        res.statusCode = 500
             
  # Updates character with data from `req.body`
  update: (req, res) ->
    Character.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, character) ->
      if not err
        res.send character
      else
        res.send err
        res.statusCode = 500
    
  # Deletes character by id
  delete: (req, res) ->
    Character.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
