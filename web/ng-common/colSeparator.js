'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive('colSeparator', function() {
    return {
        restrict: 'EA',
        scope: { 
    		  controlLabel: '@',
    		  modelVal: '=',
              exprType:'=',
              other:'@',
              
  	    },
        template: '<div>'+
        		  '<div class="form-group">'+
        		  '<label class="col-sm-3 control-label">{{controlLabel}}</label>'+
        		  '<div class="col-sm-6">'+
        		  '<select id="totalselect"  class="form-control" ng-change="change(haveModelVal)" ng-model="haveModelVal" ng-trim="false" style="{{other}}"  >'+
                  '<option value="\t" ng-selected="modelVal===\'\t\'">tab键</option>'+
                  '<option value=" "  ng-selected="modelVal===\' \'" >空格</option>'+
                  '<option value="," ng-selected="modelVal===\',\'" >逗号</option>'+
                  '<option value="others" ng-init="oherVal=modelVal" dvalue="{{oherVal}}" ng-selected="modelVal!==\'\t\'&&modelVal!==\' \'&&modelVal!==\',\'">自定义分隔符</option>'+
                  '</select>'+
                  '<input id="seperator" name="seperator" placeholder="请输入自定义分隔符" style="display:none;margin-top:10px;margin-left:-20px"  type="text" class="form-control" ng-model="modelVal" data-rule=""></input>'+  
        		  '</div>'+
        		  '</div>'+
        		  '</div>',
        replace: true,
        controller: function($scope,$element) {

           

            $(function(){

                $($element).find("#seperator").hide();
                if ($scope.modelVal!=='\t'&&$scope.modelVal!==' '&&$scope.modelVal!==',') {
                    $($element).find("#seperator").show();
                    $($element).find("#seperator").attr("data-rule","required")
                    $($element).find("#seperator").removeAttr("novalidate","novalidate");
                    $scope.exprType="others"
                   
                }else{
                    $($element).find("#seperator").hide();
                    $(".msg-wrap").remove();
                    $($element).find("#seperator").attr("novalidate","novalidate"); 
                    $scope.exprType="defalut"
                    
                };
            })
            

            $scope.change=function(haveModelVal){               
                if (haveModelVal=='others') {
                    $($element).find("#seperator").show();
                    $($element).find("#seperator").attr("data-rule","required")
                    $($element).find("#seperator").removeAttr("novalidate","novalidate");
                    $scope.modelVal='';  
                    $scope.exprType="others"
                    
                }else{
                    $scope.modelVal=haveModelVal;
                    $($element).find("#seperator").hide();
                    $(".msg-wrap").remove();
                    $($element).find("#seperator").attr("novalidate","novalidate"); 
                    $scope.exprType="defalut"
                  
                    
                }
             }


     	    $scope.$watch('modelVal',function(value){
                if ($scope.modelVal!=='\t'&&$scope.modelVal!==' '&&$scope.modelVal!==',') {
                    $($element).find("#seperator").show();
                    $($element).find("#seperator").attr("data-rule","required")
                    $($element).find("#seperator").removeAttr("novalidate","novalidate");
                    
                }else{
                    $($element).find("#seperator").hide();
                    $(".msg-wrap").remove();
                    $($element).find("#seperator").attr("novalidate","novalidate"); 
                    
                };

                if (!$($element).find("#seperator").is(":hidden")) {
                    $scope.oherVal = value;
                }
            });
    	}
    };
});