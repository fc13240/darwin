/**
* @author joycexu
* @this DarwinHbar
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* [{"label":label, "value":value},...]
*/
var DarwinMeter = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 590/500;//宽高比,从demo获得
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * header.subtitle.text 为图表的次标题，非必要
	 */
	DarwinMeter.prototype.draw = function(width, height, options) {
		if (typeof options == "undefined") {
			options = {};
		}
		if (width == "" && height == "") {
			console.error("DarwinDonut for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		options['size.canvasWidth'] = width;
		options['size.canvasHeight'] = height;
		this.parseOptions(options);
		
		this.data = this.makeColorSerial(this.data);
		this.finalOptions["data"]["content"] = this.data;
		
		var test_tt = $("._darwin_tooltip");
		if(test_tt.length<1) {
			$("body").append(
					//{ position: absolute; max-width:100px;max-height:200px;overflow:hidden;display:none;background-color:#ffcc00;border-radius:5px;padding:4px}
				$("<div>").attr("class", "_darwin_tooltip").css("position", "absolute").css("max-width", "100px")
					.css("max-height","200px").css("overflow","hidden").css("display","none").css("background-color","#ffcc00")
					.css("border-radius","5px").css("padding","4px")
			);
		}
		
		if(typeof window['_darwin_is_body_clk_meter_tt_binded'] == "undefined") {
			$('body').click(function(e){
				var segmentClick = window['_darwin_meter_segment_clk_label'];
	            if (typeof segmentClick!="undefined" 
	            	&& segmentClick!="") {
	            	$('._darwin_tooltip').css('top', e.pageY - 20).css('left', e.pageX).text(segmentClick).show();
	            }
	        });
			window['_darwin_is_body_clk_meter_tt_binded'] = 1;
		}
		
		this.finalOptions['callbacks'] = {
	        	'onMouseoutSegment':function(info) {
	        		window['_darwin_meter_segment_clk_label'] = '';
	                $('._darwin_tooltip').text('').hide();
	            },
	            'onClickSegment':function(info) {
	            	window['_darwin_meter_segment_clk_label'] = info.data.label;
	            }
	        };
		var svg = d3.select('#'+this.domid)
        .append("svg:svg")
        .attr("width", width)
        .attr("height", height);

		var radius = 0;
		if (width>height) {
			radius = height / 3;
		} else {
			radius = width / 3;
		}

		var gauge = iopctrl.arcslider()
		        .radius(radius)
		        .events(false)
		        .indicator(iopctrl.defaultGaugeIndicator);
		gauge.axis().orient("in")
		        .normalize(true)
		        .ticks(12)
		        .tickSubdivide(3)
		        .tickSize(10, 8, 10)
		        .tickPadding(5)
		        .scale(d3.scale.linear()
		                .domain([0, 100])
		                .range([-3*Math.PI/4, 3*Math.PI/4]));
		var strdata = String(this.data.value);
		
		var segDisplay = iopctrl.segdisplay()
		        .width(radius*2/3)
		        .digitCount(strdata.length+1)
		        .negative(false)
		        .decimals(0);
		
		svg.append("g")
		        .attr("class", "segdisplay")
		        .attr("transform", "translate("+radius+", "+(radius*3/2)+")")
		        .call(segDisplay);
		
		svg.append("g")
		        .attr("class", "gauge")
		        .call(gauge);
		
		segDisplay.value(this.data.value);
		gauge.value(this.data.ratio);
		DarwinVis['viscontainer'][this.domid] = d3.select('#'+this.domid);
	};
	//参数解析
	DarwinMeter.prototype.parseOptions = function(options) {
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
	DarwinMeter.prototype._rescureSetJson = function(dict, keylist, val) {
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
	DarwinMeter.prototype.makeColorSerial = function(data) {
		var colorsize = DarwinVis.colors.length;
		for(var i=0; i<data.length; i++) {
			data[i]['color'] = DarwinVis.colors[i%colorsize];
		}
		return data;
	};
	
	this.defaultOptions = {
			"header": {
				"title": {
					"text": "",//"Top 15 Fears",
					"fontSize": 34,
					"font": "courier"
				},
				"subtitle": {
					"text": "",//"What strikes the most terror in people?",
					"color": "#999999",
					"fontSize": 10,
					"font": "courier"
				},
				"location": "pie-center",
				"titleSubtitlePadding": 9
			},
			"footer": {
				"text":"",
				"color": "#999999",
				"fontSize": 10,
				"font": "open sans",
				"location": "bottom-left"
			},
			"size": {
				"canvasWidth": 590,
				"pieInnerRadius": "63%",
				"pieOuterRadius": "92%"
			},
			"data": {
				"sortOrder": "value-desc",//label-desc
				"smallSegmentGrouping": {//less than 5% will display as others
					"enabled": true,
					"value": 5
				},
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
					"format": "label-percentage1",
					"hideWhenLessThanPercentage": 1,
					"pieDistance": 32
				},
				"inner": {
					//"hideWhenLessThanPercentage": 3
					"format": "none"
				},
				"mainLabel": {
					"fontSize": 11
				},
				"percentage": {
					"color": "#999999",
					"fontSize": 11,
					"decimalPlaces": 0
				},
				"value": {
					"color": "#cccc43",
					"fontSize": 11
				},
				"lines": {
					"enabled": true
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
				"colors":{
					//"segmentStroke"=>"#3f3f3f"
				}
			}
		};
};
