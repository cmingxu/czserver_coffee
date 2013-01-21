# 用户系统 User System #

[返回首页](./index.md)

## 功能说明：##


### - 注册登陆流程说明 ###

** 用户注册 **

1. 在Unity客户端用POST form的方式提交注册字段。
2. 客户端要做是否为空的检测。服务端做Email是否存在等检测，如果发生错误，返回`422`信息???。客户端必须接收错误信息并且用`MsgBox`显示错误提示。

3. 注册成功后，返回注册成功的信息 `201`，服务端自动进行登陆，返回`token`给客户端
4. 此时character应该不存在， 客户端拿到`token`后，下一个请求应该是 `GET: /characters`的create
4. 之后的每次操作，都在`Header`里放入`token`

** 用户登陆 **

1. 在Unity客户端用POST form的方式提交登陆字段。（客户端在`PlayerPref`）里自动保存用户名和密码（加密）。
2. 登陆失败。返回错误信息。客户端弹出`MsgBox`显示错误信息。
3. 登陆成功，返回`token`, 之后的每次请求都在header里写入`token`。
4. 客户端接收到登录成功的返回值后，再次访问`bootstrap`的API来获取当前玩家的所有基本信息。


		注：每次登录如果没有character告诉客户端character不存在。客户端需要请求 `GET: /characters`的create 来创建角色信息。


------------------------------------------------------------------

# Model 说明 #

** User表，玩家的基本属性： **

- id 
- 昵称 
- 所在服务器 Ref
- 元宝（人民币） 
- 铜钱 
- 经验值EXP
- 玩家进入游戏时候，选择职业： 


** 其它：**

- VIP1
- VIP2
- VIP3

------------------------------------------------------------------


# API地址：

###  `/users` 用户资源   

### `POST: /users` : 统一用户注册     

统一用户注册

### `POST: /tokens` : 统一用户登录     

	- 返回结果为{"token":
	  "NTBmYWFmYTBjZDc5ZTUwMDAwMDAwMDA5LzEzNTg2MDY3MDQxODA", "user_id": 123}
	
	- 登陆之后的所有请求在http header中设置 Auth-Token: "NTBmYWFmYTBjZDc5ZTUwMDAwMDAwMDA5LzEzNTg2MDY3MDQxODA"


### `DELETE: /tokens` : 统一用户登出     

统一用户出。



### `GET: /users/:id` 获取:id的用户信息
用于查看其它玩家信息

### `GET: /characters/:id` 玩家的角色资源

### `GET: /bootstraps/:id` ？？玩家登陆后，一次性返回游戏所需资料

    基本信息：
    - user 当前id的用户，包括充值的金钱，铜钱等等 
    - character 玩家选中的角色（以后可以朝多角色扩展） 
    
    其它：
    - users表里的所有内容。 
    - 装备信息 
    - 当前任务的状态 
    - 所有的护星状态 
    - 当前场景所有人的名字，简要信息。 
    - 当前场景的聊天内容。 
    - 邮件提示 

    


### `PUT: /users/reset_password` : 忘记密码    

忘记密码，重置密码


------------------------------------------------------------------

[返回首页](./index.md)