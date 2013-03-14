skip_white_list = ["/tokens", "/users", "/login", "/admin/do_login"]

login_required = (req, res, next)->
  if _.include(skip_white_list, req.url)
    next()
  else
    if req.logged_in
      res.locals['user'] = req.user
      next()
    else
      res.statusCode = 401
      if req.is("json")
        res.end('{"error": "no authorization"}')
      else
        req.flash("info", "you just access limited resource, login required")
        res.redirect("/login")



module.exports = login_required

