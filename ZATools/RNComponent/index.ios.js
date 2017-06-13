'use strict';

import React,{Component} from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  NativeModules,
  TouchableOpacity
} from 'react-native';
import { NativeEventEmitter } from 'react-native';
var iosMethod = NativeModules.ZAAlertView;
var subscription;
class ZATools extends React.Component {

  async _alert(){
    console.log(iosMethod);
    iosMethod.show("hello",(error,events)=>{
        if(error){
          console.error(error);
        }else{
          console.log(events);
        }
  });
  }
  ocAlert(){
    iosMethod.alert()
  }

  componentDidMount(){
    console.log('开始订阅通知...');
    this._alert();

    var iosExport = NativeModules.ZAAlertView
    var emitter = new NativeEventEmitter(iosExport)
    this.subscription = emitter.addListener("sendCallback" , (body) => {
      console.log("oc 调用 react " + body);
    })
  }
  componentWillUnmount(){
     subscription.remove();
  }

  render() {
    var contents = this.props["scores"].map(
      score => <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
    );
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>
          2048 High Scores!
        </Text>
        <Text style={styles.scores}>
          {contents}
        </Text>
        <Image source = {require ('./images/ice.jpg')}
                style = {styles.image} />
      </View>
      // <View style= {styles.container}>

      // </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  highScoresTitle: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  button: {
    margin:5,
    backgroundColor: 'white',
    padding: 10,
    borderWidth: 1,
    borderColor: '#facece',
  },
  image: {
    margin: 10,
    width: 100,
    height: 100,
    borderRadius: 5,
    borderColor: '#ccc',
    borderWidth: 1,
  }
});

// 整体js模块的名称
AppRegistry.registerComponent('ZATools', () => ZATools);
