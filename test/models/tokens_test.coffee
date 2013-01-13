Token = require process.cwd() + '/.app/models/token'

beforeHook = (done) ->
  done()

describe "Token", ->
  before beforeHook
  it "should create new token", ->
