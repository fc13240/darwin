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
    		ignoreRowFirst: '=',
    		id: '@',
    		index: '=',
    		init: '=',
        other:'@',
        otherLabel:'@',
        otherButton:'@'
    	},
    	template: '<div class="form-group">'+
                  '<label for="hdfspath" style={{otherLabel}} class="col-sm-{{labelCol}} control-label"><span class="redStar">*&nbsp;</span>{{controlLabel}}：</label>'+
                  '<div class="col-sm-{{inputCol}}">'+
                  '    <input type="text"  name="hdfsPath" tooltip={{modelVal}} id="{{id}}_hdfsPath{{index}}" class="form-control" '+
                  'ng-model="modelVal" style="{{other}}" placeholder="{{controlLabel}}" data-rule="required;"/>'+
                  '</div>'+
                  '<div class="col-sm-1">'+
                  '    <input ng-init="init" style={{otherButton}} name="select" value="选择" class="btn btn-sm input-inline btn-primary" '+
                  'ng-click="showLayer()" type="button"  />'+
                  '</div>'  +
                  '<div class="col-sm-2 checkbox">'+
                  '<label><input type="checkbox" name="ignoreRowFirst" ng-model="ignoreRowFirst" ng-checked="{{ignoreRowFirst}}">忽略行首</label></div>'+
                  '</div>',
        replace: true,
        controller: function($scope) {
          //if($scope.ignoreRowFirst==undefined){
              //$("#hdfs_store input[name='ignoreRowFirst']").parent().parent().hide();
          //}
          $("input[name='ignoreRowFirst']").parent().parent().hide();

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