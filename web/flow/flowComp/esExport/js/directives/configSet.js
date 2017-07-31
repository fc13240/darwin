'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'esExport/partials/config-set.html',
        replace: true,
        controller: function($scope,$element,$compile, esExportConfig) {
           

           $scope.conType=[
                {value:1, text:'所有字段'},
                {value:2, text:'仅包含原始字段'},
                {value:3, text:'除原始字段之外的字段'},
                
           ]

           


        }
    };
});
