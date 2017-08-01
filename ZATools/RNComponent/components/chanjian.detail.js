import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	View,
	Text,
	Image,
	ScrollView,
	AsyncStorage,
	TouchableOpacity,
	NativeModules,
} from "react-native";

const URL = require("./config/config.js").url;
const Module = require("./modules/module.js");
var iosPicker = NativeModules.ZAShowPicker;
export class chanjianDetail extends Component {
	constructor(props) {
		super(props);
		console.log(props);
		this.getInfo = this.getInfo.bind(this);
		this.state ={
			date: null,
			data: props.data,
			detail: {},
			chanjia_finished_ids: []
		};
	}
	componentDidMount() {
		this.getInfo();
		let that = this;
		AsyncStorage.getItem("chanjia_finished_ids",function(err,result){
			that.setState({
				chanjia_finished_ids: result ? result.split(",") : []
			});
			console.log(that.state.chanjia_finished_ids);
		});
	}
	getInfo(){
		let url = URL + "/chanjian/getById";
		let formData = new FormData();
		formData.append("id", this.props.data.id);
		fetch(url, {method: "POST", body: formData})
		.then((res)=> res.json())
		.then((result)=>{
			console.log(result);
			this.setState({
				detail: result.result
			})
		})
	}
	finish(){
		let that = this;
		let data = this.state.data;
		let chanjia_finished_ids = this.state.chanjia_finished_ids;
		chanjia_finished_ids.push(data.id);
		chanjia_finished_ids = chanjia_finished_ids.join(",");
		AsyncStorage.setItem("chanjia_finished_ids",chanjia_finished_ids, function(err){
			AsyncStorage.getItem("chanjia_finished_ids",function(err,result){
				that.setState({
					chanjia_finished_ids: result.split(",")
				});
				console.log(that.state.chanjia_finished_ids);
			});
		});
		data.finish = true;
		this.setState({
			data: data
		});
		console.log(this.state.data);
	}
	setDate(){
		console.log("hello world");
		iosPicker.showTimePicker("产检时间" ,(error, events) =>{
			if(error){
				console.error(" error " + error);
			}else{
				console.log(" 时间 " + events );
				this.setState({date: events});
				console.log(" == " + this.state.date);
			}
		})
	}
	render(){
		return(
			<ScrollView style={styles.container}>
				<View>
					<View style={styles.header_item}>
						<Text style={[styles.text_big, styles.text_red]}>第{this.state.data.id}次产检</Text>
						<View style={styles.header_item_right}>
							<Text style={[styles.text_big, this.state.data.finish?styles.text_red:styles.text_black]}>{this.state.data.finish? "已完成":"待完成"}</Text>
							<TouchableOpacity onPress={this.state.data.finish ? null : this.finish.bind(this)}>
								<Image style={styles.icon} source={this.state.data.finish ? require("./icon/success_red_icon.png") : require("./icon/waiting_icon.png")} />
							</TouchableOpacity>
						</View>
					</View>
					<View style={styles.header_item}>
						<Text style={[styles.text_big, styles.text_black]}>适宜孕周</Text>
						<View style={styles.header_item_right}>
							<Text style={[styles.text_big, styles.text_grey]}>孕{this.state.data.week}周</Text>
						</View>
					</View>
					<View style={styles.header_item}>
						<Text style={[styles.text_big, styles.text_black]}>产检时间</Text>
						<TouchableOpacity style={styles.header_item_right} onPress={this.setDate.bind(this)}>
							<Text style={[styles.text_big, styles.text_grey]}>{Module.Date(this.state.data.date)} 周{Module.Day(this.state.data.date)}</Text>
							<Image style={styles.arrow_icon} source={require("./icon/arrow_icon.png")} />
						</TouchableOpacity>
					</View>
				</View>
				<View style={styles.content}>
					<View style={styles.content_item}>
						<Text style={[styles.text_small, styles.text_red]}>产检简介</Text>
						<Text style={[styles.text_small, styles.text_grey,styles.content_text]}>
							{this.state.detail.brief}
						</Text>
					</View>
					<View style={styles.content_item}>
						<Text style={[styles.text_small, styles.text_red]}>产检项目</Text>
						<Text style={[styles.text_small, styles.text_grey, styles.content_text]}>
							{this.state.detail.project}
						</Text>
					</View>
					<View style={styles.content_item}>
						<Text style={[styles.text_small, styles.text_red]}>产检贴士</Text>
						<Text style={[styles.text_small, styles.text_grey,styles.content_text]}>
							{this.state.detail.tips}
						</Text>
					</View>
				</View>
			</ScrollView>
		)
	}
};

const styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor: "#f5f5f5"
	},
	header_item:{
		backgroundColor: "#ffffff",
		paddingLeft: 15,
		paddingRight: 15,
		height: 55,
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		borderBottomColor: "#e4e4e4",
		borderBottomWidth: 1
	},
	header_item_right:{
		flexDirection: "row",
		alignItems: "center"
	},
	content:{
		paddingLeft: 15,
		paddingRight: 15,
        marginTop: 10,
        backgroundColor: "#ffffff"
	},
	content_item:{
		marginTop:14
	},
	content_text:{
		marginTop:5,
		lineHeight: 23
	},
	icon:{
		width:22,
		height:22,
		marginLeft:5
	},
	arrow_icon:{
		width: 9,
		height: 15,
		marginLeft: 5
	},
	text_big:{
		fontSize: 15
	},
	text_small:{
		fontSize: 14
	},
	text_red: {
		color: "#F55F7E"
	},
	text_black: {
		color: "#333333"
	},
	text_grey:{
		color: "#999999"
	}
});

module.exports = chanjianDetail;
