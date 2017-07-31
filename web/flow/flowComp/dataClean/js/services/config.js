'use strict';

/* Services */
var module = angular.module('comp.services');

module.service('cleancompConfig',function(){
	var self = this;
	this.defaultconfig = {
		"compname":"组件名",
		"code":"dataClean",
		"inputinfo":
		[
			 {
				 dataName:"data1",
				 dataType:"text",
				 encoding:"UTF-8",
				 dataDir:"",
				 ignoreRowFirst:"false",
				 dataRange:"dirname_time_rule",
				 dataRangeDetail:{
					 //当选择的数据范围
					 //为dirname_time_rule时，与dirnameTimeRule，timeRangeFrom，timeRangeTo，timeUnit，filenameMatch，filenameNotMatch
					 //为filename_time_rule时，与filenameTimeRule，timeRangeFrom，timeRangeTo，timeUnit，filenameNotMatch
					 //为filename_rule时，与filenameMatch，filenameNotMatch
					 //为dirname_rule时，与filenameMatch，filenameNotMatch
					 //为all时，都不相关
					 dirnameTimeRule:"@{yyyyMMdd}",
					 timeRangeFrom:"1",
					 timeRangeTo:"1",
					 timeUnit:"day",
					 filenameMatch:".*",
					 filenameNotMatch:"",
					 filenameTimeRule:"@{yyyyMMdd}"
				 },
				 colDelimitType:"FIELD",
				 colDelimitExpr:"\\t",
				 colCount:"5",
				 //多行日志合并
				 multilineCombine:"0",
				 combineRegex:"^\[.*",
				 colDetail:[{name:'c1',type:'string',dateFormat:''},
				{name:'c2',type:'string',dateFormat:''},
				{name:'c3',type:'string',dateFormat:''},
				{name:'c4',type:'string',dateFormat:''},
				{name:'c5',type:'string',dateFormat:''}]
			 }
		],
		"config":
			{
				"vcol":[],
				"relation":{
					type:"union",
					unionDetail:
						{
							//data1:[col1,col2,vcol21],
							//data2:[col2,vcol21,col4]
						},
					joinDetail:
						{
							relation:[//N份数据，至少有N-1个关系
							  ],
						    cond:[
				              ]
						}
				},
				"filter":
				{
				    "groups": [],
				    "grouprels": []
				}
			},
		"storeinfo":[
             	{
             		dataName:"data1",
             		dataType:"text",
             		paDataDir:"",
             		//colDelimitExpr:",",
             		colDelimitExpr:"\\t",
             		//dataDir:"@{yyyyMMdd -86400s}",
             		dataDir:"once",
             		outrowfilter:"no",
             		outrowfilterType:"and",
             		rowfilterDetail:[
             		],
             		outCols:[]
             	}
             ]
	};
//	console.log("oldconfig=");
//	console.log(angular.toJson(oldconfig));
	this.config = oldconfig || this.defaultconfig;
//	console.log(angular.toJson(this.config));

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
