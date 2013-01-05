request = require 'supertest'
app = require process.cwd() + '/.app'


describe 'General', ->
  describe 'Main page', ->
    it "should be here", (done) ->
      request(app)
        .get("/")
        .send( {} )
        .expect(200, {}, done
        )

  describe 'JSON request', ->
    it "should return with a json object", (done) ->
      request(app)
        .get("/")
        .set('Accept', 'application/json')
        .set('Content-type', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200, {"index", "index"}, done
        )
