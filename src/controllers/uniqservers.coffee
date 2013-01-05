Uniqserver = require '../models/uniqserver'

# Uniqserver model's CRUD controller.
module.exports = 

  # Lists all uniqservers
  index: (req, res) ->
    Uniqserver.find {}, (err, uniqservers) ->
      res.send uniqservers

  # new uniqserver 
  new: (req, res) ->
    uniqserver = new Uniqserver
      
  # Creates new uniqserver with data from `req.body`
  create: (req, res) ->
    uniqserver = new Uniqserver req.body
    uniqserver.save (err, uniqserver) ->
      if not err
        res.send uniqserver
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500
        
  # Gets uniqserver by id
  show: (req, res) ->
    Uniqserver.findById req.params.id, (err, uniqserver) ->
      if not err
        res.send uniqserver
      else
        res.send err
        res.statusCode = 500
             
  # Updates uniqserver with data from `req.body`
  update: (req, res) ->
    Uniqserver.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, uniqserver) ->
      if not err
        res.send uniqserver
      else
        res.send err
        res.statusCode = 500
    
  # Deletes uniqserver by id
  delete: (req, res) ->
    Uniqserver.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
