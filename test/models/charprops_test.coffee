Charprop = require process.cwd() + '/.app/models/charprop'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Charprop Model", ->
  before beforeHook
  it "should create new charprop", ->
