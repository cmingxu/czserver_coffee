Token = require '../models/token'

# Token model's CRUD controller.
module.exports = 
  # new token 
  new: (req, res) ->
    res.render "tokens/new", {info: req.flash("info")}
      
  # Creates new token with data from `req.body`
  create: (req, res) ->
    token = new Token req.body
    token.save (err, token) ->
      if not err
        result = token
        res.statusCode = 201
      else
        result = err
        req.flash "info", result
        res.statusCode = 422

      res.format(
        json: ()->
          res.send result
        html: ()->
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
      
  
