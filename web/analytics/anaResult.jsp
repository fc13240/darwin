<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsResultInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
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
		String id = request.getParameter("id");
		String jobId = request.getParameter("jobId");
		String type = request.getParameter("type");
		if(StringUtils.isBlank(id) || StringUtils.isBlank(jobId)){
			throw new NullPointerException("参数不能为空！");
		}
		UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
		AnalyticsInfo info = AnalyticsServices.selectById(id,user1.getId());
		System.out.println("info.getSql()="+info.getSql());
		String[] sqlArr = info.getSql().split(";");
		int selectSqlCount = 0 , logCount = 0;
		//List<String> arr = new LinkedList<String>();
		System.out.println("sqlArr="+sqlArr.length);				
		
		for(int i=0;i<sqlArr.length;i++){
			if(sqlArr[i].trim().toLowerCase().startsWith("select")){
				selectSqlCount++;
				
				System.out.println("selectSqlCount="+selectSqlCount+",logCount="+logCount);				
// 				if(sqlArr.length==1){
					logCount++;
// 				}

			}else{
				logCount++;
			}
		}
		
		if(logCount > 0){
			selectSqlCount++;
		}
		System.out.println("selectSqlCount="+selectSqlCount+",logCount="+logCount);				
		
		//request.setAttribute("arr", arr);
		
		//加载select查询的结果集和log日志
		System.out.println("jobId="+jobId);
		//if(StringUtils.isNotBlank(jobId)){
			List<AnalyticsResultInfo> anaResultList = AnalyticsResultServices.selectByJobid(jobId);
			System.out.println(anaResultList.size());
// 			System.out.println(anaResultInfo.getResult());
// 			System.out.println(anaResultInfo.getResultFmt());

if(logCount > 0 || anaResultList.size()==1){
	anaResultList.add(anaResultList.get(0));
}
			
			request.setAttribute("anaResultList", anaResultList);
			
			//计算tabs的数量
			request.setAttribute("logCount", logCount);
			request.setAttribute("tabs", anaResultList.size());
			request.setAttribute("type", type);
			request.setAttribute("jobId", jobId);
			
			/*for(int i=0;i<anaResultList.size();i++){
				AnalyticsResultInfo item = anaResultList.get(i);
				if(item.getStatus().equals("fail")){
					selectSqlCount++;
					break;
				}
				selectSqlCount++;
			}*/
		//}
	%>
	<input id="tabs" value="${tabs}" type="hidden"/>
	<input id="logCount" value="${logCount}" type="hidden"/>
	<input id="type" value="${type}" type="hidden"/>
	<input id="jobId" value="${jobId}" type="hidden"/>
	
	
    <div id="myTabContent2" class="tab-content">
    	<div class="row">
				<ul id="myTab2" class="nav nav-tabs" role="tablist2">
			    	<c:forEach var="item" items="${anaResultList}" varStatus="status">
					      <li title="${item.sql}" role="presentation2" <c:if test='${status.index eq 0}'> class="active" </c:if> ><a href="#result_home_${status.index}" id="result_home_${status.index}-tab" role="tab2" data-toggle="tab" aria-controls="result_home2" aria-expanded="true">分析${status.index}</a>
					      </li>
			    	</c:forEach>
			    </ul>
			    <div class="tab-content">
			    	<%int n=0; %>
				    <c:forEach var="item" items="${anaResultList}" varStatus="status">
					    <div role="tabpanel2" class="tab-pane fade active in" id="result_home_${status.index}" aria-labelledby="result_home_${status.index}-tab">
							<div style="margin: 0px;margin-left:20px;" id="searchTable_err_${status.index}"></div>
							<div style="display: none;margin: 0px;">${item.id}</div>
							<div style="display: none;margin: 0px;">${item.jobId}</div>
							<div style="display: none;margin: 0px;" loading="loading">${item.jobId}</div>
			<%-- 				<div style="display: none;">${item.status}</div> --%>
			<%-- 				<div style="display: none;">${item.sql}</div> --%>
			<%-- 				<div style="display: none;">${item.log}</div> --%>
							
							
							<%
							if(n < anaResultList.size()-1 && anaResultList.get(n++).getSql().toLowerCase().startsWith("select")){
							%>
							<div>
					    		<a href="#" sqlId="<%=n%>"  target="_blank"
					    		 onclick="return exportExcel(this)" style="margin: 0px;margin-left: 100px;">导出Excel</a>
					    		<a href="#" sqlId="<%=n%>"  target="_blank"
					    		 onclick="return exportPdf(this)" style="margin: 0px;margin-left: 10px;">导出PDF</a>
					    	</div>
							<%} %>
							
							<table id="searchTable_${status.index}">
							    <tr></tr>
							</table>
							
					    </div>
				    </c:forEach>
				    
			    </div>
		</div>
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

function exportExcel(obj){
	var filepath = $("#_hide_path").text();//"/user/yimr/test_load.log.100m";
	var sqlList = "";
	$("li").each(function(index,value){
		sqlList += $(value).attr("title") + ";";
	});
	
	var id = $(obj).attr("sqlId");
	
<%-- 	$(obj).attr("href","<%=request.getContextPath() %>/analytics?method=exportExcel&sqlList="+sqlList); --%>
	$(obj).attr("href","<%=request.getContextPath() %>/analytics?method=exportExcel&jobId="+$("#jobId").val()+"&id="+id);
	return true;
}

function exportPdf(obj){
	var filepath = $("#_hide_path").text();//"/user/yimr/test_load.log.100m";
	var sqlList = "";
	$("li").each(function(index,value){
		sqlList += $(value).attr("title") + ";";
	});
	
	var id = $(obj).attr("sqlId");
	
<%-- 	$(obj).attr("href","<%=request.getContextPath() %>/analytics?method=exportExcel&sqlList="+sqlList); --%>
	$(obj).attr("href","<%=request.getContextPath() %>/analytics?method=exportPdf&jobId="+$("#jobId").val()+"&id="+id);
	return true;
}

$(function(){
	
	function showTable(tableID,isLog,_id){
		var parent = $("#" + tableID + "").parent();
		var resultId = parent.find("div:eq(1)").html();
		var resultJobId = parent.find("div:eq(2)").html();
		var d = new Date();
		var _url = '<%=request.getContextPath() %>/analytics?method=analyticsResult&resultId='+resultId+"&resultJobId="+resultJobId+"&isLog="+isLog+"&d="+d.getTime()+"&linktype="+$("#type").val()+"&id="+_id;
		
		ajaxPolling(parent,_url,tableID,isLog,_id);
	}
	
	var ajaxCount = 0;
	
	//轮询db
	function ajaxPolling(parent,_url,tableID,isLog,_id){
		
// 		console.log(++ajaxCount);
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
// 				$("#searchTable_err_" + _id + '').html("").hide();
// 				console.log("=========ajax.data===========");
// 				console.log(data);
				if(!data || data==''){
// 					console.log("data is null!!!!!!!!!!!!!!!!!!!!!!");
					return;
				}
				
				showTable0(data,tableID,isLog,_url);
				
				if(data["status"]=="running"){
					
					ajaxPolling(parent,_url,tableID,isLog,_id);
					
				}else{
					parent.find("div[loading='loading']").html(""+data["status"]);
					
// 					console.log("status====="+data["status"]);
					if(data["status"]=="success" || data["status"]=="faild"){
						return;
					}
					
					//cancel可能会变状态或不变，需要暂停4秒再次刷新
					if(data["status"]!="cancel"){
						ajaxPolling(parent,_url,tableID,isLog,_id);
					}					
				}
			},
			error:function(){
// 				console.log("加载数据出错！anaResult,_id="+_id);
				
				$("#searchTable_err_" + _id + '').html("加载数据出错！");
				
				ajaxPolling(parent,_url,tableID,isLog,_id);
			}
		});
	}
	
	function showTable0(localData,tableID,isLog,_url){
// 		console.log("showTable0...");
// 		console.log(localData);
		$("#" + tableID + '').attr("_url",_url);
		gridObj = $.fn.bsgrid.init(tableID, {
            pageSizeSelect: false,
            pageAll:true,
            displayBlankRows: false, // single grid setting
            displayPagingToolbarOnlyMultiPages: true, // single grid setting
            localData: localData,
            processUserdata: function (userdata, options) {
//             	console.log("userdata : ");
//             	console.log(userdata);
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
	
	var tabs = $("#tabs").val();
	var logCount = $("#logCount").val();
	
	//if(parseInt(logCount) >= 1){
		//tabs = parseInt(tabs) + 1;
	//}
// 	console.log("tabs="+tabs+",logCount="+logCount);
	var addLogOnce = false;
	for(var i=0;i<tabs;i++){
		if(logCount > 0 && !addLogOnce && i==(tabs-1)){
			showTable("searchTable_" + i,true,i);
			addLogOnce = true;
			continue;
		}
// 		console.log("123");
		showTable("searchTable_" + i ,false,i);
	}
	$('#myTab2 a:last').tab('show');
	$('#myTab2 a:last').html('日志');
	
	$('#myTabs a').click(function (e) {
		  e.preventDefault();
		  $('#myTabs a').each(function(index,value){
// 			  console.log("hide...index="+index+",value="+value);
			  $(this).tab('hide');
		  });
		  $(this).tab('show');
	})
		
});
        
</script>