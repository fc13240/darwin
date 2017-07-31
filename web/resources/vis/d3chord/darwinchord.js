/**
* @author joycexu
* @this DarwinChord
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* [{"label":label, "value":value},...]
*/
var svg = null;
var DarwinChord = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 590/500;//宽高比,从demo获得
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * header.subtitle.text 为图表的次标题，非必要
	 */
	DarwinChord.prototype.draw = function(width, height, options) {
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
		
		//this.data = this.makeColorSerial(this.data);
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
		
		if(typeof window['_darwin_is_body_clk_chord_tt_binded'] == "undefined") {
			$('body').click(function(e){
				var segmentClick = window['_darwin_chord_segment_clk_label'];
	            if (typeof segmentClick!="undefined" 
	            	&& segmentClick!="") {
	            	$('._darwin_tooltip').css('top', e.pageY - 20).css('left', e.pageX).text(segmentClick).show();
	            }
	        });
			window['_darwin_is_body_clk_chord_tt_binded'] = 1;
		}
		
		this.finalOptions['callbacks'] = {
	        	'onMouseoutSegment':function(info) {
	        		window['_darwin_chord_segment_clk_label'] = '';
	                $('._darwin_tooltip').text('').hide();
	            },
	            'onClickSegment':function(info) {
	            	window['_darwin_chord_segment_clk_label'] = info.data.label;
	            }
	        };
		var chord = d3.layout.chord()
	    .padding(.05)
	    .sortSubgroups(d3.descending)
	    .matrix(data);
		
	var innerRadius = Math.min(width, height) * .41,
	    outerRadius = innerRadius * 1.1;

	var fill = d3.scale.ordinal()
	    .domain(d3.range(4))
	    .range(["#000000", "#FFDD89", "#957244", "#F26223"]);

	svg = d3.select("#"+this.domid).append("svg")
	    .attr("width", width)
	    .attr("height", height)
	  .append("g")
	    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

	svg.append("g").selectAll("path")
	    .data(chord.groups)
	  .enter().append("path")
	    .style("fill", function(d) { return fill(d.index); })
	    .style("stroke", function(d) { return fill(d.index); })
	    .attr("d", d3.svg.arc().innerRadius(innerRadius).outerRadius(outerRadius))
	    .on("mouseover", fade(.1))
	    .on("mouseout", fade(1));

	var ticks = svg.append("g").selectAll("g")
	    .data(chord.groups)
	  .enter().append("g").selectAll("g")
	    .data(groupTicks)
	  .enter().append("g")
	    .attr("transform", function(d) {
	      return "rotate(" + (d.angle * 180 / Math.PI - 90) + ")"
	          + "translate(" + outerRadius + ",0)";
	    });

	ticks.append("line")
	    .attr("x1", 1)
	    .attr("y1", 0)
	    .attr("x2", 5)
	    .attr("y2", 0)
	    .style("stroke", "#000");

	ticks.append("text")
	    .attr("x", 8)
	    .attr("dy", ".35em")
	    .attr("transform", function(d) { return d.angle > Math.PI ? "rotate(180)translate(-16)" : null; })
	    .style("text-anchor", function(d) { return d.angle > Math.PI ? "end" : null; })
	    .text(function(d) { return d.label; });

	svg.append("g")
	    .attr("class", "chord")
	  .selectAll("path")
	    .data(chord.chords)
	  .enter().append("path")
	    .attr("d", d3.svg.chord().radius(innerRadius))
	    .style("fill", function(d) { return fill(d.target.index); })
	    .style("opacity", 1);

		DarwinVis['viscontainer'][this.domid] = d3.select('#'+this.domid);
	};
	//参数解析
	DarwinChord.prototype.parseOptions = function(options) {
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
	DarwinChord.prototype._rescureSetJson = function(dict, keylist, val) {
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
	DarwinChord.prototype.makeColorSerial = function(data) {
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

//Returns an array of tick angles and labels, given a group.
function groupTicks(d) {
  var k = (d.endAngle - d.startAngle) / d.value;
  return d3.range(0, d.value, 1000).map(function(v, i) {
    return {
      angle: v * k + d.startAngle,
      label: i % 5 ? null : v / 1000 + "k"
    };
  });
}

// Returns an event handler for fading a given chord group.
function fade(opacity) {
  return function(g, i) {
    svg.selectAll(".chord path")
        .filter(function(d) { return d.source.index != i && d.target.index != i; })
      .transition()
        .style("opacity", opacity);
  };
}