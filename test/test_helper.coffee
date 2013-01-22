request = require 'supertest'
app = require process.cwd() + '/.app'
process.env.NODE_ENV = "test"

User = require "#{ROOT}/models/user"
Token = require "#{ROOT}/models/token"


fakeLogin = (done)->
  authentications = {email: "cming.xu@gmail.com", password: "123"}
  uu = new User(authentications)
  User.remove {}, (err, affectRow)->
    if not err
      uu.save (err, uu) ->
        if not err
          request(app)
          .post("/tokens")
          .send(authentications)
          .expect 201, (err, res) ->
            res.body.token.should.match /\w{12,}/
            token_id = res.body.token
            done()
 


module.exports.fakeLogin = fakeLogin
