'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('hdfsSource', function() {
    return {
    	restrict: 'EA',
    	templateUrl: 'dataClean/partials/hdfs-source.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig) {
    		var self = this;
      		$scope.datatypeitems = [
      		                        {type:'text', name:'文本'},
      		                        {type:'gzip', name:'gzip文件'},
      		                        {type:'binary', name:'二进制'}
      		                        ];
      		$scope.encodingitems = [
      		                        {type:'UTF-8', name:'UTF-8'},
      		                        {type:'GBK', name:'GBK'},
      		                        {type:'GB2312', name:'GB2312'},
    		                        {type:'ISO8859-1', name:'ISO8859-1'}
      		                        ];
      		$scope.datarange = [
      		                      {type:'dirname_time_rule', name:'目录下目录名符合【时间】规则的文件'},
      		                      {type:'filename_time_rule', name:'目录下文件名符合【时间】规则的文件'},
    		                        {type:'filename_rule', name:'选定目录下所有符合规则的文件'},
      		                      {type:'dirname_rule', name:'选定目录下所有符合规则的目录'},
      		                      {type:'all', name:'选定的文件/目录下所有文件'},
      		                      {type:'period', name:'指定周期'}
      		                    ];
      		$scope.timeunit = [
  		                        {type:'second', name:'秒'},
  		                        {type:'minute', name:'分钟'},
		                          {type:'hour', name:'小时'},
  		                      	{type:'day', name:'天'},
  		                      	{type:'week', name:'周'},
		                          {type:'month', name:'月'},
		                      	  {type:'year', name:'年'}
  		                      ];
      		$scope.coldelimittype = [
       		                           {type:'FIELD', name:'分隔符'},
      		                           {type:'REGX', name:'正则表达式'}
      		                        ];
        }
    };
});
