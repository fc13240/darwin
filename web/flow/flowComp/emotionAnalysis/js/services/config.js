'use strict';

/* Services */
var module = angular.module('comp.services');

module.service('statCompConfig',function(){
	var self = this;
	this.defaultconfig = {
		"compname":"组件名",
		"code":"emotionAnalysis",
		"inputinfo":
		[
			 {
				 dataName:"data1",
				 dataType:"text",
				 encoding:"UTF-8",
				 dataDir:"",
				 dataRange:"dirname_time_rule",
				 dataRangeDetail:{
					 dirnameTimeRule:"@{yyyyMMdd}",
					 timeRangeFrom:"1",
					 timeRangeTo:"1",
					 timeUnit:"day",
					 filenameMatch:".*",
					 filenameNotMatch:"",
					 filenameTimeRule:"@{yyyyMMdd}"
				 },
				 colDelimitType:"FIELD",
				 colDellimitExprType:'default',
				 colDelimitExpr:"\\t",
				 colCount:"5",
				 multilineCombine:"0",
				 combineRegex:"^\[.*",
				 colDetail:[{name:'c1',type:'string',dateFormat:''},
						{name:'c2',type:'string',dateFormat:''},
						{name:'c3',type:'string',dateFormat:''},
						{name:'c4',type:'string',dateFormat:''},
						{name:'c5',type:'string',dateFormat:''}]
			 }
		],
		"config":{
			"title":"",
			"participle":"",
			"aggregate":[
			 ]
		},
		"storeinfo":[
             	{
             		dataType:"text",
             		paDataDir:"",
             		storeExprType:'default',
             		colDelimitExpr:"\\t",
             		dataDir:"@{yyyyMMdd -86400s}",
             		outrowfilter:"no",
             		outrowfilterType:"and",
             		rowfilterDetail:[
             		],
             		outCols:[]
             	}
             ]
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
