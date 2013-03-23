User  = require '../models/user'
Token = require '../models/token'

# Token model's CRUD controller.
module.exports = 
  home: (req, res) ->
    res.render "tokens/home", {flash: req.flash("info")}
  # new token 
  new: (req, res) ->
    res.render "tokens/new", {flash: req.flash("info")}
      
  # Creates new token with data from `req.body`
  create: (req, res) ->
      res.format(
        json: ()->
          token = new Token req.body
          token.save (err, token) ->
            if not err
              res.statusCode = 201
              res.send token
            else
              res.statusCode = 422
              res.send err
        html: ()->
          User.findOne {email: req.body.email}, (err, user)->
            if user
              if user.password_valid(req.body.password)
                req.session.user_id = user._id
                req.logged_in = true
                res.flash "flash", "welcome"
                res.redirect "/home"

              else
                res.statusCode = 401
                res.flash "flash", "password not correct"
                res.redirect "tokens/new"
            else
              res.statusCode = 404
              res.flash "flash", "User not found"
              res.redirect "tokens/new"
      )

        
  # Gets token by id
  show: (req, res) ->
    Token.findById req.params.token, (err, token) ->
      if not err
        res.send token
      else
        res.send err
             
  # Deletes token by id
  destroy: (req, res) ->
      if true
        res.send {}
      else
        res.send err
      
  
