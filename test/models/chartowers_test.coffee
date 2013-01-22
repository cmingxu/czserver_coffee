Chartower = require process.cwd() + '/.app/models/chartower'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Chartower Model", ->
  before beforeHook
  it "should create new chartower", ->
