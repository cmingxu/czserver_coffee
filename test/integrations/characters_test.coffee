request = require 'supertest'
H = require "../test_helper"

Character = require process.cwd() + '/.app/models/character'
User      = require process.cwd() + '/.app/models/user'

app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "nick_name":"Some Data"
}

UPDATED_DATA = {
  "nick_name":"Another data"
}

token =  null

cleanDB = (done) ->
  Character.remove {}, ->
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
              token = res.body.token
              done()

describe 'Character', ->
  before cleanDB, H.fakeLogin
  
  character_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/characters")
      .send(INITIAL_DATA)
      .set("Auth-Token", token)
      .expect 201, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        character_id = res.body["_id"]
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/characters/#{character_id}")
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql character_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/characters")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()
    
  it "should be updated", (done) ->
    request(app)
      .put("/characters/#{character_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()
        
  it "should be persisted after update", (done) ->
    request(app)
      .get("/characters/#{character_id}")
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql character_id
        done()
  
  it "should be removed", (done) ->
    request(app)
      .del("/characters/#{character_id}")
      .expect 200, (err, res) ->
        done()
    
  it "should not be listed after remove", (done) ->
    request(app)
      .get("/characters")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()
        
  after cleanDB
      
