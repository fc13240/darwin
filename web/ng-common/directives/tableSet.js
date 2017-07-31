'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('tableSet', function() {
    return {
    	restrict: 'EA',
    	scope : {
    		colDetail: '=',
    		maxRowCount: '='
    	},
    	template: '<div>'+
					'<div class="text-right mtb10">'+
					/*'	<button class="btn btn-xs btn-primary new-hdfs-source-cols" type="button" id="newRow{{index}}" ng-click="addFormatRow()">'+
					'		<span class="glyphicon glyphicon-plus"></span>添加一行源字段'+
					'	</button>'+*/
					'</div>'+
					'<table class="table table-bordered table-hover" id="ruleTable{{index}}" style="margin-bottom: 100px;">'+
					'	<tr>'+
					'		<td width="60">列序号</td>'+
					'		<td>列名</td>'+
					'		<td>类型</td>'+
					'		<td>数据格式</td>'+
					'		<td>操作</td>'+
					'	</tr>'+
					'	<tr class="tr" ng-repeat="col in colDetail track by $index">'+
					'		<td>{{$index+1}}</td>'+
					'		<td>'+
					'			<input value="{{col.name}}" ng-model="colDetail[$index].name"  class="form-control">'+
					'		</td>'+
					'		<td>'+
					'			<select tdname="type" ng-init="col.type=col.type" class="form-control tdvalue" ng-model="colDetail[$index].type">'+
					'				<option value="{{item.type}}" ng-selected="item.type==col.type" ng-repeat="item in type">{{item.name}}</option>'+
					'			</select>'+
					'		</td>'+
					'		<td>'+
					'			<input value="{{col.dateFormat}}" tdname="dateFormat" class="form-control tdvalue" ng-model="colDetail[$index].dateFormat">'+
					'		</td>'+
					'		<td style="width:\'280px\'">'+
					'			<input type="button" id="upInsert" ng-click="upInsertFunc($index)" title="上插" class="btn-insertabove">'+
					'			<input type="button" id="downInsert" ng-click="downInsertFunc($index)" title="下插" class="btn-insertbelow">'+
					'			<input type="button" id="upShift" ng-click="upShiftFunc($index)" title="上移" class="btn-moveup">'+
					'			<input type="button" id="downShift" ng-click="downShiftFunc($index)" title="下移" class="btn-movedown">'+
					'			<input type="button" id="del" ng-click="delFunc($index)" title="删除" class="btn-del">'+
					'		</td>'+
					'	</tr>'+
					'</table>'+
					'</div>',
        replace: true,
        controller: function($scope) {
    		var self = this;
    		var colDetail = $scope.colDetail;

    		$scope.type = [
    			{type:'string', name:'字符串'},
    			{type:'int', name:'整型'},
    			{type:'double', name:'浮点型'},
    			{type:'date', name:'日期型'},
    			{type:'long', name:'长整型'},
    		 	{type:'timestamp', name:'时间戳'}
   		    ];

   		    $scope.$watch('maxRowCount',function(data){
   		    	var oldlen = colDetail.length;
	            if ($scope.maxRowCount>oldlen) {
	              for(var i=oldlen;i<$scope.maxRowCount;i++){
	                var colitem = {};
	                colitem.name = 'c'+(i+1);
	                colitem.type = 'string';
	                colitem.dateFormat = '';
	                colDetail.push(colitem);
	              }
	            } else {
	              colDetail.splice($scope.maxRowCount,oldlen-$scope.maxRowCount);
	            }
   		    });

	    	/**
	  		* target插入的目标元素
	  		* insertBefore:true插入到目标元素前面
	  		*/
	  		$scope.addFormatRow = function(){
	  			var size = colDetail.length;
	  			if (size == $scope.maxRowCount) {
            alert('已经有'+size+'列，无法继续添加');
	  				return false;
	  			}
	  			colDetail[size] = {name:'c'+(size+1),type:'string',dateFormat:''};
	  		};

	  		//上插
	  		$scope.upInsertFunc = function(index){
	  			var size = colDetail.length;
	  			if (size == $scope.maxRowCount) {
	  				return false;
	  			}
	  			var row = {name:'c'+(size+1),type:'string',dateFormat:''};
	  			colDetail.splice(index-1,0,row);
	  		};
	  		//下插
	  		$scope.downInsertFunc = function(index){
	  			var size = colDetail.length;
	  			if (size == $scope.maxRowCount) {
	  				return false;
	  			}
	  			var row = {name:'c'+(size+1),type:'string',dateFormat:''};
	  			colDetail.splice(index+1,0,row);
	  		};
	  		//上移
	  		$scope.upShiftFunc = function(index){
	  			if (index > 0) {
	  				var beforeRow = colDetail[index-1];
		  			var currentRow = colDetail[index];
		  			colDetail.splice(index-1,2,currentRow,beforeRow);
	  			}
	  		};

	  		//下移
	  		$scope.downShiftFunc = function(index){
	  			if (index < colDetail.length-1) {
	  				var behindRow = colDetail[index+1];
		  			var currentRow = colDetail[index];
		  			colDetail.splice(index,2,behindRow,currentRow);
	  			}
	  		};
	  		$scope.delFunc = function(index){
	  			colDetail.splice(index,1);
	  		};

	  		
    
        }
    };
});
