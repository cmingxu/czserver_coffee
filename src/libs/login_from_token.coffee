login_from_token = (req, res, next)->
  req.session.logged_in = true
  next()



module.exports = login_from_token

