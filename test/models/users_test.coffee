User = require process.cwd() + '/.app/models/user'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "User", ->
  before beforeHook
  it "should create new user", ->
