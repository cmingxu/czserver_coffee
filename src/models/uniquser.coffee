crypto = require 'crypto'

class Uniquser extends MongoBase
  @schema = @Schema(
    email : {type: String, validate: [@validation({message: FN.uniquser_email_not_blank[CONFIG.notice]}, "notEmpty"), @validation({passIfEmpty: true, message: FN.uniquser_email_not_valid[CONFIG.notice]}, "isEmail")]}
    hashed_password : {type: String, validate: @validation({message: "133"}, "notEmpty")}
    salt :  String
    first_name : {type: String, validate: @validation({message: FN.uniquser_first_name_not_blank[CONFIG.notice]}, "notEmpty")}
    last_name : String
    servers: [String]
    last_server : {type: String}
    created_at : {type:Date, default: Date.now}
    updated_at : {type:Date, default: Date.now}
  )

  @schema.statics.findByName = (name, cb)->
    this.find({ name: new RegExp(name, 'i') }, cb)

  @schema.statics.findByEmail = (email, cb)->
    this.findOne({ email: email }).exec cb



Uu = Uniquser.initialize()
module.exports = Uu

email_uniq_validator = (email, callback)->
  Uu.findOne(email: email).exec (err, uu)->
    if uu then callback(false) else callback(true)

Uniquser.schema.path('email').validate email_uniq_validator, FN.uniquser_email_should_be_uniq[CONFIG.notice]

Uniquser.schema.virtual('password').set((password)->
  console.log password
  console.log this.hashed_password
  #this._password = password
  #this.hashed_password = "adss"
  )


Uniquser.schema.pre 'save', (next)->
  if (this.hashed_password == "") || (this.hashed_password == undefined)
    next(new Error(FN.uniquser_password_should_not_blank))
  else
    next()



