/**
* @author fushiguang
* @this DarwinBar
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* [{"label":label, "value":value},...]
*/
var DarwinBar = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.width = 0;
	this.height = 0;
	this.bestWidthHeight = 960/500;//宽高比,从demo获得
	this.margin = {top: 40, right: 20, bottom: 30, left: 40};
	var thethis = this;//use for function
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * style.bar.color 柱子的颜色
	 * style.y.tip y轴的说明
	 */
	DarwinBar.prototype.draw = function(width, height, options) {
		if (typeof options == "undefined") {
			options = {};
		}
		var title = "";
		if (typeof options['header.title.text']!="undefined") {
			title = options['header.title.text'];
		}
		var barcolor = "orange";
		if (typeof options['style.bar.color']!="undefined") {
			barcolor = options['style.bar.color'];
		}
		var ytips = "";
		if (typeof options['style.y.tip']!="undefined") {
			ytips = options['style.y.tip'];
		}
		
		if (width == "" && height == "") {
			console.error("DarwinBar for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (width == "") {
			width = Math.floor(height * this.bestWidthHeight);
		}
		if (height == "") {
			height = width / this.bestWidthHeight;
		}
		this.width = width - this.margin.left - this.margin.right;
		this.height = height - this.margin.top - this.margin.bottom;
		
		if (this.width<0 || this.height<0) {
			console.error("DarwinBar for div["+this.domid+"], size is too small");
			return false;
		}
		
		var formatPercent = d3.format(".0");

		var x = d3.scale.ordinal()
		  .rangeRoundBands([0, this.width], .1);

		var y = d3.scale.linear()
		  .range([this.height, 0]);

		var xAxis = d3.svg.axis()
		  .scale(x)
		  .orient("bottom");

		var yAxis = d3.svg.axis()
		  .scale(y)
		  .orient("left")
		  .tickFormat(formatPercent);

		var tip = d3.tip()
		  .attr('class', 'd3-tip')
		  .offset([-10, 0])
		  .html(function(d) {
		    return "<strong>"+d.label+":</strong> <span style='color:red'>" + d.value + "</span>";
		  });

		d3.select("#"+this.domid+">svg").remove();
		var svg = d3.select("#"+this.domid).append("svg")
		  .attr("class", "darwinbar")
		  .attr("width", this.width + this.margin.left + this.margin.right)
		  .attr("height", this.height + this.margin.top + this.margin.bottom)
		  .append("g")
		  .attr("transform", "translate(" + this.margin.left + "," + this.margin.top + ")");

		var g_bartitle = svg.append("g").attr("class","bar_title");
		var g_bartitle_text = g_bartitle.append("text").attr("class","bar_title_text").text( title );
		//test text width
		var bbox = g_bartitle_text.node().getBBox();
		var newtitlex = Math.floor((width - bbox.width)/2);
		g_bartitle_text.remove();
		g_bartitle.append("text").attr("class","bar_title_text").attr("y", 10).attr("x",newtitlex).text( title );
		
		svg.call(tip);
		var y_max = parseInt(d3.max(data, function(d) { return parseFloat(d.value); }));
		
		x.domain(this.data.map(function(d) { return d.label; }));
        y.domain([0, y_max]);
        
			svg.append("g")
			  .attr("class", "x darwin_axis")
			  .attr("transform", "translate(0," + this.height + ")")
			  .call(xAxis);
	
			svg.append("g")
			  .attr("class", "y darwin_axis")
			  .call(yAxis)
			.append("text")
			  .attr("transform", "rotate(-90)")
			  .attr("y", 6)
			  .attr("dy", ".71em")
			  .style("text-anchor", "end")
			  .text( ytips );
	
			svg.selectAll(".bar")
			  .data(this.data)
			  .enter().append("rect")
			  .attr("class", "bar")
			  .attr('fill', barcolor)
			  .attr("x", function(d) { return x(d.label); })
			  .attr("width", x.rangeBand())
			  .attr("y", function(d) { console.log(y_max);console.log(thethis.height);console.log(d.value);return (y_max - parseFloat(d.value)) * thethis.height / (y_max - 0);})
			  .attr("height", function(d) { return parseFloat(d.value)  * thethis.height / y_max;})
			  .on('mouseover', tip.show)
			  .on('mouseout', tip.hide);
		
		DarwinVis['viscontainer'][this.domid] = svg;
	};
	
	
};
