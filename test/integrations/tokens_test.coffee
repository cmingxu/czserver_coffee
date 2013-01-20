request = require 'supertest'

Token = require process.cwd() + '/.app/models/token'
User = require process.cwd() + '/.app/models/user'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "email":"cming.xu@gmail.com"
  "password": "123"
}


insertUU = (done) ->
  uu = new User(INITIAL_DATA)
  uu.save (err, res)->
    done() unless err


cleanDB = (done) ->
  Token.remove {}, ->
    done()

describe 'Token', ->
  before insertUU
  
  token_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/tokens")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.token.should.match /\w{12,}/
        token_id = res.body
        done()
        
  after cleanDB
      
