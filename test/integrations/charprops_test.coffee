request = require 'supertest'
require "../test_helper"

Charprop = require process.cwd() + '/.app/models/charprop'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "level": 100
}

UPDATED_DATA = {
  "level": 99
}

cleanDB = (done) ->
  Charprop.remove {}, ->
    done()

describe 'Charprop', ->
  before cleanDB
  
  charprop_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/charprops")
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
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql charprop_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/charprops")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()
    
  it "should be updated", (done) ->
    request(app)
      .put("/charprops/#{charprop_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()
        
  it "should be persisted after update", (done) ->
    request(app)
      .get("/charprops/#{charprop_id}")
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql charprop_id
        done()
  
  it "should be removed", (done) ->
    request(app)
      .del("/charprops/#{charprop_id}")
      .expect 200, (err, res) ->
        done()
    
  it "should not be listed after remove", (done) ->
    request(app)
      .get("/charprops")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()
        
  after cleanDB
      