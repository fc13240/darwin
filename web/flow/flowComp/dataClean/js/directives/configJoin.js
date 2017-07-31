'use strict';

/* Directives */


var module = angular.module('comp.directives');

module.directive('configJoin', function() {
    return {
      restrict: 'EA',
      scope: {
    	'cleancompConfig': '=',
    	'joinTypes': '='
      },
      templateUrl: 'dataClean/partials/config-join.html',
        replace: true,
        controller: function($scope, $element, $compile, cleancompConfig, utils) {
    	    $scope.inputinfos = $scope.cleancompConfig.inputinfo;
    		$scope.allCol = function(data) {
    			var cols = [];
    			angular.forEach($scope.cleancompConfig.inputinfo, function(v,i){
    				angular.forEach(v.colDetail, function(col,j){
    					if (v.dataName === data) {
    						cols.push(v.dataName+"."+col.name);
    					}
    				});
    			});
    			angular.forEach($scope.cleancompConfig.config.vcol, function(v,i){
    				if (v.data === data) {
    					cols.push(v.data+'.'+v.colName);
    				}
    			});
    			return cols;
    		};
	    	$scope.addJoin = function() {
	    		var joinrel = {};
	    		joinrel['left'] = $('#config-join-left').val();
	    		joinrel['op'] = $('#config-join-op').val();
	    		joinrel['right'] = $('#config-join-right').val();
	    		joinrel.cond = [];
	    		cleancompConfig.config.config.relation.joinDetail.relation.push(joinrel);
	    	};
	    	
	    	$scope.conditions = {};
	    	getCond(cleancompConfig.config.config.relation.joinDetail.relation);
	    	
	    	$scope.addJoinCond = function() {
	    		var joinCond = {};
	    		var confLeft = $('#config-cond-left').val();
	    		var confRight = $('#config-cond-right').val();
	    		var joinLeft = $('#config-join-left').val();
	    		var joinRight = $('#config-join-right').val();
	    		var joinOp = $('#config-join-op').val();
	    		joinCond['left'] = confLeft;
	    		joinCond['right'] = confRight;
	    		var joinrel = {};
	    		joinrel['left'] = joinLeft;
	    		joinrel['op'] = joinOp;
	    		joinrel['right'] = joinRight;
	    		
	    		
	    		if (cleancompConfig.config.config.relation.joinDetail.relation.length===0) {
	    			joinrel.cond = [];
		    		joinrel.cond.push(joinCond);
		    		cleancompConfig.config.config.relation.joinDetail.relation.push(joinrel);
	    		}else {
	    			var checkResult = checkRelation(joinLeft,joinRight,joinOp,cleancompConfig.config.config.relation.joinDetail.relation);
	    			if (checkResult.exist) {
	    				var relation_key = checkResult.relation_key;
	    				var relation = cleancompConfig.config.config.relation.joinDetail.relation[relation_key];
	    				var cond = relation.cond;
	    				var bool = checkObjInCond(joinCond,cond);
	    				if (!bool) {
	    					cond.push(joinCond);
		    				cleancompConfig.config.config.relation.joinDetail.relation[relation_key].cond = cond;
	    				}
	    			}else {
	    				joinrel.cond = [];
			    		joinrel.cond.push(joinCond);
			    		cleancompConfig.config.config.relation.joinDetail.relation.push(joinrel);
	    			}
	    		}
	    		getCond(cleancompConfig.config.config.relation.joinDetail.relation);
	    	};
	    	
	    	function checkObjInCond (obj, cond){
	    		var bool = false;
	    		angular.forEach(cond,function(val,key){
	    			if(angular.equals(val, obj)){
	    				bool = true;
	    				return true;
	    			}
	    		});
	    		return bool;
	    	}
	    	
	    	function checkRelation(joinLeft,joinRight,joinOp,relations) {
	    		var checkResult =  {};
	    		checkResult['exist'] = false;
	    		checkResult['relation_key'] = '';
	    		angular.forEach(relations,function(relation,key){
	    			if (relation.left===joinLeft && relation.right===joinRight && relation.op===joinOp) {
	    				checkResult['exist'] = true;
	    	    		checkResult['relation_key'] = key;
	    				return true;
	    			}
	    		});
	    		return checkResult;
	    	}
	    	
	    	function getCond(relations) {
	    		$scope.conditions = {};
	    		angular.forEach(relations,function(relation,key){
	    			angular.forEach(relation.cond,function(cond,_key){
	    				var cond_key = key.toString() + "-" +  _key.toString();
	    				$scope.conditions[cond_key] =  cond.left+' = '+cond.right;
	    			});
	    		});
	    	}
	    	
	    	$('#conditions').off('click','.condition').on('click','.condition',function(){
	    		if (!$(this).hasClass('label-primary')) {
	    			$(this).addClass('label-primary');
	    		}else {
	    			$(this).removeClass('label-primary');
	    		}
	    	});
	    	
	    	$('#config-join-selected').off('click','.relation').on('click','.relation',function(){
	    		if (!$(this).hasClass('label-primary')) {
	    			$(this).addClass('label-primary');
	    		}else {
	    			$(this).removeClass('label-primary');
	    		}
	    	});
	    	
	    	$scope.removeJoin = function() {
	    		$('#config-join-selected .label-primary').each(function(){
	    			var index = $(this).attr('value');
	    			cleancompConfig.config.config.relation.joinDetail.relation.splice(index,1);
	    		});
	    		getCond(cleancompConfig.config.config.relation.joinDetail.relation);
	    	};
	    	$scope.removeJoinCond = function() {
	    		$('#conditions .label-primary').each(function(){
	    			var val = $(this).attr('value');
	    			var a = val.split('-');
	    			var relation_key = parseInt(a[0]);
	    			var condition_key = parseInt(a[1]);
	    			cleancompConfig.config.config.relation.joinDetail.relation[relation_key].cond.splice(condition_key,1);
	    		});
	    		getCond(cleancompConfig.config.config.relation.joinDetail.relation);
	    	};
        }
    };
});
