crypto = require 'crypto'

class User extends MongoBase
  @schema = @Schema(
    email : String
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

# validations 
User.schema.path('email').validate User.validation({message: FN.user_email_not_valid[CONFIG.notice]}, "isEmail")
User.schema.path('email').validate User.validation({message: FN.user_email_not_valid[CONFIG.notice]}, "notNull")

email_uniq_validator = (email, callback)->
  Uu.findOne(email: email).exec (err, uu)->
    if uu then callback(false) else callback(true)
User.schema.path('email').validate email_uniq_validator, FN.user_email_should_be_uniq[CONFIG.notice]

# virtual attributes
User.schema.virtual('password').set((password)->
  console.log 'password' + password
  if password && password.length
    this.salt = crypto.randomBytes(16).toString('base64').replace(/\//g,'_').replace(/\+/g,'-')
    this.hashed_password =  crypto.createHash('sha1').update(this.salt + "/" + password).digest("hex")
  else
    this.salt = ""
    this.hashed_password = ""
)

User.schema.path('hashed_password').validate User.validation({message: FN.user_password_should_not_blank[CONFIG.notice]}, "notEmpty")

# pre, in case no password email passed in
User.schema.pre 'validate', (next)->
  this.email ||= ""
  this.password ||= ""
  this.hashed_password ||= ""
  this.salt ||= ""
  next()




