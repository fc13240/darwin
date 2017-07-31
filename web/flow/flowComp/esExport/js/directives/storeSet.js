'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('storeSet', function() {
    return {
    	restrict: 'EA',
    	scope: {    
          esIndex: '@',
      },
    	templateUrl: 'esExport/partials/store-set.html',
        replace: true,
        controller: function($scope,$element,esExportConfig) {

            $scope.storeinfo=esExportConfig.config.storeinfo
        
        }

           
    };
});
