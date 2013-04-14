User  = require '../models/user'
Token = require '../models/token'

# Token model's CRUD controller.
module.exports = 
  home: (req, res) ->
    console.log req.user
    res.render "tokens/home", {flash: req.flash("flash"), myself: req.user}
  # new token 
  new: (req, res) ->
    res.render "tokens/new", {flash: req.flash("flash")}
      
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
          User.findOne {email: req.body.login}, "", (err, user)->
            if user
              if user.password_correct(req.body.password)
                req.session.user_id = user._id
                req.flash "flash", "welcome"
                res.redirect "/home"

              else
                res.statusCode = 401
                req.flash "flash", "password not correct"
                res.redirect "tokens/new"
            else
              res.statusCode = 404
              req.flash "flash", "User not found"
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
    req.session.user_id = null
    req.flash "flash", "bye, user"
    res.redirect("/login")
      
  
