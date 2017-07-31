'use strict';

/* Filters */

angular.module('userInfo.filters', []).
  filter('bytesToSize', function() {
    return function(bytes) {
      if (bytes === 0) return '0 B';
    	var k = 1024,
        sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.floor(Math.log(bytes) / Math.log(k));
   		return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
    };
  })
  .filter('sum',function(){
  	return function sum(data,feild) {
  		var sum = 0;
  		angular.forEach(data,function(v,k){
  			sum += parseFloat(v[feild]);
  		});
  		return sum;
  	}
  }).filter('format',function(){
    return function format(x){
        var f_x = parseFloat(x);
        if (isNaN(f_x)){
            alert('function:changeTwoDecimal->parameter error');
            return false;
        }
        f_x = Math.round(f_x*10000)/10000;
        var s_x = f_x.toString();
        var pos_decimal = s_x.indexOf('.');
        if (pos_decimal < 0){
          pos_decimal = s_x.length;
          s_x += '.';
        }
        while (s_x.length <= pos_decimal + 4){
          s_x += '0';
        }
        console.log(s_x);
        return s_x;
    }
  });