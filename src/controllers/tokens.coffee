Token = require '../models/token'

# Token model's CRUD controller.
module.exports = 

  # Lists all tokens
  index: (req, res) ->
    Token.find {}, (err, tokens) ->
      res.format
        html: ()->
          res.render "tokens/index", tokens
        json: ()->
          res.send tokens

  # new token 
  new: (req, res) ->
    token = new Token
      
  # Creates new token with data from `req.body`
  create: (req, res) ->
    token = new Token req.body
    token.save (err, token) ->
      if not err
        res.send token
        res.statusCode = 201
      else
        res.send err
        
  # Gets token by id
  show: (req, res) ->
    Token.findById req.params.token, (err, token) ->
      if not err
        res.send token
      else
        res.send err
             
  # Updates token with data from `req.body`
  update: (req, res) ->
    Token.findByIdAndUpdate req.params.token, {"$set":req.body}, (err, token) ->
      if not err
        res.send token
      else
        res.send err
    
  # Deletes token by id
  destroy: (req, res) ->
    Token.findByIdAndRemove req.params.token, (err) ->
      if not err
        res.send {}
      else
        res.send err
      
  
