Admin = require "#{ROOT}/models/admin"
User = require "#{ROOT}/models/user"

admin_paths = ["GET#/admin/users", "DELETE#users/.*"]
user_paths  = ["GET#/users/.*", "GET#/users/.*", "PUT#/users/.*"]

login_from_cookie = (req, res, next)->
  console.log _.some(admin_paths, (p)-> !!("#{req.method.toUpperCase()}##{req.path}".match(p)))
  if _.some(admin_paths, (p)-> !!("#{req.method.toUpperCase()}##{req.path}".match(p)))
    if req.session.admin_id
      Admin.findOne req.session.admin_id, "", (err, uu)->
        console.log uu
        if uu
          req.admin = uu
          req.logged_in = true
          next()
        else
          next()
    else
      next()
  else if _.any(user_paths, (p)-> "#{req.method.toUpperCase()}#{req.path}".match(p))
    if req.session.user_id
      User.findOne req.session.user_id, "", (err, uu)->
        if uu
          req.user = uu
          req.logged_in = true
          next()
        else
          next()
    else
      next()
  else
    next()

module.exports = login_from_cookie

