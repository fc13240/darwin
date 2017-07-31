'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('datacleanSeparator', function() {
    return {
        restrict: 'EA',
        scope: { 
    		  controlLabel: '@',
    		  modelVal: '=',
              exprType:'=',
              index:'@',
              other:'@'

  	    },
        template: '<div>'+
        		  '<div class="form-group">'+
        		  '<label class="col-sm-3 control-label">{{controlLabel}}</label>'+
        		  '<div class="col-sm-6">'+
        		  '<select id="totalselect"  class="form-control" ng-change="change(haveModelVal)" ng-model="haveModelVal" ng-trim="false" style="margin-left:-20px"  >'+
                  '<option value="\t" ng-selected="modelVal===\'\t\'">tab键</option>'+
                  '<option value=" "  ng-selected="modelVal===\' \'" >空格</option>'+
                  '<option value="," ng-selected="modelVal===\',\'" >逗号</option>'+
                  '<option value="others" ng-init="oherVal=modelVal" dvalue="{{oherVal}}" ng-selected="modelVal!==\'\t\'&&modelVal!==\' \'&&modelVal!==\',\'">自定义分隔符</option>'+
                  '</select>'+
                  '<input id="seperator" name="seperator" ng-if="modelVal!==\'\t\'&&modelVal!==\' \'&&modelVal!==\',\'" placeholder="请输入自定义分隔符" style="margin-top:10px;margin-left:-20px"  type="text" class="form-control" ng-model="modelVal"></input>'+  
        		  '</div>'+
        		  '</div>'+
        		  '</div>',
        replace: true,
        controller: function($scope,$element) {


            var browerType1=navigator.userAgent
        
            if (browerType1.indexOf("Firefox")>-1) {
              $scope.browserType="Firefox"
            }else if(!!window.ActiveXObject || "ActiveXObject" in window){
              $scope.browserType="IE"
            }else{
              $scope.browserType="other"
            };

            if ($scope.browserType=="IE") {
                $("#totalselect").attr("style","margin-left:-20px")

            };

            
            $(function(){

                $($element).find("#seperator").hide();
                if ($scope.modelVal!=='\t'&&$scope.modelVal!==' '&&$scope.modelVal!==',') {
                    $($element).find("#seperator").show();
                   
                }else{
                    $($element).find("#seperator").hide();
                   
                };
            })
            

            $scope.change=function(haveModelVal){               
                if (haveModelVal=='others') {
                    $($element).find("#seperator").show();
                 
                    $scope.modelVal='';  
            
                }else{
                    $scope.modelVal=haveModelVal;
                    $($element).find("#seperator").hide();
                  
                }
             }


     	    $scope.$watch('modelVal',function(value){  
                if ($scope.modelVal!=='\t'&&$scope.modelVal!==' '&&$scope.modelVal!==',') {
                    $($element).find("#seperator").show();
                    
                }else{
                    $($element).find("#seperator").hide();
                    
                };
    
                if (!$($element).find("#seperator").is(":hidden")) {
                  
                  $scope.oherVal = value;
                }
            });
    	}
    };
});