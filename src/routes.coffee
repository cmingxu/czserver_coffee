IndexController = require "#{ROOT}/controllers/index"
SessionsController = require "#{ROOT}/controllers/sessions"


map = (app, resource_name)->
  app.resource resource_name + "s", require "#{ROOT}/controllers/#{resource_name}s"

module.exports  = (app) ->
  map(app, "user")
  map(app, "character")
  map(app, "charprop")
  map(app, "chartower")
  map(app, "pmail")
  map(app, "uniquser")
  map(app, "token")

  app.get("/", IndexController.index)
  app.get("/login", SessionsController.new)
  app.post("/login", SessionsController.create)
  app.delete("/logout", SessionsController.destroy)

