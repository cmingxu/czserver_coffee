login_from_cookie = (req, res, next)->
  if req.path.match(/^\/admin/)
    if req.session.user_id
      User.findOne req.session.user_id, "", (err, uu)->
        if uu
          req.session.user = uu
          req.logged_in = true
          next()
        else
          next()
    else
      next()

  else
    next()

module.exports = login_from_cookie

