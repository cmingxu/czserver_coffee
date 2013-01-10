Uniquser = require process.cwd() + '/.app/models/uniquser'
require "../test_helper"

beforeHook = () ->
  @BODY = {email: "cming.xu@gmail.com", first_name: "Kevin", servers: ["127.0.0.1", "10.0.0.1"], last_server: "127.0.0.1"}

describe "Uniquser", ->
  before beforeHook
  describe " validation ", ->
    it "email should valid format", (done)->
      @uu = new Uniquser @BODY
      @uu.email = "not email"
      @uu.save (err)->
        if err
          err.errors.email.should.include {type: FN.uniquser_email_not_valid[CONFIG.notice]}
          done()

    it "email should not be blank", (done)->
      @uu = new Uniquser @BODY
      @uu.email = ""
      @uu.save (err)->
        if err
          err.errors.email.should.include {type: FN.uniquser_email_not_blank[CONFIG.notice]}
          done()

    it "email should be uniq", (done)->
      @uu = new Uniquser @BODY
      BODY = @BODY
      @uu.save (err)->
        @second = new Uniquser BODY
        @second.save (err)->
          if err
            err.errors.email.should.include {type: FN.uniquser_email_should_be_uniq[CONFIG.notice]}
            done()

    it "password should present", ->
    it "password confirmation should present", ->
    it "password confirmation should be same as password", ->
