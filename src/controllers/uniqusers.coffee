Uniquser = require '../models/uniquser'

# Uniquser model's CRUD controller.
module.exports = 

  # Lists all uniqusers
  index: (req, res) ->
    Uniquser.find {}, (err, uniqusers) ->
      res.send uniqusers

  # new uniquser 
  new: (req, res) ->
    uniquser = new Uniquser
      
  # Creates new uniquser with data from `req.body`
  create: (req, res) ->
    console.log req.body
    uniquser = new Uniquser req.body
    uniquser.save (err, uniquser) ->
      if not err
        res.send uniquser
        res.statusCode = 201
      else
        res.send err
        
  # Gets uniquser by id
  show: (req, res) ->
    Uniquser.findById req.params.uniquser, (err, uniquser) ->
      if not err
        res.send uniquser
      else
        res.send err
             
  # Updates uniquser with data from `req.body`
  update: (req, res) ->
    Uniquser.findByIdAndUpdate req.params.uniquser, {"$set":req.body}, (err, uniquser) ->
      if not err
        res.send uniquser
      else
        res.send err
    
  # Deletes uniquser by id
  delete: (req, res) ->
    Uniquser.findByIdAndRemove req.params.uniquser, (err) ->
      if not err
        res.send {}
      else
        res.send err
      
  
