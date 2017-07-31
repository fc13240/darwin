'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('sourceSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'participle/partials/source-set.html',
        replace: true,
        controller: function($scope,$element,statCompConfig) {
    		$scope.inputinfos = statCompConfig.config.inputinfo;

    		$scope.popup_setting = function(index) {
    			$element.find('#hdfs_source_modal_'+index).modal('show');
    		};
    		$scope.showFormat = [];
        }
    };
});
