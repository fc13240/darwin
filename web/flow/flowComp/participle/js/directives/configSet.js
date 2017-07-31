'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'participle/partials/config-set.html',
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
                  cols.push(col.name);
                });
              });
              return cols;
            };

            $scope.addAggregate = function() {
              var agg = {field:''}
              $scope.statCompConfig.config.aggregate.push(agg);
            };
            $scope.removeAggregate = function(index) {
              $scope.statCompConfig.config.aggregate.splice(index,1);
            };


        }
    };
});
