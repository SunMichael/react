'use strict';

import React,{Component} from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  NativeModules,
  TouchableOpacity,
  TextInput,
  Button,
  Alert,
  ListView,
  Animated,
  Easing,
  PropTypes,
  NavigatorIOS
} from 'react-native';

class NavigatorController extends React.Component{
  render (){
    return (
      <NavigatorIOS
      initialRoute = {{
        component: ZALogin,
        title : 'React navigator',
      }}
      style = {{flex: 1}} />
    )
  }

  pushComponent(nextRoute){
    this.props.navigator.push(nextRoute)
  }
  const route = {
    component: 'name',
    title: 'title',
    passProps: {'key':'value'}
  }

}



class ZALogin extends React.Component {

 constructor(props){
   super(props);
   const ds = new ListView.DataSource({rowHasChanged: (r1 ,r2) => (r1 !== r2)})
   this.state = {text: ' ' ,
                 psw: ' ',
               dataSource: ds.cloneWithRows(['A','B','C','D','e'])};
 }

 componentDidMount(){
   this.AjaxRequest();
 }
    async requestForApi(){
      try {
        console.log('try send request');
        let response = await fetch('https://www.baidu.com/');
        let responseJson = await response.json;
        console.log(' response == ',responseJson);
        return responseJson
      } catch (e) {
        console.log(e);
      } finally {

      }
    }

    async AjaxRequest(){
      var request = new XMLHttpRequest();
      request.onreadystatechange = (e) => {
        console.log('ajax == ',e);
        if (request.readyState !== 4) {
          return;
        }
        if (request.status === 200) {
          console.log('success', request.responseText);
        }else {
          console.log('request error');
        }
      }
      request.open('GET','https://www.baidu.com/');
      request.send;
    }

    render (){
      var text = this.props["name"]
      return (
        // <View style = {styles.container}>
        //  <View style = {{flex:1 , flexDirection: 'row'}}>
        //   <Text style = {styles.labelone}>
        //       {text ? text : "Login"}
        //   </Text>
        //  </View>
        // </View>
      //   <View style = {{flex: 3, flexDirection: 'row',justifyContent: 'space-between',
      // alignItems : 'center'}}>
      //   <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
      //   <View style={{width: 100, height: 100, backgroundColor: 'skyblue'}} />
      //   <View style={{width: 150, height: 150, backgroundColor: 'steelblue'}} />
      //   </View>
      <View style = {{padding : 10, marginTop: 20}}>
      <TextInput
      style = {{height: 40}}
      placeholder = "输入文字"
      onChangeText = { (text) => this.setState({text}) } />
      <Text style = {{padding: 10 , fontSize: 20}}>
      {this.state.text.split(' ').map((word) => word && '🍕').join(' ')}
      </Text>

      <TextInput
      style = {{ marginTop: 20, height: 40}}
      placeholder = "输入密码"
      onChangeText = { (text) => {
        console.log(text);
      }
      } />

      <Button
      style = {{padding: 10, marginTop: 20 , height: 40}}
      onPress = { () => {
        Alert.alert('点击登录');
      }}
      title = "登录"
      color = '#841584'
      backgroundColor = '#ccc'
      />
      <ListView
      style = {{marginTop: 20 ,height: 80}}
      dataSource = {this.state.dataSource}
      renderRow = {(rowData) => <Text>{rowData}</Text>} />

      <FadeInView style = {{marginTop: 20 , height: 40 ,backgroundColor:'powderblue' }}>
      <Text style = {{fontSize: 16 ,alignItems: 'center'}}>{'fadeAnimation'}</Text>
      </FadeInView>
      </View>


      );
    }

}
// const styles = StyleSheet.create ({
//     container: {
//       flex : 1,
//       backgroundColor : '#ccc'
//     }
//
//     labelone: {
//       marginTop: 70,
//       width: 70,
//       height: 20,
//       fontSize: 16,
//       color: 'blue'
//     }
//
//     textfield: {
//       margin: 70,
//
//     }
//
// });


export default class FadeInView extends React.Component {
constructor(props){
  super(props);
  this.state = {
    fadeAnim : new Animated.Value(0),
  };
}
componentDidMount(){
  var  twirl = new Animated.ValueXY(0)
  Animated.parallel([
//     // Animated.timing(twirl,{
//     //   toValue: 180,
//     // }),
  Animated.timing(
    this.state.fadeAnim,
    {
      toValue: 1,
      duration: 5000,
      easing: Easing.back,
    }
  )
]).start();
}

render (){
  return (
    <Animated.View
    style = {{...this.props.style,
    opacity: this.state.fadeAnim,
    }}
    >
    {this.props.children}
    </Animated.View>
  )
}

}







AppRegistry.registerComponent('ZATools',() => NavigatorController);
