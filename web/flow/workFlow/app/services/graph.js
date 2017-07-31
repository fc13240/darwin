define([
	'angular',
	'config',
	'jquery-ui',
	'raphael',
	'jquery',
	'sco.message',
	'raphael-connection'
]
,function(angular,config){
	'use strict';
	
	var module = angular.module('workflow.services');
	
	module.service('graph',function($rootScope,$http,backendSvr,util){
		var self = this;
		
		var relationshipTmp={};
		
		this.last_state = false;
		this.graph = {
		    w:960,
		    h:480,
		    styles:{
		        point:[170,60]
		    },
		    r:null,//(function(){
		    connections_map:{},//关系集合
		    graphs:{},// rect集合
		    comps:{},//	dom元素
		    maps:{},//顶点和索引的对应关系，为了建立索引关系,
		    tomaps:{},
		    frommaps:{},
		    config:null
		}
		
		this.createGraph = function(i, g ,tosave){
		    var me = self.graph;
		    g.depends = g.depends || "";
		    var x , y;
		    if(g.x){
		        x = g.x;
		    }else{
		        x = ((i%me.config.num) + 0.2)* me.config.cellW;
		    }
		    if(g.y){
		        y = g.y;

		    }else{
		        y = 20 + (~~(i/me.config.num)*me.config.cellH );
		    }

		    g.x = x;
		    g.y = y;
		    g.activated = g.activated===undefined?true:g.activated;

		    var activated = g.activated;
		    //var status=config.get_state();
		    //var status=false;
		    var temp = _.template(config.graph_template(activated), {"data": g});

		    // render svg rect
		    var stateR  = me.r.rect(0,0,me.styles.point[0],me.styles.point[1]);

		    stateR.id = g.comp;
		    stateR.attr({x:x,y:y}); // 给rect 位置

		    stateR.attr({fill: '#fff', "fill-opacity": 0, "stroke-width":1, 'stroke-opacity':0,cursor: "move"});


		    $jq("#graph").append(temp);
		    var graphDom = $jq(".graph").eq($jq("#graph").find(".graph").length-1);
		    var width = 160;
//		    var width = graphDom.width();
//		    width = parseInt(width,10)+10+32+5;
//		    width = width < 160?160:width;
		    graphDom.width(width);
		    
		    graphDom.dblclick(function(event){
		    	if (config.get_state() === "true" || config.get_state()===true) {
					return false;
				}
		    	if(1 === event.which){
		    		if ($jq(this).hasClass('graph')) {
		    			var id = $jq(this).attr('data-id');
				    	var frommaps = me.frommaps;
				    	var tomaps = me.tomaps;
				    	var from = relationshipTmp.from;
				    	if (!$jq(this).hasClass('ui-draggable-dragging')) {
				    		if (from === undefined) {
				    			relationshipTmp.from = id;
				    			$jq(this).addClass('selected');
				    		}else if (relationshipTmp.to === undefined) {
				    			if (id !== relationshipTmp.from) {
				    				if ((angular.isUndefined(frommaps[id]) || angular.isUndefined(frommaps[id][from])) 
				    						&& (angular.isUndefined(tomaps[id]) || angular.isUndefined(tomaps[id][from]))) {
				    					relationshipTmp.to = id;
							    		self.renderConnections([relationshipTmp]);
							    		relationshipTmp = {};
							    		$jq("#graph").find('#graph'+from).removeClass('selected');
							    		self.save();
				    				}
				    			}
				    		}
				    	}
		    		}
		    	}
		    });
		    

		    stateR.attr({width:width});

		    me.graphs[g.comp] = (stateR);
		    me.comps[g.comp] = g;

		    me.maps[g.comp] = g.comp;

		    var vertexPos = util.getVertexPos(document.querySelector('div[ng-controller="graphpaperCtrl"]'));
		    var containment = [vertexPos.x1,vertexPos.y1,vertexPos.x2-width,vertexPos.y2-graphDom.height()];
		    
		    if (config.get_state()!=="true" && config.get_state()!==true) {
		    	graphDom.find('.content').find('.css-checkbox').removeAttr('disabled');
		    }else {
		    	graphDom.find('.content').find('.css-checkbox').attr('disabled', 'disabled');
		    }
		    
		    graphDom.find('.content').find('.css-checkbox').click(function(){
		    	g.activated = $jq(this).is(':checked');
		    	self.save();
		    });
		    
		    graphDom.mouseover(function(){
	    		if (config.get_state()!=="true" && config.get_state()!==true) {
			        $jq(this).css('cursor','move');
			        $jq(this).draggable({
				        cursor: "move",
				        containment: containment,
				        start:function(){
				    		self.handlerMove(this);
				        },
				        drag:function(event){
				        	self.handlerMove(this);
				        },
				        stop:function(){
				        	var gclone = g;
				        	gclone.x = parseFloat(this.style.left);
				        	gclone.y = parseFloat(this.style.top);
				        	self.graph.comps[gclone.comp] = gclone;
				        	self.save();
				        }
				    });
	    		}
		    });
		    
		    if (tosave) {
		    	self.save();
		    }
		}
		

		this.cancelChecked = function (){
			var from = relationshipTmp.from;
			relationshipTmp = {};
			$jq("#graph").find('#graph'+from).removeClass('selected');
		}
		
		this.cancelZoom = function () {
			self.graph.r.forEach(function (el) {
				if ( el.type == 'rect'){
					
				}
			});
		}
		
		this.renderConnections = function(lines){
		    angular.forEach(lines, function(value,key){
		         var from = value.from;
		         var to = value.to;
		         var r = self.graph.r;
		         var graphs = self.graph.graphs,
		             maps = self.graph.maps,
		         	 tomaps = self.graph.tomaps,
				     frommaps = self.graph.frommaps;
		         
		         var tomap = tomaps[to] || {};
		         var frommap = frommaps[from] || {};
		         
		         tomap[from] = "";
		         frommap[to] = "";
		         
		         tomaps[to] = tomap;
		         frommaps[from] = frommap;
		         
		         self.graph.tomaps = tomaps;
		         self.graph.frommaps = frommaps;
		         
		         var connections_key = 'form_' + from + '_to_' + to;
		         var connection = r.connection(graphs[maps[from]], graphs[maps[to]],'#000');
		         self.graph.connections_map[connections_key] = connection;
		    });
		}
		
		this.redrawConnections = function(){
		    var me = self.graph,r= me.r,connections = me.connections_map;
		    angular.forEach(connections, function(value,key){
		        r.connection(value);
		    });
		}
		
		this.getData = function(tosave){
			var url = config.comp_load_url;
			
			$http.get(url)
			.then( function(response) {
				var data = response.data;
				self.render(data,tosave);
             });
		}
		
		this.render = function(data,tosave) {
			var compData = self.formatData(data).comp;
			var connectionData = self.formatData(data).connections;
			
			self.batchCreateGraph(compData);
            self.renderConnections(connectionData);
            if (tosave) {
            	self.save();
            }
		}
		
		//获取数据，两种方式选择其中一种获取数据
		this.renderGraph = function(tosave){
			if (tosave === undefined) {
				tosave=true;
			}
			var comp_data_from = config.comp_data_from;
			switch (comp_data_from) {
				case 'url':
					self.getData(tosave);
					break;
				case 'data':
					var data = config.comp_load_data();
					try{
						if (angular.isString(data)) {
							data = angular.fromJson(data);
							self.render(data,tosave);
						}
					}catch(e){
						console.log(e);
					}
					break;
			}
		}
		
		this.batchCreateGraph = function(data) {
			angular.forEach(data, function(comp,key){
				self.createGraph(key, comp);
			});
		}
		
		this.removeGraphOnServer = function (graphId) {
			var url = _.template(config.flow_comp_delete_url, {"data": {'compId':graphId}});
			var result = backendSvr.get(url,{});
			result.then(function(data){
				var data = angular.fromJson(data);
				var key = data.key;
				var value = data.value;
				if (key === 1) {
					$jq.scojs_message(value, $jq.scojs_message.TYPE_ERROR);
					return false;
				}else {
					self.removeGraph(graphId);
					return true;
				}
			});
		}
		
		
		this.removeConnection = function (graphId) {
			var frommapRemoveKey = self.removeMapObjByKey(self.graph.frommaps,graphId);
			var tomapRemoveKey = self.removeMapObjByKey(self.graph.tomaps,graphId);
			var toNewMap = tomapRemoveKey.newMap;
			var fromNewMap = frommapRemoveKey.newMap;
			
			var fromMapRemoved = frommapRemoveKey.removed;
			var toMapRemoved = tomapRemoveKey.removed;
			
			angular.forEach(toNewMap,function(tomap,to){
				toNewMap[to] = self.removeMapObjByKey(tomap,graphId).newMap;
			});
			
			angular.forEach(fromNewMap,function(frommap,from){
				fromNewMap[from] = self.removeMapObjByKey(frommap,graphId).newMap;
			});
			
			self.graph.frommaps = fromNewMap;
			self.graph.tomaps = toNewMap;
			
			
			angular.forEach(fromMapRemoved,function(frommap,from){
				angular.forEach(frommap,function(index,to){
					var connect_key = 'form_' + from + '_to_' + to;
					self.graph.connections_map = self.removeMapObjByKey(self.graph.connections_map,connect_key).newMap;
				});
			});
			
			angular.forEach(toMapRemoved,function(tomap,to){
				angular.forEach(tomap,function(index,from){
					var connect_key = 'form_' + from + '_to_' + to;
					self.graph.connections_map = self.removeMapObjByKey(self.graph.connections_map,connect_key).newMap;
				});
			});
		}
		
		this.removeGraph = function (graphId) {
			self.graph.comps = self.removeMapObjByKey(self.graph.comps,graphId).newMap;
			self.graph.maps = self.removeMapObjByKey(self.graph.maps,graphId).newMap;
			self.removeConnection(graphId);
			
			self.redraw();
			self.save();
		}
		
		this.redraw = function () {
			var me = self.graph,
				r = me.r;
			$jq("#graph").empty();
			r.clear();
			self.formatDataToJson();
			self.render(self.graph.comps);
		}
		
		
		//删除map中的key
		this.removeMapObjByKey = function (map,key) {
			var newMap = {};
			var removedMap = {};
			angular.forEach(map,function(_value,_key){
				if (key !== _key) {
					newMap[_key] = _value;
				}else {
					removedMap[_key] = _value;
				}
			})
			
			return {'newMap':newMap,'removed':removedMap};
		}
		
		this.formatConnects = function (data) {
			var connects = [];
			angular.forEach(data, function(value,key){
				var from = value.from.id;
				var to = value.to.id;
				connects.push({'from':from,'to':to});
			})
			return connects;
		}
		
		this.formatData = function(data) {
			var compData = [];
			var connectionData = [];
			angular.forEach(data, function(comp,key){
				var compId = comp['comp'];
				var depends = comp['depends'];
				
				if (angular.isDefined(depends) && depends !== '') {
					angular.forEach(depends.split(","),function(depId,key){
						var tmp = {};
						tmp['from'] = parseInt(depId);
						tmp['to'] = compId;
						connectionData.push(tmp);
					})
				}
			})
			
			return {'comp':data,'connections':connectionData};
		}
		
		
		this.handlerMove = function(target){
		    var x = parseInt(target.style.left,10);
		    var y = parseInt(target.style.top,10);
		    if(Math.abs(x-self.graph.ox) < 5 &&  Math.abs(y - self.graph.oy) < 5){
		        return;
		    }
		    var att = {x:x,y:y};
		    var id = target.getAttribute("data-id");
		    var rect = self.graph.r.getById(id);
		    rect.attr(att);
		    self.redrawConnections();
		    self.graph.r.safari();
		}
		
		this.getConnectionKey = function (graphId) {
			var frommaps = {};
			var tomaps = {};
			frommaps[graphId] = self.graph.frommaps[graphId];
			tomaps[graphId] = self.graph.tomaps[graphId];
			
			var lineKeys = [];
			
			angular.forEach(frommaps,function(frommap,from){
				angular.forEach(frommap,function(index,to){
					var connect_key = 'form_' + from + '_to_' + to;
					lineKeys.push(connect_key);
				});
			});
			
			angular.forEach(tomaps,function(tomap,to){
				angular.forEach(tomap,function(index,from){
					var connect_key = 'form_' + from + '_to_' + to;
					lineKeys.push(connect_key);
				});
			});
			
			return lineKeys;
		}
		
		this.zoomLinkLine = function (graphId) {
			var lineKeys = self.getConnectionKey(graphId);
			angular.forEach(lineKeys,function(linekey,k){
				var id = self.graph.connections_map[linekey]['line']['id'];
				var line = self.graph.r.getById(id);
				line.attr({'stroke-width':5,stroke: '#ff0000'});
				line.mouseover(function(e){
					e = e || window.event;
					$jq('body').append('<div id="connect_link_delete_tip" style="position:fixed;display:none">点击连线进行删除</div>');
					$jq('#connect_link_delete_tip').css('font-family', 'cursive');
					$jq('#connect_link_delete_tip').css('font-size', '14px');
					$jq('#connect_link_delete_tip').css('background-color', 'greenyellow');
					$jq('#connect_link_delete_tip').css('color', 'red');
					$jq('#connect_link_delete_tip').css('left', e.clientX+10);
					$jq('#connect_link_delete_tip').css('top', e.clientY);
					$jq('#connect_link_delete_tip').show();
				}).mouseout(function(){
					$jq('#connect_link_delete_tip').remove();
				}).mouseup(function(){
					if(!confirm('您确定要删除这组关联吗？')){
						return false;
					}
					var connections_map = self.removeMapObjByKey(self.graph.connections_map,linekey).removed;
					var from = connections_map[linekey].from.id+"";
					var to = connections_map[linekey].to.id+"";
					
					var tomap = self.removeMapObjByKey(self.graph.tomaps[to],from);
					var frommap = self.removeMapObjByKey(self.graph.frommaps[from],to);
					
					self.graph.tomaps[to] = tomap.newMap;
					self.graph.frommaps[from] = frommap.newMap;
					
					self.redraw();
					self.save();
				});
			})
		}
		
		this.formatDataToJson = function() {
			angular.forEach(self.graph.tomaps,function(frommap,to){
				var tos = Object.keys(frommap);
				self.graph.comps[to].depends = tos.join(',');
			});
		}
		
		this.save = function () {
			self.formatDataToJson();
			var json = angular.toJson(_.toArray(self.graph.comps));
			var data = config.flow_save_data(json);
			var url = config.flow_save_url;
			backendSvr.post(url,data);
		}
		
		this.setDisabled = function (disabled) {
			self.graph.disabled = disabled;
		}
    })
})