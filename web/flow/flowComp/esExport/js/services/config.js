'use strict';

/* Services */
var module = angular.module('comp.services');

module.service('esExportConfig',function(){
	var self = this;
	this.defaultconfig = {
		"className": "com.darwin.realtime.RealTimeAction",
		"compname":"ES导出",
		"code":"esExport",
		"inputinfo":[{
		    es_host:'127.0.0.1',
		    es_port:'19200',
		    index_type:1,  
		    index_name:'',
		    compress:false,          
		    delete:false,                
		    fields:1,                 
		    start_time:'-10d',
		    end_time:'-1d'
		 }],
		"storeinfo":{
			type:"hdfs",
			path:"XXXX"
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
