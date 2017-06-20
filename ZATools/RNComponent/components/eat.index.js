/*--------------能不能吃主页面------------*/
import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	Text,
	Image,
	View
} from "react-native";

const HeaderSearch = require("./common/header.search.js");

// 菜单栏类
export class Menus extends Component {
	constructor(props){
		super(props);
	}

   componentDidMount(){
		 fetch('http://admin.api-test.yizhenjia.com/order/pay?orderNo=DD20161126151316094119793&userId=3&payStrategy=DIVID')
      .then((response) => response.json())
      .then((responseJson) => {
				console.log(" success ");
        return responseJson.movies;
      })
      .catch((error) => {
        console.error(error);
      });
	 }

	render(){
		let items = [];
		for(let i in this.props.menus){
			console.log(i);
			let item = (
				<View style={styles.menus_item} key={i}>
					<View style={styles.item_icon_content}>
						<Image style={this.props.menus[i].imageStyle} source={this.props.menus[i].image_url} />
					</View>
					<View>
						<Text style={styles.item_text}>{this.props.menus[i].title}</Text>
					</View>
				</View>
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
	render(){
		const menus = [
			{image_url: require("./icon/rice_icon.png"), title:"主食", imageStyle: {width:30,height:35.5}},
			{image_url: require("./icon/jianguo_icon.png"),title: "坚果类", imageStyle: {width:30,height:34.25}},
			{image_url: require("./icon/dounai.png"),title:"豆/奶制品",imageStyle: {width:32,height:32}},
			{image_url: require("./icon/xiaochi_icon.png"), title:"零食小吃类",imageStyle: {width:36.5,height:23.5}},
			{image_url: require("./icon/yinliao_icon.png"), title: "饮品",imageStyle: {width:21,height:36}},
			{image_url: require("./icon/tiaowei_icon.png"), title: "调味品",imageStyle: {width:26,height:35}},
			{image_url: require("./icon/haichan_icon.png"), title: "海产品",imageStyle: {width:35.75,height:32.75}},
			{image_url: require("./icon/shuiguo.png"), title: "水果", imageStyle: {width:29.75,height:34.75}},
			{image_url: require("./icon/roulei_icon.png"), title: "肉/蛋类",imageStyle: {width:32,height:27.5}},
			{image_url: require("./icon/shucai_icon.png"), title: "蔬菜菌类",imageStyle: {width:35.75,height:33.75}},
			{image_url: require("./icon/jiagong_icon.png"), title: "加工食品",imageStyle: {width:31.75,height:34}},
			{image_url: require("./icon/caiyao_icon.png"), title:"补品&草药",imageStyle: {width:27.75,height:27.75}}
		];
		return(
			<View style={styles.container}>
				<HeaderSearch></HeaderSearch>
				<Menus menus={menus}></Menus>
			</View>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor:"#f5f5f5",
		marginTop:60
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
