/**
 * 格式化时间
 * @param d Date eg: d = new Date
 * @returns
 */
function formatDateTime(d) {
	var year = d.getYear();
	var month = d.getMonth()+1;
	var date = d.getDate();
	var day = d.getDay();
	var hours = d.getHours();
	var minutes = d.getMinutes();
	var seconds = d.getSeconds();
	var ms = d.getMilliseconds();
	var formatDateTime= year;
	if(month>9) 
		formatDateTime = formatDateTime +"-"+month;
	else
		formatDateTime = formatDateTime +"-0"+month;
	if(date>9)
		formatDateTime = formatDateTime +"-"+date;
	else
		formatDateTime = formatDateTime +"-0"+date;
	if(hours>9)
		formatDateTime = formatDateTime +" "+hours;
	else
		formatDateTime = formatDateTime +" 0"+hours;
	if(minutes>9)
		formatDateTime = formatDateTime +":"+minutes; 
	else 
		formatDateTime = formatDateTime +":0"+minutes;
	if(seconds>9)
		formatDateTime = formatDateTime +":"+seconds;
	else
		formatDateTime = formatDateTime +":0"+seconds;
	return formatDateTime;
}
/**
 * 时间加减天数
 * @param interval 	eg:y代表年， m代表月， d代表天等
 * @param number	eg:加减的数值
 * @param olddate	eg:加减的时间基数
 * @returns {Date}
 */
function DateAdd(interval,number, olddate){ 
	var date = new Date();
	number = parseInt(number);
    switch(interval){
        case "y": date.setFullYear(olddate.getFullYear()+number); break;
        case "m": date.setMonth(olddate.getMonth()+number); break;
        case "d": date.setDate(olddate.getDate()+number); break;
        case "w": date.setDate(olddate.getDate()+7*number); break;
        case "h": date.setHours(olddate.getHours()+number); break;
        case "n": date.setMinutes(olddate.getMinutes()+number); break;
        case "s": date.setSeconds(olddate.getSeconds()+number); break;
        case "l": date.setMilliseconds(olddate.getMilliseconds()+number); break;
    } 
    return date;
}
/**
 * 格式化输出时间
 * (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2014-07-02 08:09:04.423
 * (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2014-7-2 8:9:4.18 
 */
Date.prototype.Format = function(fmt)   
{
	var o = {   
	    "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
    };
	if(/(y+)/.test(fmt))
		fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	for(var k in o)  
		if(new RegExp("("+ k +")").test(fmt)) 
		fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	return fmt;   
}  
/**
 * 将字符串转换为时间戳，单位s
 */
function strtotime(s){
    var t = s.split(/(?: |-|:)/);
    t[1]--;
    eval('var d = new Date('+t.join(',')+');');
    return d.getTime()/1000;
}
/**
 * 获得时间段的开始与结束时间
 */
function getDateRange(rangetype) {
	var dates = [], curdate = new Date(), starttime, endtime;
	if (rangetype=='lasthour') {
		//上一小时
		var lastHour = DateAdd('h', -1,  curdate), starttime, endtime;
		starttime = lastHour.Format("yyyy-MM-dd hh:00:00");
		endtime = lastHour.Format("yyyy-MM-dd hh:59:59");
		
	} else if (rangetype=='curhour') {
		//当前小时
		starttime = curdate.Format("yyyy-MM-dd hh:00:00");
		endtime = curdate.Format("yyyy-MM-dd hh:mm:ss");
	} else if (rangetype=='today') {
		//今天
		starttime = curdate.Format("yyyy-MM-dd 00:00:00");
		endtime = curdate.Format("yyyy-MM-dd hh:mm:ss");
	} else if (rangetype=='yestoday') {
		//昨天
		var yestoday = DateAdd('d', -1,  curdate);
		starttime = yestoday.Format("yyyy-MM-dd 00:00:00");
		endtime = yestoday.Format("yyyy-MM-dd 23:59:59");
	} else if (rangetype=='week') {
		//本周
		var day = curdate.getDay();
		if (day == 0) {
			day = 6;
		}
		var monday =  DateAdd('d',  -day+1,  curdate);
		starttime = monday.Format("yyyy-MM-dd 00:00:00");
		endtime = curdate.Format("yyyy-MM-dd hh:mm:ss");
	} else if (rangetype=='lastweek') {
		//上周
		var day = curdate.getDay();
		if (day == 0) {
			day = 6;
		}
		var lastmonday = DateAdd('d',  -day-7+1,  curdate);
		var lastsunday = DateAdd('d',  6,  lastmonday);
		starttime = lastmonday.Format("yyyy-MM-dd 00:00:00");
		endtime = lastsunday.Format("yyyy-MM-dd 23:59:59");
	} else if (rangetype=='month') {
		//本月
		starttime = curdate.Format("yyyy-MM-01 00:00:00");
		endtime = curdate.Format("yyyy-MM-dd hh:mm:ss");
	} else if (rangetype=='lastmonth') {
		//上月
		var days = curdate.getDate();
		var lastmonth = DateAdd('d',  -days,  curdate);
		starttime = lastmonth.Format("yyyy-MM-01 00:00:00");
		endtime = lastmonth.Format("yyyy-MM-dd 23:59:59");
	} else if (rangetype=='year') {
		//今年
		starttime = curdate.Format("yyyy-01-01 00:00:00");
		endtime = curdate.Format("yyyy-MM-dd hh:mm:ss");
	}
	dates.push(starttime);
	dates.push(endtime);
	dates.push(strtotime(starttime));
	dates.push(strtotime(endtime));
	return dates;
}