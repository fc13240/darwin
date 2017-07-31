define([
	'angular',
	'jquery',
	'sco.message'
]
,function(angular){
	'use strict';
	
	var module = angular.module('workflow.services');
	
	module.service('backendSvr',function($rootScope,$http){
		var self = this;
		
		this.post = function (url,data) {
			$jq.ajax({
                type         : 'POST',
                url         : url,
                data         : data,
                dataType     : 'json'
            }).done(function(){
            	return true;
            }).fail(function(){ 
            	$jq.scojs_message("对不起，没有权限！", $jq.scojs_message.TYPE_ERROR);
            	return false;
            });
		}
		
		this.get_flow_state = function (url,data) {
			return $jq.ajax({
                url         : url,
                data         : data,
                dataType     : 'json'
            }).done(function(req){
            	return req;
            }).fail(function(){ 
            	$jq.scojs_message("获得工作流状态异常！", $jq.scojs_message.TYPE_ERROR);
            	return false;
            });
		}
		
		this.get = function (url,data) {
			return $jq.ajax({
                url         : url,
                data         : data,
                dataType     : 'json'
            }).done(function(req){
            	return req;
            }).fail(function(){ 
            	$jq.scojs_message("对不起，没有权限！", $jq.scojs_message.TYPE_ERROR);
            	return false;
            });
		}
		
		function getURL(url) { 
			var xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP"); 
			xmlhttp.open("GET", url, false); 
			xmlhttp.send(); 
			if(xmlhttp.readyState==4) { 
				if(xmlhttp.Status != 200) alert("不存在"); 
				return xmlhttp.Status==200; 
			} 
			return false; 
		} 
	})
})