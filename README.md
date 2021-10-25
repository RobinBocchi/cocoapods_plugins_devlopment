### cocoapods插件开发调试
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
#### cocoapods插件加载机制及插件入口
`cocoapods_plugin.rb`

#### 源码调试配置
##### 导入源码并引入Gemfile
增加`.bundle/config`文件，执行`bundle install`之后将相关gem库安装到当前工程vendor目录下
将要调试的cocoapods模块或其他gem库源码下载后放到`pod_env`目录下，注意源码的版本关系。
在根目录下Gemfile中配置要调试的gem库的源码地址，如`gem 'cocoapods', :path => "./pod_env/CocoaPods-1.8.3"`

##### VSCode配置
`.vscode/launch.json`中配置如下
```json
    {
      "name": "plugins installed",
      "type": "Ruby",
      "request": "launch",
      "cwd": "${workspaceRoot}/demo",
      "program": "/usr/local/bin/pod",
      "args": [
        "plugins", "installed"
      ]
    }
```

##### RubyMine配置
注意`bundle exec`配置
