'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('userTables', function() {
    return {
        restrict: 'EA',
        scope: { 
    		tables: '=',
            url: '@'
    	},
        templateUrl: 'userInfo/partials/tables.html',
        replace: true,
        controller: function($scope) {
    		
    	}
    };
});