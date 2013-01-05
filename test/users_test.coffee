request = require 'supertest'

User = require process.cwd() + '/.app/models/user'
app = require process.cwd() + '/.app'

cleanDB = (done) ->
  User.remove {}, ->
    done()

describe 'User', ->
