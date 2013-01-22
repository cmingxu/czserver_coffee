Token = require "#{ROOT}/models/token"

login_from_token = (req, res, next)->
  if req.get('Auth-Token')
    Token.loginWithToken req.get('Auth-Token'), (err, user)->
      if not err
        req.logged_in = true
        req.user = user
        next()
      else
        next()
  else
    next()
    

module.exports = login_from_token

