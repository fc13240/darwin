'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configFilter', function() {
    return {
      restrict: 'EA',
      scope: {
    	compConfig: '='
      },
      templateUrl: 'dataClean/partials/config-filter.html',
        replace: true,
        controller: function($scope, cleancompConfig,utils) {
    		
    		$scope.filter = $scope.compConfig.config.filter;
    		
    		$scope.colname = [];

    		$scope.$watch('compConfig.inputinfo',function(){
    			var colname = [];
    			angular.forEach($scope.compConfig.inputinfo,function(v,k){
    				var dataName = v.dataName;
    				angular.forEach(v.colDetail,function(_v,_k){
    					colname.push({'text':dataName+"."+_v.name,'value':dataName+"."+_v.name});
    				});
    			});
    			angular.forEach($scope.compConfig.config.vcol, function(v,i){
    				colname.push({'text':v.data+'.'+v.colName,'value':v.data+'.'+v.colName});
    			});
    			$scope.colname = colname;
    		},true);

    		$scope.$watch('compConfig.config.vcol',function(vcol){
    			var colname = [];
    			angular.forEach($scope.compConfig.inputinfo,function(v,k){
    				var dataName = v.dataName;
    				angular.forEach(v.colDetail,function(_v,_k){
    					colname.push({'text':dataName+"."+_v.name,'value':dataName+"."+_v.name});
    				});
    			});
    			angular.forEach($scope.compConfig.config.vcol, function(v,i){
    				colname.push({'text':v.data+'.'+v.colName,'value':v.data+'.'+v.colName});
    			});
    			$scope.colname = colname;
    		},true);
    		
    		$scope.conds = utils.conds;
    		$scope.remove = function(groupindex,index) {
                
    			$scope.compConfig.config.filter.groups[groupindex].groupitems.splice(index,1);   
    			var length=$scope.compConfig.config.filter.groups[groupindex].groupitems.length;
    			
                if(length==0){
    				$scope.compConfig.config.filter.groups.splice(groupindex,1);
                    $scope.compConfig.config.filter.grouprels.splice(groupindex,1)
    			}
    			return false;
    		};

    		$scope.addnewgroup = function() {
    			var group = {
			            groupitems: [
			                {
			                    colname: "",
			                    cond: "=",
			                    val: ""
			                }
			            ],
			            groupitemrels: []
			        };
               
                if($scope.compConfig.config.filter.groups.length>0) {
                    $scope.compConfig.config.filter.grouprels[$scope.compConfig.config.filter.groups.length-1]='AND'
                };
    			$scope.compConfig.config.filter.groups.push(group);
    		};

    		$scope.addnewcond = function (groupindex) {
    			var col = {
	    	            	colname: "",
	    	                cond: "=",
	    	                val: ""
    					  };

    			$scope.compConfig.config.filter.groups[groupindex].groupitems.push(col);
    		};

    		$scope.removethisgroup = function(groupindex){
                var groupLen=$scope.compConfig.config.filter.groups.length
                if (groupLen==1) {
                    groupindex=0;
                };
                $scope.compConfig.config.filter.grouprels.splice(groupindex,1)
    			$scope.compConfig.config.filter.groups.splice(groupindex,1);
    		};
        }
    };
});
