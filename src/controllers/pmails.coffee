Pmail = require '../models/pmail'

# Pmail model's CRUD controller.
module.exports = 

  # Lists all pmails
  index: (req, res) ->
    Pmail.find {}, (err, pmails) ->
      res.send pmails

  # new pmail 
  new: (req, res) ->
    pmail = new Pmail
      
  # Creates new pmail with data from `req.body`
  create: (req, res) ->
    pmail = new Pmail req.body
    pmail.save (err, pmail) ->
      if not err
        res.send pmail
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500
        
  # Gets pmail by id
  show: (req, res) ->
    Pmail.findById req.params.pmail, (err, pmail) ->
      if not err
        res.send pmail
      else
        res.send err
        res.statusCode = 500
             
  # Updates pmail with data from `req.body`
  update: (req, res) ->
    Pmail.findByIdAndUpdate req.params.pmail, {"$set":req.body}, (err, pmail) ->
      if not err
        res.send pmail
      else
        res.send err
        res.statusCode = 500
    
  # Deletes pmail by id
  destroy: (req, res) ->
    Pmail.findByIdAndRemove req.params.pmail, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
