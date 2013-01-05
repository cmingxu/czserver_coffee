class Charprop extends MongoBase
  @schema = @Schema(
	  pType : { type : String, enum : ['Helmet', 'Armor', 'Weapon', 'Boots', 'Gloves', 'Rings'] }
	  isConsumable : Boolean
	  count : { type : Number, default : 1 }
	  positionOfPack : Number
	  level : Number
	  addHP : Number
	  addATK : Number
	  addDef : Number
	  propBaseId : { type : Schema.ObjectId, ref : 'PropBase'}
	  created_at: { type : Date, default : Date.now }
	  updated_at: { type : Date, default : Date.now }
  )
  @schema.methods.abc = ()->
    console.log 'hahah'

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)



module.exports = Charprop.initialize()

#装备类别
    #Helmet 头盔
    #Armor 盔甲
    #Weapon 武器
    #Boots 长靴
    #Gloves 手套
    #Rings 戒指

#装备的通用属性 PropSchema
    #装备类别：头盔/武器/护甲/手套/长靴/饰品
    #是否消耗型 isConsumable。（区分可以消耗的药水和佩戴的武器）
    #数量：count    （如果是药水、礼包等可消耗品，放入背包时 count++, 使用时count--）
    #在背包的位置 positionOfPac
    #等级 level
    #增加生命值addHP
    #攻击力addATK
    #防御力addDEF
    #属于哪种武器基类 propBaseId ->Ref PropBase

