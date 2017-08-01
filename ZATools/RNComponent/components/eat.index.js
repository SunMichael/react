/*--------------能不能吃主页面------------*/
import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	Text,
	Image,
	View,
	TouchableOpacity
} from "react-native";

const HeaderSearch = require("./common/header.search.js");
const eatList = require("./eat.list.js");

// 菜单栏类
export class Menus extends Component {
	constructor(props){
		console.log(props);
		super(props);
		this.pressPush = this.pressPush.bind(this);
	}
	pressPush(i){
		var nextRoute = {
			component:eatList,
			title:this.props.menus[i].title,
			passProps: {
				id: this.props.menus[i].id
			}
		};
		this.props.navigator.push(nextRoute);
	}
	render(){
		let items = [];
		for(let i in this.props.menus){
			let item = (
				<TouchableOpacity style={styles.menus_item} key={i} onPress={this.pressPush.bind(this,i)}> 
					<View style={styles.item_icon_content} >
						<Image style={this.props.menus[i].imageStyle} source={this.props.menus[i].image_url} />
					</View>
					<View>
						<Text style={styles.item_text} >{this.props.menus[i].title}</Text>
					</View>
				</TouchableOpacity>
			); 
			items.push(item);
		}
		return (
			<View style={styles.menus}>
				{items}
			</View>
		)
	}
};
export default class eatIndex extends Component {
	constructor(props){
		console.log(props);
		super(props);
	}
	render(){
		const menus = [
			{id:1,image_url: require("./icon/rice_icon.png"), title:"五谷杂粮", imageStyle: {width:30,height:35.5}},
			{id:2,image_url: require("./icon/jianguo_icon.png"),title: "坚果类", imageStyle: {width:30,height:34.25}},
			{id:3,image_url: require("./icon/dounai.png"),title:"豆/奶制品",imageStyle: {width:32,height:32}},
			{id:4,image_url: require("./icon/xiaochi_icon.png"), title:"零食小吃类",imageStyle: {width:36.5,height:23.5}},
			{id:5,image_url: require("./icon/yinliao_icon.png"), title: "饮品",imageStyle: {width:21,height:36}},
			{id:6,image_url: require("./icon/tiaowei_icon.png"), title: "调味品",imageStyle: {width:26,height:35}},
			{id:7,image_url: require("./icon/haichan_icon.png"), title: "海产品",imageStyle: {width:35.75,height:32.75}},
			{id:8,image_url: require("./icon/shuiguo.png"), title: "水果", imageStyle: {width:29.75,height:34.75}},
			{id:9,image_url: require("./icon/roulei_icon.png"), title: "肉/蛋类",imageStyle: {width:32,height:27.5}},
			{id:10,image_url: require("./icon/shucai_icon.png"), title: "蔬菜菌类",imageStyle: {width:35.75,height:33.75}},
			{id:11,image_url: require("./icon/jiagong_icon.png"), title: "加工食品",imageStyle: {width:31.75,height:34}},
			{id:12,image_url: require("./icon/caiyao_icon.png"), title:"补品&草药",imageStyle: {width:27.75,height:27.75}}
		];
		return(
			<View style={styles.container}>
				<HeaderSearch></HeaderSearch>
				<Menus navigator={this.props.navigator} route={this.props.route} menus={menus}></Menus>
			</View>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor:"#f5f5f5",
		marginTop:65
	},
	menus:{
		flex:1,
		flexDirection: "row",
		flexWrap: "wrap",
		marginTop:7.5
	},
	menus_item:{
		width:125,
		height:125,
		backgroundColor: "#ffffff",
		borderBottomColor: "#e4e4e4",
		borderBottomWidth: 1,
		borderLeftColor:"#e4e4e4",
		borderLeftWidth:1
	},
	item_icon_content:{
		width: "100%",
		height:88,
		backgroundColor:"#fbfbfb",
		justifyContent: "center",
		alignItems: "center"
	},
	item_icon:{
		width:30,
		height:35.5
	},
	item_text:{
		textAlign:"center",
		fontSize:12,
		color:"#999999"
	}
});

module.exports = eatIndex;
