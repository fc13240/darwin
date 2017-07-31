'use strict';

/* Controllers */


var module = angular.module('comp.controllers');


module.controller('compCtrl', function($scope,cleancompConfig,utils,$location,$http,$element) {
	var self = this;
	$scope.cleancompConfig = cleancompConfig.config;
	

	$scope.saveComp = function(){

		console.log($scope.cleancompConfig.inputinfo.colDellimitExprType+'default不验证')
		if ($scope.cleancompConfig.inputinfo.colDellimitExprType=='others') {
			$("#seperator").attr("data-rule","required")
            $("#seperator").removeAttr("novalidate","novalidate");
		}else{
			$(".msg-wrap").remove();
            $("#seperator").attr("novalidate","novalidate"); 
		};

		if (cleancompConfig.config.storeinfo.esconfig.timeColumnType=="fromColumn") {
        	if (cleancompConfig.config.storeinfo.esconfig.timeColumn!="") {
        		//设置时间字段
				angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
	                 if (cleancompConfig.config.storeinfo.esconfig.timeColumn===value.column_name) {
	                    cleancompConfig.config.inputinfo.columns[key].isTime=true 
	                    cleancompConfig.config.inputinfo.columns[key].dateFormat=value.dateFormat
	                    cleancompConfig.config.storeinfo.esconfig.format=value.dateFormat
	                 }else{
	                    cleancompConfig.config.inputinfo.columns[key].isTime=false
	                 };
		        })
			    angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
	                 angular.forEach(value.resultArr,function(v,k){
	                    if (cleancompConfig.config.storeinfo.esconfig.timeColumn===v.resultName) {
	                        cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=true
	                        cleancompConfig.config.config.filterDetail[key].resultArr[k].dateFormat=v.dateFormat
	                        cleancompConfig.config.storeinfo.esconfig.format=v.dateFormat
	                    }else{
	                        cleancompConfig.config.config.filterDetail[key].resultArr[k].isTime=false
	                    };
	                 })    
                })
        	};	
        };

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
		$scope.escolumns()
		if (cleancompConfig.config.inputinfo.sourceType==='') {
			if (confirm("sourceType为必选项,不可以为空")) {
				return true;
			}return false;
		};
		$scope.timeColumnsValidator=[]
             angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
                if (value.type_name=='datetime') {
                    $scope.timeColumnsValidator.push(value)
             };     
        });

        if ($scope.timeColumnsValidator.length===0) {
        	if ($("#getColume").is(':checked')) {
        		if (confirm("没有时间格式的字段,不可选择来自某个字段,请选择采集时间")) {
				   return true;
			    }return false;
        	};	
        };

       
        if (cleancompConfig.config.storeinfo.esconfig.timeColumnType=="fromColumn") {
        	if (cleancompConfig.config.storeinfo.esconfig.timeColumn=="") {
        		if (confirm("没有选择时间字段,或者这个时间字段不是选定的sourceType的,请重新选择")) {
				   return true;
			    }return false;
        	};	
        };

        if (cleancompConfig.config.storeinfo.esconfig.index==='') {
        	if (confirm("索引为空,不可以保存")) {
				   return true;
			    }return false;
        };
        

        cleancompConfig.config.storeinfo.esconfig.format=$('#format').val()

		cleancompConfig.config.storeinfo.esconfig.sourceType=cleancompConfig.config.inputinfo.sourceType
		cleancompConfig.config.storeinfo.esconfig.columnSize=cleancompConfig.config.storeinfo.escolumns.length
		angular.forEach(cleancompConfig.config.storeinfo.escolumns,function(value,key){
           if (value.isTime==true) {
           	   value.dateFormat=cleancompConfig.config.storeinfo.esconfig.format
           	   /*value.type_name="datetime"*/
           };
        })

		
		var url = '/flowComp?method=saveCommon';
		var params = {};
		params['flowId'] = $scope.flowId;
		params['id'] = $scope.compId;
		params['code'] = 'realtimeReceive';
		params['name'] = cleancompConfig.config.compname;
		params['config'] = angular.toJson(cleancompConfig.config);
		utils.post(url,params);
	}

	$scope.escolumns=function() {
              
  /*    $scope.inputLength=cleancompConfig.config.inputinfo.columns.length
      $scope.filterLength=cleancompConfig.config.config.filterDetail.length*/
      cleancompConfig.config.storeinfo.escolumns = [];
      angular.forEach(cleancompConfig.config.inputinfo.columns,function(value,key){
         cleancompConfig.config.storeinfo.escolumns.push(value);
         $scope.len=cleancompConfig.config.storeinfo.escolumns.length
      })
      angular.forEach(cleancompConfig.config.config.filterDetail,function(value,key){
        angular.forEach(value.resultArr,function(v,k){
           var filterJson={}
           filterJson["column_name"]=v.resultName
           filterJson["dateFormat"]=v.dateFormat
           filterJson["id"]=$scope.len
           filterJson["isTime"]=v.isTime
           filterJson["type_name"]=v.type
           cleancompConfig.config.storeinfo.escolumns.push(filterJson);
           $scope.len=cleancompConfig.config.storeinfo.escolumns.length
        })
      
       })
     
      console.log(cleancompConfig.config.storeinfo.escolumns)

    }

	$scope.init = function() {};

	
	

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

    // $scope.autoCreateColumns = function(){
		  //   	console.log("autoCreateColumns..");
		    	
		  //   }

});
