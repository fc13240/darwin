'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('sourceSet', function() {
    return {
        require: '^modal',
    	restrict: 'EA',
    	templateUrl: 'realtimeToHdfs/partials/source-set.html',
        replace: true,
        controller: function($scope,$element,$compile,cleancompConfig) {
    		$scope.inputinfos =cleancompConfig.config.inputinfo;

    		$scope.popup_setting = function() {
    			$element.find('#hdfs_source_modal').modal('show');
    		};
    		 		
    		$scope.showFormat = [];

            $scope.selectOneSourse=function(){
                 $("#selectOneSourse").attr("style","border:2px solid #ccc;width:100px;height:25px;position:absolute;margin-left:240px;z-index:9999;background:#F5F8F8; border-radius:6px;");
            }
           
            $scope.addOneSourse = function() {
                $("#selectOneSourse").attr("style","display:none")
                var inputinfoDefault = {
                         dataName:"data1",
                         dataType:"text",
                         encoding:"UTF-8",
                         dataDir:"/user/yimr/abc",
                         dataRange:"dirname_time_rule",
                         dataRangeDetail:{
                             dirnameTimeRule:"dir@{yyyyMMdd}",
                             timeRangeFrom:"1",
                             timeRangeTo:"24",
                             timeUnit:"day",
                             filenameMatch:"abc.*",
                             filenameNotMatch:"abc.kk*",
                             filenameTimeRule:"dir@{yyyyMMdd}"
                         },
                         colDelimitType:"FIELD",
                         colDelimitExpr:"\\t",
                         colCount:"20",
                         multilineCombine:"0",
                         combineRegex:"",
                         colDetail:[
                         ]
                };
                //$scope.inputinfos.push(inputinfoDefault);
            };
            
        }
    };
});
