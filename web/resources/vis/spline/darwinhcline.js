/**
* @author fushiguang
* @this DarwinMLine
* @constructor
* @param domid 为展示图表的dom的id，不需要以#开头
* @param data 为数据对象，格式：
* {"xvalues":['x1'，'x2'，'x3',...], "yvalues":{"y1name":[y11,y12,y13,...],"y2name":[y21,y22,y23,y24,...]} }
*/
var DarwinSplineLine = function(domid, data) {
	this.domid = domid;
	this.data = data;
	this.finalOptions = {};
	this.bestWidthHeight = 1000/300;//宽高比,从demo获得
	this.padding = [0,0,0,0];
	/**
	 * options 为图表的参数。
	 * header.title.text 为图表标题，一般是必要的
	 * graph.legend.show 0不显示，1显示
	 * graph.linestyle.smooth 0直线，1平滑
	 * graph.linestyle.showarea 0不显示区域，1显示区域
	 */
	DarwinSplineLine.prototype.draw = function(width, height, options) {
		var _self = this;
		
		if (width == "" && height == "") {
			console.error("DarwinMLine for div["+this.domid+"], both width and height are empty. must at least one has value");
			return false;
		}
		if (width == "") {
			width = Math.floor(height * this.bestWidthHeight);
		}
		if (height == "") {
			height = Math.floor(width / this.bestWidthHeight);
		}
		
		if (typeof options == "undefined") {
			options = {};
		}
		
		var _padding = _self.padding;
		/*
		var _title = "";
		if (typeof options['header.title.text']!="undefined") {
			_padding[0] = 40;
			_title = options['header.title.text'];
		}*/
		
		Highcharts.setOptions({                                                     
            global: {                                                               
                useUTC: false                                                       
            }                                                                       
        });                                                                         
                                                                                    
        var chart;
        //console.log("DarwinSplineLine.data=");
        console.log(this.data);
        
        var dd = this.data;
		$('#'+_self.domid).highcharts({
			
			chart: {                                                                
                type: 'spline',                                                     
                animation: Highcharts.svg, // don't animate in old IE               
                marginRight: 10,                                                    
                events: {                                                           
                    load: function() {                                              
                                                                                    
                        // set up the updating of the chart each second             
                        var series = this.series[0];
                        
                        /*
                        setInterval(function() {
                        	sendAjaxRequest(dd,function(textStatus,d){
                        		console.log("d="+d);
                        		var x = (new Date()).getTime(),
                        		y = parseInt(d);                                  
                        		series.addPoint([x, y], true, true);
                        	},this.data);
                        	
                        }, 5000);*/
                        
                        
                        //sendAjaxRequest(series,dd,function(textStatus,d){
                    		//console.log("d="+d);
                    		//var x = (new Date()).getTime(), // current time         
                    		//y = parseInt(d);//Math.random();                                  
                    		//series.addPoint([x, y], true, true);
                    	//});
                        
                        _ajaxRequest(series,dd);
                        
                    }                                                               
                }                                                                   
            },                                                                      
            title: {                                                                
                text: ''+dd.name                                            
            },                                                                      
            xAxis: {                                                                
                type: 'datetime',                                                   
                tickPixelInterval: 150                                              
            },                                                                      
            yAxis: {                                                                
                title: {                                                            
                    text: 'Value'                                                   
                },                                                                  
                plotLines: [{                                                       
                    value: 0,                                                       
                    width: 1,                                                       
                    color: '#808080'                                                
                }]                                                                  
            },                                                                      
            tooltip: {                                                              
                formatter: function() {                                             
                        return '<b>'+ this.series.name +'</b><br/>'+                
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);                         
                }                                                                   
            },                                                                      
            legend: {                                                               
                enabled: false                                                      
            },                                                                      
            exporting: {                                                            
                enabled: false                                                      
            },                                                                      
            series: [{                                                              
                name: 'Random data',                                                
                data: (function() {                                                 
                    // generate an array of random data                             
                    var data = [],                                                  
                        time = (new Date()).getTime(),                              
                        i;                                                          
                                                                                    
                    for (i = -19; i <= 0; i++) {                                    
                        data.push({                                                 
                            x: time + i * 1000,                                     
                            y: 0                                        
                        });                                                         
                    }                                                               
                    return data;                                                    
                })()                                                                
            }]
			
	    });
		
		function _ajaxRequest(series,dd){
			sendAjaxRequest(series,dd,function(textStatus,d){
        		console.log("d="+d);
        		var x = (new Date()).getTime(), // current time         
        		y = parseInt(d);//Math.random();                                  
        		series.addPoint([x, y], true, true);
        	});
		}
		
		//发送ajax请求查询sql
		function sendAjaxRequest(series,chart,func){
			//console.log("sendAjaxRequest..");
			//console.log(chart);
			//func();
			var url = "/analytics?method=runningOnChart&graphid="+chart.id;
//			var url = getLocation() + "/search?method=sqlMethod&sql="+chart.sql+"&rangeType="+chart.rangeType+"&startTime="+chart.startTime+"&stopTime="+chart.stopTime+"&d="+Math.random();
//			var url = "/search?method=sqlMethod&sql="+chart.sql+"&rangeType="+chart.rangeType+"&startTime="+chart.startTime+"&stopTime="+chart.stopTime+"&d="+Math.random();
			$.ajax({
					url:url,
					type:"get",
					dataType:"text",
					success:function(d, textStatus){
						console.log(d);
						func(0,d);
						
						_ajaxRequest(series,dd);
					},
					error:function(){
						console.log("加载数据出错！");
						func(1,null);
						
						_ajaxRequest(series,dd);
					}
			});
		}
		
		function getLocation() {
			var localObj = window.location;
			var contextPath = localObj.pathname.split("/")[1];
			var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
			var server_context = basePath;
			//console.log(server_context);
			return server_context;
		};
		
		//DarwinVis['viscontainer'][this.domid] = linechart2;
	};
	
	//递归设置属性值
	DarwinSplineLine.prototype._clone = function(fromobject, toobject) {
		for(var fk in fromobject) {
			if(typeof fromobject[fk]=="object") {
				toobject[fk] = {};
				this._clone(fromobject[fk], toobject[fk]);
			} else {
				toobject[fk] = fromobject[fk];
			}
		}
	};
	
	
	DarwinSplineLine.prototype.getLocation = function() {
		var localObj = window.location;
		var contextPath = localObj.pathname.split("/")[1];
		var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
		var server_context = basePath;
		//console.log(server_context);
		return server_context;
	};
};
