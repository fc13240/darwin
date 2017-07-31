<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowStatusInfo"%>
<%@page import="com.stonesun.realTime.services.db.FlowStatusServices"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="/flowStatus/css/css.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>流程监控周期性历史详情</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	
	<%request.setAttribute("topId", "41");%>
	<form action="<%=request.getContextPath()%>/flowStatus?method=index"
		method="post" class="form-horizontal" role="form">
		<input id='flowId' name='flowId' value='' type='hidden'/>
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">流程监控历史</div>
				</div>
			</div>
		</div>
		<div class="container mh500">
			<div class="row">
			<%-- <c:if test="${empty plateform}">
				<div class="col-md-3">
					<%@ include file="/configure/leftMenu.jsp"%>
				</div>
				</c:if> --%>
				<c:forEach var="stu" items="${pager.list}">
					<div class="col-md-9">
						<div class="page-header">
							<div class="row">
								<div class="col-xs-12 col-md-12">
									<ol class="breadcrumb">
										<li><a href="<%=request.getContextPath() %>/flowStatus?method=index">流程监控列表</a></li>
										<li class="active">流程名称【${stu.flowName}】</li>
										<li><a
											href="<%=request.getContextPath() %>/flowStatus?method=history&flowId=${stu.flowId}">所有周期</a></li>
										<li class="active">运行周期:${stu.period }</li>
									</ol>
								</div>
							</div>
							<div class="page-header-op r">
								<a href="/flow/init.jsp?id=${stu.flowId}" class="btn btn-primary btn-xs" role="button">返回流程</a>
							</div>
							<div class="page-header-op r">
								<a href="flowStatus?method=history&flowId=${stu.flowId}&period=${stu.period}" class="btn btn-primary btn-xs" role="button">刷新</a>
								&nbsp;&nbsp;
							</div>
						</div>
						<div class="page-header-desc">流程执行详细信息</div>
						<table class="table table-hover table-striped">
							<thead>
								<tr>
									<th style="width: 180px;">运行周期</th>
									<th style="width: 180px;">状态</th>
									<th style="width: 180px;">开始时间</th>
									<th style="width: 180px;">结束时间</th>
									<th style="width: 100px;">耗时</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${stu.period }</td>
									<td >
										<c:choose>
											<c:when test="${stu.periodStatus eq 'wait'}">
												<span id="_htmlStatus01" class="label label-warning">等待运行</span>
											</c:when>
											<c:when test="${stu.periodStatus eq 'canceling'}">
												<span id="_htmlStatus01" class="label label-warning">正在为您取消！请稍候...</span>
											</c:when>
											<c:when test="${stu.periodStatus eq 'success'}">
												<span id="_htmlStatus01" class="label label-success">执行结束！</span>
											</c:when>
											<c:when test="${stu.periodStatus eq 'failed'}">
												<span id="_htmlStatus01" class="label label-danger">执行失败！</span>
											</c:when>
											<c:otherwise>
												<span id="_htmlStatus01" class="label label-warning">正在执行...</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${stu.runTimeMin }</td>
									<td id="_stopTimeMax">${stu.stopTimeMax }</td>
									<td id="_costTime">${stu._costTime }</td>
								</tr>
							</tbody>
						</table>
							<div class="page-header-desc">组件运行进度</div>
							<span id="_htmltotal">
								<span style='font-size:10px;font-weight:bold;'>已经完成${stu._overSize}个组件(共${stu._flowCompListSize}个)。</span><br>
							</span>
							<div class="votebox" >
								<dl class="barbox">
									<dd class="barline">
										<c:choose>
											<c:when test="${stu.periodStatus eq 'failed'}">
												<div id="barboxId" style="width:${stu._progressBar }%" class="barfailed"></div>
											</c:when>
											<c:otherwise>
												<div id="barboxId" style="width:${stu._progressBar }%" class="barSuccess"></div>
											</c:otherwise>
										</c:choose>
									</dd>
								</dl>
							</div>
						<table class="table table-hover table-striped">
							<c:forEach var="stu" items="${stu.flowCompList}">
								<tr>
									<td style="width: 10px;">
										<div id="status_${stu.flowCompId }" >
											<c:choose>
												<c:when test="${stu.status eq 'wait'}">
													<span style='color:yellow' class='glyphicon glyphicon-time'></span>
												</c:when>
												<c:when test="${stu.status eq 'success'}">
													<span style='color:green' class='glyphicon glyphicon-ok'></span>
												</c:when>
												<c:when test="${stu.status eq 'failed'}">
													<span style='color:red' class='glyphicon glyphicon-remove''></span>
												</c:when>
												<c:otherwise>
													<img src='<%=request.getContextPath() %>/resources/images/loading.gif'>
												</c:otherwise>
											</c:choose>
										</div>
									</td>
									<td>
										<span>组件：<span class="label label-info">${stu.flowCompId}_${stu.flowCompName}</span>&nbsp;&nbsp;
											<span id="time_${stu.flowCompId }">
												<span>&nbsp;&nbsp;开始时间：${stu.runTime}</span>
												<span>&nbsp;&nbsp;结束时间：${stu.stopTime}</span>
												<span>&nbsp;&nbsp;耗时：${stu._costTime}</span>
											</span>
										</span>
										<br><span>日志详情：${stu.log}</span>
										<a href="/flowStatus?method=showLogClick&id=${stu.flowId}&flowCompId=${stu.flowCompId}&period=${stu.period }">查看更多详细日志</a>
<%-- 										<a onclick="howLogClick(${stu.flowId},${stu.flowCompId},${stu.period})">查看更多详细日志</a> --%>
										<div id="show${stu.flowCompId }" ></div>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</c:forEach>
			</div>
		</div>
	</form>
<%-- 	<c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if> --%>
</body>

<script>
$(function(){
	setTimeout("random()",10);
});

function random(){
		
		$.ajax({
			type:"post",
			dataType:"json",
			url:"<%=request.getContextPath() %>/flowStatus?method=showLogPeriod&id=${pager.params.flowId}&period=${pager.params.period}",
			success:function(data){
				try{
					
// 					console.log(data);
					if(!data || data==''){
						return;
					}
					
					$.each(data,function(index,item){
						var _htmltotal ="";
						var _htmlLog = "";
						var _htmlStatus = "";
						var _htmlTime = "";
						var _htmlStatus01 = "";
						var _status = item["status"];
						var periodStatus = item["periodStatus"];
						var _id = item["flowCompId"];
						var _log = item["log"];
						var _logSize = item["logSize"];
						var _progressBar = item["_progressBar"];
						var showdiv = _id;
						var _stopTimeMax = item["stopTimeMax"];
						var _costTime = item["_costTime"];
						_htmltotal = "<span style='font-size:10px;font-weight:bold;'>已经完成"+item["_overSize"]+"个组件(共"+item["_flowCompListSize"]+"个)。</span><br>";
						
						if(periodStatus=="success"){
							$("#_htmlStatus01").attr("class","label label-success");
							$("#_htmlStatus01").html("执行结束！");
						}else if(periodStatus=="failed"){
							$("#_htmlStatus01").attr("class","label label-danger");
							$("#_htmlStatus01").html("执行失败！");
						}else if(periodStatus=="canceling"){
							$("#_htmlStatus01").attr("class","label label-warning");
							$("#_htmlStatus01").html("正在为您取消！请稍候...");
						}else if(periodStatus=="wait"){
							$("#_htmlStatus01").attr("class","label label-warning");
							$("#_htmlStatus01").html("等待运行");
						}else{
							$("#_htmlStatus01").attr("class","label label-warning");
							$("#_htmlStatus01").html("正在执行...");
						}
						
						if(_status=="wait"){
							_htmlStatus += "<span style='color:yellow' class='glyphicon glyphicon-time'></span>";
						}else if (_status=="success"){
							_htmlStatus += "<span style='color:green' class='glyphicon glyphicon-ok'></span>";
						}else if(_status=="failed"){
							_htmlStatus += "<span style='color:red' class='glyphicon glyphicon-remove''></span>";
						}else{
							_htmlStatus += "<img src='<%=request.getContextPath() %>/resources/images/loading.gif'>";
						}
						_htmlTime += "<span>&nbsp;&nbsp;开始时间："+item["runTime"]+"</span>";
						_htmlTime += "<span>&nbsp;&nbsp;结束时间："+item["stopTime"]+"</span>";
						_htmlTime += "<span>&nbsp;&nbsp;耗时："+item["flowCompCostTime"]+"</span>";
						if(_status!="wait"){
							if(_logSize<500){
								_htmlLog += "<div>" +_log.replace(/\n/g,'</br>')+ "</div>";
							}else{
								_htmlLog += "<div style='width: 100%;height:200px;overflow:auto;' id='logTest"+_id+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
							}
						}
						$("#logTest"+_id).scrollTop(250);
						$("#time_"+showdiv+"").html(_htmlTime);
						$("#status_"+showdiv+"").html(_htmlStatus);
						$("#show"+showdiv+"").html(_htmlLog);
						$("#_htmltotal").html(_htmltotal);
						$("#_stopTimeMax").html(_stopTimeMax);
						if(_costTime!=""){
							$("#_costTime").html(_costTime);
						}
						if(periodStatus=="failed"){
							$("#barboxId").attr("style","width:"+item["_progressBar"]+"%");
							$("#barboxId").attr("class","barfailed");
						}else{
							$("#barboxId").attr("style","width:"+item["_progressBar"]+"%");
							$("#barboxId").attr("class","barSuccess");
						}
							
						if(!(periodStatus=="success" || periodStatus=="failed")){
							setTimeout("random()",1000);
						}
					});
					
				}catch(err){
					setTimeout("random()",1000);
// 					console.log(err);
				}
			
			},
			error:function(err){
// 				console.log(err);
				console.log("加载数据出错！");
			}
		});
	}

</script>

</html>