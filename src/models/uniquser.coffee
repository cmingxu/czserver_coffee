class Uniquser extends MongoBase
  @schema = @Schema(
    email : String
    hashed_password : String
    first_name : String
    last_name : String
    servers: [ { type: Schema.ObjectId, ref : 'UniqServer'} ]
    last_server : { type: Schema.ObjectId, ref : 'UniqServer'} 
    created_at : {type:Date, default: Date.now}
    updated_at : {type:Date, default: Date.now}
  )
  @schema.methods.abc = ()->
    console.log 'hahah'

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)



module.exports = Uniquser.initialize()
