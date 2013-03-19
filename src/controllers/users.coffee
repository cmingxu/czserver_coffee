User = require '../models/user'

# User model's CRUD controller.
module.exports = 

  # Lists all users
  index: (req, res) ->
    User.find {}, (err, users) ->
      if err
        req.statusCode = 404
        req.send {}
      else
        res.send users

  # new user 
  new: (req, res) ->
    user = new User
    res.render "users/new"
      
  # Creates new user with data from `req.body`
  #TODO should be logged in here
  create: (req, res) ->
    user = new User req.body
    user.save (err, user) ->
      if not err
        result = user
        res.statusCode = 201
      else
        result =  ErrorHelper.toFormattedError("user", err)
        req.flash "info", result
        res.statusCode = 422

      res.format(
        json: ()->
          res.send result
        html: ()->
          res.redirect "users/new"
      )

        
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
      
  
