Character = require process.cwd() + '/.app/models/character'
require "../test_helper"

INIT_DATA =
  nick_name: "nick_name"
  job: "道士"
  gender: "Male"

beforeHook = (done) ->
  Character.remove (err, result)->
    done()

describe "Character Model", ->
  before beforeHook

  it "should create a record when data are valid", (done) -> 
    c = new Character(INIT_DATA)
    c.save done

  it "should fail validation when jop not provided", (done)->
    c = new Character()
    done()
  it "should set hp to default value", (done)->
    done()
