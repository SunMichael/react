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

export default class index extends Component{
	render(){
		const initialRoute = {
			component: eatIndex,
          	title: '能不能吃'
		};
		return(
			<NavigatorIOS
		        initialRoute={{
		          component:  eatIndex,
		          title: '能不能吃',
		        }}
		        style={{flex: 1}}
		      />
		)
	}
}

AppRegistry.registerComponent('ZATools', () => index);
