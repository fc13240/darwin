'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('sourceSet', function() {
    return {
        require: '^modal',
    	restrict: 'EA',
    	templateUrl: 'dataClean/partials/source-set.html',
        replace: true,
        controller: function($scope,$element,$compile,cleancompConfig) {
//            console.log("cleancompConfig.config.inputinfo="+angular.toJson(cleancompConfig.config.inputinfo));
    		$scope.inputinfos =cleancompConfig.config.inputinfo;
//            console.log("$scope.inputinfos="+angular.toJson($scope.inputinfos));

    		$scope.popup_setting = function(index) {
    			$element.find('#hdfs_source_modal_'+index).modal('show');
    		};
    		
    		$scope.remove_setting = function(index) {
    			if (!confirm('您确定要删除这个设置吗？')) {
					return false;
				}
    			cleancompConfig.config.inputinfo.splice(index,1);
    		};
    		
    		$scope.showFormat = [];

           
            
        }
    };
});
