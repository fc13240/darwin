'use strict';

/* Controllers */


var module = angular.module('comp.controllers');


module.controller('compCtrl', function($scope,cleancompConfig,utils,$location,$http,$element) {
	var self = this;
	$scope.cleancompConfig = cleancompConfig.config;
	

	$scope.saveComp = function(){

	
		//检测表单是否所有字段都验证通过
	$('#rightForm').isValid(function(v){
		    console.log(v ? '表单验证通过' : '表单验证不通过');
		    if(v){
		    	self.save();
		    }else {
		    	alert("有些配置项可能没有添加,请检查");
		    }
		    return;
		});

	};


	this.save = function(){
		    		
		var url = '/flowComp?method=saveCommon';
		var params = {};
		params['flowId'] = $scope.flowId;
		params['id'] = $scope.compId;
		params['code'] = 'realtimeToHdfs';
		params['name'] = cleancompConfig.config.compname;
		params['config'] = angular.toJson(cleancompConfig.config);
		utils.post(url,params);
	}


	
	$scope.init = function() {};

	
    $scope.set_refresh = function (state) {
      $scope.refresh = state;
    };

    // $scope.autoCreateColumns = function(){
		  //   	console.log("autoCreateColumns..");
		    	
		  //   }

});
