class Pmail extends MongoBase
  @schema = @Schema(
	  user_id : { type : Schema.ObjectId, ref : 'User'}
	  title : String
	  content : String
	  from_user_id : { type : Schema.ObjectId, ref : 'User'}
	  from_nick_name : String
	  to_user_id : { type : Schema.ObjectId, ref : 'User'}
	  to_nick_name : String 
	  is_read : Boolean
	  mail_box : { type : String, enum : ['InBox', 'SendBox'] }
	  created_at: { type : Date, default : Date.now }
	  updated_at: { type : Date, default : Date.now }
  )

module.exports = Pmail.initialize()


#-------------
#邮箱系统设计：

#Collection： mails
#- user_id 用户名
#- title 标题
#- content 内容
#- from_user_id      发件人id
#- from_nick_name   发件人昵称
#- to_user_id      对方的用户id
#- to_nick_name  对方的昵称
#- is_read 是否阅读
#- mail_box enum{‘InBox’， ‘SendBox’）



