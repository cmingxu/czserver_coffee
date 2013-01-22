Pmail = require process.cwd() + '/.app/models/pmail'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Pmail Model", ->
  before beforeHook
  it "should create new pmail", ->
