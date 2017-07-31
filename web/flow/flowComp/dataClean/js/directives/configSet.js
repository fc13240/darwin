'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configSet', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataClean/partials/config-set.html',
        replace: true,
        controller: function($scope,$element,$compile, cleancompConfig) {
    		$scope.popComputeField = function() {
    			$('#d-params-container').empty();
    			$element.find('#compute-field-setting').modal('show');
    		};
    		$scope.relationTypes = [{type:'union',name:'多输入追加'},{type:'join',name:'多输入连接'}];
    		$scope.joinTypes = [
    		                    {type:'inner',name:'内连接'},
    		                    {type:'left',name:'左连接'},
    		                    {type:'right',name:'右连接'},
//    		                    {type:'outer',name:'外连接'}
    		                    ];

    		$scope.removeFunc = function(index) {
                $('#d-params-container').empty();
    			$scope.cleancompConfig.config.vcol.splice(index,1);
            };


            $scope.editFunc = function(index) {
                $scope.index=index;
                $('#d-params-container').empty();
            	$scope.vcolItem = $scope.cleancompConfig.config.vcol[index];
            	var funcName = $scope.vcolItem.funcName;

            	var html = '<div ng-controller="configFieldCtrl" vcolItemIndex="'+index+'">'
            		+'<ng-include src="\'dataClean/partials/func/'+funcName+'.html\'"></ng-include></div>';
                $('#d-params-container').empty();
                angular.element(document.getElementById('d-params-container')).append($compile(angular.element(html))($scope));
            	$element.find('#compute-field-setting').modal('show');
            };


            $("#relationType").change(function(){
                var relationType=$("#relationType option:selected").val();
                console.log(relationType)
            })
           

            $scope.isExist=function(newCol) {
                //获取一共有多少个vcol配置项
                var length=cleancompConfig.config.config.vcol.length;
                //循环获取当前配置下的所有新列名称
                for (var i = 0; i < length; i++) {
                    if ($scope.index===i) {
                        continue;
                    };
                    var newCols=cleancompConfig.config.config.vcol[i].colName;
                    if (newCol===newCols) {
                        return confirm("新列名称已存在");
                    };
                };     
            }


            $scope.saveFunc = function() {
                var saveNewCol=$($element).find("#newCol").val();
                //获取一共有多少个vcol配置项
                    var length=cleancompConfig.config.config.vcol.length;
                    //循环获取当前配置下的所有新列名称
                    //var newCols=cleancompConfig.config.config.vcol[1].colName;
                    for (var i = 0; i < length; i++) {
                        if ($scope.index===i) {
                            continue;
                        };
                        var newCols=cleancompConfig.config.config.vcol[i].colName;
                        //判断是否有重复的内容
                        if (saveNewCol===newCols) {
                            if(confirm("新列名称已存在")){
                                return true;
                            }return false ;
                        };
                    };    


                //检测表单是否所有字段都验证通过
                $('#otherConfig').isValid(function(v){
                    if(v){
                        var configFieldCtrl = document.querySelector('div[ng-controller="configFieldCtrl"]');
                        var vcolItemIndex = $(configFieldCtrl).attr('vcolItemIndex');
                        var vcolItem = angular.element(configFieldCtrl).scope().vcolItem;
                        if (vcolItemIndex !== undefined) {
                            $scope.cleancompConfig.config.vcol[vcolItemIndex] = vcolItem;
                        }else {
                            var length = $scope.cleancompConfig.config.vcol.length;
                            $scope.cleancompConfig.config.vcol[length] = vcolItem;
                        }
                        $element.find('#compute-field-setting').modal('hide');
                    }else {
                        $element.find('#compute-field-setting').modal('show');
                    }
                    return;
                });
            	//$('#d-params-container').empty();
                
                            
                
            	
            };


            $scope.close=function(){
                $('#d-params-container').empty();
            }


        }
    };
});
