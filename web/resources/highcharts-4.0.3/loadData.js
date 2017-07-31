var Api = function(){
	function getLocation(){
		var localObj = window.location;
		var contextPath = localObj.pathname.split("/")[1];
		var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
		var server_context = basePath;
		//console.log(server_context);
		return server_context;
	}
	
	function getStat(func){
		var url = getLocation() + "/api?method=getDateQueue&stageID="+$("#stage_id").val()+"&d="+Math.random();
		//var result = [];
		$.ajax({
				url:url,
				type:"get",
				dataType:"text",
				//async:false,
				success:function(data, textStatus){
					console.log(data);
					func(0,data);
				},
				error:function(){
					console.log("加载数据出错！");
					//result = null;
					func(1,null);
				}
		});
		//return result;
	}
	
	function getOriginal(func){
		var url = getLocation() + "/api?method=getOrigData&stageID="+$("#stage_id").val()+"&d="+Math.random();
		$.ajax({
				url:url,
				type:"get",
				dataType:"text",
				//async:false,
				success:function(data, textStatus){
					console.log(data);
					func(0,data);
				},
				error:function(){
					console.log("加载数据出错！");
					func(1,null);
				}
		});
	}
	
	function getFieldsString(func){
		var window_id = $("#window_id").val();
		var p_stageid = $("#p_stageid").val();
		var spl = $("#sql").val();
		var type = "ds";
		var pid = window_id;
		if(p_stageid==''){
			type = "stage";
			pid = p_stageid;
		}
		var url = getLocation() + "/api?method=getFieldsString&type="+type+"&pid="+pid+"&spl="+spl+"&d="+Math.random();
		$.ajax({
				url:url,
				type:"get",
				dataType:"text",
				//async:false,
				success:function(data, textStatus){
					console.log(data);
					func(0,data);
				},
				error:function(){
					console.log("加载数据出错！");
					func(1,null);
				}
		});
	}
	
	function getDsOrigData(dsID,func){
		//var dsID = $("#dsID").val();
		var url = getLocation() + "/api?method=getDsOrigData&dsID="+dsID+"&d="+Math.random();
		$.ajax({
				url:url,
				type:"get",
				dataType:"text",
				//async:false,
				success:function(data, textStatus){
					console.log(data);
					func(0,data);
				},
				error:function(){
					console.log("加载数据出错！");
					func(1,null);
				}
		});
	}
	
	return {
		getStat:getStat,
		getOriginal:getOriginal,
		getFieldsString:getFieldsString,
		getDsOrigData:getDsOrigData
	};
};