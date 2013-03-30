crypto = require 'crypto'

class Admin extends MongoBase
  @schema = @Schema(
    login: String
    hashed_password : String
    salt :  String
    real_name : String
  )

  @schema.methods.password_correct = (password)->
    this.hashed_password == crypto.createHash("sha1").update(this.salt + "/" + password).digest("hex")

admin = Admin.initialize()

# TODO
# virtual attributes
Admin.schema.virtual('password').set((password)->
  if password && password.length
    this.salt = crypto.randomBytes(16).toString('base64').replace(/\//g,'_').replace(/\+/g,'-')
    this.hashed_password =  crypto.createHash('sha1').update(this.salt + "/" + password).digest("hex")
  else
    this.salt = ""
    this.hashed_password = ""
)


module.exports = admin
