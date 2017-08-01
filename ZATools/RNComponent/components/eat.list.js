/*----------------能不能吃列表页面----------*/
import React, { Component } from "react";
import {
	AppRegistry,
	StyleSheet,
	Text,
	Image,
	View,
	ScrollView,
	TouchableOpacity,
	ListView
} from "react-native";
const HeaderSearch = require("./common/header.search.js");
const eatDetail = require("./eat.detail.js");
const URL = require("./config/config.js").url;
console.log(URL);

export class List extends Component {
	constructor(props){
		super(props);
		this.pressPush = this.pressPush.bind(this);
		console.log(props);
	}
	pressPush(i){
		console.log(this.props);
		let nextRoute = {
			component: eatDetail,
			title: this.props.list[i].title1
		};
		this.props.navigator.push(nextRoute);
	}
	eatIcon(val){
		if(val == "YES"){
			return require("./icon/success_icon.png");
		}else if(val === "NO"){
			return require("./icon/stop_icon.png");
		}else if(val === "WARN"){
			return require("./icon/warning_icon.png");
		}
	}
	render(){
		return(
			<View style={styles.listContent}>
				<TouchableOpacity style={styles.item}>
					<View>
						<Image source={{uri:this.props.item.imgUrl}} style={styles.img}></Image>
					</View>
					<View style={styles.item_right}>
						<Text style={styles.item_title_big}>{this.props.item.name}</Text>
						<Text style={styles.item_title_small}>{this.props.item.aliasName}</Text>
						<View style={styles.options}>
							<View style={styles.option}>
								<Image source={this.eatIcon(this.props.item.preCaneat)} style={styles.option_icon}></Image>
								<Text style={styles.option_text}>孕妇</Text>
							</View>
							<View style={styles.option}>
								<Image source={this.eatIcon(this.props.item.afterCaneat)} style={styles.option_icon}></Image>
								<Text style={styles.option_text}>产妇</Text>
							</View>
							<View style={styles.option}>
								<Image source={this.eatIcon(this.props.item.babyCaneat)} style={styles.option_icon}></Image>
								<Text style={styles.option_text}>婴幼儿</Text>
							</View>
						</View>
					</View>
				</TouchableOpacity>
			</View>
		)
	}
};

export class eatList extends Component {
	constructor(props){
		var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
		super(props);
		this.state = {
			list: [],
			page: {
				pageNo:1,
				pageSize:10,
				pageCount: null
			},
			dataSource: ds
		}
		console.log(this.state);
	}
	componentDidMount() {
		console.log("组件加载完毕");
		this.getData();
	}
	getData(){
		let url = URL + "/eat/list";
		let formData = new FormData();
		formData.append("typeId", this.props.id);
		formData.append("pageNo", this.state.page.pageNo);
		formData.append("pageSize", this.state.page.pageSize);
		fetch(url, {
			method: "POST",
			headers: {
			    'Accept': 'application/json',
			    'Content-Type': 'application/x-www-form-urlencoded',
			},
			body: formData
		})
      	.then(res => res.json())
      	.then(resJson => {
      		let list = resJson.result.list || [];
      		console.log(list);
        	let page = this.state.page;
        	let dataList = this.state.list || [];
        	console.log(dataList);
        	list.map(function(item,index,array){
        		dataList.push(item);
        	});
        	console.log(dataList);
        	page.pageCount = resJson.result.page.pageCount;
        	this.setState({
        		list: list,
        		dataSource: this.state.dataSource.cloneWithRows(dataList),
        		page: page
        	})
      	})
      	.catch(err => {
        	console.log(err);
      	});
	}
	_more(){
		console.log("加载更多......");
		let page = this.state.page;
		if(page.pageNo < page.pageCount){
			page.pageNo += 1;
			console.log(page);
			this.setState({
				page: page
			});
			this.getData();
			console.log(page);
		};
		
	}
	_renderRow(info){
		return (
			<List item={info}></List>
		)
	}
	render() {
		const list = [];
		return(
			<View style={styles.container}>
				<HeaderSearch></HeaderSearch>
				<View style={styles.list}>
					<ListView dataSource={this.state.dataSource} renderRow={this._renderRow} onEndReached={this._more.bind(this)} 
					onEndReachedThreshold={50}
					/>
				</View>
			</View>
		)
	}
};
const styles = StyleSheet.create({
	container:{
		marginTop:65,
		backgroundColor: "#f5f5f5"
	},
	list:{
		marginTop:10,
		paddingLeft: 15,
		backgroundColor: "#ffffff",
		paddingBottom:46
	},
	listContent:{
		marginTop: -65,
		marginBottom: 65
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