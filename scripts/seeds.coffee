fs = require 'fs'
path = require 'path'
crypto = require 'crypto'
charlatan = require 'charlatan'
async = require 'async'


APP_ROOT = __dirname + "/../.app"
process.env.NODE_ENV      = "test"
require path.join(APP_ROOT, "boot")
UniqUser = require path.join(APP_ROOT, "models", "uniquser")
User = require path.join(APP_ROOT, "models", "user")
server_list = CONFIG.server_list
console.log server_list
console.log CONFIG
MongoBase.connect()

uniqusers = [
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123").digest("hex"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123").digest("hex"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123").digest("hex"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123").digest("hex"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123").digest("hex"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
  {email: charlatan.Internet.email(), hashed_password: crypto.createHash('sha1').update("123").digest("hex"), first_name: charlatan.Name.name(), last_name: charlatan.Name.name() , last_server: _.first(_.shuffle(server_list)) }
]

users = [
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
  {nick_name: charlatan.Name.name(), server: _.first(_.shuffle(server_list)), gold: 1000, money: 1000, food: 1000, vip: "Vip1"}
]

gen_uniq_users = () ->
  uniqusers.forEach (uu)->
    uuser = new UniqUser(uu)
    uuser.save (err) ->
      console.log err if err




gen_users = () ->
  users.forEach (u)->
    user = new User(u)
    UniqUser.find (err, uus)->
      user.uniq_user = _.first(_.shuffle(uus))
      console.log user.uniq_user
      user.save (err) ->
        console.log err if err

#gen_uniq_users()

#gen_users()

         #async.series [gen_uniq_users, gen_users]
