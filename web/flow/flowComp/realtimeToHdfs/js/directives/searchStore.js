'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('searchStore', function() {
    return {
    	restrict: 'EA',
      scope: {    
          modelVal: '=',
          esIndex:"@",
      },
    	templateUrl: 'realtimeToHdfs/partials/search-store.html',
        replace: true,
        controller: function($scope, $element,$http, $compile, cleancompConfig) {
    		var self = this;


        $scope.outCycles = [
                            {value:'fiveMinute', text:'每5分钟'},
                            {value:'fifteenMinute', text:'每15分钟'},
                            {value:'thirtyMinute', text:'每半小时'},
                            {value:'oneHour', text:'每一小时'},
                            {value:'oneDay', text:'每一天'}
                        ];
          

        $scope.selectCycle=function(){
            if ($scope.modelVal.outCycle=='fiveMinute') {
                /*$("#subDirectory").val('@{yyyyMMddHH}@{5m}');*/
                $scope.modelVal.subDirectory='@{yyyyMMddHH}@{5m}'
            }else if($scope.modelVal.outCycle=='fifteenMinute'){
               /* $("#subDirectory").val('@{yyyyMMddHH}@{15m}');*/
                $scope.modelVal.subDirectory='@{yyyyMMddHH}@{15m}'
            }else if($scope.modelVal.outCycle=='thirtyMinute'){
                /*$("#subDirectory").val('@{yyyyMMddHH}@{30m}');*/
                $scope.modelVal.subDirectory='@{yyyyMMddHH}@{30m}'
            }else if($scope.modelVal.outCycle=='oneHour'){
               /* $("#subDirectory").val('@{yyyyMMdd}@{1H}');*/
                $scope.modelVal.subDirectory='@{yyyyMMdd}@{1H}'
            }else if($scope.modelVal.outCycle=='oneDay'){
               /* $("#subDirectory").val('@{yyyyMMdd}@{1d}');*/
                $scope.modelVal.subDirectory='@{yyyyMMdd}@{1d}'
            }else{

            };
        }
        


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
