<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsResultInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsResultServices"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/resources/common.jsp"%>

<!-- grid.simple.min.css, grid.simple.min.js -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script>

<body style="padding-top: 0px;">
	<%
		//根据分析id查询总共的tabs的数量
		String q = request.getParameter("q");
		if(StringUtils.isBlank(q)){
			throw new NullPointerException("参数不能为空！");
		}
	%>
	
	<div role="tabpanel2" class="tab-pane fade active in" id="result_home_${status.index}" aria-labelledby="result_home_${status.index}-tab">
		<div style="display: none;">${item.id}</div>
		<div style="display: none;">${item.jobId}</div>
		<div style="display: none;" loading="loading">${item.jobId}</div>
		<table id="searchTable_${status.index}">
		    <tr></tr>
		</table>
    </div>
</body>

<script type="text/javascript">

var _st = window.setTimeout;
window.setTimeout = function(fRef, mDelay) {
    if (typeof fRef == 'function') {
        var argu = Array.prototype.slice.call(arguments,2);
        var f = (function(){ fRef.apply(null, argu); });
        return _st(f, mDelay);
    }
    return _st(fRef,mDelay);
}

$(function(){
	
	function showTable(tableID,isLog){
		var parent = $("#" + tableID + "").parent();
		var resultId = parent.find("div:eq(0)").html();
		var resultJobId = parent.find("div:eq(1)").html();
		var d = new Date();
		var _url = '<%=request.getContextPath() %>/analytics?method=analyticsResult&resultId='+resultId+"&resultJobId="+resultJobId+"&isLog="+isLog+"&d="+d.getTime();
		
		ajaxPolling(parent,_url,tableID,isLog);
	}
	
	var ajaxCount = 0;
	
	//轮询db
	function ajaxPolling(parent,_url,tableID,isLog){
		console.log(++ajaxCount + ",_url=" + _url);
// 		setTimeout("function(){console.log('1000s');}",1000);
		
		//$('body').everyTime('2s',function(){
		//do something...
		//});
		
		$.ajax({
			url:_url,
			type:"post",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
// 				console.log("=========ajax.data===========");
// 				console.log(data);
				if(!data || data==''){
					console.log("data is null!!!!!!!!!!!!!!!!!!!!!!");
					return;
				}
				
				if(data["success"]==false){
// 					console.log("success..false..");
					parent.find("div[loading='loading']").html(""+data["status"]);
					
// 					console.log("setTimeout..");
					//setTimeout(ajaxPolling,2000,parent,_url,tableID,isLog);
					ajaxPolling(parent,_url,tableID,isLog);
				}else{
					showTable0(data,tableID,isLog);
					
					console.log("status====="+data["status"]);
					
					if(data["status"]!="success" && data["status"]!="fail"){
// 						setTimeout(ajaxPolling,2000,parent,_url,tableID,isLog);
						ajaxPolling(parent,_url,tableID,isLog);
					}
					//cancel可能会变状态或不变，需要暂停4秒再次刷新
					else if(data["status"]!="cancel"){
// 						setTimeout(ajaxPolling,4000,parent,_url,tableID,isLog);
						ajaxPolling(parent,_url,tableID,isLog);
					}
					
				}
			},
			error:function(){
				console.log("加载数据出错！");
			}
		});
	}
	
	function showTable0(localData,tableID,isLog){
		console.log("showTable0...");
		gridObj = $.fn.bsgrid.init(tableID, {
            pageSizeSelect: false,
            pageAll:true,
            displayBlankRows: false, // single grid setting
            displayPagingToolbarOnlyMultiPages: true, // single grid setting
            localData: localData,
            processUserdata: function (userdata, options) {
                $("#" + tableID + ' tr th').remove();
                var dynamic_columns = userdata['dynamic_columns'];
                if(!dynamic_columns){return;}
                var cNum = dynamic_columns.length;
                for (var i = 0; i < cNum; i++) {
                    $("#"+tableID+' tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
                }
            }
        });
	}
	
	showTable("searchTable_0" ,false);
	
// 	var tabs = $("#tabs").val();
// 	var logCount = $("#logCount").val();
	
	//if(parseInt(logCount) >= 1){
		//tabs = parseInt(tabs) + 1;
	//}
// 	console.log("tabs="+tabs+",logCount="+logCount);
// 	var addLogOnce = false;
// 	for(var i=0;i<tabs;i++){
// 		if(logCount > 0 && !addLogOnce && i==(tabs-1)){
// 			showTable("searchTable_" + i,true);
// 			addLogOnce = true;
// 			continue;
// 		}
// 		console.log("123");
// 		showTable("searchTable_" + i ,false);
// 	}
// 	$('#myTab2 a:last').tab('show');
// 	$('#myTab2 a:last').html('日志');
});
        
</script>