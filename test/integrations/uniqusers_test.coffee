request = require 'supertest'
require "../test_helper"
charlatan = require 'charlatan'

UniqUser = require process.cwd() + '/.app/models/uniquser'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "email": charlatan.Internet.email()
  "password": "123"
}

UPDATED_DATA = {
  "email": charlatan.Internet.email()
  "password": "123"
}

cleanDB = (done) ->
  UniqUser.remove {}, ->
    done()

describe 'UniqUser', ->
  before cleanDB
  
  user_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/uniqusers")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(_.pick(INITIAL_DATA, "email"))
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        user_id = res.body["_id"]
        done()

  it "should not be created when email not valid", (done) ->
    request(app)
      .post("/uniqusers")
      .send({email: "add"})
      .expect 422, (err, res) ->
        res.body.errors.should.include {type: FN.uniquser_email_not_valid[CONFIG.notice], resource: "uniquser", path: "email"}
        done()
        
  it "should not be created when email emapty", (done) ->
    request(app)
      .post("/uniqusers")
      .send({email: ""})
      .expect 422, (err, res) ->
        res.body.errors.should.include {type: FN.uniquser_email_not_blank[CONFIG.notice], resource: "uniquser", path: "email"}
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/uniqusers/#{user_id}")
      .expect 200, (err, res) ->
        res.body.should.include(_.pick(INITIAL_DATA, "email"))
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql user_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/uniqusers")
      .set("Accept", "application/json")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(_.pick(INITIAL_DATA, "email"))
        done()
    
  it "should be updated", (done) ->
    request(app)
      .put("/uniqusers/#{user_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(_.pick(UPDATED_DATA, "email"))
        done()

  it "should not be updated when email empty", (done) ->
    request(app)
      .put("/uniqusers/#{user_id}")
      .send({email: ""})
      .expect 422, (err, res) ->
        res.body.errors.should.include {type: FN.uniquser_email_not_blank[CONFIG.notice], resource: "uniquser", path: "email"}
        done()

  after cleanDB
