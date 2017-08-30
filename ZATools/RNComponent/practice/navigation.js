
import React, {Component} from 'react';
import {
  NavigatorIOS ,
  AppRegistry,
  Text ,
  TouchableOpacity,
} from 'react-native';

const SHList = require("./scroller.js")

export default class SHNavigation  extends Component{

  _handleNavigationRequest() {
    this.refs.nav.push({
      component: SHList,
      title: '第二个界面',
      passProps: { myProp: 'B' },
    });
  }

  render() {
    return (
      <NavigatorIOS
        ref='nav'
        initialRoute={{
          component: SHList,
          title: '第一个界面',
          passProps: { myProp: 'A' },
          rightButtonTitle: 'Next',
          onRightButtonPress: () => this._handleNavigationRequest(),
        }}
        style={{flex: 1}}
      />
    );
  }
}
AppRegistry.registerComponent('ZATools', () => SHNavigation);
