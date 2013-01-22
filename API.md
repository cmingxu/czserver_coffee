## List Of API ##

### 创建一个UniqUser

```
curl -H "accept: application/json"  -H "Content-Type: application/json" -d '{"email": "cming.xu123@gmail.com", "first_name": "ac", "last_server": "aaa", "password": "123"}' http://localhost:3000/uniqusers  -X POST -v 
```

- 错误检查

  - Email不能空
  - Email不能重复
  - 错误格式
    ```
      {
        "message": "Validation failed",
        "name": "ValidationError",
         "errors": {
            "email": {
                "message": "Validator \"email should be uniq\" failed for path email",
                "name": "ValidatorError",
                "path": "email",
                  "type": "email should be uniq"
            }
        }

        客户端显示的错误为， XXX.errros.email.type,
这个显示内容是可以再服务端配置的
    ```
  

- 约定
  - 客户端(Unity)保证password已经被Confirm过了，
服务端只接收password,不接收password_confirmation

  - 客户端保证password不为空



### 登录

```
curl -H "accept: application/json"  -H "Content-Type: application/json"
-d '{"email": "cming.xu123@gmail.com", "first_name": "ac", "last_server": "aaa", "password": "123"}'
http://localhost:3000/uniqusers  -X POST -v
```


