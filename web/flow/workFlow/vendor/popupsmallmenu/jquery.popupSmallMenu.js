define(["jquery"], function($jq,undefined){
	 $jq.fn.popupSmallMenu = function(options) {
	 	var $currMenu = $jq(this),
	 	defaultOptions = {
	 		event : null,
	 		target : null,
	 		pos : undefined,
	 		onClickItem : null,
	 		refLeftDom : 'right-container',
	 		refTopDom : 'content',
	 	},
	 	options = $jq.extend(defaultOptions,options);
	 	
	 	var _smallMenu = {
	 		popupSmallMenu : function() {
	 			this._bindItemClick();
	 			this._bindMenuEvent();
	 			this._showMenu();
	 			return $currMenu;
	 		},
	 		_bindMenuEvent : function() {
	 			var thiz = this;
		 		$currMenu.hover(function(){ 	
				},function(){
					thiz._unBindItemClick();
					$currMenu.hide();
				});
				
				$currMenu.click(function(){
					thiz._unBindItemClick();
					$currMenu.hide();
				});
		 	},
		 	_showMenu : function() {
		 		if(!options.event) {
		 			alert('请传入鼠标事件');
		 		}
		 		
		 	
		 	   var xPos = 0;
		 	   var yPos = 0;
		 	   if (options.pos === undefined) {
		 		   var win = $jq(window);
			 	   var mWidth = $currMenu.outerWidth(true);
			       var mHeight = $currMenu.outerHeight(true);
			       var modLeft = 0, modTop = 0;
			       if (options.refLeftDom) {
			    	   if ($jq('#'+options.refLeftDom).length>0) {
			    		   modLeft = $jq('#'+options.refLeftDom).position().left;
			    	   }
			       }
			       if (options.refTopDom) {
			    	   if ($jq('#'+options.refTopDom).length>0) {
			    		   modTop = $jq('#'+options.refTopDom).position().top;
			    	   }
			       }
			       xPos = ((options.event.pageX - win.scrollLeft()) + mWidth < win.width()) ? options.event.pageX - modLeft : options.event.pageX - mWidth - tmpPos.left;
			       yPos = ((options.event.pageY - win.scrollTop()) + mHeight < win.height()) ? options.event.pageY - modTop: options.event.pageY - mHeight;
			 	   
		 	   }else {
		 		  xPos = options.pos.x;
			 	  yPos = options.pos.y;
		 	   }
		       
		 		$currMenu.css({
		 			top: yPos + 'px',
		 	        left: xPos + 'px',
		            display:"block"
		        });
		 	},
		 	_bindItemClick : function() {
		 		$currMenu.find('li').each(function(index,obj){
 					var $li = $jq(obj);
	 				var itemIden = $li.attr('class');
	 				$li.bind('click',function(event){
	 					event.stopPropagation();
	 					if(options.onClickItem 
	 							&& typeof options.onClickItem === 'function') {
					 		options.onClickItem(itemIden);
					 	}
	 				});
 				});
		 	}
		 	,
		 	_unBindItemClick : function(){
		 		$currMenu.find('li').each(function(index,obj){
	 				$jq(obj).unbind();
	 			});
		 	}
	 	};
	 	
	 	return _smallMenu.popupSmallMenu();
	}
});

