GameConfig = require process.cwd() + '/.app/models/game_config'
require "../test_helper"
_ = require 'underscore'

beforeHook = (done) ->
  done()

describe "Game Config Model", ->
  before beforeHook
  it "should be contains good config", ->
    _.keys(GameConfig).should.include "goods"


  it "should be has type attr", ->
    _.keys(GameConfig['goods']).should.include "type"
