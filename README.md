# react   
### iOS项目加入react-native      

1.创建package.json文件       

在终端中cd到项目目录， 运行npm init生成文件，编辑文件内容如下：   
<pre><code>{
 
  "name": "name",//此处替换你的项目名称
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "start": "node node_modules/react-native/local-cli/cli.js start"
  },
  "dependencies": {
    "react": "15.4.1",// react版本，可以替换成最新的。 
    "react-native": "0.42.0"// 同上，目前最新0.42.0 
    
  } 
}
</code></pre>


2.下载node_modules

npm install --save react-native 

3.通过pod安装需要的库 

pod 里的内容如下：

pod 'React', :path => './node_modules/react-native', :subspecs => [

    'Core',
    'RCTActionSheet',
    'RCTAnimation',
    'RCTGeolocation',
    'RCTImage',
    'RCTLinkingIOS',
    'RCTNetwork',
    'RCTSettings',
    'RCTText',
    'RCTVibration',
    'RCTWebSocket'
    
  ]
 
  pod "Yoga", :path => "./node_modules/react-native/ReactCommon/yoga"
  
  Yoga必须在target 8.0以上
  
4.pod install 安装     

5.创建js文件，在终端在启动服务，npm start或者npm start --reset-cache

6.中文文档地址：http://reactnative.cn/



