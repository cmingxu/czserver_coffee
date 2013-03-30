skip_white_list = [
  "GET#/login", 
  "GET#/admin/logout"
  "GET#/admin/login"
  "POST#/admin/do_login", 
  "GET#/tokens/new",
  "GET#/register",
  "POST#/tokens",
  "POST#/users",
]


login_required = (req, res, next)->
  if _.include(skip_white_list, "#{req.method.toUpperCase()}##{req.url}")
    next()
  else
    if req.logged_in
      res.locals['user'] = req.user || req.admin
      res.locals['is_admin']  = true  if req.admin
      res.locals['is_user']   = false if req.admin
      res.locals['is_user']   = true  if req.user
      res.locals['is_admin']  = false if req.user
      next()
    else
      res.statusCode = 401
      if req.is("json")
        res.end('{"error": "no authorization"}')
      else
        req.flash("flash", "you just access limited resource, login required")
        res.redirect("/admin/login")



module.exports = login_required

