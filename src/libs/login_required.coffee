skip_white_list = [
  "GET#/", 
  "GET#/register",
  "GET#/login", 
  "GET#/logout", 
  "GET#/tokens/new",
  "POST#/tokens",
  "POST#/users",

  "GET#/admin/logout"
  "GET#/admin/login"
  "POST#/admin/do_login", 

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
        res.redirect("/users/login")



module.exports = login_required

