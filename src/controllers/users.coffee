User = require '../models/user'

# User model's CRUD controller.
module.exports =

  # Lists all users
  index: (req, res) ->
    User.find {}, (err, users) ->
      res.format
        html: ()->
          res.render "users/index", users
        json: ()->
          res.send users


  new: (req, res) ->
    user = new User
    res.render "users/new", user
     
  # Creates new user with data from `req.body`
  create: (req, res) ->
    user = new User req.body
    user.save (err, user) ->
      if not err
        res.send user
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500


        
  # Gets user by id
  show: (req, res) ->
    User.findById req.params.id, (err, user) ->
      if not err
        res.send user
      else
        res.send err
        res.statusCode = 500
             
  # Updates user with data from `req.body`
  update: (req, res) ->
    User.findByIdAndUpdate req.params.id, {"$set":req.body}, (err, user) ->
      if not err
        res.send user
      else
        res.send err
        res.statusCode = 500
    
  # Deletes user by id
  destroy: (req, res) ->
    User.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
      
  
