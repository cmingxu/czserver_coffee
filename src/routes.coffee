IndexController = require "#{ROOT}/controllers/index"


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

  app.get("/", IndexController.index)

