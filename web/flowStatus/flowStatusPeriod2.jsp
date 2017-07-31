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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/flowStatus/css/css.css" />
<title>流程监控周期性历史详情</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	<%request.setAttribute("topId", "41");%>
	<form action="<%=request.getContextPath()%>/flowStatus?method=index"
		method="post" class="form-horizontal" role="form">
		<div class="page-header"> 
 			<div class="row"> 
 				<div class="col-xs-6 col-md-6"> 
 					<a href="flowStatus?method=history2&flowId=${pager.params.flowId}&period=${pager.params.period}" class="btn btn-primary btn-xs" role="button">刷新</a>&nbsp;
 					<a target="_blank" href="<%=request.getContextPath() %>flowStatus?method=history&flowId=${pager.params.flowId}" class="btn btn-primary btn-xs" role="button">查看监控历史</a> 
 				</div> 
 			</div> 
 		</div> 
		<div class="container mh500">
			<div class="row">
				<c:if test="${pager.total == 0}">对不起，暂时没有监控日志！请刷新重试！如果刷新仍没有日志，请联系系统管理员检查您的服务是否正常。</c:if>
				<c:if test="${pager.total > 0}">
					<c:forEach var="stu" items="${pager.list}">
						<div class="col-md-12">
							<div class="page-header-desc">流程执行详细信息</div>
							<table class="table table-hover table-striped">
								<thead>
									<tr>
										<th style="width: 160px;">运行周期</th>
										<th style="width: 160px;">状态</th>
										<th style="width: 160px;">开始时间</th>
										<th style="width: 160px;">结束时间</th>
										<th style="width: 100px;">耗时</th>
										<th style="width: 80px;">操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="_period">${stu.period }</td>
										<td>
											<c:choose>
												<c:when test="${stu.periodStatus eq 'running'}">
													<span id="_htmlStatus01" class="label label-warning">正在执行...</span>
												</c:when>
												<c:when test="${stu.periodStatus eq 'success'}">
													<span id="_htmlStatus01" class="label label-success">执行结束！</span>
												</c:when>
												<c:when test="${stu.periodStatus eq 'failed'}">
													<span id="_htmlStatus01" class="label label-danger">执行失败！</span>
												</c:when>
												<c:when test="${stu.periodStatus eq 'wait'}">
													<span id="_htmlStatus01" class="label label-warning">等待运行.....</span>
												</c:when>
												<c:otherwise>
													<span id="_htmlStatus01" class="label label-warning">正在为您取消！请稍候...</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td id="_runTimeMin">${stu.runTimeMin }</td>
										<td id="_stopTimeMax">${stu.stopTimeMax }</td>
										<td id="_costTime">${stu._costTime }</td>
										<td><a href="flowStatus?method=history&flowId=${stu.flowId}&period=${stu.period}"  target="_blank" >到监控详情页面</a></td>
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
												<div id="barboxId" style="width:${stu._progressBar }%" class="barSuccess"></div>
											</dd>
										</dl>
									</div>
								</div>
							<table class="table table-hover table-striped">
								<c:forEach var="stu" items="${stu.flowCompList}">
									<tr>
										<td style="width: 10px;">
											<c:choose>
												<c:when test="${stu.status eq 'wait'}">
													<span id="status_${stu.flowCompId }" style='color:yellow' class='glyphicon glyphicon-time'></span>
												</c:when>
												<c:when test="${stu.status eq 'running'}">
													<div id="status_${stu.flowCompId }" ><img src='<%=request.getContextPath() %>/resources/images/loading.gif'></div>
												</c:when>
												<c:when test="${stu.status eq 'success'}">
													<span id="status_${stu.flowCompId }" style='color:green' class='glyphicon glyphicon-ok'></span>
												</c:when>
												<c:otherwise>
													<span id="status_${stu.flowCompId }" style='color:red' class='glyphicon glyphicon-remove'></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<span>组件：<span class="label label-info">${stu.flowCompId}_${stu.flowCompName}</span>&nbsp;&nbsp;
												<span id="time_${stu.flowCompId }">
													<span>&nbsp;&nbsp;开始时间：${stu.runTime}</span>
													<span>&nbsp;&nbsp;结束时间：${stu.stopTime}</span>
													<span>&nbsp;&nbsp;耗时：${stu._costTime}</span>
												</span>
											</span><br>
											<div id="open${stu.flowCompId }"><a onclick="moreLogs(${pager.params.flowId },${stu.flowCompId },'${pager.params.period }');">点击展开更多日志...</a></div>
											<div id="close${stu.flowCompId }" style="display:none;"><a onclick="closeLogs(${stu.flowCompId });" >点击收起</a></div>
											<div id="wait${stu.flowCompId }" style="display:none;">正在为您加载...<img src='<%=request.getContextPath() %>/resources/images/waitLog.gif'></div>
											<input type="hidden" id="ff${stu.flowCompId }" name="ff${stu.flowCompId }"/>
											<span id="dbLog${stu.flowCompId }"></span>
											<div id="show${stu.flowCompId }" ></div>
											<div id="showclick${stu.flowCompId }">
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</c:forEach>
				</c:if>
			</div>
	</form>
</body>
<script>
$(function(){
	setTimeout("random()",1000);
});

function random(){
		
		$.ajax({
			type:"post",
			dataType:"json",
// 			async:true,
			url:"<%=request.getContextPath() %>/flowStatus?method=showLog&id=${pager.params.flowId}&periodFlag=${pager.params.periodFlag}",
			success:function(data){
			try{
				
// 				console.log(data);
				if(!data || data==''){
					
					return;
				}
				
				$.each(data,function(index,item){

					var error = item["error"];
					if(error == "0" ){
						var _htmltotal ="";
						var _htmlLog = "";
						var _htmlStatus = "";
						var _htmlTime = "";
						var _htmlStatus01 = "";
						var _status = item["status"];
						var periodStatus = item["periodStatus"];
						var period = item["period"];
						var _id = item["flowCompId"];
						var _dblog = item["dblog"];
						var _log = item["log"];
						var _logSize = item["logSize"];
						var _progressBar = item["_progressBar"];
						var showdiv = _id;
						var _runTimeMin = item["runTimeMin"];
						var _stopTimeMax = item["stopTimeMax"];
						var _costTime = item["_costTime"];
						if(periodStatus=="running"){
							$("#_htmlStatus01").attr("class","label label-warning");
							$("#_htmlStatus01").html("正在执行...");
						}else if(periodStatus=="success"){
							$("#_htmlStatus01").attr("class","label label-success");
							$("#_htmlStatus01").html("执行结束！");
						}else if(periodStatus=="failed"){
							$("#_htmlStatus01").attr("class","label label-danger");
							$("#_htmlStatus01").html("执行失败！");
						}else if(periodStatus=="wait"){
							$("#_htmlStatus01").attr("class","label label-warning");
							$("#_htmlStatus01").html("等待运行.....");
						}else {
							$("#_htmlStatus01").attr("class","label label-warning");
							$("#_htmlStatus01").html("正在为您取消！请稍候...");
						}
						_htmltotal = "<span style='font-size:10px;font-weight:bold;'>已经完成"+item["_overSize"]+"个组件(共"+item["_flowCompListSize"]+"个)。</span><br>";
						
						if(_status=="wait"){
							$("#status_"+showdiv+"").attr("style","color:yellow");
							$("#status_"+showdiv+"").attr("class","glyphicon glyphicon-time");
							$("#status_"+showdiv+"").html("");
						}else if (_status=="success"){
							$("#status_"+showdiv+"").attr("style","color:green");
							$("#status_"+showdiv+"").attr("class","glyphicon glyphicon-ok");
							$("#status_"+showdiv+"").html("");
						}else if(_status=="failed"){
							$("#status_"+showdiv+"").attr("style","color:red");
							$("#status_"+showdiv+"").attr("class","glyphicon glyphicon-remove");
							$("#status_"+showdiv+"").html("");
						}else{
							$("#status_"+showdiv+"").attr("style","");
							$("#status_"+showdiv+"").attr("class","");
							$("#status_"+showdiv+"").html("<img src='<%=request.getContextPath() %>/resources/images/loading.gif'>");
						}
						_htmlTime += "<span>&nbsp;&nbsp;开始时间："+item["runTime"]+"</span>";
						_htmlTime += "<span>&nbsp;&nbsp;结束时间："+item["stopTime"]+"</span>";
						_htmlTime += "<span>&nbsp;&nbsp;耗时："+item["flowCompCostTime"]+"</span>";
	// 					if(_status!="wait"){
	// 						if(_logSize<500){
	// 							_htmlLog += "<div>" +_log.replace(/\n/g,'</br>')+ "</div>";
	// 						}else{
	// 							_htmlLog += "<div style='height:200px;overflow:auto;' id='logTest"+_id+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
	// 						}
	// 					}
						var _htmlDbLog ="";
						if(_dblog!=null || _dblog!=""){
							_htmlDbLog =_dblog.replace(/\n/g,'</br>');
						}
						$("#time_"+showdiv+"").html(_htmlTime);
						$("#show"+showdiv+"").html(_htmlLog);
	// 					$("#logTest"+_id).scrollTop(250);
						$("#_htmltotal").html(_htmltotal);
						$("#_stopTimeMax").html(_stopTimeMax);
						$("#_runTimeMin").html(_runTimeMin);
						$("#_period").html(period);
						if(_costTime!=""){
							$("#_costTime").html(_costTime);
						}
						$("#dbLog"+showdiv+"").html(_htmlDbLog);
						if(periodStatus=="failed"){
							$("#barboxId").attr("style","width:"+item["_progressBar"]+"%");
							$("#barboxId").attr("class","barfailed");
						}else{
							$("#barboxId").attr("style","width:"+item["_progressBar"]+"%");
							$("#barboxId").attr("class","barSuccess");
						}
						if(period=="once"){
							if(_status=="running" || _status=="wait"){
								setTimeout("random()",1000);
							}
						}else{
							setTimeout("random()",1000);
						}
					}
				});
				
			}catch(err){
// 				console.log(err);
			}
		
		},
		error:function(err){
			setTimeout("random()",1000);
// 			console.log(err);
// 			console.log("加载数据出错！");
		}
		});
	}

</script>
<script type="text/javascript">

var offset = 0;

function moreLogs(_id,_flowCompId,_period){
	
	$("#wait"+_flowCompId).attr("style","");
	var _url = '<%=request.getContextPath() %>/flowStatus?method=showLogClick01';
	_url += "&offset=-1";
	$.ajax({
		url:_url,
		type:"post",
		data:{id:_id,flowCompId:_flowCompId,period:_period},
		dataType:"json",
		success:function(data, textStatus){
			var _key = data["key"];
			var _log = data["log"];
			var _htmlLog = "";
			if(_key=="0"){
				var _logSize = data["logSize"];
				$("#open"+_flowCompId).attr("style","display:none;");
				$("#close"+_flowCompId).attr("style","");
				_htmlLog +="<div style='border: 1px solid;width: 92%;'>";
				if(_logSize>=10240){
					_htmlLog +="<div id='buttons' style='padding:5px 10px;'>";
					_htmlLog +="跳过指定字节数(*默认-1是从末页往前的10240字节)：<input type='text' value='-1' id='offset"+_flowCompId+"'/>";
					_htmlLog +="<input type='button' value='首页' onclick='first("+_id+","+_flowCompId+",\""+_period+"\");'/>";
					_htmlLog +="<input type='button' value='上一页' onclick='sub("+_id+","+_flowCompId+",\""+_period+"\");'/>";
					_htmlLog +="<input type='button' value='下一页' onclick='next("+_id+","+_flowCompId+",\""+_period+"\");'/>";
					_htmlLog +="<input type='button' value='末页' onclick='last("+_id+","+_flowCompId+",\""+_period+"\");' /></div>";
				}
				_htmlLog += "<div style='padding:5px 10px;height:200px;overflow:auto;' id='logTest"+_flowCompId+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
				_htmlLog += "</div>";
			}else{
				_htmlLog += _log;
			}
			$("#showclick"+_flowCompId).html(_htmlLog);
			$("#wait"+_flowCompId).attr("style","display:none;");
			document.getElementById("ff"+_flowCompId).focus(); 
		},
		error:function(err){
		}
	});
}

function cat(_id,_flowCompId,_period){
	offset = $("#offset"+_flowCompId).val();
	var _url = '<%=request.getContextPath() %>/flowStatus?method=showLogClick01';
	_url += "&offset="+offset;
	$.ajax({
		url:_url,
		type:"post",
		data:{id:_id,flowCompId:_flowCompId,period:_period},
		dataType:"json",
		success:function(data, textStatus){
			var _key = data["key"];
			var _log = data["log"];
			var _htmlLog = "";
			if(_key=="0"){
				$("#open"+_flowCompId).attr("style","display:none;");
				$("#close"+_flowCompId).attr("style","");
				_htmlLog +="<div style='border: 1px solid;'>";
				_htmlLog +="<div id='buttons' style='padding:5px 10px'>";
				_htmlLog +="跳过指定字节数(*默认-1是从末页往前的10240字节)：<input type='text' value='"+offset+"' id='offset"+_flowCompId+"'/>";
				_htmlLog +="<input type='button' value='首页' onclick='first("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='上一页' onclick='sub("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='下一页' onclick='next("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='末页' onclick='last("+_id+","+_flowCompId+",\""+_period+"\");' /></div>";
				_htmlLog += "<div style='padding:5px 10px;width: 100%;height:200px;overflow:auto;' id='logTest"+_flowCompId+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
				_htmlLog += "</div>";
			}else{
				_htmlLog += _log;
			}
			$("#showclick"+_flowCompId).html(_htmlLog);
			document.getElementById("ff"+_flowCompId).focus(); 
		},
		error:function(err){
		}
	});
}


function first(_id,_flowCompId,_period){
	var _url = '<%=request.getContextPath() %>/flowStatus?method=showLogClick01';
	_url += "&offset=0";
	$.ajax({
		url:_url,
		type:"post",
		data:{id:_id,flowCompId:_flowCompId,period:_period},
		dataType:"json",
		success:function(data, textStatus){
			var _key = data["key"];
			var _log = data["log"];
			var _htmlLog = "";
			if(_key=="0"){
				$("#open"+_flowCompId).attr("style","display:none;");
				$("#close"+_flowCompId).attr("style","");
				_htmlLog +="<div style='border: 1px solid;'>";
				_htmlLog +="<div id='buttons' style='padding:5px 10px'>";
				_htmlLog +="跳过指定字节数(*默认-1是从末页往前的10240字节)：<input type='text' value='0' id='offset"+_flowCompId+"'/>";
				_htmlLog +="<input type='button' value='首页' onclick='first("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='上一页' onclick='sub("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='下一页' onclick='next("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='末页' onclick='last("+_id+","+_flowCompId+",\""+_period+"\");' /></div>";
				_htmlLog += "<div style='padding:5px 10px;width: 100%;height:200px;overflow:auto;' id='logTest"+_flowCompId+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
				_htmlLog += "</div>";
			}else{
				_htmlLog += _log;
			}
			$("#showclick"+_flowCompId).html(_htmlLog);
			document.getElementById("ff"+_flowCompId).focus(); 
		},
		error:function(err){
		}
	});
}


function sub(_id,_flowCompId,_period){
	offset = $("#offset"+_flowCompId).val();
	offset = parseInt(offset) - 1024*10;
	if(offset <= 0){
		offset = 0;
	}
	var _url = '<%=request.getContextPath() %>/flowStatus?method=showLogClick01';
	_url += "&offset="+offset;
	$.ajax({
		url:_url,
		type:"post",
		data:{id:_id,flowCompId:_flowCompId,period:_period},
		dataType:"json",
		success:function(data, textStatus){
			var _key = data["key"];
			var _log = data["log"];
			var _htmlLog = "";
			if(_key=="0"){
				$("#open"+_flowCompId).attr("style","display:none;");
				$("#close"+_flowCompId).attr("style","");
				_htmlLog +="<div style='border: 1px solid;'>";
				_htmlLog +="<div id='buttons' style='padding:5px 10px'>";
				_htmlLog +="跳过指定字节数(*默认-1是从末页往前的10240字节)：<input type='text' value='"+offset+"' id='offset"+_flowCompId+"'/>";
				_htmlLog +="<input type='button' value='首页' onclick='first("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='上一页' onclick='sub("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='下一页' onclick='next("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='末页' onclick='last("+_id+","+_flowCompId+",\""+_period+"\");' /></div>";
				_htmlLog += "<div style='padding:5px 10px;width: 100%;height:200px;overflow:auto;' id='logTest"+_flowCompId+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
				_htmlLog += "</div>";
			}else{
				_htmlLog += _log;
			}
			$("#showclick"+_flowCompId).html(_htmlLog);
			document.getElementById("ff"+_flowCompId).focus(); 
		},
		error:function(err){
		}
	});
}


function next(_id,_flowCompId,_period){
	offset = $("#offset"+_flowCompId).val();
	if(offset != -1){
		offset = parseInt(offset) + 1024*10;;
		var _url = '<%=request.getContextPath() %>/flowStatus?method=showLogClick01';
		_url += "&offset="+offset;
		$.ajax({
			url:_url,
			type:"post",
			data:{id:_id,flowCompId:_flowCompId,period:_period},
			dataType:"json",
			success:function(data, textStatus){
				var _key = data["key"];
				var _log = data["log"];
				var _htmlLog = "";
				if(_key=="0"){
					$("#open"+_flowCompId).attr("style","display:none;");
					$("#close"+_flowCompId).attr("style","");
					_htmlLog +="<div style='border: 1px solid;'>";
					_htmlLog +="<div id='buttons' style='padding:5px 10px'>";
					_htmlLog +="跳过指定字节数(*默认-1是从末页往前的10240字节)：<input type='text' value='"+offset+"' id='offset"+_flowCompId+"'/>";
					_htmlLog +="<input type='button' value='首页' onclick='first("+_id+","+_flowCompId+",\""+_period+"\");'/>";
					_htmlLog +="<input type='button' value='上一页' onclick='sub("+_id+","+_flowCompId+",\""+_period+"\");'/>";
					_htmlLog +="<input type='button' value='下一页' onclick='next("+_id+","+_flowCompId+",\""+_period+"\");'/>";
					_htmlLog +="<input type='button' value='末页' onclick='last("+_id+","+_flowCompId+",\""+_period+"\");' /></div>";
					_htmlLog += "<div style='padding:5px 10px;width: 100%;height:200px;overflow:auto;' id='logTest"+_flowCompId+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
					_htmlLog += "</div>";
				}else{
					_htmlLog += _log;
				}
				$("#showclick"+_flowCompId).html(_htmlLog);
				document.getElementById("ff"+_flowCompId).focus(); 
			},
			error:function(err){
			}
		});
	}
	
}

function last(_id,_flowCompId,_period){
	
	var _url = '<%=request.getContextPath() %>/flowStatus?method=showLogClick01';
	_url += "&offset=-1";
	$.ajax({
		url:_url,
		type:"post",
		data:{id:_id,flowCompId:_flowCompId,period:_period},
		dataType:"json",
		success:function(data, textStatus){
			var _key = data["key"];
			var _log = data["log"];
			var _htmlLog = "";
			if(_key=="0"){
				$("#open"+_flowCompId).attr("style","display:none;");
				$("#close"+_flowCompId).attr("style","");
				_htmlLog +="<div style='border: 1px solid;'>";
				_htmlLog +="<div id='buttons' style='padding:5px 10px'>";
				_htmlLog +="跳过指定字节数(*默认-1是从末页往前的10240字节)：<input type='text' value='-1' id='offset"+_flowCompId+"'/>";
				_htmlLog +="<input type='button' value='首页' onclick='first("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='上一页' onclick='sub("+_id+","+_flowCompId+",\""+_period+"\");'/>";
				_htmlLog +="<input type='button' value='下一页' onclick='next("+_id+","+_flowCompId+",\""+_period+"\");'/>";				_htmlLog +="<input type='button' value='末页' onclick='last("+_id+","+_flowCompId+",\""+_period+"\");' /></div>";
				_htmlLog += "<div style='padding:5px 10px;width: 100%;height:200px;overflow:auto;' id='logTest"+_flowCompId+"'>" +_log.replace(/\n/g,'</br>')+ "</div>";
				_htmlLog += "</div>";
			}else{
				_htmlLog += _log;
			}
			$("#showclick"+_flowCompId).html(_htmlLog);
			document.getElementById("ff"+_flowCompId).focus(); 
		},
		error:function(err){
		}
	});
}

function closeLogs(_flowCompId){
	$("#showclick"+_flowCompId).html("");
	$("#open"+_flowCompId).attr("style","");
	$("#close"+_flowCompId).attr("style","display:none;");
	document.getElementById("ff"+_flowCompId).focus(); 
}

</script>
</html>