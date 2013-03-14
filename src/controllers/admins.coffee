Admin = require '../models/admin'

# Admin model's CRUD controller.
module.exports = 

  login: (req, res, next) ->
    if req.method == "GET"
      res.render("admins/login", {"field": "field content"})
    else
      Admin.findOne {email: req.body.email}, "", (err, uu)->
        if uu
          if uu.password_correct(req.body.password)
            req.logged_in = true
            res.redirect_to("admins/users")
          else
            res.statusCode = 401
            res.render("admins/login", {field: "password", message: "password not correct", info: req.flash("info")})
        else
          res.statusCode = 401
          res.render("admins/login",  {"field": "email", message: "login / email not exists", info: req.flash("info")})

