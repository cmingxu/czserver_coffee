request = require 'supertest'
require "../test_helper"

Character = require process.cwd() + '/.app/models/character'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "name":"Some Data"
}

UPDATED_DATA = {
  "name":"Another data"
}

cleanDB = (done) ->
  Character.remove {}, ->
    done()

describe 'Character', ->
  before cleanDB
  
  character_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/characters")
      .send(INITIAL_DATA)
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
      