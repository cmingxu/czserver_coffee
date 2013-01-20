request = require 'supertest'
Helper = require "../test_helper"


app = require process.cwd() + '/.app'


describe 'UniqServer', ->
  beforeEach  Helper.fakeLogin
  uniqserver = null
      
  it "should be created", (done) ->
    request(app)
      .post("/uniqusers")
      .expect 201, (err, res) ->
        done()

        
  it "should be listed", (done) ->
    request(app)
      .get("/uniqservers")
      .set("Accept", "application/json")
      .expect 200, (err, res) ->
        res.body.should.be.an.instanceof Array
        res.body.should.eql CONFIG.server_list
        done()
