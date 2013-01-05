require './boot'
express = require 'express'
Resource = require 'express-resource'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'

#### Basic application initialization
# Create app instance.
app = express()


# Define Port
app.port = CONFIG.port



mongoose.connect "mongodb://#{CONFIG.mongo_host}/#{CONFIG.mongo_name}"



#### View initialization 
# Add Connect Assets.
app.use assets()
# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')
 

# Set View Engine.
app.set 'view engine', 'jade'

# [Body parser middleware](http://www.senchalabs.org/connect/middleware-bodyParser.html) parses JSON or XML bodies into `req.body` object
app.use express.bodyParser()


#### Finalization
# Initialize routes
routes = require './routes'
routes(app)


# Export application object
module.exports = app

