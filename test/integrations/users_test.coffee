request = require 'supertest'
H = require "../test_helper"
charlatan = require 'charlatan'

User = require process.cwd() + '/.app/models/user'
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
  User.remove {}, ->
    done()

describe 'User', ->
  before cleanDB, H.fakeLogin
  
  user_id = null
      
  it "should be created", (done) ->
    request(app)
      .post("/users")
      .send(INITIAL_DATA)
      .expect 201, (err, res) ->
        res.body.should.include(_.pick(INITIAL_DATA, "email"))
        res.body.should.have.property "_id"
        res.body["_id"].should.be.ok
        user_id = res.body["_id"]
        done()

  it "should not be created when email not valid", (done) ->
    request(app)
      .post("/users")
      .send({email: "add"})
      .expect 422, (err, res) ->
        res.body.errors.should.include {type: FN.user_email_not_valid[CONFIG.notice], resource: "user", path: "email"}
        done()
        
  it "should not be created when email emapty", (done) ->
    request(app)
      .post("/users")
      .send({email: ""})
      .expect 422, (err, res) ->
        res.body.errors.should.include {type: FN.user_email_not_valid[CONFIG.notice], resource: "user", path: "email"}
        done()
        
  it "should be accessible by id", (done) ->
    request(app)
      .get("/users/#{user_id}")
      .expect 200, (err, res) ->
        res.body.should.include(_.pick(INITIAL_DATA, "email"))
        res.body.should.have.property "_id"
        res.body["_id"].should.be.eql user_id
        done()
        
  it "should be listed in list", (done) ->
    request(app)
      .get("/users")
      .set("Accept", "application/json")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.have.length 1
        res.body[0].should.include(_.pick(INITIAL_DATA, "email"))
        done()
    
  it "should be updated", (done) ->
    request(app)
      .put("/users/#{user_id}")
      .send(UPDATED_DATA)
      .expect 200, (err, res) ->
        res.body.should.include(_.pick(UPDATED_DATA, "email"))
        done()

  it "should not be updated when email empty", (done) ->
    request(app)
      .put("/users/#{user_id}")
      .send({email: ""})
      .expect 422, (err, res) ->
        res.body.errors.should.include {type: FN.user_email_not_valid[CONFIG.notice], resource: "user", path: "email"}
        done()

  after cleanDB
