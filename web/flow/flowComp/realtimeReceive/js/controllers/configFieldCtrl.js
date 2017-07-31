'use strict';

/* Controllers */


var module = angular.module('comp.controllers');

module.controller('configFieldCtrl', function($scope,$element,$attrs,cleancompConfig,utils) {
	$scope.srclb = [];
	$scope.srclbList = utils.getAllCols();
	$scope.dstlbList = {};
});
