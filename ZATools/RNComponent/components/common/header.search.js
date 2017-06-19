/*-----------顶部搜索组件-----------*/
"use strict";
import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	TextInput,
	TouchableOpacity,
	Image
} from "react-native"

export default class headerSearch extends Component {
	render(){
		return(
			<View style={styles.container}>
				<View style={styles.search}>
					<TextInput placeholder="输入关键字看看能不能吃" style={styles.input}></TextInput>
					<Image style={styles.search_icon} source={require("./search _icon.png")} />
				</View>
				<TouchableOpacity style={styles.btn}>
					<Text style={styles.btnText}>搜索</Text>
				</TouchableOpacity>
			</View>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		paddingLeft:15,
		paddingRight: 15,
		height: 55,
		backgroundColor: "#ffffff",
		flexDirection: "row",
		justifyContent: "center",
		alignItems: "center"
	},
	search:{
		width:297,
		height: 37,
		position:"relative"
	},
	search_icon: {
		position: "absolute",
		left:15,
		top:"50%",
		marginTop: -6,
		width:10,
		height:12
	},
	input: {
		width:297,
		height: 37,
		backgroundColor: "#F2F2F2",
		borderRadius: 19,
		fontSize:14,
		paddingLeft:31,
		color:"#333333"
	},
	btn:{
		marginLeft:5
	},
	btnText: {
		fontSize: 18,
		color: "#F55F7E"
	}
});

module.exports = headerSearch;
