### cocoapods插件调试
#### 目录结构
```shell
    -.bundle # bundle配置文件，将gem依赖库放到本地vendor文件夹，运行时通过bundle exec调用本地库执行
    -demo # 测试iOS工程
    -playground #用于ruby 调试
    -pod_dev # 开发环境
    -pod_env # cocoapods依赖库目录
    -vendor # 本地ruby环境
    -Gemfile
```