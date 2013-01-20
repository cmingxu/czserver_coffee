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
    uniquser = new Uniquser req.body
    uniquser.save (err, uniquser) ->
      if not err
        res.send uniquser
        res.statusCode = 201
      else
        res.send ErrorHelper.toFormattedError("uniquser", err)
        res.statusCode = 422
        
  # Gets uniquser by id
  show: (req, res) ->
    Uniquser.findById req.params.uniquser, (err, uniquser) ->
      if not err
        res.send uniquser
      else
        res.send err
             
  # Updates uniquser with data from `req.body`
  update: (req, res) ->
    Uniquser.findById req.params.uniquser, (err, uniquser) ->
      if not err
        _.extend(uniquser, req.body)
        uniquser.save (err, uniquser)->
          if not err
            res.send uniquser
          else
            res.send ErrorHelper.toFormattedError("uniquser", err)
            res.statusCode = 422
      else
        res.statusCode = 404
    
  # Deletes uniquser by id
  delete: (req, res) ->
    Uniquser.findByIdAndRemove req.params.uniquser, (err) ->
      if not err
        res.send {}
      else
        res.send err
      
  
