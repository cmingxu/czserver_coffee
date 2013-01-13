Uniquser = require process.cwd() + '/.app/models/uniquser'
require "../test_helper"

beforeHook = (done) ->
  @uu =  new Uniquser {email: "cming.xu@gmail.com", first_name: "Kevin", servers: ["127.0.0.1", "10.0.0.1"], last_server: "127.0.0.1", password: "123"}
  @sec = new Uniquser {email: "cming.xu@gmail.com", first_name: "Kevin", servers: ["127.0.0.1", "10.0.0.1"], last_server: "127.0.0.1", password: "123"}
  Uniquser.remove({}, (err)-> done() unless err)

describe "Uniquser", ->
  beforeEach beforeHook
  describe " validation ", ->
    it "email should valid format", (done)->
      @uu.email = "not email"
      @uu.save (err)->
        if err
          console.log err
          err.errors.email.should.include {type: FN.uniquser_email_not_valid[CONFIG.notice]}
          done()

    it "email should not be blank", (done)->
      @uu.email = ""
      @uu.save (err)->
        if err
          err.errors.email.should.include {type: FN.uniquser_email_not_blank[CONFIG.notice]}
          done()

    it "first name should not be blank", (done)->
      @uu.first_name = ""
      @uu.save (err)->
        if err
          err.errors.first_name.should.include {type: FN.uniquser_first_name_not_blank[CONFIG.notice]}
          done()

    it "email should be uniq", (done)->
      self = this
      @uu.save (err)->
        self.sec.save (err)->
          if err
            err.errors.email.should.include {type: FN.uniquser_email_should_be_uniq[CONFIG.notice]}
            done()

    it "password should present", (done)->
      @uu.password = undefined
      @uu.save (err)->
        if err
          err.errors.email.should.include {type: FN.uniquser_password_should_not_blank[CONFIG.notice]}
          done()

