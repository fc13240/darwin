'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('userHelp', function() {
    return {
        restrict: 'EA',
        templateUrl: 'userInfo/partials/user-help.html',
        replace: true,
        controller: function($scope,$element) {
    	}
    };
});