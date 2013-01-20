request = require 'supertest'
require "../test_helper"

app = require process.cwd() + '/.app'


cleanDB = (done) ->

describe 'Character', ->
  before cleanDB
  
  character_id = null
  it "should be created", (done) ->
