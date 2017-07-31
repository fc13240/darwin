/**
* @author fushiguang
* @this DarwinPie
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* [{"label":label, "value":value},...]
*/
var DarwinPie = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 590/500;//宽高比,从demo获得
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * header.subtitle.text 为图表的次标题，非必要
	 */
	DarwinPie.prototype.draw = function(width, height, options) {
		if (typeof options == "undefined") {
			options = {};
		}
		if (width == "" && height == "") {
			console.error("DarwinPie for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (width == "") {
			width = Math.floor(height * this.bestWidthHeight);
		}
		if (height == "") {
			height = Math.floor(width / this.bestWidthHeight);
		}
		options['size.canvasWidth'] = width;
		options['size.canvasHeight'] = height;
		this.parseOptions(options);
		$('#'+this.domid).empty();
		this.data = this.makeColorSerial(this.data);
		this.finalOptions["data"]["content"] = this.data;
		
		DarwinVis['viscontainer'][this.domid] = new d3pie(this.domid, this.finalOptions);
	};
	//参数解析
	DarwinPie.prototype.parseOptions = function(options) {
		this.finalOptions = this.defaultOptions;
		
		if (options == null || typeof options == "undefined") {
			return;
		}
		for(var key in options) {
			var list = key.split('.');
			this.finalOptions = this._rescureSetJson(this.finalOptions, list, options[key]);
		}
	};
	//递归设置属性值
	DarwinPie.prototype._rescureSetJson = function(dict, keylist, val) {
		var key = keylist.shift();
		if (keylist.length == 0) {
			dict[key] = val;
			return dict;
		}
		//dict = dict[key];
		dict[key] = this._rescureSetJson(dict[key], keylist, val);
		return dict;
	};
	/**
	 * 为每个数据计算其颜色
	 */
	DarwinPie.prototype.makeColorSerial = function(data) {
		//if(!data){return;}
		console.log("data="+data);
		var colorsize = DarwinVis.colors.length;
		for(var i=0; i<data.length; i++) {
			data[i]['color'] = DarwinVis.colors[i%colorsize];
		}
		return data;
	};
	
	this.defaultOptions = {
			"header": {
				"title": {
					"text": "",//"Lots of Programming Languages",
					"fontSize": 24,
					"font": "open sans"
				},
				"subtitle": {
					"text": "",//"A full pie chart to show off label collision detection and resolution.",
					"color": "#999999",
					"fontSize": 12,
					"font": "open sans"
				},
				"titleSubtitlePadding": 9
			},
			"footer": {
				"color": "#999999",
				"fontSize": 10,
				"font": "open sans",
				"location": "bottom-left"
			},
			"size": {
				"canvasWidth": 590
			},
			"data": {
				"sortOrder": "value-desc",
				"content": [/*
					{
						"label": "JavaScript",
						"value": 264131,
						"color": "#546e91"
					}*/
				]
			},
			"labels": {
				"outer": {
					"hideWhenLessThanPercentage": 1,
					"pieDistance": 32
				},
				"inner": {
					"hideWhenLessThanPercentage": 3
				},
				"mainLabel": {
					"fontSize": 11
				},
				"percentage": {
					"color": "#ffffff",
					"decimalPlaces": 0
				},
				"value": {
					"color": "#adadad",
					"fontSize": 11
				},
				"lines": {
					"enabled": true,
					"style": "straight"
				}
			},
			"effects": {
				"pullOutSegmentOnClick": {
					"effect": "linear",
					"speed": 400,
					"size": 8
				}
			},
			"misc": {
				"gradient": {
					"enabled": true,
					"percentage": 100
				}
			}
		};
};
