'use strict';

/* Controllers */


var module = angular.module('userInfo.controllers');


module.controller('userInfo', function($scope,$location,$http,$element,$compile) {
	var self = this;

   /* $http.get('/manage/user?method=userInfo')
    .success(function(response) {
        $scope.userinfo = response;
        var t= $('<user-info userinfo="userinfo"></user-info>');
         $compile(t)($scope);
         $element.find('#user-info').html(t);
    }).error(function(error){
        
    });*/

    $.ajax({url:'/manage/user?method=userInfo',cache:false})
    .success(function(response) {
        $scope.userinfo = response;
        var t= $('<user-info userinfo="userinfo"></user-info>');
         $compile(t)($scope);
         $element.find('#user-info').html(t);
    }).error(function(error){
        
    });

    $.ajax({ul:'/manage/user?method=userSpace',cache:false})
    .success(function(response) {
        $scope.spaces = response;
        var t= $('<user-spaces spaces="spaces"></user-spaces>');
         $compile(t)($scope);
         $element.find('#user-spaces').html(t);
    }).error(function(error){
        
    });

    $.ajax({url:'/manage/user?method=userflow',cache:false})
    .success(function(response) {
        $scope.wfstatestat = response;
        var t= $('<wf-state-stat wfstatestat="wfstatestat"></wf-state-stat>');
         $compile(t)($scope);
         $element.find('#user-flow').html(t);
    }).error(function(error){
        
    });

    $.ajax({url:'/manage/user?method=userHbase',cache:false})
    .success(function(response) {
        $scope.tables = response;
        var t= $('<user-tables tables="tables"></user-tables>');
         $compile(t)($scope);
         $element.find('#user-db').html(t);
    }).error(function(error){
        console.log(error);
    });

    $http.get('/manage/user?method=userEsInfo')
    .success(function(response) {
        $scope.idxs = response;
        var t= $('<user-idxs idxs="idxs"></user-idxs>');
         $compile(t)($scope);
         $element.find('#user-idx').html(t);
    }).error(function(error){
        
    });
});
