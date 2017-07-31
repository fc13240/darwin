'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('storeSeparator', function() {
    return {
        restrict: 'EA',
        scope: { 
    		  controlLabel: '@',
    		  modelVal: '=',
              other:'@',
              storetype:'=',
              
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
                  '<input id="storeseperator" name="storeseperator" placeholder="请输入自定义分隔符" style="display:none;margin-top:10px;margin-left:-20px"  type="text" class="form-control" ng-model="modelVal" data-rule=""></input>'+  
        		  '</div>'+
        		  '</div>'+
        		  '</div>',
        replace: true,
        controller: function($scope,$element) {

            console.log($scope.other)


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

                $($element).find("#storeseperator").hide();
                if ($scope.modelVal!=='\t'&&$scope.modelVal!==' '&&$scope.modelVal!==',') {
                    $($element).find("#storeseperator").show();
                    $($element).find("#storeseperator").attr("data-rule","required")
                    $($element).find("#storeseperator").removeAttr("novalidate","novalidate");
                    $scope.storetype="others"
                }else{
                    $($element).find("#storeseperator").hide();
                    $(".msg-wrap").remove();
                    $($element).find("#storeseperator").attr("novalidate","novalidate"); 
                    $scope.storetype="defalut"
                };
            })
            

            $scope.change=function(haveModelVal){               
                if (haveModelVal=='others') {
                    $($element).find("#storeseperator").show();
                    $($element).find("#storeseperator").attr("data-rule","required")
                    $($element).find("#storeseperator").removeAttr("novalidate","novalidate");
                    $scope.modelVal='';  
                    $scope.storetype="others"
                }else{
                    $scope.modelVal=haveModelVal;
                    $($element).find("#storeseperator").hide();
                    $(".msg-wrap").remove();
                    $($element).find("#storeseperator").attr("novalidate","novalidate"); 
                    $scope.storetype="defalut"
                    
                }
             }


     	    $scope.$watch('modelVal',function(value){
                if ($scope.modelVal!=='\t'&&$scope.modelVal!==' '&&$scope.modelVal!==',') {
                    $($element).find("#storeseperator").show();
                    $($element).find("#storeseperator").attr("data-rule","required")
                    $($element).find("#storeseperator").removeAttr("novalidate","novalidate");
                    
                }else{
                    $($element).find("#storeseperator").hide();
                    $(".msg-wrap").remove();
                    $($element).find("#storeseperator").attr("novalidate","novalidate"); 
                    
                };

                if (!$($element).find("#storeseperator").is(":hidden")) {
                    $scope.oherVal = value;
                }
            });
    	}
    };
});