/**
* @author joycexu
* @this DarwinWordcloud
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* [{"label":label, "value":value},...]
*/
var DarwinWordcloud = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 590/500;//宽高比,从demo获得
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * header.subtitle.text 为图表的次标题，非必要
	 */
	DarwinWordcloud.prototype.draw = function(width, height, options) {
		if (typeof options == "undefined") {
			options = {};
		}
		var title = "";
		if (typeof options['header.title.text']!="undefined") {
			title = options['header.title.text'];
		}
		if (width == "" && height == "") {
			console.error("DarwinWordcloud for div["+this.domid+"], both width and height are empty. must at least one has value");
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
		$('#'+this.domid).empty();
		var fill = d3.scale.category20b();
		var w = width,
		    h = height;
		var words = [],
		    max,
		    scale = 1,
		    complete = 0,
		    keyword = "",
		    tags = this.data,
		    maxLength = 30,
		    fetcher;
		var svgtitle = d3.select("#"+domid).append("svg")
	    .attr("width", w)
	    .attr("height", 20);
		var g_bartitle = svgtitle.append("g").attr("class","bar_title");
		var g_bartitle_text = g_bartitle.append("text").attr("class","bar_title_text").text( title );
		var svg = d3.select("#"+domid).append("svg")
	    .attr("width", w)
	    .attr("height", h-20);
		
//		var tags = [{'key':"高校食堂现神菜西瓜",'value':3332223},{'key':"贝克汉姆挺中国足球",'value':20}];
		var fontSize = d3.scale['linear']().range([20, 40]);//有三个选项 log sqrt linear
		if (tags.length) fontSize.domain([+tags[tags.length - 1].value || 1, +tags[0].value]);
		var thethisgraph = this;
		var layout = d3.layout.cloud()
		    .timeInterval(10)
		    .size([w, h])
		    .fontSize(function(d) { return fontSize(+d.value); })
		    .font('Impact')
		    .spiral('archimedean')//有两个选项 archimedean rectangular
		    .text(function(d) { return d.key; })
		    .on("end", drawword)
		    .stop().words(tags.slice(0, max = Math.min(tags.length, +250))).start();
		var background = svg.append("g"),
	    viss = svg.append("g")
	    .attr("transform", "translate(" + [w >> 1, h >> 1] + ")");
		
		function drawword(data,bounds) {
			scale = bounds ? Math.min(
				      w / Math.abs(bounds[1].x - w / 2),
				      w / Math.abs(bounds[0].x - w / 2),
				      h / Math.abs(bounds[1].y - h / 2),
				      h / Math.abs(bounds[0].y - h / 2)) / 2 : 1;
		  words = data;
		  if (!viss) return;
		  var text = viss.selectAll("text")
		      .data(words, function(d) { 
		    	  if (isNaN) {
		    		  return d.text.toLowerCase();
		    	  }else {
		    		  return d.text;
		    	  }
		      });
		  text.transition()
		      .duration(1000)
		      .attr("transform", function(d) { return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"; })
		      .style("font-size", function(d) { return d.size + "px"; });
		  text.enter().append("text")
		      .attr("text-anchor", "middle")
		      .attr("transform", function(d) { return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"; })
		      .style("font-size", function(d) { return d.size + "px"; })
		      .style("opacity", 1e-6)
		    .transition()
		      .duration(1000)
		      .style("opacity", 1);
		  text.style("font-family", function(d) { return d.font; })
		      .style("fill", function(d) { return fill(d.text.toLowerCase()); })
		      .text(function(d) { return d.text; });
		  var exitGroup = background.append("g")
		      .attr("transform", viss.attr("transform"));
		  var exitGroupNode = exitGroup.node();
		  text.exit().each(function() {
		    exitGroupNode.appendChild(this);
		  });
		  exitGroup.transition()
		      .duration(1000)
		      .style("opacity", 1e-6)
		      .remove();
		  viss.transition()
		      .delay(1000)
		      .duration(750)
		      .attr("transform", "translate(" + [w >> 1, h >> 1] + ")scale(" + scale + ")");
		};
		DarwinVis['viscontainer'][this.domid] = d3.select('#'+this.domid);
	};
	
	//参数解析
	DarwinWordcloud.prototype.parseOptions = function(options) {
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
	DarwinWordcloud.prototype._rescureSetJson = function(dict, keylist, val) {
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
	DarwinWordcloud.prototype.makeColorSerial = function(data) {
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

