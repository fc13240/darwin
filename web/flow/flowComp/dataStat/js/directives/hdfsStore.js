'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('hdfsStore', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataStat/partials/hdfs-store.html',
        replace: true,
        controller: function($scope, $element, $compile, statCompConfig) {
        	console.log(statCompConfig);
        	$scope.statCompConfig=statCompConfig.config;
    		var self = this;
      		$scope.datatypeitems = [
      		                        {type:'text', name:'文本'}
      		                       // {type:'gzip', name:'gzip文件'},
      		                       // {type:'binary', name:'二进制'}
      		                        ];
      		$scope.outrowfilters = [
      		                        {value:'yes', text:'条件输出'},
      		                        {value:'no', text:'全部输出'}
      		                        ];
      		//>/</=/>=/<=/d>/d</d=/d>=/d<=/isnull/notnull/contain/notcontain/
      		$scope.outrowops = [
      		                     {value:'>',text:'大于'},
      		                     {value:'<',text:'小于'},
      		                     {value:'=',text:'等于'},
      		                     {value:'>=',text:'大于且等于'},
      		                     {value:'<=',text:'小于且等于'},
      		                     {value:'d>',text:'数值大于'},
      		                  	 {value:'d<',text:'数值小于'},
      		                  	 {value:'d=',text:'数值等于'},
      		                  	 {value:'d>=',text:'数值大于等于'},
      		                  	 {value:'d<=',text:'数值小于等于'},
      		                  	 {value:'isnull',text:'为空'},
      		                  	 {value:'notnull',text:'不为空'},
      		                  	 {value:'contain',text:'包含'},
      		                  	 {value:'notcontain',text:'不包含'}
      		                    ];
      		$scope.getAllCols = function() {
      			var cols = [];
      			angular.forEach(statCompConfig.config.inputinfo, function(v,i){
      				angular.forEach(v.colDetail, function(col,j){
      					cols.push(v.dataName+"."+col.name);
      				});
      			});
      			angular.forEach(statCompConfig.config.config.vcol, function(v,i){
      				cols.push(v.data+'.'+v.colName);
      			});
      			return cols;
      		};
      		$scope.addStoreFilter = function(index) {
      			var filter = {colname:'',cond:'',val:''};
      			filter.colname = $('#storeinfo-filter-left'+index).val();
      			filter.cond = $('#storeinfo-filter-op'+index).val();
      			filter.val = $('#storeinfo-filter-value'+index).val();
      			$scope.storeinfos[index].rowfilterDetail.push(filter);
      		};
      		$scope.removeStoreFilter = function(index) {
      			$.each($('#storeinfo-filter-selected'+index).find('option:selected'), function(i,v){
      				$scope.storeinfos[index].rowfilterDetail.splice($(v).val(),1);
      			});
      		};
      		$scope.addOutCols = function(index) {
      			$scope.storeinfos[index].outCols.push($('#storeinfo-outcols-'+index).val());
      		};
      		$scope.removeOutCols = function(index) {
      			$.each($('#storeinfo-outcols-selected'+index).find('option:selected'), function(i,v){
      				$scope.storeinfos[index].outCols.splice($(v).val(),1);
      			});
      		};
          $scope.addSortCols = function(index) {
            if ($scope.storeinfos[index].sort=== undefined) {
              $scope.storeinfos[index].sort = {'cols':[],'order':'desc'}
            }
            if ($.inArray($('#storeinfo-sortcols-'+index).val(),$scope.storeinfos[index].sort.cols) ==-1) {
              $scope.storeinfos[index].sort.cols.push($('#storeinfo-sortcols-'+index).val());
            }else {
            	alert('不能添加重复元素');
            }

      		};
      		$scope.removeSortCols = function(colIndex) {
      			$.each($('#storeinfo-sortcols-selected'+colIndex).find('option:selected'), function(i,v){
      				$scope.storeinfos[colIndex].sort.cols.splice($(v).index(),1);
      			});
      		};
          $scope.allOrders = [{text:'升序',value:'asc'},{text:'降序',value:'desc'}];
      		$scope.storeinfoFilter = [];
        }
    };
});
