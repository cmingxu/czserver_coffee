## INSTALL ##
```
 brew install node
 brew install mongodb
 brew install redis
 
 git clone git@bitbucket.org:cmingxu/czserver_coffee.git
 npm install -d
```


## START ##

```
 cake dev
```

## TEST ##

```
  cake test
```

## 如何查看程序是否启动正常 ##
因为没有界面， 所以浏览器访问比较麻烦. curl localhost:3000/users
看结果

## New Scaffold ##

```
  cake scaffold --name MODEL_NAME
```

## TROUBLE SHOTTING ##

  - cake dev启动不了， 提示类似于open文件上限问题， 产生原因是coffee编译过程中到达了mac open file的上限
```
  sudo ulimit -n 10000
```

  - cake dev后提示信息有mongo相关的， 可能是mongodb没有安装，
或者地址不正确， 配置再src/config/[dev|test|production]下。


## FAQ ##

  - 如何查看所有命令？
    ```
      cake 
    ```

  - 文件修改后如何编译？
    ```
      cake build
    ```


  - 如何导入游戏配置文件？
    把csv文件放到相应文件夹后执行· cake export_config·,
再路径.app/config/game_config可以看到生成后的配置文件，再boot.coffee可以找到GAME_CONFIG的全局变量



  - 哪里能找到build后的js文件？
    .app目录下


  - CSV(或者其他)文件为什么不能加入到版本管理中？
    检查一下.gitignore吧

  
  - 如何生成测试数据？
    `cake --env [test|dev|production] seeds`

  
  - 哪里放脚本？
    scripts文件夹下， 然后编写cake， 可以仿照seeds或者export_config  

  - 如何清空数据库?
    `cake --name czserver_test drop`

  - 如何创建一个UniqUser
    ```
      curl -H "accept: application/json"  -H "Content-Type: application/json" -d '{"email": "cming.xu@gmail.com", "first_name": "ac", "last_server": "aaa"}' http://localhost:3000/uniqusers  -X POST

    ```
