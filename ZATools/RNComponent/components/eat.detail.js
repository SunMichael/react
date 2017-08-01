/*-----------能不能吃详情---------*/
import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	NavigatorIOS,
	TouchableOpacity,
	Image
} from "react-native";


export class List extends Component {
	render(){
		return (
			<View>
				<View style={styles.item}>
					<Text style={styles.item_title}>怀孕妈妈能吃大米吗？</Text>
					<View style={[styles.icon_content,styles.success_icon]}>
						<Image style={styles.icon} source={require("./icon/success_white_icon.png")}></Image>
						<Text style={styles.icon_text}>能吃!</Text>
					</View>
					<Text style={styles.item_text}>准妈妈可以将大米制作成米饭或煮粥，作为主食用。</Text>
				</View>
				<View style={styles.item}>
					<Text style={styles.item_title}>怀孕妈妈能吃大米吗？</Text>
					<View style={[styles.icon_content,styles.stop_icon]}>
						<Image style={styles.icon} source={require("./icon/stop_white_icon.png")}></Image>
						<Text style={styles.icon_text}>不能吃!</Text>
					</View>
					<Text style={styles.item_text}>准妈妈可以将大米制作成米饭或煮粥，作为主食用。</Text>
				</View>
				<View style={styles.item}>
					<Text style={styles.item_title}>怀孕妈妈能吃大米吗？</Text>
					<View style={[styles.icon_content,styles.warning_icon]}>
						<Image style={styles.icon} source={require("./icon/warning_white_icon.png")}></Image>
						<Text style={styles.icon_text}>慎吃!</Text>
					</View>
					<Text style={styles.item_text}>准妈妈可以将大米制作成米饭或煮粥，作为主食用。</Text>
				</View>
			</View>
		)
	}
};

export class eatDetail extends Component {
	render(){
		return(
			<View style={styles.container}>
				<Text style={styles.title}>花生</Text>
				<List></List>
			</View>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		marginTop: 65,
		paddingLeft:15,
		paddingRight:15
	},
	title: {
		fontSize:18,
		color:"#333333",
		height:45,
		lineHeight: 45
	},
	item:{
		paddingTop:25,
		paddingBottom:25,
		borderTopColor: "#e4e4e4",
		borderTopWidth: 1
	},
	item_title:{
		fontSize:18,
		color:"#333333"
	},
	icon_content:{
		marginTop:10,
		flexDirection: "row",
		alignItems: "center",
		padding:5,
		borderRadius:50
	},
	success_icon:{
		backgroundColor: "#19BB2A",
		width:66,
	},
	stop_icon:{
		backgroundColor: "#F55F7E",
		width:80
	},
	warning_icon:{
		backgroundColor: "#FF8A00",
		width:66,
	},
	icon:{
		width:15,
		height:15
	},
	icon_text:{
		marginLeft:3,
		fontSize:14,
		color:"#ffffff"
	},
	item_text:{
		marginTop:15,
		fontSize:15,
		color:"#999999"
	}
});

module.exports = eatDetail;