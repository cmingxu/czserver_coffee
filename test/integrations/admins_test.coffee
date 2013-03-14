request = require 'supertest'

Admin = require process.cwd() + '/.app/models/admin'
app = require process.cwd() + '/.app'


INITIAL_DATA = {
  "someField":"Some Data"
}

UPDATED_DATA = {
  "someField":"Another data"
}

cleanDB = (done) ->
  Admin.remove {}, ->
    done()

describe 'Admin', ->
