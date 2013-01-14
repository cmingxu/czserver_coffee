Uniquser = require './uniquser'


class Token
  constructor: (body)->
    @email = body.email
    @password = body.password

    @


  save: (callback)->
    self = this
    Uniquser.findOne {email: self.email}, "", (err, uu)->
      if uu
        if uu.password_correct(self.password)
          token = new Buffer(uu._id + "/" + ((new Date()).valueOf()), "utf8").toString("base64")
          #save token in redis
          callback null, token
        else
          callback {message: "", result: "password not valid"}, null
      else
          callback {message: "", result: "email not exist"}, null

  @remove: (condtions, callback)->
    callback()




module.exports = Token
