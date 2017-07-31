'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('userIdxs', function() {
    return {
        restrict: 'EA',
        scope: { 
    		idxs: '=',
            url: '@'
    	},
        templateUrl: 'userInfo/partials/idxs.html',
        replace: true,
        controller: function($scope) {
    		
    	}
    };
});