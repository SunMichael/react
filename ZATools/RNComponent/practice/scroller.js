import React ,{Component} from "react";
import {
  AppRegistry,
  FlatList,
  ListView,
  Text,
  StyleSheet,
  View,
  Image,
  TouchableOpacity,
  Animated,
  ActivityIndicator,
  Button,
}from "react-native";

export class  FlatListBasics extends Component {

  // constructor(props) {
  //   super(props);
  //   var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
  //   this.state = {
  //     dataSource: ds.cloneWithRows(['row 1', 'row 2']),
  //   };
  // }
  // render() {
  //   return (
  //     <ListView
  //       dataSource={this.state.dataSource}
  //       renderRow={(rowData) => <Text>{rowData}</Text>}
  //     />
  //   );
  // }
  constructor(props){
    super(props);
    this.state = {
      showText: true,
      animatedValue: new Animated.Value(0),
      twirlValue: new Animated.Value(0),
    }

    setInterval(() =>{
      this.setState( {showText : !this.state.showText} )
    } , 1000);
  }
  onPressButton(){
    console.log('click!!!');
  }
  componentDidMount(){
    this.state.animatedValue.setValue(1.5);
    Animated.parallel([
      Animated.spring(
        this.state.animatedValue ,
        {
          toValue: 0.8,
          friction: 1,
        }
      ),
      Animated.timing(
        this.state.twirlValue,
        {
          toValue: 10
        }
      ),
    ]).start();
  }
  render(){
    let display = this.state.showText ? 'hello' : '';
    return (
      <View style = {{flex : 1, flexDirection: 'column',justifyContent: 'flex-end'}}>
      <View style = {{width: 10, height: 100}}></View>
      <Text style = {styles.red}>{display}</Text>
      <Text style = {[styles.bigblue , styles.red]}>bigblue, red </Text>
      <View style = {{flex: 2, backgroundColor:'powderblue'}} />
      <Button style = {{flex:2 , height: 50}}
      onPress = {()=>{
        console.log('clicked');
      }}
      title = 'click me'
      color = '#841584'
      accessibilityLabel = 'See an informative alert' />
      <View style = {{width: 50 , height: 50, backgroundColor:'#d9d9d9'}} />
      <ActivityIndicator style = {styles.centering}
      animating = {true}
      size = 'large'
      color="#aa00aa" />
      <TouchableOpacity onPress = {this.onPressButton}>
      <Animated.Image source = {require('./ice.jpg')}
      style = {{
        width: 50 ,
        height: 60,
        borderRadius : 6,
        borderColor : 'blue',
        transform: [{scale: this.state.animatedValue}]
      }} >
      <Text style = {{backgroundColor: 'rgba(255, 255, 255, 0.1)'}}>imageText</Text>
      </Animated.Image>
      </TouchableOpacity>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex : 1,
    paddingTop: 20
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 40,
  },
  bigblue: {
    color: 'blue',
    fontSize: 30,
    fontWeight: 'bold',
  },
  red: {
    color: 'red',
  },
  centering:{
    alignItems: 'center',
    justifyContent: 'center',
    padding: 10,
  }
});

module.exports = FlatListBasics;
