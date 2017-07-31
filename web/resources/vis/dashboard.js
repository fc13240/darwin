/**
* @author joycexu
* @this DarwinDashboard
* @constructor
* @param domid 为展示仪表盘的dom的id，不需要以#开头
* @param dashboardid 为展示仪表盘id
*/
var DarwinDashboard = function(domid, dashboardid,savePanelStyleFunc) {
	this.domid = domid;
	this.dom = $('#'+domid);
	this.dashboardid = dashboardid;
	this.needSave = false;
	this.panelcount = 0;
	this.timer = null;
	this.interval = 30000;
	this.refresh = false;
	this.savePanelStyleFunc = savePanelStyleFunc;
	var thethis = this;	//use for function
	//initial dashboard
	DarwinDashboard.prototype.init = function(panels) {
		thethis.dom.empty();
		if (panels && panels.length > 0) {
			thethis.count = 0;
			var panelhtml = [],top = 0, left = 0, style = null;
			$.each(panels, function(i, v){
				panelhtml = []
				if (v.style && v.style.top) {
					style = v.style;
				} 
				thethis.addpanel(v.type, v.panelid, v.graphid, style);
			});
			thethis.draw();
		}
		interact('.draggable')
		.draggable({
		    inertia: true,
		    restrict: {
		    	restriction: "parent",
		    	endOnly: true,
		    	elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
		    },
		    onmove: function (event) {
		    	var target = event.target,
		    		x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
		    		y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;
		    	target.style.webkitTransform =
		    	target.style.transform = 'translate(' + x + 'px, ' + y + 'px)';
		    	target.setAttribute('data-x', x);
		    	target.setAttribute('data-y', y);
		    },
		    onend: function (event) {
		    	thethis.save(event.target);
		    	//thethis.needSave = true;
		    }
		})
		.resizable(true)
		.on('resizemove', function (event) {
		    var target = event.target;
		    var newWidth  = parseFloat(target.style.width) + event.dx,
		        newHeight = parseFloat(target.style.height) + event.dy;
		    target.style.width  = newWidth + 'px';
		    target.style.height = newHeight + 'px';
		})
		.on('resizeend', function(event){
			//重绘图表
			var panelgraph = $(event.target).children('.darwin-board-content').data('graph');
			console.log(typeof panelgraph !== 'undefined');
			if (typeof panelgraph !== 'undefined') {
				var width = $(event.target).width();
				var height = $(event.target).height()-20;
				panelgraph.draw(width, height);
			}
			//thethis.needSave = true;
			thethis.save(event.target);
		});
		KindEditor.ready(function(K) {
			window.editor = K.create('#text-content');
			K('#btn-change-bg').click(function() {
				editor.loadPlugin('image', function() {
					editor.plugin.imageDialog({
						imageUrl : K('#url1').val(),
						clickFn : function(url, title, width, height, border, align) {
							//K('#url1').val(url);
							editor.hideDialog();
							//console.log(url);
							$('#darwin-dashboard').css('backgroundImage', 'url('+url+')');
						}
					});
				});
			});
		});
		
		//确定添加文字区域
		$('#btn-add-text-confirm').click(function(){
			//TODO:这里应该向后端发送增加文字类型panel的请求,返回panelid
			var panelid = 100;
			thethis.addpanel('text', panelid, window.editor.html());
			$('#add－text-modal').modal('hide')
		});
		//确定添加图表区域
		$('#btn-add-graph-confirm').click(function(){
			//TODO:这里应该向后端发送增加文字类型panel的请求,返回panelid和graphid
			var panelid = 100, graphid = 1;
			thethis.addpanel('graph', panelid, graphid);
			$('#add－graph-modal').modal('hide')
		});
		//全屏显示图表
		$('#btn-full-screen').click(function(){
			
		});
		//更换背景
		$('#btn-change-bg').click(function(){
			
		});
		//导出
		$('#btn-export').click(function(){
			
		});
		//开启／关闭实时刷新
		$('#dashboard-refresh-realtime').click(function(){
			if ($(this).is(':checked')) {
				//开启自动刷新
				thethis.startRefresh();
			} else {
				//关闭
				thethis.stopRefresh();
			}
		});
		$('#time-select').change(function(){
			var timearr = getDateRange($(this).val());
			$('#time-start').val(timearr[0]);
			$('#time-end').val(timearr[1]);
		});
		$('#time-select').change();
		$('#time-interval').change(function(){
			if (thethis.refresh) {
				thethis.interval = parseInt($(this).val());
				thethis.startRefresh();
			}
		});
		$('#btn-full-screen').click(function() {
			$('#darwin-dashboard').fullscreen();
			return false;
		});
		$('.darwin-board-op-edit').on('click', function(){
			var panelid = $(this).parent().parent().data('panelid');
			var graphid = $(this).parent().parent().data('graphid');
//			console.log("=========");
//			console.log($(this).parent().parent().data());
//			alert('准备进入面板的编辑页面'+panelid);
			location.href = "/chart/edit.jsp?id="+graphid;
		});
		$('.darwin-board-op-del').on('click', function(){
			var panelid = $(this).parent().parent().data('panelid');
			if (!confirm('您确定要删除这个面板吗？')) {
				return false;
			}
			createMark();
			console.log('开始删除'+panelid);
			
			$.ajax({
				url:getLocation() + "/panel?method=deletePanel&panelid="+panelid,
				type:"post",
				dataType:"text",
				success:function(data2, textStatus){
					location.reload();
				},
				error:function(error){
					console.log(error);
				}
			});
			
		});
		window['dashboard'] = thethis;
		
		
		function getLocation() {
			var localObj = window.location;
			var contextPath = localObj.pathname.split("/")[1];
			var basePath = localObj.protocol+"//"+localObj.host+"/";//+contextPath;
			var server_context = basePath;
			console.log(server_context);
			return server_context;
		};
	};
	//resize
	DarwinDashboard.prototype.resize = function() {
		
	};
	//全屏
	DarwinDashboard.prototype.fullscreen = function() {
		
	};
	//get condition, eg.time、 dashboard
	DarwinDashboard.prototype.getCondition = function() {
		var cond = {};
		return cond;
	};
	//draw
	DarwinDashboard.prototype.draw = function() {
		if (dashboard.timer != null) {
			$('#time-end').val(new Date().Format("yyyy-MM-dd hh:mm:ss"));
		}
		//逐一绘制panel
		var paneldom = null;
		$.each($('.darwin-board'), function(i, v){
			$(v).children('.darwin-board-content').html('正在获取数据，请稍等');
			thethis.drawpanel($(v).data('panelid'), $(v).data('graphid'), thethis.getCondition());
		});
	};
	//draw panel
	DarwinDashboard.prototype.drawpanel = function(panelid, graphid, cond) {
		console.log("drawpanel="+panelid+","+graphid+","+cond);
		$.ajax({
			//url:this.getLocation() + "/search?method=loadIndexData&graphid="+graphid,
			url:"/analytics?method=runningOnChart&method2=drawpanel&graphid="+graphid,
			type:"post",
			dataType:"json",
			success:function(data2, textStatus){
				console.log(data2);
				console.log(textStatus);
				var options = {
						"header.title.text":data2.name,
						"header.subtitle.text":"A full pie chart to show off label collision detection and resolution.",
				};
				
				var chartData = [];
				if(data2.chartType=="spline"){//实时曲线图
					chartData = data2.chartInfo;
				}else{ //默认图数据
					chartData = data2.data;
				}
				
				console.log("chartData="+chartData);
				
				//test
				//var x = (new Date()).getTime(), // current time         
                //y = Math.random();
				
				//chartData
				
				//var r = {panelid:panelid, graphid:graphid, type:'hcline', data:data2.data, options:options}
				var r = {panelid:panelid, graphid:graphid, type:data2.chartType, data:chartData, options:options}
				var graph = null;
				var domId = 'panelbody'+r.panelid;
				if (panelid==3) {
					r.type = 'map';
					r.data = [
								{
									"label": "河北",
									"value": 264131
								},
								{
									"label": "北京",
									"value": 218812
								},
								{
									"label": "上海",
									"value": 157618
								},
								{
									"label": "江西",
									"value": 114384
								}
							];
				}
				var graph = new GraphViewPort(r.graphid, domId);
				graph.render(r);
				$('#'+domId).data('graph', graph);
			},
			error:function(error){
				console.log(error);
			}
		});
	};
	//add a panel
	DarwinDashboard.prototype.addpanel = function(type, panelid, mixdata, style) {
		var panelhtml = [], top = 120*thethis.count + 'px', left = 0, width = '400px', height = '300px', transform = '';
		if (style) {
			top = style.top;
			left = style.left;
			top = style.top;
			width = style.width;
			height = style.height;
			transform = style.transform;
		}
		if (type=='text') {
			panelhtml.push('<div data-type="'+type+'" data-panelid="'+panelid+'" data-graphid="0" class="darwin-board draggable" style="top:'+top+';left:'+left+';width:'+width+';height:'+height+';transform:'+transform+'">');
			panelhtml.push('<div class="darwin-board-op"><a class="darwin-board-op-edit"><span class="glyphicon glyphicon-cog"></span></a><a class="darwin-board-op-del"><span class="glyphicon glyphicon-trash"></span></a></div>');
			panelhtml.push('<div class="darwin-board-content" id="panelbody'+panelid+'" >');
			panelhtml.push(mixdata);
			panelhtml.push('</div>');
			panelhtml.push('</div>');
			thethis.count++;
			thethis.dom.append(panelhtml.join(''));
		} else {
			panelhtml.push('<div data-type="'+type+'" data-panelid="'+panelid+'" data-graphid="'+mixdata+'" class="darwin-board draggable" style="top:'+top+';left:'+left+';width:'+width+';height:'+height+';transform:'+transform+'">');
			panelhtml.push('<div class="darwin-board-op"><a class="darwin-board-op-edit"><span class="glyphicon glyphicon-cog"></span></a><a class="darwin-board-op-del"><span class="glyphicon glyphicon-trash"></span></a></div>');
			panelhtml.push('<div class="darwin-board-content" id="panelbody'+panelid+'" >');
			panelhtml.push('</div>');
			panelhtml.push('</div>');
			thethis.count++;
			thethis.dom.append(panelhtml.join(''));
			thethis.drawpanel(panelid, mixdata, thethis.getCondition());
		}
	};
	//export data
	DarwinDashboard.prototype.exportdata = function() {
		
	};
	//保存
	DarwinDashboard.prototype.save = function(paneldom) {
		var params = {};
		params['id'] = $(paneldom).data('panelid');
		//params['style'] = {};
		params['top'] = $(paneldom).css('top');
		params['left'] = $(paneldom).css('left');
		params['width'] = $(paneldom).css('width');
		params['height'] = $(paneldom).css('height');
		params['transform'] = $(paneldom).css('transform');
		//TODO:向后端发送ajax请求
		this.savePanelStyleFunc(params);
	};
	//start refresh
	DarwinDashboard.prototype.startRefresh = function() {
		clearTimeout(dashboard.timer);
		dashboard.refresh = true;
		dashboard.timer = setInterval("dashboard.draw()", dashboard.interval); 
	};
	//end refresh
	DarwinDashboard.prototype.stopRefresh = function() {
		dashboard.refresh = false;
		clearTimeout(dashboard.timer);
	};
	
	DarwinDashboard.prototype.getLocation = function() {
		var localObj = window.location;
		var contextPath = localObj.pathname.split("/")[1];
		var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
		var server_context = basePath;
		//console.log(server_context);
		return server_context;
	};
};
