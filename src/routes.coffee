IndexController = require "#{ROOT}/controllers/index"
UsersController = require "#{ROOT}/controllers/users"


map = (app, resource_name)->
  app.resource resource_name + "s", require "#{ROOT}/controllers/#{resource_name}s"

module.exports  = (app) ->
  map(app, "user")
  map(app, "character")
  map(app, "charprop")
  map(app, "chartower")
  map(app, "pmail")
  map(app, "user")
  map(app, "token")

  app.get("/",                  IndexController.index)
  app.get("/admin/login",             require("#{ROOT}/controllers/admins").login)
  app.get("/admin/logout",      require("#{ROOT}/controllers/admins").logout)
  app.get("/admin/users",       require("#{ROOT}/controllers/users").index)
  app.post("/admin/do_login",   require("#{ROOT}/controllers/admins").login)

