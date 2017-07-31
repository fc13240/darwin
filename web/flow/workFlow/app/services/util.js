define([
	'angular'
]
,function(angular){
	'use strict';
	
	var module = angular.module('workflow.services');
	
	module.service('util',function(){
		var self = this;
		
		var doc = document,
			body = doc.body,
			html = doc.documentElement,
        	client = doc.compatMode == 'BackCompat' ? body : html;

		this.getViewWidth = function () {
		    return client.clientWidth;
		};
		
		this.getWidth = function () {
		    return client.offsetWidth;
		};
		
		this.getHeight = function () {
		    return Math.max(html.scrollHeight, body.scrollHeight, client.clientHeight);
		};
		
		this.getLeft = function () {
			return client.scrollLeft;
		}
		
		this.getTop = function () {
			return client.scrollTop;
		}
		
		//获得相对于页面的坐标
		this.positionObj = function(event,obj){
			//获得对象相对于页面的横坐标值；id为对象的id
			var thisX = obj.offsetLeft;
			
			//获得对象相对于页面的横坐标值；
			var thisY = obj.offsetTop;
			
			//获得页面滚动的距离；
//			var thisScrollTop = client.scrollTop;
			var thisScrollTop = self.getScrollTop();
			
			event = event||window.event;
			
			//获得相对于对象定位的横标值 = 鼠标当前相对页面的横坐标值 - 对象横坐标值；
			var x = event.clientX - thisX;
			
			//获得相对于对象定位的纵标值 = 鼠标当前相对页面的纵坐标值 - 对象纵坐标值 - 滚动条滚动的高度；
			var y = event.clientY - thisY + thisScrollTop;
			
			var pos = {'x':x,'y':y};
			
			return pos;
		}

		this.getScrollTop = function () {
	        var scrollPos;
	        if (window.pageYOffset) {
	        	scrollPos = window.pageYOffset;
	        }else if (document.compatMode && document.compatMode != 'BackCompat') {
	        	scrollPos = document.documentElement.scrollTop;
	        }  else if (document.body) {
	        	scrollPos = document.body.scrollTop;
	        }
	        return scrollPos;
		}
		
		this.getVertexPos = function (obj) {
            var actualLeft = obj.offsetLeft;
            var actualTop = obj.offsetTop;
            var current = obj.offsetParent;
            while (current !== null){
                actualLeft += current.offsetLeft;
                actualTop += current.offsetTop;
                current = current.offsetParent;
            }
			var thisX = actualLeft;
			var thisY = actualTop;
			var thisH = obj.offsetHeight;
			var thisW = obj.offsetWidth;
			var pos = {'x1':thisX,'y1':thisY,'x2':thisX + thisW,'y2':thisY + thisH};
			return pos;
		}
		
    })
})