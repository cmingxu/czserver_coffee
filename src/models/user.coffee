crypto = require 'crypto'

class User extends MongoBase
  @schema = @Schema(
    email : {type: String, validate: [@validation({message: FN.user_email_not_blank[CONFIG.notice]}, "notEmpty"), @validation({passIfEmpty: true, message: FN.user_email_not_valid[CONFIG.notice]}, "isEmail")]}
    hashed_password : String
    salt :  String
    real_name : String
    gold : Number
    money : Number
    food : Number
    vip  : { type : String, enum : ['Vip1', 'Vip2', 'Vip3']}
    created_at : {type:Date, default: Date.now}
    updated_at : {type:Date, default: Date.now}
  )

  @schema.statics.findByName = (name, cb)->
    this.find({ name: new RegExp(name, 'i') }, cb)

  @schema.statics.findByEmail = (email, cb)->
    this.findOne({ email: email }).exec cb

  @schema.methods.password_correct = (password)->
    this.hashed_password == crypto.createHash("sha1").update(this.salt + "/" + password).digest("hex")


Uu = User.initialize()
module.exports = Uu

email_uniq_validator = (email, callback)->
  Uu.findOne(email: email).exec (err, uu)->
    if uu then callback(false) else callback(true)

User.schema.path('email').validate email_uniq_validator, FN.user_email_should_be_uniq[CONFIG.notice]

User.schema.virtual('password').set((password)->
  this.salt = crypto.randomBytes(16).toString('base64').replace(/\//g,'_').replace(/\+/g,'-')
  this.hashed_password =  crypto.createHash('sha1').update(this.salt + "/" + password).digest("hex")
)





