$(function(){
	var pagePrivilegeBtns = $("#pagePrivilegeBtns").text();
	console.log("pagePrivilegeBtns:--------------"+pagePrivilegeBtns);
	if($.trim(pagePrivilegeBtns)!=''){
		var btns = pagePrivilegeBtns.split(",");
		console.log("btns:"+btns);
		if(pagePrivilegeBtns.indexOf("save") == -1){
			$("a").each(function(index,value){
				var code = $(value).attr("code");
				if(code == "select"){
					$(value).html("查看");
				}
			});
		}
		
		$("input,button,a").each(function(index,value){
			var code = $(value).attr("code");
// 			console.log("index="+index+",value="+$(value)+",code="+code);
			
			if(code && $.trim(code)!=''){
				setCompDisabled(btns,code,value);
			}
		});
		
	}

	function setCompDisabled(btns,code,codeThis){
		//console.log("setCompDisabled.code="+code);
		var find = false;
		for(var b in btns){
//			console.log("setCompDisabled.code="+code+",b="+btns[b]);
			if(btns[b]==code){
//				console.log("setCompDisabled22.code="+code+",b="+btns[b]);
				find = true;
				break;
			}
		}
		
		if(!find){
//			console.log("setCompDisabled.code="+code+",find="+find);
			$(codeThis).attr("disabled",!find).attr("href","javascript:void(0);");
			$(codeThis).attr("onclick","");
			$(codeThis).css({"cursor":"not-allowed","color":"#999"});
			$(codeThis).off();
		}
	}
});
