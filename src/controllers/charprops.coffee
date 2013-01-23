Charprop = require '../models/charprop'

# Charprop model's CRUD controller.
module.exports = 

  # Lists all charprops
  index: (req, res) ->
    Charprop.find {}, (err, charprops) ->
      res.send charprops

  # new charprop 
  new: (req, res) ->
    charprop = new Charprop
      
  # Creates new charprop with data from `req.body`
  create: (req, res) ->
    charprop = new Charprop req.body
    charprop.save (err, charprop) ->
      if not err
        res.send charprop
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 422
        
  # Gets charprop by id
  show: (req, res) ->
    Charprop.findById req.params.charprop, (err, charprop) ->
      if not err
        res.send charprop
      else
        res.send err
        res.statusCode = 422
             
  # Updates charprop with data from `req.body`
  update: (req, res) ->
    Charprop.findByIdAndUpdate req.params.charprop, {"$set":req.body}, (err, charprop) ->
      if not err
        res.send charprop
      else
        res.send err
        res.statusCode = 422
    
  # Deletes charprop by id
  destroy: (req, res) ->
    Charprop.findByIdAndRemove req.params.charprop, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 422
      
  
