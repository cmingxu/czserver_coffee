Admin = require '../models/admin'

# Admin model's CRUD controller.
module.exports = 

  login: (req, res, next) ->
    if req.method == "GET"
      res.render("admins/login")
    else

      
  
