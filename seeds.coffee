fs = require 'fs'
path = require 'path'
crypto = require 'crypto'
charlatan = require 'charlatan'


APP_ROOT = __dirname + "/.app"
process.env.NODE_ENV      = "dev"
require path.join(APP_ROOT, "boot")
UniqUser = require path.join(APP_ROOT, "models", "uniquser")
User = require path.join(APP_ROOT, "models", "user")
server_list = CONFIG.server_list

uniqusers = [
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
]

users = [
  {}
]

uniqusers.forEach (uu)->
  uuser = new UniqUser(uu)
  console.log uuser
  uuser.save (err) ->
    console.log err if err
