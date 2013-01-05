class Uniqserver extends MongoBase
  @schema = @Schema(
	  name : String
	  ip : String
	  lang : String
	  created_at : {type : Date, default : Date.now}
	  updated_at : {type : Date, default : Date.now}
  )

  @schema.methods.abc = ()->
    console.log 'hahah'

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)



module.exports = Uniqserver.initialize()
