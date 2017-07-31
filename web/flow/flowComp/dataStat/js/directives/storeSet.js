'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('storeSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataStat/partials/store-set.html',
        replace: true,
        controller: function($scope,$element,statCompConfig) {
	    	$scope.storeinfos = statCompConfig.config.storeinfo;

			$scope.popup_store = function(index) {
				$element.find('#hdfs_store_modal_'+index).modal('show');
			};

			$scope.remove_store = function(index) {
				if (!confirm('您确定要删除这个设置吗？')) {
					return false;
				}
    			statCompConfig.config.storeinfo.splice(index,1);
    		};

    		$scope.showStoreCols = [];
        }
    };
});
