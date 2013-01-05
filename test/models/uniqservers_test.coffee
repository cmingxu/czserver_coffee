Uniqserver = require process.cwd() + '/.app/models/uniqserver'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Uniqserver", ->
  before beforeHook
  it "should create new uniqserver", ->
