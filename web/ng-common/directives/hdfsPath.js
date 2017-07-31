'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('hdfsPath', function() {
    return {
    	restrict: 'EA',
    	scope: { 
    		controlLabel: '@',
    		labelCol: '@',
    		inputCol: '@',
    		modelVal: '=',
    		id: '@',
    		index: '=',
    		init: '='
    	},
    	template: '<div class="form-group">'+
                  '<label for="hdfspath" class="col-sm-{{labelCol}} control-label">{{controlLabel}}：</label>'+
                  '<div class="col-sm-{{inputCol}}">'+
                  '        <input type="text" tooltip={{modelVal}} id="{{id}}_hdfsPath{{index}}" class="form-control" '+
                  'ng-model="modelVal" placeholder="{{controlLabel}}" readonly="true"/>'+
                  '</div>'+
                  '<div class="col-sm-1">'+
                  '    <input ng-init="init" name="select" value="选择" class="btn input-inline" '+
                  'ng-click="showLayer()" type="button"/>'+
                  '</div>'+
                  '</div>',
        replace: true,
        controller: function($scope) {
        	$scope.index = $scope.index || 'index';
	    	$scope.showLayer = function(_id){
	    		layer.open({
	    		    type: 2,
	    		    area: ['600px', '600px'],
	    		    closeBtn: true,
	    		    shadeClose: true,
	    		    skin: 'layui-layer-molv', //墨绿风格
	    		    fix: false, //不固定
	    		    content: '/flow/flowComp/hdfsTree.jsp?compId='+$scope.id+'_hdfsPath'+$scope.index+'&pathValue='+$scope.modelVal
	    		});
	    	};
        }
    };
});