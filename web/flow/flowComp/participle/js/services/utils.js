'use strict';

/* Services */

var module = angular.module('comp.services');

module.service('utils',function(statCompConfig,$http,$q){
	var self = this;

	this.removeMapObjByKey = function (map,key) {
		var newMap = {};
		var removedMap = {};
		angular.forEach(map,function(_value,_key){
			if (key !== _key) {
				newMap[_key] = _value;
			}else {
				removedMap[_key] = _value;
			}
		})

		return {'newMap':newMap,'removed':removedMap};
	}

	this.getcolname = function(){
		var colname = [];
		angular.forEach(statCompConfig.config.inputinfo,function(v,k){
			var dataName = v.dataName;
			angular.forEach(v.colDetail,function(_v,_k){
				colname.push({'text':dataName+"."+_v.name,'value':dataName+"."+_v.name});
			});
		});
		angular.forEach(statCompConfig.config.config.vcol, function(v,i){
			colname.push({'text':v.data+'.'+v.colName,'value':v.data+'.'+v.colName});
		});
		return colname;
	};

	this.getColMap = function () {
		var map = {};
		angular.forEach(statCompConfig.config.inputinfo,function(v,k){
			var dataName = v.dataName;
			angular.forEach(v.colDetail,function(_v,_k){
				var map_key = dataName+"."+_v.name;
				map[map_key] = {'text':map_key,'value':map_key};
			});
		});
		angular.forEach(statCompConfig.config.config.vcol, function(v,i){
			var dataName = v.data+'.'+v.colName;
			map[dataName] = {'text':dataName,'value':dataName};
		});
		return map;
	}

	this.getAllCols = function() {
		var cols = [];
		angular.forEach(statCompConfig.config.inputinfo, function(v,i){
			angular.forEach(v.colDetail, function(col,j){
				cols.push(v.dataName+"."+col.name);
			});
		});
		angular.forEach(statCompConfig.config.config.vcol, function(v,i){
			cols.push(v.data+'.'+v.colName);
		});
		return cols;
	};

	this.post = function (url,data) {
		if ($.blockUI===undefined) {
			$.blockUI = common.blockUI;
		} 
		$.blockUI({ message: "系统处理中，请等待...",css: { 
	        border: 'none', 
	        padding: '15px', 
	        backgroundColor: '#000', 
	        '-webkit-border-radius': '10px', 
	        '-moz-border-radius': '10px', 
	        opacity: .5, 
	        color: '#fff' 
	    }});	
		$.ajax({
            type         : 'POST',
            url         : url,
            data         : data,
            dataType     : 'json'
        }).done(function(){
        	$.unblockUI();
        	return ;
        }).fail(function(){ 
        	console.log("出错啦！");
        	$.unblockUI();
        });
	}

	this.get = function (url) {
		$http.get(url)
		.success(function(response) {
			return response;
		}).error(function(){
			return '';
		});
	}

	this.query = function(url) {
      var deferred = $q.defer(); // 声明延后执行，表示要去监控后面的执行
      $http({method: 'GET', url: url}).
      success(function(data, status, headers, config) {
        deferred.resolve(data);  // 声明执行成功，即http请求数据成功，可以返回数据了
      }).
      error(function(data, status, headers, config) {
        deferred.reject(data);   // 声明执行失败，即服务器返回错误
      });
      return deferred.promise;   // 返回承诺，这里并不是最终数据，而是访问最终数据的API
	}

	this.conds = [
         {value:'>',text:'大于'},
         {value:'<',text:'小于'},
         {value:'=',text:'等于'},
         {value:'>=',text:'大于且等于'},
         {value:'<=',text:'小于且等于'},
         {value:'d>',text:'数值大于'},
      	 {value:'d<',text:'数值小于'},
      	 {value:'d=',text:'数值等于'},
      	 {value:'d>=',text:'数值大于等于'},
      	 {value:'d<=',text:'数值小于等于'},
      	 {value:'isnull',text:'为空'},
      	 {value:'notnull',text:'不为空'},
      	 {value:'contain',text:'包含'},
      	 {value:'notcontain',text:'不包含'}
   ];
});
