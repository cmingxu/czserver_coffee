Pmail = require process.cwd() + '/.app/models/pmail'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Pmail", ->
  before beforeHook
  it "should create new pmail", ->
