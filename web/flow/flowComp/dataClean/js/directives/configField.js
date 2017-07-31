'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configField', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataClean/partials/config-field.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig,utils) {
    	  var self = this;
          $scope.funcList = [
            {
              groupname:'字符串类',
              list:[
                {funcName:'strjoin',funcDesc:'字符串拼接',returnType:'string'},
                {funcName:'strreplace',funcDesc:'字符串替换',returnType:'string'},
                {funcName:'strconvert',funcDesc:'大小写转换',returnType:'string'},
                {funcName:'strlength',funcDesc:'求长度',returnType:'int'},
                {funcName:'strmd5',funcDesc:'种子加密',returnType:'string'},
                {funcName:'substring',funcDesc:'求子串',returnType:'string'},
                {funcName:'segmentation',funcDesc:'切分',returnType:'string'},
                {funcName:'strregx',funcDesc:'正则提取',returnType:'string'},
                {funcName:'strconst',funcDesc:'添加常量列',returnType:'string'}
                ]
            },
            {
              groupname:'日期时间',
              list:[
                {funcName:'stamptodate',funcDesc:'时间戳到日期',returnType:'string'},
                {funcName:'datetostamp',funcDesc:'日期到时间戳',returnType:'string'}
                ]
            },
            {
              groupname:'url处理',
              list:[
                {funcName:'urlencode',funcDesc:'url编码',returnType:'string'},
                {funcName:'urldecode',funcDesc:'url解码',returnType:'string'},
                {funcName:'urlparams',funcDesc:'url参数提取',returnType:'string'}
                ]
            },
            {
              groupname:'ip处理',
              list:[
                {funcName:'ip2area',funcDesc:'ip转省市',returnType:'string'}
                ]
            },
            {
              groupname:'四则运算',
              list:[
                {funcName:'arithmetic',funcDesc:'四则运算',returnType:'string'}
                ]
            },
            {
              groupname:'字典',
              list:[
                {funcName:'mapkey',funcDesc:'key到值映射',returnType:'string'}
                ]
            }/*,
            {
              groupname:'其他',
              list:[
                {funcName:'useragent',funcDesc:'UserAgent解析',returnType:'string'}
                ]
            },
            {
              groupname:'高级',
              list:[
                {funcName:'udfexpr',funcDesc:'自定义表达式',returnType:'string'}
                ]
            }*/
          ];

          $scope.setFunc = function(funcName) {
        	  var html = '<div ng-controller="configFieldCtrl" '
          		+'ng-init="vcolItem={};vcolItem.args=[];vcolItem.funcName=\''+funcName+'\';vcolItem.returnType=\'string\'" '
          		+'ng-include="\'dataClean/partials/func/'+funcName+'.html\'"></div>';
            $('#d-params-container').empty();
            angular.element(document.getElementById('d-params-container')).append($compile(angular.element(html))($scope));
          };
          $scope.colname = utils.getcolname();

          //dateclean  config中的配置调用的方法
          $scope.getAllCols = function(data) {
            var saveNewCol=$($element).find("#newCol").val();
      			var cols = [];
      			angular.forEach(cleancompConfig.config.inputinfo, function(v,i){
      				angular.forEach(v.colDetail, function(col,j){
                if (v.dataName === data) {
                   cols.push(v.dataName+"."+col.name);
                }
      					//cols.push(v.dataName+"."+col.name);
      				});
      			});
      			angular.forEach(cleancompConfig.config.config.vcol, function(v,i){
              if (v.data === data) {
                if (v.colName===saveNewCol) {
                   //return false;
                }else{
                   cols.push(v.data+'.'+v.colName);
                };
                
              }
      				//cols.push(v.data + "."+ v.colName);
      			});
      			return cols;
      		};
        }
    };
});
