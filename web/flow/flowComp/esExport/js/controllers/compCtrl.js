'use strict';

/* Controllers */


var module = angular.module('comp.controllers');


module.controller('compCtrl', function($scope,esExportConfig,utils,$location,$http,$element) {
	var self = this;
	$scope.esExportConfig = esExportConfig.config;
	

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
		$scope.startTime=$scope.esExportConfig.inputinfo[0].start_time.replace("d",'').replace("H",'')
		$scope.endTime=$scope.esExportConfig.inputinfo[0].end_time.replace("d",'').replace("H",'')
		
		if(eval($scope.startTime)>eval($scope.endTime)){
			if (confirm("起始时间必须小于结束时间")) {
				return true;
			}return false;
		}

		var url = '/flowComp?method=saveCommon';
		var params = {};
		params['flowId'] = $scope.flowId;
		params['id'] = $scope.compId;
		params['code'] = 'realtimeReceive';
		params['name'] = esExportConfig.config.compname;
		params['config'] = angular.toJson(esExportConfig.config);
		utils.post(url,params);
	}

	

	$scope.mouseenter = function () {  
	    $(".propmt").popover({
             trigger:'hover',
             placement:'bottom',
             html: true
             });
    }

    $scope.set_refresh = function (state) {
      $scope.refresh = state;
    };

 

});
