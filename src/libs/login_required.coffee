login_required = (req, res, next)->
  console.log req.headers
  next()


module.exports = login_required

