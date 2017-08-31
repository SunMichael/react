/*---------产检时间表--------*/
import React, { Component } from "react";
import {
	AppRegistry,
	View,
	StyleSheet,
	Text,
	ListView,
	Image,
	AsyncStorage,
	TouchableOpacity
} from "react-native";

const URL = require("./config/config.js").url;
const Module = require("./modules/module.js");
const chanjianDetail = require("./chanjian.detail.js");

export class antenatalCareList extends Component{
	constructor(props) {
		super(props);
		var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => {
			if (r1 !== r2) {
                console.log("不相等=");
                console.log(r1);
            } else {
                console.log("相等=");
                console.log(r1);
                console.log(r2);
            }
            return r1 !== r2;
		}});
		this.state = {
		   list: [],
		   dataSource: ds,
		   chanjia_finished_ids: []
		};
		this.getList = this.getList.bind(this);
	}
	componentDidMount() {
		let that = this;
		AsyncStorage.getItem("chanjia_finished_ids",function(err,result){
			console.log(this);
			that.setState({
				chanjia_finished_ids: result ? result.split(",") : []
			});
			that.getList();
		});
		//AsyncStorage.removeItem("chanjia_finished_ids");
	}
	getList(){
		let url = URL + "/chanjian/list";
		let formData = new FormData();
		formData.append("expectedBirthDate", "2017-8-20");

		let chanjia_finished_ids = this.state.chanjia_finished_ids;
		fetch(url, {method: "POST", body: formData}).then((res)=>{
			console.log(res);
			return res.json();
		}).then((result)=>{
			var list = result.result;
			var newlist = list.map(function(item,index,array){
				if(chanjia_finished_ids.indexOf(item.id.toString()) >= 0){
					item.finish = true;
				}else{
					item.finish = false;
				};
				return JSON.stringify(item);
			});
			this.setState({
				list: list,
				dataSource: this.state.dataSource.cloneWithRows(newlist)
			});
		});
	}
	pressPush(data){
		let nextRoute = {
			component: chanjianDetail,
			title: "第" + data.id + "次产检",
			passProps: {
				data: data
			}
		};
		console.log(this.props);
		this.props.navigator.push(nextRoute);
	}
	pressFinish(id){
		let that = this;
		let chanjia_finished_ids = this.state.chanjia_finished_ids;
		if(chanjia_finished_ids.indexOf(id.toString()) < 0 ){
			chanjia_finished_ids.push(id);
			chanjia_finished_ids = chanjia_finished_ids.join(",");
			AsyncStorage.setItem("chanjia_finished_ids",chanjia_finished_ids, function(err){
				AsyncStorage.getItem("chanjia_finished_ids",function(err,result){
					that.setState({
						chanjia_finished_ids: result.split(",")
					});
					console.log(that.state.chanjia_finished_ids);
				});
			});
			console.log(this.state.list);
			var list = this.state.list;
			console.log(list);
			var newList = list.map(function(item,index,array){
				if(chanjia_finished_ids.indexOf(item.id.toString()) >= 0){
					item.finish = true;
				}else{
					item.finish = false;
				};
				return JSON.stringify(item);
			});
			console.log(newList);
			this.setState({
				dataSource: this.state.dataSource.cloneWithRows(newList)
			});
			console.log(this.state.dataSource);
		}
	}
	_renderRow(rowData){
		let row = JSON.parse(rowData);
		return (
			<View style={styles.row}>
				<TouchableOpacity style={styles.row_left} onPress={this.pressPush.bind(this, row)
				}>
					<View style={row.finish ? styles.active: styles.times}>
						<Text style={styles.times_text}>第{Module.NumToCN(row.id)}次</Text>
						<Text style={styles.times_text}>产检</Text>
					</View>
					<View style={styles.row_content}>
						<View>
							<Text style={[styles.text_big]}>{this.state.test}怀孕{row.week}周 {this.state.i}</Text>
							<Text style={[styles.grey, styles.text_small]}>{row.brief}</Text>
							<View style={styles.times_row}>
								{
									this.state.chanjia_finished_ids.indexOf(rowData.id) >= 0 ? (
										<Image source={require("./icon/time_icon.png")} style={styles.time_icon} />
									): ( null
									)
								}
								<Text style={[styles.grey, styles.text_small]}>{Module.Date(row.date)} 周{Module.Day(row.date)}</Text>
							</View>
						</View>
					</View>
				</TouchableOpacity>
				<TouchableOpacity onPress={this.pressFinish.bind(this, row.id)}>
					<Image source={row.finish
								? require("./icon/success_red_icon.png")
								: require("./icon/success_grey_icon.png")
							}
							style={styles.right_icon}/>
				</TouchableOpacity>
			</View>
		)
	}
	render(){
		return(
			<View style={styles.container}>
				<ListView
			      dataSource={this.state.dataSource}
			      renderRow={this._renderRow.bind(this)}
			    />
			</View>
		);
	}
};

const styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor: "#f5f5f5"
	},
	row:{
		marginLeft:15,
		marginRight:15,
		padding:15,
		backgroundColor: "#ffffff",
		marginTop:10,
		height:90,
		borderRadius:4,
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		shadowColor: "#000000",
		shadowOffset: {width:0,height:0},
		shadowRadius: 3
	},
	times:{
		width:60,
		height:60,
		backgroundColor: "#d9d9d9",
		borderRadius: 30,
		flexDirection: "column",
		justifyContent: "center",
		alignItems: "center",
	},
	active:{
		width:60,
		height:60,
		backgroundColor: "#FF9A9E",
		borderRadius: 30,
		flexDirection: "column",
		justifyContent: "center",
		alignItems: "center",
	},
	times_text:{
		color:"#ffffff"
	},
	right_icon:{
		width:22,
		height:22
	},
	row_left:{
		flexDirection: "row",
		alignItems:"center"
	},
	time_icon:{
		width:14,
		height:14,
		marginRight: 4
	},
	times_row:{
		flexDirection: "row",
		alignItems:"center"
	},
	row_content:{
		marginLeft:10,
		flexDirection: "column",
		justifyContent : "space-between"
	},
	text_big: {
		fontSize: 15
	},
	text_small: {
		fontSize: 14
	},
	block:{
		color: "#333333"
	},
	grey: {
		color: "#999999"
	}
});

module.exports = antenatalCareList;
