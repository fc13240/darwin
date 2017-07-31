'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('progressbar', function() {
    return {
        restrict: 'EA',
        scope: { 
    		spaces: '='
    	},
        templateUrl: 'userInfo/partials/progressbar.html',
        replace: true,
        controller: function($scope) {
    		
    	}
    };
});