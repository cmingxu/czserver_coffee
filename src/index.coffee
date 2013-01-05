require './boot'
express = require 'express'
Resource = require 'express-resource'
stylus = require 'stylus'
assets = require 'connect-assets'
global.MongoBase = require "#{ROOT}/models/mongo_base"
global.Schema    = MongoBase.Schema
MongoBase.connect()

app = express()


app.port = CONFIG.port


app.use express.favicon()
app.use assets()
app.use express.static(process.cwd() + '/public')

app.use express.logger CONFIG.loglevel
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.responseTime()
app.use (req, res, next)->
  next()


app.use (err, req, res, next)->
  console.error(err.stack)
  res.send(500, 'Something broke!')
 
app.set 'view engine', 'jade'

app.use express.bodyParser()


routes = require './routes'
routes(app)


module.exports = app

