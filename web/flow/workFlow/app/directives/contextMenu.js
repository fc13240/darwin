define([
	'angular',
	'config',
	'jquery',
	'popupSmallMenu',
	'sco.message'
],function(angular, config){
    'use strict';
    
    var module = angular.module('workflow.directives');
    
    module.directive('contextMenu',function(){
    	return {
            restrict: 'EA',
            template: '<ul id="menu"  class="small-menu"></ul>',
            replace: true,
            controller: function($scope, $element,$window,graph,util,backendSvr) {
	    		$jq('#graph').off('mousedown','.graph').on('mousedown','.graph',(function(event){
	    			var menus = config.get_content_menu();
	    		
	    			if ($jq(this).attr('graph-type')==='realtimeWatch') {
	    					
	    					menus[2].show=false
	    			};
	    			$jq($element).empty();
	    			var urlMap = {};
	    			angular.forEach(menus, function(menu,key){
	    				
	    				if (menu.show) {
	    					var li = $jq('<li class="'+menu.icon+'"><a>'+menu.name+'</a></li>');
	    					$jq($element).append(li);
	    				}
	    				if (menu.url !== undefined) {
	    					urlMap[menu.icon] = menu.url;
	    				}
	    			});
	    			
	    			var target = this;
	    			var graphId = $jq(this).attr('data-id');
	    			var graphType = $jq(this).attr('graph-type');
	    		

	    			if(3 == event.which){
	    				$jq(document).bind('contextmenu',function(e){
	        				return false; 
	        			});

	    				
	    				$jq("#menu").popupSmallMenu({
			    			event : event,
			    			target: target,
			    			pos: util.positionObj(event,document.getElementById('right-container')),
			    			onClickItem  : function(item) {
	    						switch(item){
	    							case 'delete':
//	    								var state = backendSvr.get_flow_state(config.flow_state,{});
//	    								if (state) {
//	    									$jq.scojs_message("当前为部署状态，不能进行此操作！，如果您未看到此状态，请刷新页面", $jq.scojs_message.TYPE_ERROR);
//	    									return false;
//	    								}
	    								if (!confirm('您确定要删除这个组件吗？')) {
				    						return false;
				    					}
				    					graph.removeGraphOnServer(graphId);
				    
	    							break;
	    							case 'edit':
//	    								var state = backendSvr.get_flow_state(config.flow_state,{});
//	    								if (state) {
//	    									$jq.scojs_message("当前为部署状态，不能进行此操作！，如果您未看到此状态，请刷新页面", $jq.scojs_message.TYPE_ERROR);
//	    									return false;
//	    								}
	    								var data = {};
	    								data['compId'] = graphId;
	    								data['type'] = graphType;
	    								var url = _.template(config.comp_config_url, {"data": data});
	    								// $window.open(url);
	    								$window.location.href = url;
	    							break;
	    							case 'view':
	    								var data = {};
	    								data['compId'] = graphId;
	    								data['type'] = graphType;
	    								var url = _.template(config.comp_config_url+'&mode=read', {"data": data});
	    								// $window.open(url);
	    								$window.location.href = url;
	    							break;
	    							case 'deletelink':
//	    								var state = backendSvr.get_flow_state(config.flow_state,{});
//	    								if (state) {
//	    									$jq.scojs_message("当前为部署状态，不能进行此操作！，如果您未看到此状态，请刷新页面", $jq.scojs_message.TYPE_ERROR);
//	    									return false;
//	    								}
	    								graph.zoomLinkLine(graphId);
	    							break;
	    							case 'viewdata':
	    								var data = {};
	    								data['compId'] = graphId;
	    								data['type'] = graphType;
	    								var url = _.template(urlMap['viewdata'], {"data": data});
	    								$window.open(url);
	    							break;
	    						}
			    			}
			    		});
	    	        }
	    		})
    		)}
    	};
    })
})