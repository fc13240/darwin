'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('tableSet', function() {
	var html2='';
	html2+='<div class="form-group">';
	html2+='<div class="col-sm-12">';
	html2+='<textarea ng-model="tmp_mulit_column" rows="" cols="120" class="form-control" placeholder="以英文逗号分隔，可以输入多列，点击自动分隔，系统自动为您生成对应的列。如：col1,col2,col3"></textarea>';
	html2+='</div>';
	html2+='</div>';
	html2+='<div class="form-group">';
	html2+='<div class="col-sm-12" style="text-align: right;">';
	html2+='<input type="button" value="自动生成列" class="btn btn-primary" ng-click="autoCreateColumns()"/>';
	html2+='</div>';
	html2+='</div>';

    return {
    	restrict: 'EA',
    	scope : {
    		colDetail: '=',
    		maxRowCount: '=',
    		cleancompConfig: '='
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
					'			<input name="collName{{$index + 1}}" value="{{col.name}}" ng-model="colDetail[$index].name"  class="form-control radius2" data-rule="required;">'+
					'		</td>'+
					'		<td>'+
					'			<select tdname="type" ng-init="col.type=col.type" class="form-control tdvalue radius2" ng-model="colDetail[$index].type">'+
					'				<option value="{{item.type}}" ng-selected="item.type==col.type" ng-repeat="item in type">{{item.name}}</option>'+
					'			</select>'+
					'		</td>'+
					'		<td>'+
					'			<input value="{{col.dateFormat}}" tdname="dateFormat" class="form-control tdvalue radius2" ng-model="colDetail[$index].dateFormat">'+
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
    			{type:'int', name:'整型'},
    			{type:'double', name:'浮点型'},
    			{type:'date', name:'日期型'},
    			{type:'long', name:'长整型'},
    		 	{type:'timestamp', name:'时间戳'}
   		    ];

   		    var _first = false;

   		    $scope.$watch('maxRowCount',function(data){
   		    	var oldlen = $scope.colDetail.length;
	            if ($scope.maxRowCount>oldlen) {
	              for(var i=oldlen;i<$scope.maxRowCount;i++){
	                var colitem = {};
  	                colitem.name = 'c'+(i+1);
  	                colitem.type = 'string';
  	                colitem.dateFormat = '';
  	                $scope.colDetail.push(colitem);
	              }
	            } else {
	              $scope.colDetail.splice($scope.maxRowCount,oldlen-$scope.maxRowCount);
	            }
   		    });
  

   		   /* $scope.$watch('maxRowCount',function(v1,v2){
   		    	if($scope.cleancompConfig.maxRowCountNotWatch){
   		    		$scope.cleancompConfig.maxRowCountNotWatch = false;
   		    		return;
   		    	}
   		    	
   		    	if ($scope.colDetail.length===0) {
  	              for(var i=0;i<$scope.maxRowCount;i++){
  	                var colitem = {};
  	                colitem.name = 'c'+(i+1);
  	                colitem.type = 'string';
  	                colitem.dateFormat = '';
  	                $scope.colDetail.push(colitem);
  	              }
   		    	}else {
   		    		var oldlen = v2;//$scope.colDetail.length;
   		            if ($scope.maxRowCount>oldlen) {
   		              for(var i=oldlen;i<$scope.maxRowCount;i++){
   		                var colitem = {};
   		                colitem.name = 'c'+(i+1);
   		                colitem.type = 'string';
   		                colitem.dateFormat = '';
   		                $scope.colDetail.push(colitem);
   		              }
   		            } else {
   		              	$scope.colDetail.splice($scope.maxRowCount,oldlen-$scope.maxRowCount);
   		            }
   		    	}
   		    });
*/
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
	  			console.log("$scope=="+angular.toJson($scope));
	  			$scope.maxRowCount = $scope.colDetail.length;
	  		};

	  		$scope.autoCreateColumns = function(){
		    	console.log("autoCreateColumns...");
		    	$scope.cleancompConfig.maxRowCountNotWatch = true;
		    	var str = $scope.tmp_mulit_column;
		    	if($.trim(str)==''){return;}

		    	$scope.colDetail = [];
		    	var arr = str.split(",");
		    	
		    	var _index = 0;
		    	var _array = [];
		    	for(var i = 0; i<arr.length;i++){
		    		if($.trim(arr[i])==''){continue;}
		    		_array.push({name:arr[i],type:'string',dateFormat:''});
		    	}
		    	$scope.colDetail = _array;
		    	$scope.maxRowCount = _array.length;
		    }

        }
    };
});
