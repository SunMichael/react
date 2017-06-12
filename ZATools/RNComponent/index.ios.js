'use strict';

import React,{Component} from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NativeModules,
  TouchableOpacity
} from 'react-native';
import { NativeAppEventEmitter } from 'react-native';
var iosMethod = NativeModules.ZAAlertView;
var subscription;
class ZATools extends React.Component {
    /*
  _alert(){
    iosMethod.show("hello",(error,events)=>{
        if(error){
          console.error(error);
        }else{
          this.setState({events:events});
        }
  });
  }
  componentDidMount(){
    console.log('开始订阅通知...');
    subscription = NativeAppEventEmitter.addListener(
         'sendCallback',
          (reminder) => {
            let errorCode=reminder.errorCode;
            if(errorCode===0){
               this.setState({msg:reminder.name});
            }else{
               this.setState({msg:reminder.msg});
            }

          }
         );
  }
  componentWillUnmount(){
     subscription.remove();
  }
     */
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
      </View>
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
});

// 整体js模块的名称
AppRegistry.registerComponent('ZATools', () => ZATools);
