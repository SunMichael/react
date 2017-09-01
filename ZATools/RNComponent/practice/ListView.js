/* @flow */

import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ListView,
  TouchableOpacity,
  Image,
  TabBarIOS,
} from 'react-native';

export default class SHListView extends Component {
  constructor(props){
    super(props);
    this.initData();
  }
  initData(){
    var ds = new ListView.DataSource({rowHasChanged: (r1 ,r2) => r1 !== r2})
    // return {
      // dataSource: ds.cloneWithRows(this._genRows({})),
    // };
    this.state = {
      pageNo : 1,
      pageSize : 20,
      dataSource : ds.cloneWithRows(this._genRows({})),
      selectedTab : 'blueTab',
    }

  }
  _genRows(pressData: {[key: number] : boolean}) : Array<string>{
    var dataBlob = [];
    for (var i = 0; i < 100; i++) {
      var pressText = pressData[i] ? 'pressed' : '';
      dataBlob.push('row' + i + pressText);
    }
    console.log('dataSource :' + dataBlob);
    return dataBlob;
  }
  componentDidMount(){
    this._fetData();
  }
  render() {
    return (
      // <View style={styles.container}>
      //   <Text>I'm the SHListView component</Text>
      // </View>
      //


      <TabBarIOS unselectedTintColor = 'yellow'
      tintColor = 'white'
      barTintColor = 'darkslateblue'>
      <TabBarIOS.Item
      title = 'Blue Tab'
      icon = {require('./warning_icon.png')}
      selected = {this.state.selectedTab === 'blueTab'}
      onPress = {() =>{
        this.setState({
          selectedTab : 'blueTab',
        })
      }}>
      {this._renderContent('#414A8C','BlueTab',2)}
      </TabBarIOS.Item>
      <TabBarIOS.Item
      systemIcon = 'history'
      badge = {1}
      selected = {this.state.selectedTab === 'redTab'}
      onPress = {
        () => {
          this.setState({
            selectedTab : 'redTab',
          })
        }
      }
      >
      {this._renderContent('#783E33','Red Tab', 1)}
      </TabBarIOS.Item>
      </TabBarIOS>
    );
  }
  _renderRow(rowData: string, sectionID:number, rowID: number){
    console.log('rowData : ' + rowData + 'rowID' + rowID);
    var text = 'rowData : ' + rowData  ;
    return (
      <TouchableOpacity onPress = {() => {

      }}>
      <View style = {styles.row}>
      <Image source = {require('./ice.jpg')}
      style = {{width : 60, height : 60  ,marginRight: 15}}>
      </Image>
      <Text style = {{flex : 1, paddingRight:10}}> {text}
      </Text>
      </View>
      </TouchableOpacity>
  )
  };

  _renderContent(color: string, pageText: string, num?: number){
    if (num !== 2) {
      return (
        <View style = {[styles.tabContent , {backgroundColor : color}]}>
        <Text style = {styles.tabText}> {pageText} </Text>
        <Text style = {styles.tabText}> {num} re-renders of the {pageText} </Text>
        </View>
      );
    } else {
      return (
        <ListView dataSource = {this.state.dataSource}
        renderRow = {this._renderRow}>
        </ListView>
      )
    }
  }


  _fetData(){
    fetch('http://mobile.api-test.yizhenjia.com/tool/chanjian/list',{
      method : 'POST',
      headers : {
        'Accept' : 'application/json',
      },
      body: JSON.stringify({
        'pageNo' : this.state.pageNo,
        'pageSize' : this.state.pageSize,
        'expectedBirthDate' : '2017-8-20',
      })
    })
    .then((response) => {
      console.log('response.....');
      return response.json()
    })
    .then((responseJson) => {
      console.log('responseJson' + responseJson.result);
      var dataAry = responseJson.result;
      var formAry = dataAry.map((item, index, ary) => {
        return JSON.stringify(item);
      })
      this.setState({dataSource : this.state.dataSource.cloneWithRows(formAry)})
    })
    .catch((error) => {
      console.log('fetcherror' + error);
    })
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  row: {
    flexDirection : 'row',
    // justifyContent : 'center',
    padding : 10,
    backgroundColor : '#F6F6F6',
  },
  tabContent: {
    flex : 1,
    alignItems : 'center',
  },
  tabText : {
    color : 'white',
    margin : 50,
  }
});

module.exports = SHListView;
