request = require 'supertest'
require "../test_helper"

Pmail = require process.cwd() + '/.app/models/pmail'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "title":"Some Data"
  "content":"Some Data"
}

UPDATED_DATA = {
  "title":"Another data"
  "content":"Another data"
}

cleanDB = (done) ->
  Pmail.remove {}, ->
    done()

describe 'Pmail', ->
  before cleanDB
  
  pmail_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/pmails")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        pmail_id = res.body["_id"]
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/pmails/#{pmail_id}")
      .expect 200, (err, res) ->
        res.body.should.include(INITIAL_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql pmail_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/pmails")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(INITIAL_DATA)
        done()
    
  it "should be updated", (done) ->
    request(app)
      .put("/pmails/#{pmail_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        done()
        
  it "should be persisted after update", (done) ->
    request(app)
      .get("/pmails/#{pmail_id}")
      .expect 200, (err, res) ->
        res.body.should.include(UPDATED_DATA)
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql pmail_id
        done()
  
  it "should be removed", (done) ->
    request(app)
      .del("/pmails/#{pmail_id}")
      .expect 200, (err, res) ->
        done()
    
  it "should not be listed after remove", (done) ->
    request(app)
      .get("/pmails")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 0
        done()
        
  after cleanDB
      
