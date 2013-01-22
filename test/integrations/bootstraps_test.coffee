request = require 'supertest'
require "../test_helper"

app = require process.cwd() + '/.app'


cleanDB = (done) ->
  done()

describe 'bootstrap ', ->
  
