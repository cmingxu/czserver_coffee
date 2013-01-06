class Uniquser extends MongoBase
  @schema = @Schema(
    email : String
    hashed_password : String
    first_name : String
    last_name : String
    servers: [String]
    last_server : String
    created_at : {type:Date, default: Date.now}
    updated_at : {type:Date, default: Date.now}
  )

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)

  @schema.statics.findByEmail = (email, cb) ->
    this.find({ email: email }, cb)



module.exports = Uniquser.initialize()
