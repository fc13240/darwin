var GraphViewPort = function(graphId, domId) {
	this.graphId = graphId;
	this.domId = domId;
	this.timer = null;
	this.graph = null;
	GraphViewPort.prototype.refreshGraph = function(forcerefresh) {
		var self = this;
		self.refreshTimePanel(forcerefresh);
	};
	GraphViewPort.prototype.refreshTimePanel = function(forcerefresh) {
		var self = this;
		//向后台请求数据,给出正在刷新提示
		var domId = self.domId?self.domId:'graph-container';
		if (self.timer == null) {
			$('#'+domId).html('<div class="progress"><div class="progress-bar" style="width:1%;"></div></div>');
			self.timer = setInterval('refreshProgress("'+domId+'")', 100);
		}
		//调用封装的js展现数据
		var params = {};
		params['graph_id'] = self.graphId;
		params['start_time'] = $('#selected-time-start').val();
		params['end_time'] = $('#selected-time-end').val();
		params['forcerefresh'] = forcerefresh;
		SsAjax.post(
			params,
			'/vis/graph/ajax/method/refreshgraph',
			function(data) {
				if ($('#'+self.domId).find('.progress-bar').length>0) {
					$('#'+self.domId).find('.progress-bar').css('width', '100%');
					clearInterval(self.timer);
					$('#'+self.domId).empty();
				}
				if (!data.status) {
					self.render(data);
				} else {
					//失败的处理
					$.scojs_message(data.statusinfo, $.scojs_message.TYPE_ERROR);
				}
			}
		);
	};
	GraphViewPort.prototype.render = function (r) {
		var self = this;
		var type = r.type?r.type:'pie';
		var data = r.data?r.data:[];
		var options = r.options?r.options:{};
		var graph = null;
		var domId = self.domId?self.domId:'graph-container';
		var width = $('#'+domId).width();
		var height = $('#'+domId).parent().height()-20;
		$('#'+domId).empty();
		
		if (type=='pie') {
			graph = new DarwinPie(domId, r.data);
		} else if (type=='bar') {
			graph = new DarwinBar(domId, r.data);
		} else if (type=='donut') {
			graph = new DarwinDonut(domId, r.data);
		} else if (type=='line') {
			graph = new DarwinLine(domId, r.data);
		} else if (type=='hbar') {
			graph = new DarwinHbar(domId, r.data);
		} else if (type=='meter') {
			graph = new DarwinMeter(domId, r.data);
		} else if (type=='chord') {
			graph = new DarwinChord(domId, r.data);
		} else if (type=='wordcloud') {
			graph = new DarwinWordcloud(domId, r.data);
		} else if (type=='bubble') {
			graph = new DarwinBubble(domId, r.data);
		} else if (type=='mline') {
			graph = new DarwinMLine(domId, r.data);
		} else if (type=='map') {
			$('#'+domId).html('<div class="map" style="width:'+width+'px;height:'+height+'px;position:relative;"></div>');
			graph = new DarwinMap(domId, r.data);
		} else if (type=='hcline') {
			graph = new DarwinHcLine(domId, r.data);
		} else if (type=='spline') {
			graph = new DarwinSplineLine(domId, r.data);
		} 
		
		graph.draw(width, height, options);
		this.graph = graph;
	};
	GraphViewPort.prototype.draw = function (width, height) {
		this.graph.draw(width, height, this.finalOptions);
	};
}