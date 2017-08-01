import {AsyncStorage} from "react-native";

exports.Date = function(timeStamp){
	if(!timeStamp){
		return "";
	};
	let newDate = new Date(timeStamp);
	let year = newDate.getFullYear();
	let month = newDate.getMonth() + 1;
	month = (month < 10) ? "0" + month : month;
	let date = newDate.getDate(); 
	return year + "-" + month + "-" + date;
};
exports.Day = function(timeStamp){
	if(!timeStamp){
		return "";
	};
	let newDate = new Date(timeStamp);
	let day = newDate.getDay();
	switch(day){
		case 0:
			return "日";
		case 1:
			return "一";
		case 2:
			return "二";
		case 3:
			return "三";
		case 4:
			return "四";
		case 5:
			return "五";
		case 6:
			return "六"
	}
};
exports.NumToCN = function(num){
	if(!num){
		return "";
	};
	switch(num){
		case 1:
			return "一";
		case 2:
			return "二";
		case 3:
			return "三";
		case 4:
			return "四";
		case 5:
			return "五";
		case 6:
			return "六";
		case 7:
			return "七";
		case 8:
			return "八";
		case 9:
			return "九";
		case 10:
			return "十";
		case 11:
			return "十一";
		case 12:
			return "十二"
	}
};
exports.async_save = function(key, value){
	try {
		AsyncStorage.setItem(key, value);
		console.log("_save success: ", value);
	}catch(error){
		console.log(error);
	}
};
exports.async_get = function(key){
	try {
		var value = AsyncStorage.getItem(key);
		console.log(value);
	}catch(error){
		console.log(error);
	}
};