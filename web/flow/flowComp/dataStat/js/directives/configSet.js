'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataStat/partials/config-set.html',
        replace: true,
        controller: function($scope,$element,statCompConfig,utils) {
    		$scope.computeTypes = [
    		                       {type:'COUNT',name:'计数'},
    		                       {type:'SUM',name:'求和'},
    		                       {type:'AVG',name:'求平均'},
    		                       {type:'MAX',name:'求最大值'},
    		                       {type:'MIN',name:'求最小值'},
    		                       {type:'UNIQ',name:'去重计数'},
    		                       {type:'TOPN',name:'求TOPN'}
    		                       ];
            $scope.getAllCols = function() {
              var cols = [];
              angular.forEach(statCompConfig.config.inputinfo, function(v,i){
                angular.forEach(v.colDetail, function(col,j){
                  //cols.push(col.name);
                   cols.push(v.dataName+"."+col.name);
                });
              });
              return cols;
            };
            $scope.addGroupBy = function() {
              var groupby = $('#groupby-field').val();
              if (groupby !== '选择分组字段') {
            	  var in_array = $.inArray(groupby,$scope.statCompConfig.config.groupby);
            	  
            	  if (in_array !== -1){
            		  alert('分组字段不能重复！');
            		  return false;
            	  }
            	  $scope.statCompConfig.config.groupby.push(groupby);
              }
            };
            $scope.removeGroupBy = function() {
              $.each($('#groupby-field-selected').find('option:selected'), function(i,v){
                $scope.statCompConfig.config.groupby.splice($(v).val(),1);
              });
            };
            $scope.addAggregate = function() {
              var agg = {method:'count',field:'',resultcol:'result'+($scope.statCompConfig.config.aggregate.length+1)}
              $scope.statCompConfig.config.aggregate.push(agg);
            };
            $scope.removeAggregate = function(index) {
              $scope.statCompConfig.config.aggregate.splice(index,1);
            };

            

            $scope.change=function(obj,index){
              var aa=statCompConfig.config.config.aggregate;
              var j=0;
              for (var i = 0; i < aa.length; i++) {
                var aaa=aa[i];
                if (aaa.method=='UNIQ') {
                    j++;
                    if (j>1) {
                        alert("只可添加一个去重计数"); 
                        $scope.statCompConfig.config.aggregate.splice(index,1);
                                
                    };
                };
              };             
            }
        }
    };
});
