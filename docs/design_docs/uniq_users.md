# 统一用户登陆系统 User System #

[返回首页](./index.md)

## 功能说明：##

------------------------------------------------------------------



------------------------------------------------------------------


### 相关Models：###

|    名称   |         说明       
|-----------|-------------------
|   user    |用户
| character |玩家选定的角色


------------------------------------------------------------------

# API地址：

### `POST: /tokens` : 统一用户登录     
- 返回结果为{"token":
  "NTBmYWFmYTBjZDc5ZTUwMDAwMDAwMDA5LzEzNTg2MDY3MDQxODA", "user_id": 123}

- 登陆之后的所有请求在http header中设置 Auth-Token: "NTBmYWFmYTBjZDc5ZTUwMDAwMDAwMDA5LzEzNTg2MDY3MDQxODA"

### `PUT: /users`

### `GET: /characters`

### `GET: /users/:id`

    - user 统一登陆用户 当前服务器的用户，包括充值的金钱，铜钱等等 
    - character 玩家选中的角色（以后可以朝多角色扩展） 

    其它：
    - users表里的所有内容。 
    - 装备信息 
    - 当前任务的状态 
    - 所有的护星状态 
    - 当前场景所有人的名字，简要信息。 
    - 当前场景的聊天内容。 
    - 邮件提示 

    
### `DELETE: /tokens` : 统一用户登出     

统一用户出。

### `POST: /users` : 统一用户注册     

统一用户注册

### `PUT: /users/reset_password` : 忘记密码    

忘记密码  


------------------------------------------------------------------

[返回首页](./index.md)


