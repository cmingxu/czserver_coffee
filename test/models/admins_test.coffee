Admin = require process.cwd() + '/.app/models/admin'

beforeHook = (done) ->
  done()

describe "Admin", ->
  before beforeHook
  it "should create new admin", ->
