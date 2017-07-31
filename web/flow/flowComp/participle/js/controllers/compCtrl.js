'use strict';

/* Controllers */


var module = angular.module('comp.controllers');


module.controller('compCtrl', function($scope,statCompConfig,utils,$location,$http,$element) {
	var self = this;
	$scope.statCompConfig = statCompConfig.config;
	$scope.saveComp = function(){
		//特殊处理分隔符
		if ($scope.statCompConfig.inputinfo[0].colDellimitExprType=='others') {
			$("#seperator").attr("data-rule","required")
            $("#seperator").removeAttr("novalidate","novalidate");
		}else{
			$(".msg-wrap").remove();
            $("#seperator").attr("novalidate","novalidate"); 
		};
		
		if ($scope.statCompConfig.storeinfo[0].storeExprType=='others') {
			$("#storeseperator").attr("data-rule","required")
            $("#storeseperator").removeAttr("novalidate","novalidate");
		}else{
			$(".msg-wrap").remove();
            $("#storeseperator").attr("novalidate","novalidate"); 
		};

		$('#rightForm').isValid(function(v){
		    //console.log(v ? '表单验证通过' : '表单验证不通过');
		    if(v){ 
		    	self.save();
		    }else {
		    	alert("有些配置项可能没有添加,请检查");
		    }
		    return;
		});
	};


	this.save = function(){
		//检查config的配置项是否为空
		var aggregates=statCompConfig.config.config.aggregate;
		for (var i = 0; i < aggregates.length; i++) {
			var gruopsNum=i+1;
			if (aggregates[i].field=="") {
                    if (confirm("标签字段 "+gruopsNum+" , 值为空,请添加值")) {
                    	return true;
                    }return false;              
                }
		};


		var url = '/flowComp?method=saveCommon';
		var params = {};
		params['flowId'] = $scope.flowId;
		params['id'] = $scope.compId;
		params['code'] = 'participle';
		params['name'] = statCompConfig.config.compname;
		params['config'] = angular.toJson(statCompConfig.config);

		utils.post(url,params);
	}

	$scope.init = function() {
	};

	$scope.addOneHdfsSource = function() {
		var inputinfoDefault = {
				 dataName:"data"+($scope.inputinfos.length+1),
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
		$scope.inputinfos.push(inputinfoDefault);
	};
	$scope.addOneStore = function() {
		var storeinfoDefault = {
         		dataType:"text",
         		paDataDir:"/user/yimr/abc",
         		colDelimitExpr:"\\t",
         		dataDir:"abc@{yyyyMMdd -86400s}",
         		outrowfilter:"no",
         		outrowfilterType:"and",
         		rowfilterDetail:[
         		],
         		outCols:[
         		]
         	};
		$scope.storeinfos.push(storeinfoDefault);
	};

	$scope.mouseenter = function () {  
	    $(".propmt").popover({
             trigger:'hover',
             placement:'bottom',
             html: true
             });
    }
});
