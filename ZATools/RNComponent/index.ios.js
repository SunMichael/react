/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NavigatorIOS,
  TouchableOpacity
} from 'react-native';

const eatIndex = require("./components/eat.index.js");
const headerSearch = require("./components/common/header.search.js");
const eatList = require("./components/eat.list.js");
const eatDetail = require("./components/eat.detail.js");
const chanjianList = require("./components/chanjian.list.js");

export default class index extends Component{
	render(){
		return(
			<NavigatorIOS
		        initialRoute={{
		          component:  chanjianList,
		          title: "产检时间表",
		          passProps: {}
		        }}
		        configureScene={(route)=>{
			 	return Navigator.configureScene.PushFromRight;
				}}
				renderScene={(route, navigator)=>{
				 	var Component = route.component;
				 	return(
				 		<Component navigator={navigator} route={route} {...route.passProps} />
				 	);
				}}
		        style={{flex:1}}
		      />
		)
	}
}

AppRegistry.registerComponent('ZATools', () => index);
