'use strict';

/* Directives */


var module = angular.module('userInfo.directives');
  
module.directive('userSpaces', function() {
    return {
        restrict: 'EA',
        scope: { 
    		spaces: '=',
            url: '@'
    	},
        templateUrl: 'userInfo/partials/spaces.html',
        replace: true,
        controller: function($scope) {
    		$scope.goto = function(obj) {
                var url = '/configure/hdfsManage.jsp';
                var post_params = {'hdfsPath':obj.groupdir};
                post(url,post_params);
            }

            function post(URL, PARAMS) {
                var temp_form = document.getElementById('new_form_for_window');
                if (temp_form === null|| temp_form === undefined){
                    temp_form = document.createElement("form");
                    temp_form.id = 'new_form_for_window';
                    temp_form.action = URL;
                    temp_form.target = "_blank";
                    temp_form.method = "post";
                    temp_form.style.display = "none";
                    angular.forEach(PARAMS,function(value,name){
                        var input = document.createElement("input");
                        input.name = name;
                        input.value = value;
                        temp_form .appendChild(input); 
                    });
                }
                document.body.appendChild(temp_form);
                temp_form.submit();
                document.body.removeChild(temp_form);  
            }
    	}
    };
});