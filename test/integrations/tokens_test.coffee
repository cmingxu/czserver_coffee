request = require 'supertest'

Token = require process.cwd() + '/.app/models/token'
Uniquser = require process.cwd() + '/.app/models/uniquser'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "email":"cming.xu@gmail.com"
  "password": "123"
}


cleanDB = (done) ->
  uu = new Uniquser(INITIAL_DATA)

  Token.remove {}, ->
    done()

describe 'Token', ->
  before cleanDB
  
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
      
