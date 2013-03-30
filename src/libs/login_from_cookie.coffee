Admin = require "#{ROOT}/models/admin"
User = require "#{ROOT}/models/user"

login_from_cookie = (req, res, next)->
  if req.path.match(/^\/admin/) # request from admin
    if req.session.admin_id
      Admin.findOne req.session.admin_id, "", (err, uu)->
        if uu
          req.admin = uu
          req.logged_in = true
          next()
        else
          next()
    else
      next()
  else
    next()

module.exports = login_from_cookie

