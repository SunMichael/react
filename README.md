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


2.拷贝一份node_modules

可以新建一个项目 然后cd 到目录下执行 react-native init name ，拷贝里面的文件夹到项目下       

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


