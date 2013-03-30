skip_white_list = ["GET#/login", "POST#/admin/do_login", "GET#/tokens/new", "POST#/tokens"]

login_required = (req, res, next)->
  if _.include(skip_white_list, "#{req.method.toUpperCase()}##{req.url}")
    next()
  else
    if req.logged_in
      res.locals['user'] = req.user || req.admin
      next()
    else
      res.statusCode = 401
      if req.is("json")
        res.end('{"error": "no authorization"}')
      else
        req.flash("flash", "you just access limited resource, login required")
        res.redirect("/login")



module.exports = login_required

