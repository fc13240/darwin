/**
 * 公共脚本
 */

//创建遮罩效果
function createMark(){
	//console.log("createMark...");

	if ($.blockUI===undefined) {
		$.blockUI = common.blockUI;
	} 

	$.blockUI({ message: "系统处理中，请等待...",css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
        opacity: .5, 
        color: '#fff' 
    }});
}

$(function(){
	
	//每个页面的表单都可以添加一个notBindDefaultEvent属性，true表示不使用这个默认的绑定提交事件，而是自己去实现表单提交事件
	var notBindDefaultEvent = $("form").attr("notBindDefaultEvent");
//	console.log("notBindDefaultEvent="+notBindDefaultEvent);
	if(!notBindDefaultEvent || notBindDefaultEvent!="true"){
//		console.log("notBindDefaultEvent2="+notBindDefaultEvent);
		
		//通用按钮的提交表单事件
		try{
			if( $("#defaultForm") && $("#defaultForm").length > 0){
				console.log("defaultForm....");
				//排除conn.jsp页面的form表单提交，写的好差劲。。先这样。。。
				$("#defaultForm").on("valid.form", function(e, form){
					console.log("valid...");
					//createMark();
					
					//form.submit();
				});
			}else{
				$("form").on("valid.form", function(e, form){
					console.log("valid...");
					createMark();
					
					form.submit();
				});
				
				//表单验证失败
				$('form').on('invalid.form', function(e, form, errors){
					console.log("表单验证失败...");
					console.log(e);
					console.log(form);
					console.log(errors);
				    //do something...
					if(window.invalidFormFunc){
						invalidFormFunc();
					}
				});
			}
			
		}catch(e){
			console.log(e);
		}
	}
});

(function($) {
	var oldHTML = $.fn.html;
	$.fn.formhtml =function() {
	if (arguments.length) return oldHTML.apply(this,arguments);
		$("input,textarea,button", this).each(function() {
		this.setAttribute('value',this.value);
	});
	$(":radio,:checkbox", this).each(function() {
		if (this.checked) this.setAttribute('checked', 'checked');
		this.removeAttribute('checked');
	});
	$("option", this).each(function() {
		if (this.selected) this.setAttribute('selected', 'selected');
		this.removeAttribute('selected');
	});
	return oldHTML.apply(this);
	};
})(jQuery);