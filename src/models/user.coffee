class User extends MongoBase
  @schema = @Schema(
    uniq_user : { type : Schema.ObjectId, ref : 'UniqUser'}
    nick_name : String
    server: String
    gold : Number
    money : Number
    food : Number
    vip  : { type : String, enum : ['Vip1', 'Vip2', 'Vip3']}
    created_at: { type : Date, default : Date.now }
    updated_at: { type : Date, default : Date.now }
  )

  @schema.methods.abc = ()->
    console.log 'hahah'

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)




module.exports = User.initialize()
