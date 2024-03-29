User = require '../models/user'
Character = require '../models/character'

# User model's CRUD controller.
module.exports = 

  # Lists all users
  index: (req, res) ->
    User.find {}, (err, users) ->
      res.format
        json: ()->
          if err
            res.statusCode = 404
            res.send {}
          else
            res.send users
        html: () ->
          res.render "users/index", {users}

  # new user 
  new: (req, res) ->
    user = new User
    res.render "users/new", {flash: req.flash("flash"), _user: {gold: 0, food: 0, vip: "VIP1", money: 0}}
      
  # Creates new user with data from `req.body`
  #TODO should be logged in here
  create: (req, res) ->
    user = new User req.body
    console.log req.body
    user.character = new Character
    user.save (err, user) ->
      if not err
        result = user
        res.statusCode = 201
      else
        result =  ErrorHelper.toFormattedError("user", err)
        req.flash "flash", result
        res.statusCode = 422

      res.format(
        json: ()->
          res.send result
        html: ()->
          if err
            req.flash("flash", JSON.stringify(result))
            res.render "users/new", {_user: req.body}
          else
            req.flash("flash", "user saved successfully")
            res.redirect "/tokens/new"
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
          res.format(
            json: ()->
              if not err
                res.send user
              else
                res.send ErrorHelper.toFormattedError("user", err)
                res.statusCode = 422
            html: ()->
              if err
                req.flash("flash", JSON.stringify(err))
                res.redirect "/home"
              else
                req.flash("flash", "user saved successfully")
                res.redirect "/home"
          )
      else 
        res.statusCode = 404

  # Deletes user by id
  destroy: (req, res) ->
    User.findByIdAndRemove req.params.user, (err) ->
      res.format(
        json: ()->
          if not err
            res.send {}
          else
            res.send err
        html: ()->
          if not err
            req.flash "flash", "user delete successfully"
            res.redirect "/users"
          else
            req.flash "flash", JSON.stringfiy(err)
            res.redirect "/users"
      )

