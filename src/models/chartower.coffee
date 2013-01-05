class Chartower extends MongoBase
  @schema = @Schema(
    someField: String
  )
  @schema.methods.abc = ()->
    console.log 'hahah'

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)



module.exports = Chartower.initialize()
