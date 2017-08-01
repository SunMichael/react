import React, { Component } from "react";

import {
	AppRegistry,
	View,
	StyleSheet,
	Text,
	ListView
} from "react-native";

export class yimiaoList extends Component{
	constructor(props) {
		super(props);
		var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
	  	this.state = {
	    	dataSource: ds.cloneWithRows(['row 1', 'row 2']),
	  	};
	}
	row_render(){
		return (
			<View style={styles.row}>
				<View style={[styles.row_item, styles.row_item_title]}>
					<Text style={[styles.fontSize_30, styles.color_red]}>出生当天</Text>
					<Text style={[styles.fontSize_30, styles.color_red]}>2017-09-11</Text>
				</View>
				<View style={[styles.row_item, styles.row_item_con]}>
					<View>
						<View style={styles.flex_row}>
							<Text style={[styles.color_black, styles.fontSize_15]}>卡介苗</Text>
							<Text style={[styles.fontSize_24, styles.color_grey, styles.marginLeft_10]}>第一次</Text>
						</View>
						<View style={[styles.flex_row, styles.marginTop_16]}>
							<Text style={[styles.color_black, styles.fontSize_14]}>预防：</Text>
							<Text style={[styles.color_black, styles.fontSize_14]}>结核病</Text>
						</View>
					</View>
					<View style={[styles.btn_green]}>
						<Text style={[styles.fontSize_24, styles.color_white]}>必打</Text>
					</View>
				</View>
				<View style={styles.circle}>
					<View style={styles.dot}></View>
				</View>
			</View>
		)
	}
	render(){
		return(
			<View style={styles.container}>
				<ListView
					dataSource={this.state.dataSource}
	      			renderRow={this.row_render.bind(this)}
				 />
			</View>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor: "#f5f5f5"
	},
	row:{
		backgroundColor: "#ffffff",
		marginLeft:15,
		marginRight:10,
		marginTop:10
	},
	row_item:{
		flexDirection:"row",
		justifyContent: "space-between",
		alignItems: "center",
		paddingLeft: 15,
		paddingRight: 15,
	},
	row_item_title:{
		height:35
	},
	row_item_con:{
		height:56,
		borderTopColor: "#e4e4e4",
		borderTopWidth: 1
	},
	fontSize_30:{
		fontSize: 15
	},
	fontSize_28:{
		fontSize: 14
	},
	fontSize_24:{
		fontSize: 12
	},
	color_red:{
		color:"#F55F7E"
	},
	color_white:{
		color:"#ffffff"
	},
	color_black:{
		color: "#666666"
	},
	color_grey:{
		color: "#999999"
	},
	btn_green:{
		width:36,
		height:21,
		flexDirection:"row",
		justifyContent:"center",
		alignItems: "center",
		backgroundColor: "#35BB2E",
		borderRadius: 2
	},
	flex_row:{
		flexDirection: "row",
		alignItems: "flex-end"
	},
	marginLeft_10:{
		marginLeft: 5
	},
	marginTop_16:{
		marginTop:8
	},
	circle:{
		position:"absolute",
		top:0,
		left: -5,
		width:10,
		height:10,
		backgroundColor: "#ffffff",
		borderTopLeftRadius: 5,
		borderBottomLeftRadius: 5
	},
	dot:{
		width:2.5,
		height:2.5,
		backgroundColor: "#f55f7e",
		borderRadius:1.25,
		marginTop:3.75,
		marginLeft:2
	}
});

module.exports = yimiaoList;