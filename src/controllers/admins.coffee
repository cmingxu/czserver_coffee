Admin = require '../models/admin'

# Admin model's CRUD controller.
module.exports = 

  login: (req, res, next) ->
    if req.method == "GET"
      res.render("admins/login")
    else
      User.findOne {email: req.body.login}, "", (err, uu)->
        if uu
          if uu.password_correct(req.body.password)
            req.logged_in = true
            req.session.user = uu
          else
            res.render("admins/login", {"field": "password", "message": "password not correct"})
        else
          res.render("admins/login", {"field": "email", "message": "login / email not exists"})

