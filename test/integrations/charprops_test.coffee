request = require 'supertest'
require "../test_helper"

Charprop = require process.cwd() + '/.app/models/charprop'
User     = require process.cwd() + '/.app/models/user'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "level": 100
}

UPDATED_DATA = {
  "level": 99
}
token = null

cleanDB = (done) ->
  Charprop.remove {}, ->
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

describe 'Charprop', ->
  before cleanDB
  
  charprop_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/charprops")
      .set('Auth-Token', token)
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        charprop_id = res.body["_id"]
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/charprops/#{charprop_id}")
      .set('Auth-Token', token)
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql charprop_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/charprops")
      .set('Auth-Token', token)
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()
    
  it "should be updated", (done) ->
    request(app)
      .put("/charprops/#{charprop_id}")
      .set('Auth-Token', token)
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()
        
  it "should be persisted after update", (done) ->
    request(app)
      .get("/charprops/#{charprop_id}")
      .set('Auth-Token', token)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql charprop_id
        done()
  
  it "should be removed", (done) ->
    request(app)
      .del("/charprops/#{charprop_id}")
      .set('Auth-Token', token)
      .expect 200, (err, res) ->
        done()
    
  it "should not be listed after remove", (done) ->
    request(app)
      .get("/charprops")
      .set('Auth-Token', token)
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()
        
  after cleanDB
      
