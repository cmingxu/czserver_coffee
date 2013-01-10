Uniquser = require process.cwd() + '/.app/models/uniquser'
require "../test_helper"

beforeHook = (done) ->
  done()

describe "Uniquser", ->
  before beforeHook
  describe " validation ", -> 
    it "email should not blank", -> 
    it "email should be valid", -> 
    it "email should be uniq", -> 
    it "password should present", -> 
    it "password confirmation should present", -> 
    it "password confirmation should be same as password", -> 
