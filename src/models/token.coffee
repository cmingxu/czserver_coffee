User = require './user'

class Token
  constructor: (body)->
    @email = body.email
    @password = body.password
    @


  save: (callback)->
    self = this
    User.findOne {email: self.email}, "", (err, uu)->
      if uu
        if uu.password_correct(self.password)
          token = new Buffer(uu._id + "/" + ((new Date()).valueOf()), "utf8").toString("base64")
          redis_client.hmset token, {user_id: uu._id.toString()}, (err)->
            callback null, {token: token, hasCharacter: false}
        else
          callback ErrorHelper.toMongooseError("password", FN.token_password_not_correct[CONFIG.notice]), null
      else
          callback ErrorHelper.toMongooseError("email",  FN.token_email_not_exist[CONFIG.notice]), null

  @remove: (conditions, callback)->
    callback()

  @loginWithToken: (token, callback)->
    redis_client.hgetall token, (err, result)->
      if err
        callback err, null
      else
        if result && result.user_id
          User.findOne {_id: result.user_id}, "", (err, user)->
            callback err, user
        else
          callback {}, null
          




module.exports = Token
