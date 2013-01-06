UniqUser = require "../models/uniquser"
everyauth = require 'everyauth'

everyauth.everymodule.findUserById (email, callback)->
  UniqUser.findByEmail email, callback

module.exports =

  new: (req, res) ->
    req.format
      json: ()->
        res.end()

      html: ()->
        res.render "sessions/new"


  create: (req, res) ->
    auth = (params)->
      everyauth.password
    req.format
      json: ()->
        res.end()

      html: ()->
        res.render "sessions/new"

  destroy: (req, res) ->
