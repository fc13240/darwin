'use strict';

/* Services */
var module = angular.module('comp.services');

module.service('cleancompConfig',function(){
	var self = this;
	this.defaultconfig = {
		"className": "com.darwin.realtime.RealTimeAction",
		"compname":"组件名",
		"code":"realtimeToHdfs",
		"inputinfo":{
				 type: "kafka",
				 topic: "tomcattopic",//Kafka主题
				 consumerId:'unique'
		},
		"config":
			{	

			},
		"storeinfo":{
					paDataDir:'',
					subDirectory:'@{yyyyMMdd}@{1H}',
					fileName:'fileName',
					outCycle:'oneHour',
					isCompress:false
				}
	};
	
	this.config = oldconfig || this.defaultconfig;

	this.cloneConfig = clone(this.config);

	function clone(obj) {
		var o;
		if (typeof obj == "object") {
			if (obj === null) {
				o = null;
			} else {
				if (obj instanceof Array) {
					o = [];
					for (var i = 0, len = obj.length; i < len; i++) {
						o.push(clone(obj[i]));
					}
				} else {
					o = {};
					for (var j in obj) {
						o[j] = clone(obj[j]);
					}
				}
			}
		} else {
			o = obj;
		}
		return o;
	}


});
