Character = require process.cwd() + '/.app/models/character'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Character", ->
  before beforeHook
  it "should create new character", ->
