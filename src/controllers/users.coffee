User = require '../models/user'

# User model's CRUD controller.
module.exports = 

  # Lists all users
  index: (req, res) ->
    User.find {}, (err, users) ->
      res.send users

  # new user 
  new: (req, res) ->
    user = new User
      
  # Creates new user with data from `req.body`
  # should be logged in here
  create: (req, res) ->
    user = new User req.body
    user.save (err, user) ->
      if not err
        res.send user
        res.statusCode = 201
      else
        res.send ErrorHelper.toFormattedError("user", err)
        res.statusCode = 422
        
  # Gets user by id
  show: (req, res) ->
    User.findById req.params.user, (err, user) ->
      if not err
        res.send user
      else
        res.send err
             
  # Updates user with data from `req.body`
  update: (req, res) ->
    User.findById req.params.user, (err, user) ->
      if not err
        _.extend(user, req.body)
        user.save (err, user)->
          if not err
            res.send user
          else
            res.send ErrorHelper.toFormattedError("user", err)
            res.statusCode = 422
      else
        res.statusCode = 404
    
  # Deletes user by id
  delete: (req, res) ->
    User.findByIdAndRemove req.params.user, (err) ->
      if not err
        res.send {}
      else
        res.send err
      
  
