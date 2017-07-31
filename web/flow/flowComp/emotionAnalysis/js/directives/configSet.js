'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'emotionAnalysis/partials/config-set.html',
        replace: true,
        controller: function($scope,$element,statCompConfig,utils) {
            $scope.getAllCols = function() {
              var cols = [];
              angular.forEach(statCompConfig.config.inputinfo, function(v,i){
                angular.forEach(v.colDetail, function(col,j){
                  cols.push(v.dataName+"."+col.name);
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
