'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('kafkaSource', function() {
    return {
    	restrict: 'EA',
      scope: { 
          modelVal: '=',
      },
    	templateUrl: 'realtimeToHdfs/partials/kafka-source.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig,$http) {


            var browerType1=navigator.userAgent
            
            if (browerType1.indexOf("Firefox")>-1) {
              $scope.browserType="Firefox"
            }else{
              $scope.browserType="other"
            };
        		
            var self = this;

            $scope.inputinfo=cleancompConfig.config.inputinfo


            $scope.mouseenter = function () {  
              $(".propmt").popover({
                     trigger:'hover',
                     placement:'bottom',
                     html: true
                     });
            }
       


        }




    };
});
