'use strict';

/* Services */

var module = angular.module('comp.services');

module.service('commonUtils',function(cleancompConfig,$http,$q){
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
});
