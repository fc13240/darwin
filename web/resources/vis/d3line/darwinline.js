/**
* @author fushiguang
* @this DarwinLine
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，数据需按照时间排序好（增序），且格式如下
* [{"datetime":"dt with format yyyy-mm-dd HH:ii:ss", "value":value},...]
*/
var DarwinLine = function(domid, data) {
	this.domid = domid;
	this.data = [];
	this.outpathcolor = "#eee";
	for(var i=0; i<data.length; i++) {
		var dtstr = data[i]["datetime"];
		//firefox js engine not allow - in datetime format
		dtstr = dtstr.replace(/\-/g, '/');
		var dtms = Date.parse(dtstr);
		this.data.push({"datetime":new Date(dtms), "value":data[i]["value"]});
	}
	
	//this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 900/450;//宽高比,从demo获得
	
	var monthNames = [ "\u4e00\u6708", "\u4e8c\u6708", "\u4e09\u6708", "\u56db\u6708", "\u4e94\u6708", "\u516d\u6708",
	                   "\u4e03\u6708", "\u516b\u6708", "\u4e5d\u6708", "\u5341\u6708", "\u5341\u4e00\u6708", "\u5341\u4e8c\u6708" ];

	//最多展现的转折点数量，当超过时不展现
	var maxDataPointsForDots = 200,
	transitionDuration = 1000;

	
	
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * header.subtitle.text 为图表的次标题，非必要
	 */
	DarwinLine.prototype.draw = function(width, height, options) {
		var svg = null,
		yAxisGroup = null,
		xAxisGroup = null,
		dataCirclesGroup = null,
		dataLinesGroup = null;
		
		if (typeof options == "undefined") {
			options = {};
		}
		var title = "";
		if (typeof options['header.title.text']!="undefined") {
			title = options['header.title.text'];
		}
		var linecolor = "steelblue";
		if (typeof options['style.line.color']!="undefined") {
			linecolor = options['style.line.color'];
		}
		var areacolor = "lightsteelblue";
		if (typeof options['style.area.color']!="undefined") {
			areacolor = options['style.area.color'];
		}
		var ytips = "";
		if (typeof options['style.y.tip']!="undefined") {
			ytips = options['style.y.tip'];
		}
		
		if (width == "" && height == "") {
			console.error("DarwinLine for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (width == "") {
			width = Math.floor(height * this.bestWidthHeight);
		}
		if (height == "") {
			height = width / this.bestWidthHeight;
		}
		this.width = width;// - this.margin.left - this.margin.right;
		this.height = height;// - this.margin.top - this.margin.bottom;
		
		if (this.width<0 || this.height<0) {
			console.error("DarwinLine for div["+this.domid+"], size is too small");
			return false;
		}
		
		var formatPercent = d3.format(".0");
		/*
%a - abbreviated weekday name.
%A - full weekday name.
%b - abbreviated month name.
%B - full month name.
%c - date and time, as "%a %b %e %H:%M:%S %Y".
%d - zero-padded day of the month as a decimal number [01,31].
%e - space-padded day of the month as a decimal number [ 1,31]; equivalent to %_d.
%H - hour (24-hour clock) as a decimal number [00,23].
%I - hour (12-hour clock) as a decimal number [01,12].
%j - day of the year as a decimal number [001,366].
%m - month as a decimal number [01,12].
%M - minute as a decimal number [00,59].
%L - milliseconds as a decimal number [000, 999].
%p - either AM or PM.
%S - second as a decimal number [00,61].
%U - week number of the year (Sunday as the first day of the week) as a decimal number [00,53].
%w - weekday as a decimal number [0(Sunday),6].
%W - week number of the year (Monday as the first day of the week) as a decimal number [00,53].
%x - date, as "%m/%d/%Y".
%X - time, as "%H:%M:%S".
%y - year without century as a decimal number [00,99].
%Y - year with century as a decimal number.
%Z - time zone offset, such as "-0700".
%% - a literal "%" character.
		 */
		var formatx = d3.time.format.multi([
		                                    [".%L", function(d) { return d.getMilliseconds(); }],
			                                   [":%S", function(d) { return d.getSeconds(); }],
			                                   ["%H:%M", function(d) { return d.getMinutes(); }],
			                                   ["%H%p", function(d) { return d.getHours(); }],
			                                   ["%m\u6708%d\u65e5", function(d) { return d.getDay() && d.getDate() != 1; }],
			                                   ["%m\u6708%d\u65e5", function(d) { return d.getDate() != 1; }],
			                                   ["%m\u6708", function(d) { return d.getMonth(); }],
			                                   ["%Y\u5e74", function() { return true; }]/*
		                                   [".%L", function(d) { return d.getMilliseconds(); }],
		                                   [":%S", function(d) { return d.getSeconds(); }],
		                                   ["%I:%M", function(d) { return d.getMinutes(); }],
		                                   ["%I %p", function(d) { return d.getHours(); }],
		                                   ["%a %d", function(d) { return d.getDay() && d.getDate() != 1; }],
		                                   ["%b %d", function(d) { return d.getDate() != 1; }],
		                                   ["%B", function(d) { return d.getMonth(); }],
		                                   ["%Y", function() { return true; }]*/
		                                 ]);
		
		var margin = 40;
		var max = d3.max(this.data, function(d) { return d.value;});
		
		var g_bartitle_text = d3.select('body').append('svg:svg')
			.append('svg:g').append("text").style("font-size","12pt").text( max );
		//test text width
		var bbox = g_bartitle_text.node().getBBox();
		//console.log(bbox.width+"======================");
		d3.select('body').select('svg').remove();
		if (bbox.width>margin) {
			margin = Math.ceil(bbox.width);
		}
		
		var min = 0;
		var pointRadius = 4;
		var x = d3.time.scale()
			.range([0, this.width - margin * 2])
			.domain([this.data[0].datetime, this.data[this.data.length - 1].datetime]);
		var y = d3.scale.linear()
			.range([this.height - margin * 2, 0])
			.domain([min, max]);
		
		var xAxis = d3.svg.axis()
			.scale(x)
			.tickSize(this.height - margin * 2)
			.tickPadding(10)
			//.ticks(d3.time.day,1)
			.tickFormat(formatx);//间隔数.nice(d3.time.year)
		var yAxis = d3.svg.axis()
			.scale(y)
			.orient('left')
			.tickSize(-this.width + margin * 2)
			.tickPadding(10)//离y轴的距离
			.tickFormat(formatPercent);
		var t = null;

		svg = d3.select('#'+this.domid).select('svg').select('g');
		if (svg.empty()) {
			svg = d3.select('#'+this.domid)
				.append('svg:svg')
					.attr('width', this.width)
					.attr('height', this.height)
					.attr('class', 'viz')
					.attr('fill', 'none')
				.append('svg:g')
					.attr('transform', 'translate(' + margin + ',' + margin + ')');
		}
		
		t = svg.transition().duration(transitionDuration);

		// y ticks and labels
		if (!yAxisGroup) {
			yAxisGroup = svg.append('svg:g')
				.attr('class', 'yTick')
				.call(yAxis)
				.append("text")
					  //.attr("transform", "rotate(-90)")
					  .attr("y", -12)
					  .attr("dy", ".71em")
					  .attr("x", 10)
					  .style("text-anchor", "end")
					  .text( ytips );
		}
		else {
			t.select('.yTick').call(yAxis);
		}
		
		// x ticks and labels
		if (!xAxisGroup) {
			xAxisGroup = svg.append('svg:g')
				.attr('class', 'xTick')
				.call(xAxis);
		}
		else {
			t.select('.xTick').call(xAxis);
		}
		
		//上半部分的外部边框
		svg.selectAll('.xTick .domain')
			.style("stroke", this.outpathcolor)
			.style("stroke-width", 2)
			.style("stroke-dasharray", 0)
			.style("fill", "none");
		
		
		svg.selectAll('.tick line').style("stroke", "#CDCDCD")
			.style("stroke-width", 0.5)
			.style("fill", "none");
		
		// Draw the lines
		if (!dataLinesGroup) {
			dataLinesGroup = svg.append('svg:g');
		}
		
		var dataLines = dataLinesGroup.selectAll('.darwin-data-line')
				.data([this.data]);
		
		var line = d3.svg.line()
			// assign the X function to plot our line as we wish
			.x(function(d,i) { 
				// verbose logging to show what's actually being done
				//console.log('Plotting X value for date: ' + d.date + ' using index: ' + i + ' to be at: ' + x(d.date) + ' using our xScale.');
				// return the X coordinate where we want to plot this datapoint
				//return x(i); 
				return x(d.datetime); 
			})
			.y(function(d) { 
				// verbose logging to show what's actually being done
				//console.log('Plotting Y value for data value: ' + d.value + ' to be at: ' + y(d.value) + " using our yScale.");
				// return the Y coordinate where we want to plot this datapoint
				//return y(d); 
				return y(d.value); 
			})
			.interpolate("linear");
		
			 /*
			 .attr("d", d3.svg.line()
			 .x(function(d) { return x(d.date); })
			 .y(function(d) { return y(0); }))
			 .transition()
			 .delay(transitionDuration / 2)
			 .duration(transitionDuration)
				.style('opacity', 1)
		                    .attr("transform", function(d) { return "translate(" + x(d.date) + "," + y(d.value) + ")"; });
			  */
		
		var garea = d3.svg.area()
			.interpolate("linear")
			.x(function(d) { 
				// verbose logging to show what's actually being done
				return x(d.datetime); 
			})
		        	.y0(this.height - margin * 2)
			.y1(function(d) { 
				// verbose logging to show what's actually being done
				return y(d.value); 
			});
		
		dataLines
			.enter()
			.append('svg:path')
		        	.attr("class", "darwin-area")
		        	.style("fill", areacolor)
		        	.attr("d", garea(this.data)).style('opacity', 0.5);
		
		dataLines.enter().append('path')
			 .attr('class', 'darwin-data-line')
			 .style("stroke", linecolor)
			 .style("stroke-width", 2)
			 .style("fill", "none")
			 .style("stroke-dasharray", 0)
			 .style('opacity', 0.3)
			 .attr("d", line(this.data));
			/*
			.transition()
			.delay(transitionDuration / 2)
			.duration(transitionDuration)
				.style('opacity', 1)
				.attr('x1', function(d, i) { return (i > 0) ? xScale(data[i - 1].date) : xScale(d.date); })
				.attr('y1', function(d, i) { return (i > 0) ? yScale(data[i - 1].value) : yScale(d.value); })
				.attr('x2', function(d) { return xScale(d.date); })
				.attr('y2', function(d) { return yScale(d.value); });
			*/
		
		dataLines.transition()
			.attr("d", line)
			.duration(transitionDuration)
				.style('opacity', 1)
				//.style('stroke', '#cdcdcd')
	            //.style('stroke-width', 0.5)
	            //.style('fill', 'none')
		                    ;/*.attr("transform", 
		                    		function(d) { 
		                    			return "translate(" + x(d.datetime) + "," + y(d.value) + ")"; 
		                    		});*/
		
		dataLines.exit()
			.transition()
			.attr("d", line)
			.duration(transitionDuration)
		                    .attr("transform", 
		                    		function(d) {
		                    			return "translate(" + x(d.datetime) + "," + y(0) + ")"; 
		                    		})
				.style('opacity', 1e-6)
				.remove();
		
		//整个图表区域的下半部分
		svg.selectAll('g .darwin-area')
			.style("stroke", this.outpathcolor)
			.style("stroke-width", 2)
			.style("stroke-dasharray", 0);
		
		svg.selectAll('text').style('font-family', 'courier').style('font-size', '8pt').style('fill', '#787878');
		
		svg.selectAll(".darwin-area").transition()
			.duration(transitionDuration)
			.attr("d", garea(this.data));

		// Draw the points
		if (!dataCirclesGroup) {
			dataCirclesGroup = svg.append('svg:g');
		}

		var circles = dataCirclesGroup.selectAll('.darwin-data-point')
			.data(this.data);

		var mythis = this;
		circles
			.enter()
				.append('svg:circle')
					.attr('class', 'darwin-data-point')
					.style("stroke", linecolor)
					.style("stroke-width", 2)
					.style("fill", "#fff")
					.style('opacity', 1e-6)
					.attr('cx', function(d) { return x(d.datetime);})
					.attr('cy', function() { return y(0);})
					.attr('r', function() { return (mythis.data.length <= maxDataPointsForDots) ? pointRadius : 0;})
				.transition()
				.duration(transitionDuration)
					.style('opacity', 1)
					.attr('cx', function(d) { return x(d.datetime);})
					.attr('cy', function(d) { return y(d.value);});
		
		circles
			.transition()
			.duration(transitionDuration)
				.attr('cx', function(d) { return x(d.datetime);})
				.attr('cy', function(d) { return y(d.value);})
				.attr('r', function() { return (mythis.data.length <= maxDataPointsForDots) ? pointRadius : 0;})
				.style('opacity', 1);
		
		circles
			.exit()
				.transition()
				.duration(transitionDuration)
					// Leave the cx transition off. Allowing the points to fall where they lie is best.
					//.attr('cx', function(d, i) { return xScale(i) })
					.attr('cy', function() { return y(0);})
					.style("opacity", 1e-6)
					.remove();

	  $('svg circle').tipsy({ 
		  gravity: 'w', 
		  html: true, 
		  title: function() {
			  var d = this.__data__;
			  var pDate = d.datetime;
			  return "<strong>"+pDate.getFullYear()+"-"+pDate.getMonth()+"-"+pDate.getDate()+":</strong> <span style='color:white'>" + d.value + "</span>";
			  //return pDate.getFullYear()+" "+monthNames[pDate.getMonth()] + " " + pDate.getDate() + " " + '<br>' + d.value; 
		  }
	  });
	  DarwinVis['viscontainer'][this.domid] = d3.select('#'+this.domid);
	};
};
