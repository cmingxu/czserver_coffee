skip_white_list = ["/tokens", "/users"]

login_required = (req, res, next)->
  if _.include(skip_white_list, req.url)
    next()
  else
    if req.logged_in
      next()
    else
      res.statusCode = 401
      res.end()



module.exports = login_required

