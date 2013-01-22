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
          #save token in redis
          callback null, {token: token, hasCharacter: false}
        else
          callback ErrorHelper.toMongooseError("password", FN.token_password_not_correct[CONFIG.notice]), null
      else
          callback ErrorHelper.toMongooseError("email",  FN.token_email_not_exist[CONFIG.notice]), null

  @remove: (conditions, callback)->
    callback()

  @loginWithToken: (req, callback)->
    try
      token = new Buffer(req.get("Auth-Token"), "base64").toString("utf8")
      user_id = token.split("/")[0]
      token_created_at = token.split("/")[1]
    catch e
      callback e, null
    

    User.findOne {id: user_id}, (err, user)->
      callback err, user




module.exports = Token
