Token = require process.cwd() + '/.app/models/token'
User  = require process.cwd() + '/.app/models/user'

user = null
beforeHook = (done) ->
  User.remove {}, ()->
    uu = new User({email: "cming.xu@gmail.com", password: "123"})
    user = uu
    uu.save (err, uu)->
      done() unless err

afterHook = (done) ->
  User.remove {}, ()->
    Token.remove {}, ()->
      done()

describe "Token Model", ->
  beforeEach beforeHook
  afterEach afterHook

  it "should create new token", (done)->
    t = new Token({email: "cming.xu@gmail.com", password: "123"})
    t.save (err, token)->
      token.hasCharacter.should.be.false
      done()

  it "should login with token", ->
