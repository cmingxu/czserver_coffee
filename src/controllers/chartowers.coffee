Chartower = require '../models/chartower'

# Chartower model's CRUD controller.
module.exports = 

  # Lists all chartowers
  index: (req, res) ->
    Chartower.find {}, (err, chartowers) ->
      res.send chartowers

  # new chartower 
  new: (req, res) ->
    chartower = new Chartower
      
  # Creates new chartower with data from `req.body`
  create: (req, res) ->
    chartower = new Chartower req.body
    chartower.save (err, chartower) ->
      if not err
        res.send chartower
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500
        
  # Gets chartower by id
  show: (req, res) ->
    Chartower.findById req.params.chartower, (err, chartower) ->
      if not err
        res.send chartower
      else
        res.send err
        res.statusCode = 500
             
  # Updates chartower with data from `req.body`
  update: (req, res) ->
    Chartower.findByIdAndUpdate req.params.chartower, {"$set":req.body}, (err, chartower) ->
      if not err
        res.send chartower
      else
        res.send err
        res.statusCode = 500
    
  # Deletes chartower by id
  destroy: (req, res) ->
    Chartower.findByIdAndRemove req.params.chartower, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
