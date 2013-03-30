Admin = require '../models/admin'

# Admin model's CRUD controller.
module.exports = 

  login: (req, res, next) ->
    if req.method == "GET"
      res.render("admins/login", {flash: req.flash("flash")})
    else
      Admin.findOne {login: req.body.email}, "", (err, uu)->
        if uu
          if uu.password_correct(req.body.password)
            req.session.admin_id = uu._id
            res.redirect("/admins/users")
          else
            res.statusCode = 401
            req.flash "flash", "password not correct"
            res.redirect("admins/login")
        else
          res.statusCode = 401
          req.flash "flash", "login / email not exist"
          res.redirect("admins/login")

