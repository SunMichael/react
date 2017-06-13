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
} from 'react-native';


class ZALogin extends React.Component {

 constructor(props){
   super(props);
   this.state = {text: ' ' ,
                 psw: ' '};
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

AppRegistry.registerComponent('ZATools',() => ZALogin);
