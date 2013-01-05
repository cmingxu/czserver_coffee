Uniquser = require process.cwd() + '/.app/models/uniquser'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Uniquser", ->
  before beforeHook
  it "should create new uniquser", ->
