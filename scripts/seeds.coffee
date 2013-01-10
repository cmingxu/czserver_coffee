fs = require 'fs'
path = require 'path'
crypto = require 'crypto'
charlatan = require 'charlatan'
async = require 'async'


APP_ROOT = __dirname + "/../.app"
require path.join(APP_ROOT, "boot")
console.log path.join(APP_ROOT, "src/models", "uniquser")
UniqUser = require path.join(APP_ROOT, "models", "uniquser")
User = require path.join(APP_ROOT, "models", "user")
server_list = CONFIG.server_list
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


funcs = []
uniqusers.forEach (uu)->
  funcs.push (callback)->
    uuser = new UniqUser(uu)
    uuser.save (err) ->
      callback err if err
      callback null




users.forEach (u)->
  funcs.push (callback)->
    user = new User(u)
    UniqUser.find (err, uus)->
      user.uniq_user = _.first(_.shuffle(uus))
      user.save (err) ->
        callback err if err
        callback null

async.series funcs#, (err, results) -> console.log err if err
