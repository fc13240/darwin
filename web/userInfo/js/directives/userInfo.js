'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('userInfo', function() {
    return {
        restrict: 'EA',
        scope: { 
    		userinfo: '=',
            url: '@'
    	},
        templateUrl: 'userInfo/partials/user-info.html',
        replace: true,
        controller: function($scope,$element,utils) {
            //$element.html('<center><img src="userInfo/img/loading.gif"></center>');
            var dd = utils.get($scope.url);
            console.log(dd);
    	}
    };
});