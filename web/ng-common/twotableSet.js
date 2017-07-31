'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('twotableSet', function() {
	var html2='';

    return {
    	restrict: 'EA',
    	scope : {
    		colDetail: '=',
    		maxRowCount: '='
    	},
    	template: 
    			'<div>'+html2+
					'<div class="text-right mtb10">'+
					
					'</div>'+
					'<table class="table table-bordered table-hover" id="ruleTable{{index}}" style="margin-bottom: 100px;">'+
					'	<tr>'+
					'		<td width="60">列序号</td>'+
					'		<td><span class="redStar">*&nbsp;</span>列名</td>'+
					'		<td>类型</td>'+
					'		<td>数据格式</td>'+
					'		<td>操作'+
					'	<a class="new-hdfs-source-cols" type="button" id="newRow{{index}}" ng-click="addFormatRow()">'+
					'		<img src="/resources/site/img/addnewRow.png">'+
					'	</a>'+
					'       </td>'+
					'	</tr>'+
					'	<tr class="tr" ng-repeat="col in colDetail track by $index">'+
					'		<td>{{$index+1}}</td>'+
					'		<td>'+
					'			<input name="collName{{$index + 1}}" value="{{col.column_name}}" ng-model="colDetail[$index].column_name"  class="form-control" data-rule="required;">'+
					'		</td>'+
					'		<td>'+
					'			<select id="type{{$index}}" ng-change="changeType({{$index}})" tdname="type" ng-init="col.type_name=col.type_name" class="form-control tdvalue " ng-model="colDetail[$index].type_name">'+
					'				<option value="{{item.type}}" ng-selected="item.type==col.type_name" ng-repeat="item in type">{{item.name}}</option>'+
					'			</select>'+
					'		</td>'+
					'		<td>'+
					'			<input name="formatT{{$index}}" id="formatT{{$index}}" value="{{col.dateFormat}}" tdname="dateFormat" class="form-control tdvalue radius2" ng-model="colDetail[$index].dateFormat" data-rule="">'+
					'		</td>'+
					'		<td style="width:\'280px\'">'+
			//		'			<input type="button" id="upInsert" ng-click="upInsertFunc($index)" title="上插" class="btn-insertabove">'+
			//		'			<input type="button" id="downInsert" ng-click="downInsertFunc($index)" title="下插" class="btn-insertbelow">'+
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
    		//var colDetail = $scope.colDetail;

    		$scope.type = [
    			{type:'string', name:'字符串'},
    			{type:'text', name:'字符串(不分词)'},
    			{type:'int', name:'整型'},
    			{type:'double', name:'浮点型'},
    			{type:'datetime', name:'日期型'},
    			{type:'long', name:'长整型'},
    		 	{type:'timestamp', name:'时间戳'}
   		    ];

   		    $scope.changeType=function(index){
   		    	console.log(index)
   		    	$scope.typeName=$("#type"+index+" option:selected").val();
   		    	console.log($scope.typeName)
   		    	if ($scope.typeName=='datetime') {
   		    		$("#formatT"+index).attr("data-rule","required")
   		    		$("#formatT"+index).removeAttr("novalidate","novalidate");
   		    	}else{
					$(".msg-wrap").remove();
                    $("#formatT"+index).attr("novalidate","novalidate");    
   		    	};
   		    	
   		    }

   		    $scope.$watch('maxRowCount',function(data){
   		    	var oldlen = $scope.colDetail.length;
	            if ($scope.maxRowCount>oldlen) {
	              for(var i=oldlen;i<$scope.maxRowCount;i++){
	                var colitem = {};
	                colitem.column_name = 'c'+(i+1);
	                colitem.id=i;
	                colitem.type_name = 'string';
	                colitem.dateFormat = '';
	                colitem.isTime = false;
	                $scope.colDetail.push(colitem);
	              }
	            } else {
	              $scope.colDetail.splice($scope.maxRowCount,oldlen-$scope.maxRowCount);
	            }
   		    });

	    	/**
	  		* target插入的目标元素
	  		* insertBefore:true插入到目标元素前面
	  		*/
	  		$scope.addFormatRow = function(){
	  			var size = $scope.colDetail.length;
	  			if (size == $scope.maxRowCount) {
            		alert('已经有'+size+'列，无法继续添加');
	  				return false;
	  			}
	  			$scope.colDetail[size] = {name:'c'+(size+1),type:'string',dateFormat:''};
	  		};

	  		//上插
	  		$scope.upInsertFunc = function(index){
	  			var size = $scope.colDetail.length;
	  			if (size == $scope.maxRowCount) {
	  				return false;
	  			}
	  			var row = {name:'c'+(size+1),type:'string',dateFormat:''};
	  			$scope.colDetail.splice(index-1,0,row);
	  		};
	  		//下插
	  		$scope.downInsertFunc = function(index){
	  			var size = $scope.colDetail.length;
	  			if (size == $scope.maxRowCount) {
	  				return false;
	  			}
	  			var row = {name:'c'+(size+1),type:'string',dateFormat:''};
	  			$scope.colDetail.splice(index+1,0,row);
	  		};
	  		//上移
	  		$scope.upShiftFunc = function(index){
	  			console.log(index)
	  			if (index > 0) {
	  				var beforeRow = $scope.colDetail[index-1];
		  			var currentRow = $scope.colDetail[index];
		  			$scope.colDetail.splice(index-1,2,currentRow,beforeRow);
	  			}
	  		};

	  		//下移
	  		$scope.downShiftFunc = function(index){
	  			if (index < $scope.colDetail.length-1) {
	  				var behindRow = $scope.colDetail[index+1];
		  			var currentRow = $scope.colDetail[index];
		  			$scope.colDetail.splice(index,2,behindRow,currentRow);
	  			}

	  		};
	  		$scope.delFunc = function(index){
	  			$scope.colDetail.splice(index,1);
	  		};

	  		$scope.autoCreateColumns = function(){
		    	
		    	var str = $scope.tmp_mulit_column;
		    	if($.trim(str)==''){return;}

		    	$scope.colDetail = [];
		    	var arr = str.split(",");
		    	$scope.maxRowCount = arr.length;
		    	var _index = 0;
		    	for(var i = 0; i<arr.length;i++){
		    		if($.trim(arr[i])==''){continue;}
		    		$scope.colDetail[_index++] = {name:arr[i],type:'string',dateFormat:''};
		    	}
		    }

        }
    };
});
