## 用户登陆系统 UniqUser System ##

功能说明：

```
用户系统说明：


玩家从统一用户(UniqUsers)登陆系统注册，登录。

第一次登陆：
- 弹出选择服务器的列表，让玩家选中一个服务器。然后在该服务器上建立单独的user数据。选中的服务器记录在UniqUsers表的servers和last_server属性里。
- 弹出角色选择列表，让玩家选择角色。在characters表里创建相应记录。并返回这个新建的记录。


第n次登陆：
- 检测last_server是否存在。如果不存在则显示已经登陆过的servers列表和所有servers列表。让玩家选中一个服务器登陆。
- 登陆后，在characters表里选出相应的记录。


登陆成功后跳转到/index地址，返回下列数据：

Result：
- uniq_user 统一登陆用户 
- user 当前服务器的用户，包括充值的金钱，铜钱等等 
- character 玩家选中的角色（以后可以朝多角色扩展） 
其它：


users表里的所有内容。 

装备信息 
当前任务的状态 
所有的护星状态 


当前场景所有人的名字，简要信息。 
当前场景的聊天内容。 
邮件提示 
```

```
相关Models：

```


```
API接口：
- login (GET)
- login (POST)
- register
- forget_password
```

