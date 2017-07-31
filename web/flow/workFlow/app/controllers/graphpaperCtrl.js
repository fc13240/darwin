define([
	'angular',
	'config',
	'raphael',
	'sco.message'
]
,function(angular,config){
	'use strict';

	var module = angular.module('workflow.controllers');

	module.controller('graphpaperCtrl',function($scope,$rootScope,$timeout,$http,graph,util){
		var self = this;

		var innerHtml = '<div id="content"><div id="canvas"></div><div id="graph"></div></div>';
		var dom = document.querySelector('div[ng-controller="graphpaperCtrl"]');

		this.showGraph = function(w,h){
		    var me = graph.graph;

	        me.w = w;// - 280;
	        me.h = h - 30;
	        me.r = Raphael("canvas",me.w, me.h);
	        me.graphs = me.r.set();
	        var w = me.w,
	            h=me.h;

	        var cellW = 240;
	        var cellH = 120;
	        var num = Math.floor(w / cellW);
	        var conf = {'cellW':cellW,'cellH':cellH,'num':num};
	        me.config = conf;

	        document.getElementById('canvas').onclick = function() {
	        	graph.cancelChecked();
	        	graph.cancelZoom();
	        };

	        document.onmousemove = function() {
	        	if (graph.last_state !== config.get_state()) {
	        		graph.redraw();
	        		graph.last_state = config.get_state();
	    		}
	        };

	        graph.graph = me;
	        $scope.graph = me;
		}

		this.updateTiming = function(){
			graph.redraw();
			$timeout(function(){
			  self.updateTiming();
			},parseInt(config.refrash_time));
		};

		$scope.init = function() {
			dom.innerHTML = innerHtml;
			//var w = util.getViewWidth();
	        var h = util.getHeight();
			var width = document.getElementById('canvas').clientWidth;
			//width = w>width?w:width;
			self.showGraph(width,h);
			graph.renderGraph(false);
			//self.updateTiming();
		};



		//选择所有的checkbox
		$scope.check=function(flowid){
			var allCheck=$(".css-checkbox");
			if (flowid=='' || flowid<0) {
				$jq.scojs_message("请先保存流程", $jq.scojs_message.TYPE_ERROR);	
				return false;
			}
			if (config.get_state()==="true") {
				$jq.scojs_message("请取消部署再进行勾选", $jq.scojs_message.TYPE_ERROR);
				return false;
			}
			for (var i = 0; i<allCheck.length; i++) {
				allCheck[i].checked = "checked";
			};

			angular.forEach(graph.graph.comps,function(comp,key){
				comp.activated = true;
				graph.graph.comps[key] = comp;
			})
			graph.save();
		}

		//取消全部的checkbox
		$scope.unCheck=function(flowid){
			var allCheck=$(".css-checkbox");
			if (flowid=='' || flowid<0) {
				$jq.scojs_message("请先保存流程", $jq.scojs_message.TYPE_ERROR);	
				return false;
			}
			if (config.get_state()==="true") {
				$jq.scojs_message("请取消部署再进行勾选", $jq.scojs_message.TYPE_ERROR);
				return false;
			}
			for (var i = 0; i <allCheck.length; i++) {
				allCheck[i].checked =false;	
			};
			angular.forEach(graph.graph.comps,function(comp,key){
				comp.activated = false;
				graph.graph.comps[key] = comp;
			})
			graph.save();
		}

		$scope.update = function(data){
			if (config.get_state()==="true") {
				$jq.scojs_message("请取消部署再添加组件", $jq.scojs_message.TYPE_ERROR);
				return false;
			}
			if(dom.children[0] !== undefined && dom.children[0].id === 'content'){
				var compLength = Object.keys(graph.graph.comps).length;
				if (compLength>1 && data.x==20 && data.y==200) {
					data.x = 20 + compLength*15;
					data.y = 200 + compLength*25;
				}
				graph.createGraph(101,data,true);
				$scope.$apply();
			}
		}

		$scope.save = function(){
			if (config.get_state()==="true") {
				$jq.scojs_message("当前状态不可保存", $jq.scojs_message.TYPE_ERROR);

				return false;
			}
			graph.save();
		}

		$scope.init();

    })
})
