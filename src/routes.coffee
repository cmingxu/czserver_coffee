UsersController = require "#{ROOT}/controllers/users"
IndexController = require "#{ROOT}/controllers/index"

module.exports  = (app) ->
  app.resource("users", UsersController)


  app.get("/", IndexController.index)
