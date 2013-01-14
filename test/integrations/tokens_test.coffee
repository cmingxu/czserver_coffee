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
        res.body.should.match /\w{12,}/
        token_id = res.body
        done()
  #      
  #it "should be accessible by id", (done) ->
  #  request(app)
  #    .get("/tokens/#{token_id}")
  #    .expect 200, (err, res) ->
  #      res.body.should.include(INITIAL_DATA)
  #      res.body.should.have.property "_id"
  #      res.body["_id"].should.be.eql token_id
  #      done()
  #      
  #it "should be removed", (done) ->
  #  request(app)
  #    .del("/tokens/#{token_id}")
  #    .expect 200, (err, res) ->
  #      done()
  #  
  #it "should not be listed after remove", (done) ->
  #  request(app)
  #    .get("/tokens")
  #    .set("accept", "application/json")
  #    .expect 200, (err, res) ->
  #      res.body.should.be.an.instanceof Array
  #      res.body.should.have.length 0
  #      done()
        
  after cleanDB
      
