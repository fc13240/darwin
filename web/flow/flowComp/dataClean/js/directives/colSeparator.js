'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('colSeparator', function() {
    return {
        restrict: 'EA',
        scope: { 
  		  controlLabel: '@',
  		  modelVal: '='
  	    },
        templateUrl: 'dataClean/partials/col-separator.html',
        replace: true,
        controller: function($scope) {
    	}
    };
});