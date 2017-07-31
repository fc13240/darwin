'use strict';

/* Directives */


var module = angular.module('comp.directives');
  
module.directive("selectChoice",function(){
    return {
        restrict : "EA",
        scope: {
            selectChoiceLeft: '@',
            selectChoiceRight: '@',
            selectLeftModel: '=',
            selectRightModel: '=',
            selectLeftDataModel: '=',
            selectRightDataModel: '=',
            selectLeftReturnAllData: '=',
            selectRightReturnAllData: '=',
            colDetail: '=',
        },
        template: '<div>'+
                    '<style type="text/css">'+
                    '    #srclb,#dstlb{border:1px solid #aaa;width:200px;height:195px;}'+
                    '   .to{width:30px;}'+
                    '</style>'+
                    '<table width="460" border="0" class="zhcx" cellpadding="0" cellspacing="0">'+
                    '    <tr>'+
                    '       <td>'+
                    '            <select id="srclb" name="{{selectChoiceLeft || \'selectChoiceLeft\'}}" size="10"'+
                    'multiple="multiple" ondblclick="toRight()">'+
                    '               <option value="{{option}}" ng-if="selectRightDataModel.indexOf(option)===-1" '+
                    'ng-repeat="option in selectLeftDataModel">{{option}}</option>'+
                    '           </select>'+
                    '       </td>'+
                    '       <td>&nbsp;&nbsp;</td>'+
                    '           <td>'+
                    '           <button type="button" class="btn btn-xs btn-default" ng-click="toRight()">'+
                    '                <span class="glyphicon glyphicon-chevron-right"></span>'+
                    '           </button></br></br>'+
                    '           <button type="button" class="btn btn-xs btn-default" ng-click="toRight(true)">'+
                    '                <span class="glyphicon glyphicon-forward"></span>'+
                    '           </button> </br></br> '+
                    '           <button type="button" class="btn btn-xs btn-default" ng-click="toLeft()">'+
                    '                <span class="glyphicon glyphicon-chevron-left"></span>'+
                    '           </button></br></br>'+
                    '           <button type="button" class="btn btn-xs btn-default" ng-click="toLeft(true)">'+
                    '                <span class="glyphicon glyphicon-backward"></span>'+
                    '           </button>  '+
                    '           </td>'+
                    '       <td>&nbsp;&nbsp;</td>'+
                    '       <td>'+
                    '           <select id="dstlb" name="{{selectChoiceRight || \'selectChoiceRight\'}}" size="10" '+
                    'multiple="multiple" ondblclick="toLeft()">'+
                    '               <option value="{{option}}" ng-repeat="option in selectRightDataModel">{{option}}</option>'+
                    '           </select>'+
                    '       </td>'+
                    '       <td>&nbsp;&nbsp;</td>'+
                    ' 		<td>'+
                    '		    <button type="button" class="btn btn-xs btn-default" ng-click="move(true)">'+
                    '                <span class="glyphicon glyphicon-arrow-up"></span>'+
                    '           </button></br></br></br>'+
                    '           <button type="button" class="btn btn-xs btn-default" ng-click="move(false)">'+
                    '                <span class="glyphicon glyphicon-arrow-down"></span>'+
                    '           </button>  '+
                    '		</td>'+
                    '   </tr>'+
                    '</table>'+
                    '</div>',
        controller : function($scope,$element){
            $scope.left = $scope.selectChoiceLeft || "selectChoiceLeft";
            $scope.right = $scope.selectChoiceRight || "selectChoiceRight";
            $scope.copy = function (){
                var source = arguments[0] || "";
                var target = arguments[1] || "";
                var isAll = arguments[2] || false;
                if(source && target){
                    if(isAll){//全选
                        for(var i=0,len=source.options.length; i<len; i++){
                            var v = source.options[i].value;
                            var t = source.options[i].text;
                            var opt = new Option(t, v);
                            if(!$scope.isExists(target, opt)){
                                target.options.add(opt);
                                source.options.remove(i);
                                i--;//移除一个，长度重新算
                                len=source.options.length
                            }
                        }
                    } else{
                        for(var i=0,len=source.options.length; i<len; i++){
                            if(source.options[i].selected){
                                var v = source.options[i].value;
                                var t = source.options[i].text;
                                console.log(v+"====="+t);
                                var opt = new Option(t, v);
                                console.log(target);
                                if(!$scope.isExists(target, opt)){
                                    console.log(opt);
                                    target.options.add(opt);
                                    source.options.remove(i);
                                    i--;
                                    len=source.options.length
                                }
                            }
                        }
                    }
                }
            }

            //判断目标中是否存在该元素
            $scope.isExists = function (target, opt){
                if(target && opt){
                    for(var i=0,len=target.options.length; i < len; i++){
                        if(target.options[i].value == opt.value){
                            return true;
                        }
                    }
                }
                return false;
            }
            $scope.toRight = function(isAll){
                var left = document.getElementsByName($scope.left)[0];
                var right = document.getElementsByName($scope.right)[0];
                $scope.copy(left, right, (isAll || false));
                $scope.getLeftOptions();
                $scope.getRightOptions();
                $scope.getSelectVal();
            }
            $scope.toLeft = function (isAll){ 
                
                var left = document.getElementsByName($scope.left)[0];
                var right = document.getElementsByName($scope.right)[0];
                $scope.copy(right, left, (isAll || false));
                $scope.getLeftOptions();
                $scope.getRightOptions();
                $scope.getSelectVal();
            }
            
            $scope.getLeftOptions = function () {
                if ($scope.selectLeftReturnAllData !==undefined) {
                    var left = document.getElementsByName($scope.left)[0];
                    var options = left.options;
                    var dic = {};
                    var arr = [];
                    for (var i=0,len=options.length; i < len; i++){
                        dic[options[i].value] = options[i].text;
                        arr.push(options[i].value);
                    }
                    $scope.safeApply(function(){
                        //$scope.selectLeftReturnAllData = dic;
                        $scope.selectLeftReturnAllData = arr.join(',');
                    });
                }
            }

            $scope.getRightOptions = function () {
                if ($scope.selectRightReturnAllData !== undefined) {
                    var right = document.getElementsByName($scope.right)[0];
                    var options = right.options;
                    var dic = {};
                    var arr = [];
                    for (var i=0,len=options.length; i < len; i++){
                        dic[options[i].value] = options[i].text;
                        arr.push(options[i].value);
                    }
                    $scope.safeApply(function(){
                        //$scope.selectRightReturnAllData = dic;
                        $scope.selectRightReturnAllData = arr.join(',');
                    });
                }
            }
                
            $scope.getSelectVal = function() {
                if ($scope.selectLeftModel !== undefined){
                    $scope.selectLeftModel = document.getElementsByName($scope.left)[0].value;
                }
                
                if ($scope.selectRightModel !== undefined) {
                    $scope.selectRightModel = document.getElementsByName($scope.right)[0].value;
                }
            }

            $scope.safeApply = function(fn) {
                var phase = this.$root.$$phase;
                if(phase == '$apply' || phase == '$digest') {
                    if(fn && (typeof(fn) === 'function')) {
                        fn();
                    }
                } else {
                    this.$apply(fn);
                }
            };
            

            //处理上移和下移操作
            $scope.move=function(){
                if(arguments.length==1){
                    moveUp(arguments[0]);
                 }else if(arguments.length==2){
                    moveRight(arguments[0],arguments[1]);
                }
            }

            function moveUp(direction){
              var currentSel=document.getElementById("dstlb");
              if(currentSel == null) return;
              if(direction){//up   if true
                console.log(currentSel.selectedIndex);
                if (currentSel.selectedIndex > 0) {  
                    for(var i=0;i<currentSel.length;i++){
                        if(currentSel[i].selected){
                            var oOption = currentSel.options[i];
                            var oPrevOption = currentSel.options[i---1];
                            currentSel.insertBefore(oOption, oPrevOption);
                        }
                    }                
                } 
              }else{//down
                for(var i=currentSel.length-1;i>=0;i--){
                    if(currentSel[i].selected){
                        if(i==currentSel.length-1) return;
                        var oOption = currentSel.options[i];
                        var oNextOption = currentSel.options[i+1];
                        currentSel.insertBefore(oNextOption, oOption);                        
                    }
                }
              }
             }
        }
    };
});