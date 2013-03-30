crypto = require 'crypto'
Character = require "#{ROOT}/models/character"

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

  @schema.methods.with_its_character = (callback) ->
    Character.find {user: this._id}, {}, (err, character)->
      if err
        callback(err, null)
      else
        callback(null, character)


Uu = User.initialize()
module.exports = Uu

# validations 
User.schema.path('email').validate User.validation({message: FN.user_email_not_valid[CONFIG.notice]}, "isEmail")
User.schema.path('email').validate User.validation({message: FN.user_email_not_valid[CONFIG.notice]}, "notNull")

email_uniq_validator = (email, callback)->
  Uu.findOne(email: email).exec (err, uu)->
    if uu then callback(false) else callback(true)
User.schema.path('email').validate email_uniq_validator, FN.user_email_should_be_uniq[CONFIG.notice]
User.schema.path('hashed_password').validate User.validation({message: FN.user_password_should_not_blank[CONFIG.notice]}, "notEmpty")

# virtual attributes
User.schema.virtual('password').set((password)->
  if password && password.length
    this.salt = crypto.randomBytes(16).toString('base64').replace(/\//g,'_').replace(/\+/g,'-')
    this.hashed_password =  crypto.createHash('sha1').update(this.salt + "/" + password).digest("hex")
  else
    this.salt = ""
    this.hashed_password = ""
)

User.schema.pre 'save', (next)->
  if this.isNew
    this.gold   ||= 0
    this.money  ||= 0
    this.food   ||= 0
    this.vip    ||= "Vip1"

  next()


# pre, in case no password email passed in
User.schema.pre 'validate', (next)->
  this.email ||= ""
  this.password ||= ""
  this.hashed_password ||= ""
  this.salt ||= ""
  next()




