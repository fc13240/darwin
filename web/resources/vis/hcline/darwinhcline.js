/**
* @author fushiguang
* @this DarwinMLine
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* {"xvalues":['x1'，'x2'，'x3',...], "yvalues":{"y1name":[y11,y12,y13,...],"y2name":[y21,y22,y23,y24,...]} }
*/
var DarwinHcLine = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 1000/300;//宽高比,从demo获得
	this.padding = [0,0,0,0];
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * graph.legend.show 0不显示，1显示
	 * graph.linestyle.smooth 0直线，1平滑
	 * graph.linestyle.showarea 0不显示区域，1显示区域
	 */
	DarwinHcLine.prototype.draw = function(width, height, options) {
		var _self = this;
		
		if (width == "" && height == "") {
			console.error("DarwinMLine for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (width == "") {
			width = Math.floor(height * this.bestWidthHeight);
		}
		if (height == "") {
			height = Math.floor(width / this.bestWidthHeight);
		}
		
		if (typeof options == "undefined") {
			options = {};
		}
		
		var _padding = _self.padding;
		/*
		var _title = "";
		if (typeof options['header.title.text']!="undefined") {
			_padding[0] = 40;
			_title = options['header.title.text'];
		}*/
		$('#'+_self.domid).highcharts({
	        title: {
	            text: 'Monthly Average Temperature',
	            x: -20 //center
	        },
	        subtitle: {
	            text: 'Source: WorldClimate.com',
	            x: -20
	        },
	        xAxis: {
	            categories: data[0]//['Jan', 'Feb', 'Mar']
	        },
	        yAxis: {
	            title: {
	                text: 'Temperature (°C)'
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: '°C'
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0
	        },
	        series: [{
	            name: 'Tokyo',
	            data: data[1]
	        }]
	    });
		/////////////
		
		//DarwinVis['viscontainer'][this.domid] = linechart2;
	};
	
	//递归设置属性值
	DarwinHcLine.prototype._clone = function(fromobject, toobject) {
		for(var fk in fromobject) {
			if(typeof fromobject[fk]=="object") {
				toobject[fk] = {};
				this._clone(fromobject[fk], toobject[fk]);
			} else {
				toobject[fk] = fromobject[fk];
			}
		}
	};
	
	
	DarwinHcLine.prototype.getLocation = function() {
		var localObj = window.location;
		var contextPath = localObj.pathname.split("/")[1];
		var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
		var server_context = basePath;
		//console.log(server_context);
		return server_context;
	};
};
