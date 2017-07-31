'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('userFavs', function() {
    return {
        restrict: 'EA',
        scope: { 
    		favs: '=',
            url: '@'
    	},
        templateUrl: 'userInfo/partials/favs.html',
        replace: true,
        controller: function($scope) {
    		
    	}
    };
});