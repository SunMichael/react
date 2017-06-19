/*----------------能不能吃列表页面----------*/
import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	Text,
	Image,
	View,
	ScrollView
} from "react-native";
const HeaderSearch = require("./common/header.search.js");

export class List extends Component {
	constructor(props) {
		super(props);
	}
	render(){
		console.log(this.props.list);
		let lists = [];
		for(var i in this.props.list){
			console.log(i);
			let item = (
				<View style={styles.item} key={i}>
					<View>
						<Image source={this.props.list[i].logo} style={styles.img}></Image>
					</View>
					<View style={styles.item_right}>
						<Text style={styles.item_title_big}>{this.props.list[i].title1}</Text>
						<Text style={styles.item_title_small}>{this.props.list[i].title2}</Text>
						<View style={styles.options}>
							<View style={styles.option}>
								<Image source={require("./icon/success_icon.png")} style={styles.option_icon}></Image>
								<Text style={styles.option_text}>孕妇</Text>
							</View>
							<View style={styles.option}>
								<Image source={require("./icon/success_icon.png")} style={styles.option_icon}></Image>
								<Text style={styles.option_text}>产妇</Text>
							</View>
							<View style={styles.option}>
								<Image source={require("./icon/success_icon.png")} style={styles.option_icon}></Image>
								<Text style={styles.option_text}>婴幼儿</Text>
							</View>
						</View>
					</View>
				</View>
			);
			lists.push(item);
		};
		return(
			<View>
				{lists}
			</View>
		)
	}
};

export class eatList extends Component {
	render() {
		const list = [
			{logo: require("./img/eat_pic1.png"), title1: "大米", title2: "稻米"},
			{logo: require("./img/eat_pic2.png"), title1: "花生", title2: "落花生、炸花生"},
			{logo: require("./img/eat_pic3.png"), title1: "松子", title2: "炒松子"},
			{logo: require("./img/eat_pic4.png"), title1: "夏威夷果", title2: "炒松子"},
			{logo: require("./img/eat_pic1.png"), title1: "大米", title2: "稻米"},
			{logo: require("./img/eat_pic2.png"), title1: "花生", title2: "落花生、炸花生"},
			{logo: require("./img/eat_pic3.png"), title1: "松子", title2: "炒松子"},
			{logo: require("./img/eat_pic4.png"), title1: "夏威夷果", title2: "炒松子"}
		];
		return(
			<View style={styles.container}>
				<ScrollView style={styles.list}>
					<List list={list}></List>
				</ScrollView>
			</View>
		)
	}
};
const styles = StyleSheet.create({
	container:{
		marginTop:60,
		backgroundColor: "#f5f5f5"
	},
	list:{
		marginTop:10,
		paddingLeft: 15,
		backgroundColor: "#ffffff",
		padding:0
	},
	item: {
		paddingTop:15,
		paddingBottom:15,
		paddingRight:15,
		height: 100,
		flexDirection: "row",
		borderBottomWidth:1,
		borderBottomColor: "#e4e4e4"
	},
	item_right:{
		paddingTop:4,
		marginLeft:10,
		flexDirection:"column",
		justifyContent:"space-between"
	},
	img:{
		width:70,
		height:70
	},
	item_title_big:{
		fontSize:18,
		color:"#333333"
	},
	item_title_small:{
		fontSize:12,
		color:"#999999"
	},
	options:{
		flexDirection:"row"
	},
	option:{
		flexDirection:"row",
		alignItems:"center",
		marginRight:25
	},
	option_icon:{
		width:12,
		height:12
	},
	option_text: {
		fontSize:12,
		color:"#999999",
		marginLeft:4
	}
});

module.exports = eatList;