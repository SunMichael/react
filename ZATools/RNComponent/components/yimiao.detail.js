import React , { Component } from "react";
import {
	AppRegistry,
	View,
	Text,
	StyleSheet,
	Image
} from "react-native";

export class yimiaoDetail extends Component {
	render(){
		return (
			<View style={styles.container}>
				<View style={styles.header}>
					<View style={styles.header_row}>
						<View style={styles.flex_row}>
							<Image style={styles.zhen_icon} source={require("./icon/zhen_icon.png")} />
							<Text>疫苗名称</Text>
						</View>
						<Text>乙肝疫苗第一针</Text>
					</View>
				</View>
			</View>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		flex: 1,
		marginTop: 65,
		backgroundColor: "#f5f5f5"
	},
	header:{
		backgroundColor: "#ffffff",
		margin:15,
		borderRadius: 4
	},
	header_row:{
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		height: 45
	},
	flex_row:{
		flexDirection: "row",
		alignItems: "center",
		paddingLeft: 15,
		paddingRight: 15
	},
	zhen_icon:{
		width:13,
		height:13
	}
});

module.exports = yimiaoDetail;