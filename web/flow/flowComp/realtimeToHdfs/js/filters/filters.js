'use strict';

/* Filters */

angular.module('comp.filters', []).
  filter('getMapKey', function() {
    return function(map,joinString) {
    	var keys = Object.keys(map);
    	if (joinString && keys) {
    		return keys.join(joinString);
    	}
      return keys;
    };
  }).filter('explode',function(){
  	return function(string,delimiter) {
  		if (string === undefined || string === "") {
  			return [];
  		}
  		var r = string.split(delimiter);
  		return r;
  	}
  });
