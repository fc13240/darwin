'use strict';

/* Controllers */


var module = angular.module('comp.controllers');


module.controller('compCtrl', function($scope,cleancompConfig,utils,$location,$http,$element) {
	var self = this;
	$scope.cleancompConfig = cleancompConfig.config;
	

	$scope.saveComp = function(){

		//检测表单是否所有字段都验证通过
		$('#rightForm').isValid(function(v){
		    if(v){
		    	self.save();
		    }else {
		    	alert("有些配置项可能没有添加,请检查");
		    }
		    return;
		});

	};


	this.save = function(){
	//判断条件组和条件是否不为空，若为空提示，不为空则保存
	var groups=cleancompConfig.config.config.filter.groups;

		for (var i = 0; i < groups.length; i++) {
			var groupVal=groups[i].groupitems;

			for (var j = 0; j < groupVal.length; j++) {
				var gruopsNum=i+1;
				var colNum=j+1;
				if (groupVal[j].cond=="isnull"||groupVal[j].cond=="notnull") {
					
				}else{
					if (groupVal[j].val=="") {
						//confirm("条件组 "+gruopsNum+" / 条件 "+colNum+", 值为空,请添加值")
	                    if (confirm("条件组下 / 条件, 值为空,请添加值")) {
	                    	return true;
	                    }return false;              
	                }
                }
			};
		};

		if(cleancompConfig.config.config.relation.type==='join'){
			if (cleancompConfig.config.inputinfo.length<=1) {
				if (confirm("选择多输入连接时,输入数据个数必须大于1")) {
					return true;
				}return false;
			};
		}
		


		var url = '/flowComp?method=saveCommon';
		var params = {};
		params['flowId'] = $scope.flowId;
		params['id'] = $scope.compId;
		params['code'] = 'dataClean';
		params['name'] = cleancompConfig.config.compname;
		params['config'] = angular.toJson(cleancompConfig.config);
		console.log("params:");
		console.log(params);
		utils.post(url,params);
	}

	$scope.init = function() {};
 
	$scope.addOneHdfsSource = function() {
		var dataLength = $scope.inputinfos.length;
		if (dataLength>0) {
			angular.forEach($scope.inputinfos,function(v,i){
				var dataindex = parseInt(v.dataName.replace('data',''));
				if (dataindex>dataLength) {
					dataLength = dataindex;
				}
			});
		}
		var inputinfoDefault = {
				 dataName:"data"+(dataLength+1),
				 dataType:"text",
				 encoding:"UTF-8",
				 dataDir:"",
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
		console.log("addOneStore..");
		var dataLength = $scope.storeinfos.length;
		if (dataLength>0) {
			angular.forEach($scope.storeinfos,function(v,i){
				var dataindex = parseInt(v.dataName.replace('data',''));
				if (dataindex>dataLength) {
					dataLength = dataindex;
				}
			});
		}
		var storeinfoDefault = {
			    dataName:"data"+(dataLength+1),
         		dataType:"text",
         		paDataDir:"/user/yimr/abc",
         		colDelimitExpr:"\\t",
         		dataDir:"once",
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

    $scope.set_refresh = function (state) {
    	console.log("set_refresh..");
      $scope.refresh = state;
    };
});
