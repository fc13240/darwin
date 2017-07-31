/**
* @author joycexu
* @this DarwinHbar
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* [{"label":label, "value":value},...]
*/
var DarwinHbar = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 590/500;//宽高比,从demo获得
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * header.subtitle.text 为图表的次标题，非必要
	 */
	DarwinHbar.prototype.draw = function(width, height, options) {
		if (typeof options == "undefined") {
			options = {};
		}
		var title = "";
		if (typeof options['header.title.text']!="undefined") {
			title = options['header.title.text'];
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
		
		if(typeof window['_darwin_is_body_clk_hbar_tt_binded'] == "undefined") {
			$('body').click(function(e){
				var segmentClick = window['_darwin_hbar_segment_clk_label'];
	            if (typeof segmentClick!="undefined" 
	            	&& segmentClick!="") {
	            	$('._darwin_tooltip').css('top', e.pageY - 20).css('left', e.pageX).text(segmentClick).show();
	            }
	        });
			window['_darwin_is_body_clk_hbar_tt_binded'] = 1;
		}
		
		this.finalOptions['callbacks'] = {
	        	'onMouseoutSegment':function(info) {
	        		window['_darwin_hbar_segment_clk_label'] = '';
	                $('._darwin_tooltip').text('').hide();
	            },
	            'onClickSegment':function(info) {
	            	window['_darwin_hbar_segment_clk_label'] = info.data.label;
	            }
	        };
		var margin = {top: 30, right: 10, bottom: 10, left: 10},
		    width = options['size.canvasWidth'] - margin.left - margin.right,
		    height = options['size.canvasHeight'] - margin.top - margin.bottom;

		var x = d3.scale.linear()
		    .range([0, width])
	
		var y = d3.scale.ordinal()
		    .rangeRoundBands([0, height], .2);
	
		var xAxis = d3.svg.axis()
		    .scale(x)
		    .orient("top");
		var yAxis = d3.svg.axis()
			  .scale(y)
			  .orient("left");
		var tip = d3.tip()
			  .attr('class', 'd3-tip')
			  .offset([-10, 0])
			  .html(function(d) {
			    return "<strong>"+d.label+":</strong> <span style='color:red'>" + d.value + "</span>";
			  });
		var svg = d3.select("#"+this.domid).append("svg")
		    .attr("width", width + margin.left + margin.right)
		    .attr("height", height + margin.top + margin.bottom)
		    .append("g")
		    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
	    var data = this.data;
	    
	    svg.call(tip);
		x.domain(d3.extent(data, function(d) { return d.value; })).nice();
		y.domain(data.map(function(d) { return d.label; }));
		
		var g_bartitle = svg.append("g").attr("class","bar_title");
		var g_bartitle_text = g_bartitle.append("text").attr("class","bar_title_text").text( title );
		
		
		svg.selectAll(".barbg")
	      .data(data)
	      .enter()
	      .append("rect")
	      .attr("class", "bar-bg")
	      .attr("x", 0)
	      .attr("y", function(d) { return y(d.label); })
	      .attr("width", width + margin.left + margin.right)
	      .attr("height", y.rangeBand())
		  .on('mouseover', tip.show)
		  .on('mouseout', tip.hide);
		
		svg.selectAll(".bar")
	      .data(data)
	      .enter()
	      .append("rect")
	      .attr("class", "bar")
	      .attr("x", function(d) { return x(Math.min(0, d.value)); })
	      .attr("y", function(d) { return y(d.label); })
	      .attr("width", function(d) { return Math.abs(x(d.value) - x(0)); })
	      .attr("height", y.rangeBand())
		  .on('mouseover', tip.show)
		  .on('mouseout', tip.hide);
		
		 svg.selectAll(".label")
		  .data(data)
	      .enter()
	      .append("text")
	      .attr("x", 0)
	      .attr("y", function(d) { return y(d.label)+y.rangeBand()/2; })
	      .text(function(d) { return d.label; })
		DarwinVis['viscontainer'][this.domid] = d3.select('#'+this.domid);
	};
	//参数解析
	DarwinHbar.prototype.parseOptions = function(options) {
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
	DarwinHbar.prototype._rescureSetJson = function(dict, keylist, val) {
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
	DarwinHbar.prototype.makeColorSerial = function(data) {
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
