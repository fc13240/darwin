'use strict';

/* Services */
var module = angular.module('comp.services');

module.service('cleancompConfig',function(){
	var self = this;
	this.defaultconfig = {
		"className": "com.darwin.realtime.RealTimeAction",
		"compname":"组件名",
		"code":"realtimeReceive",
		"inputinfo":{
				 type: "kafka",
				 topic: "tomcattopic",//Kafka主题
				 sourceType:"selectOne",
				 consumerId:'unique',
				 encoding:"UTF-8",
				 colDelimitType:'FIELD',
				 colDellimitExprType:'default',
				 colDelimitExpr:'\t',
				 columnSize:"7",
				 isParse:false,
				 columns:[
				 {column_name:'c1',id:'0',type_name:'string',dateFormat:'',isTime: "false"},
				 {column_name:'c2',id:'1',type_name:'string',dateFormat:'',isTime: "false"},
				 {column_name:'c3',id:'2',type_name:'string',dateFormat:'',isTime: "false"},
				 {column_name:'c4',id:'3',type_name:'string',dateFormat:'',isTime: "false"},
				 {column_name:'c5',id:'4',type_name:'string',dateFormat:'',isTime: "false"},
				 {column_name:'c6',id:'5',type_name:'string',dateFormat:'',isTime: "false"},
				 {column_name:'c7',id:'6',type_name:'string',dateFormat:'',isTime: "false"}
				]



		},
		"config":
			{	
				"filterDetail":[
					/*{
						"expr":"表达式1",
						"resultArr":[
							{
								"resultName":'a',
							    "type":'string'
							},
							{
								"resultName":'b',
							    "type":'int'
							},
							{
								"resultName":'c',
							    "type":'string'
							}
						]	
					}*/
				]
			},
		"storeinfo":{
				   "esconfig": {//ES的配置
			            es_clusterName: "elasticsearch_darwin",
			            es_host: "192.168.2.92",
			            es_port: 19200,
			            hostName: "localhost",
			            index: "",
			            sourceType:"selectOne",
			            uid: 1,
			            columnSize: 7,
			            format:'',
			            timeColumnType:'fromAgent',
			            shardsnum:30,
			            isOpenAdvanSet:false,
			            timeColumn:''
        			},
		            "escolumns": [
			            
			        ]

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
