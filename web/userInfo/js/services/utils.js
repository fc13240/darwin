'use strict';

/* Services */

var module = angular.module('userInfo.services');

module.service('utils',function($http,$q){
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


	this.post = function (url,data) {
		$.ajax({
            type         : 'POST',
            url         : url,
            data         : data,
            dataType     : 'json'
        }).done(function(){
        	return ;
        }).fail(function(){ 
        	console.log("出错啦！");
        });
	}

	this.get = function (url) {
		$http.get(url)
		.success(function(response) {
			return response;
		}).error(function(error){
			return error;
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
});
