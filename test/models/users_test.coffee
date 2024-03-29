User = require process.cwd() + '/.app/models/user'
require "../test_helper"

beforeHook = () ->
  @uu =  new User {email: "cming.xu@gmail.com", first_name: "Kevin", servers: ["127.0.0.1", "10.0.0.1"], last_server: "127.0.0.1", password: "123"}
  @sec = new User {email: "cming.xu@gmail.com", first_name: "Kevin", servers: ["127.0.0.1", "10.0.0.1"], last_server: "127.0.0.1", password: "123"}

afterHook = (done) ->
  User.remove({}, (err)-> done() unless err)


describe "User validation ", ->
  beforeEach beforeHook
  afterEach afterHook
  it "email should valid format", (done)->
    @uu.email = "not email"
    @uu.save (err)->
      if err
        err.errors.email.should.include {type: FN.user_email_not_valid[CONFIG.notice]}
        done()

  it "email should not be blank", (done)->
    @uu.email = ""
    @uu.save (err)->
      if err
        err.errors.email.should.include {type: FN.user_email_not_valid[CONFIG.notice]}
        done()

  it "email should be uniq", (done)->
    self = this
    @uu.save (err)->
      self.sec.save (err)->
        if err
          err.errors.email.should.include {type: FN.user_email_should_be_uniq[CONFIG.notice]}
          done()

  it "hashed_password should be set", (done)->
    @uu.save (err)->
      User.find()
        .limit(1)
        .exec (err, uu)->
          crypto = require 'crypto'
          if uu[0].hashed_password == crypto.createHash("sha1").update(uu[0].salt + "/" + "123").digest("hex")
            done()



