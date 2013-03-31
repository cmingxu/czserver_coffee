Admin = require "#{ROOT}/models/admin"
User = require "#{ROOT}/models/user"

admin_paths = ["GET#/admin/users", "DELETE#/users/.*"]
user_paths  = ["GET#/users/.*", "GET#/users/.*", "PUT#/users/.*", "GET#/home", "PUT#/characters/.*"]


login_from_cookie = (req, res, next)->
  console.log "#{req.method.toUpperCase()}##{req.path}"
  if _.some(admin_paths, (p)-> !!("#{req.method.toUpperCase()}##{req.path}".match(p)))
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
  else if _.some(user_paths, (p)-> "#{req.method.toUpperCase()}##{req.path}".match(p))
    if req.session.user_id
      User.findOne {_id: req.session.user_id}, "", (err, uu)->
        if uu
          req.user = uu
          req.logged_in = true
          uu.with_its_character (err, character) ->
            if character
              req.user.character = character
            next()
        else
          next()
    else
      next()
  else
    next()

module.exports = login_from_cookie

