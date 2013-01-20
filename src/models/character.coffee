class Character extends MongoBase
  @schema = @Schema(
    nick_name : String
    user: { type : Schema.ObjectId, ref : 'User'}
    gender : { type : String, enum: ['Male', 'Female']}
    job : String
    level : Number
    HP : Number
    HP_max : Number
    MP : Number
    MP_max : Number
    HP_incSpeed : Number
    MP_incSpeed : Number
    ATK : Number
    DEF : Number

    addedPropeties: {
      addedHP_max : Number
      addedMP_max : Number
      addedATK : Number
      addedDEF : Number
    }

    isDead : Boolean
    union_id : { type : Schema.ObjectId, ref: 'Union'}

    created_at: { type : Date, default : Date.now }
    updated_at: { type : Date, default : Date.now }
  )

  @schema.methods.abc = ()->
    console.log 'hahah'

  @schema.statics.findByName = (name, cb) ->
    this.find({ name: new RegExp(name, 'i') }, cb)



module.exports = Character.initialize()


#角色的基本属性： 
#- user_id   属于的用户id， Ref
#- name 名字 
#- gender 性别 
#- role  角色 / 职业 
#- level 等级 
#- HP 生命值 
#- HP_max 生命值上限 
#- MP 魔法值 
#- MP_max 魔法值上限 
#- HP_incSpeed 生命回复速度 
#- MP_incSpeed 魔法回复速度

#// - 体力值 
#// - 体力值上限 
#// - 体力回复速度 

#- ATK 基础攻击力 
#- DEF 基础防御力 

#- isDead？   是否死亡？？？ 或者用isAlive

	#addedPropeties永久属性加成
	#{
	#    addedHP_max,       增加的生命上限
	#    addedMP_max,       增加的魔法上线
	#    addedATK,      增加的攻击力
	#    addedDEF,      增加的防御力
	#   
	#}

