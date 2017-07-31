<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.FlowStatusServices"%>
<%@page import="com.stonesun.realTime.services.db.FlowServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowInfo"%>
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
<script src="<%=request.getContextPath() %>/resources/My97DatePicker/WdatePicker.js"></script>
<title>流程监控历史</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	
	<%request.setAttribute("topId", "41");%>
	<%
		String flowId = request.getParameter("flowId");
		boolean displayStatus = false;
		if(StringUtils.isNotBlank(flowId)){
			FlowInfo info =  FlowServices.selectById(Integer.valueOf(flowId));
			if(info!=null){
				if("online".equals(info.getStatus())
						&& StringUtils.isNotBlank(info.getPeriodType())
						&& !"rt".equals(info.getPeriodType())){
					displayStatus=true;
				}
			}
		}
		request.setAttribute("displayStatus", displayStatus);
	%>
	<form action="<%=request.getContextPath() %>/flowStatus?method=index" method="post" id="historyform" class="form-horizontal" role="form">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
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
			<div class="col-md-9">
				<div class="page-header">
					<ol class="breadcrumb">
						<li><a href="<%=request.getContextPath() %>/flowStatus?method=index">流程监控列表</a></li>
						<li class="active">流程名称【${pager.params.flowName}】</li>
						<li class="active">所有周期</li>
						<li class="active">
							<a href="/flow/init.jsp?id=${pager.params.flowId}" class="btn btn-primary btn-xs" role="button">返回流程</a>
						</li>
					</ol>
					<input id="flowId" type="hidden" value="${pager.params.flowId}"></input>
					<div class="page-header-op r">
						<select id="period" name="period" class="form-control">
							<%
								session.setAttribute("periodList", FlowStatusServices.selectPeriods(request.getParameter("flowId")));
							%>
							<option value="">--选择周期--</option>
							<c:forEach items="${periodList}" var="list">
					           <option value="${list.period}">${list.period}</option>
					        </c:forEach>
						</select>
					</div>
					<div class="page-header-op r">
						&nbsp;&nbsp;
					</div>
					<div class="page-header-op r">
						<c:if test="${displayStatus}">
							<button code="save" id="saveHdfsConfigBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
								补充周期
							</button>
						</c:if>
					</div>
					<div class="clear"></div>
				</div>
				<div>当前找到 ${pager.total} 个周期的监控历史</div>
				<p>
				</p>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>周期</th>
							<th style="width: 170px;">执行时间</th>
							<th style="width: 170px;">结束时间</th>
							<th>状态</th>
							<th style="width: 180px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td>${stu.period}</td>
								<td id="runTime${stu.period}">${stu.runTime}</td>
								<td id="stopTime${stu.period}">${stu.stopTime}</td>
								<td id="complist-${pager.params.flowId}">
									<c:forEach items="${stu.flowCompList}" var="item">
							           	  组件：${item.flowCompId}/${item.flowCompName}
							           	  <c:choose>
											<c:when test="${item.status eq 'success' }">
												<span id="label${stu.period}${item.flowCompId}" class="label label-success">成功</span>
											</c:when>
											<c:when test="${item.status eq 'running' }">
												<span id="label${stu.period}${item.flowCompId}" class="label label-warning">执行中..</span>
											</c:when>
											<c:when test="${item.status eq 'wait' }">
												<span id="label${stu.period}${item.flowCompId}" style='color:yellow' class='glyphicon glyphicon-time'>等待运行</span>
											</c:when>
											<c:when test="${item.status eq 'canceling' }">
												<span id="label${stu.period}${item.flowCompId}" class="label label-warning">取消中..</span>
											</c:when>
											<c:otherwise><span id="label${stu.period}${item.flowCompId}" class="label label-danger">失败</span></c:otherwise>
										</c:choose>
										<br>
							        </c:forEach>
								</td>
								<td>
									<input value="${stu.flowId}" name="flowId" id="flowId" type="hidden"/>
									<input value="${stu.periodStatus}" name="periodStatus${stu.period}" id="periodStatus${stu.period}" type="hidden"/>
									<input value="${stu.period}" name="period" id="period" type="hidden"/>
									<a href="flowStatus?method=history&flowId=${pager.params.flowId}&period=${stu.period}">查看该周期详细日志</a>
									<br> <a code="save" id="run${stu.period}" onclick="run(${pager.params.flowId},'${stu.period}','${stu.periodStatus}');">立即执行</a>
									<br> <a code="save" id="kill${stu.period}" onclick="kill(${pager.params.flowId},'${stu.period}','${stu.periodStatus}');" >立即停止</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
				<div>
					<%@ include file="/resources/pager.jsp"%>
				</div>
			</div>
		</div>
	</div>
	</form>
<%@ include file="/flowStatus/addperiod.jsp"%>
<%-- <c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script type="text/javascript">
	function run(_id,_period,_periodStatus){
		var runId=$("#run"+_period);
		var _text = "";
		var _href="<%=request.getContextPath() %>flowStatus?method=history&flowId="+${pager.params.flowId}
		var _url = '<%=request.getContextPath() %>/flowStatus?method=run';
		if(_periodStatus=='running'){
			_text="正在执行中"
		}else if(_periodStatus=='wait'){
			_text="正在等待中"
		}else if(_periodStatus=='canceling'){
			_text="正在取消中"
		}else{
			createMark();
			$.ajax({
				url:_url,
				type:"post",
				data:{id:_id,period:_period},
				dataType:"json",
				success:function(data, textStatus){
					common['$'].unblockUI();
					var key = data["key"];
					if(key == "0"){
						_text = "发送成功！";
						var value = data["value"];
						var runTime = data["runTime"];
						var stopTime = data["stopTime"];
						var _d = data["compList"];
						$.each(_d,function(index,item){
							var compId = item["compId"];
							var status = item["status"];

							var _html = "";
							if(status == 'success'){
								$("#label"+_period+compId).attr("class","label label-success");
								$("#label"+_period+compId).text("成功");
								$("#label"+_period+compId).attr("style","");
							}else if (status == 'running'){
								$("#label"+_period+compId).attr("class","label label-warning");
								$("#label"+_period+compId).text("执行中..");
								$("#label"+_period+compId).attr("style","");
							}else if (status == 'wait'){
								$("#label"+_period+compId).attr("class","glyphicon glyphicon-time");
								$("#label"+_period+compId).attr("style","color:yellow");
								$("#label"+_period+compId).text("等待运行");
							}else if (status == 'canceling'){
								$("#label"+_period+compId).attr("class","label label-warning");
								$("#label"+_period+compId).text("取消中..");
								$("#label"+_period+compId).attr("style","");
							}else{
								$("#label"+_period+compId).attr("class","label label-danger");
								$("#label"+_period+compId).text("失败");
								$("#label"+_period+compId).attr("style","");
							}

						});
						$("#periodStatus"+_period).val(value);
						$("#runTime"+_period).text(runTime);
						$("#stopTime"+_period).text(stopTime);
						$("#run"+_period).attr("onclick","run('"+_id+"','"+_period+"','"+value+"');");
						$("#kill"+_period).attr("onclick","kill('"+_id+"','"+_period+"','"+value+"');");

					}else if(key == "2"){
						_text = "操作失败！无可用节点！";
					}else if(key == "1"){
						var value = data["value"];
						if(value == "node_not_used"){
							_text = "操作失败！节点已失联！";
						}else if(value == "flowInfo_offline"){
							_text = "操作失败！该流程已经取消部署！";
						}else if(value == "flowInfo_null"){
							_text = "操作失败！该流程已经被删除！";
						}else{
							_text = value;
						}
					}else if(key == "-1"){
						_text = "执行失败！";
					}else{
						_text = "执行失败！";
					}

					if(_text){
						layer.tips(_text, '#run'+_period, {
						    tips: [1, '#3595CC'],
						    time: 2000
						});
					}
				},
				error:function(err){
					console.log("加载数据出错！");
					common['$'].unblockUI();

					layer.tips('执行流程出现异常！', '#run'+_period, {
					    tips: [1, '#3595CC'],
					    time: 2000
					});
				}
			});
		}
		if(_text){
			layer.tips(_text, '#run'+_period, {
			    tips: [1, '#3595CC'],
			    time: 2000
			});
		}

	}

	function kill(_id,_period,_periodStatus){
		var _text = "";

		var _url = '<%=request.getContextPath() %>/flowStatus?method=kill';
		if(_periodStatus=='success'){
			_text="已经执行成功，无需取消"
		}else if(_periodStatus=='failed' && $('#complist-'+_id).find('.label-warning').length==0){
			_text="执行失败，无需取消"
		}else if(_periodStatus=='canceling'){
			_text="正在取消中"
		}else{
			createMark();
			$.ajax({
				url:_url,
				type:"post",
				data:{id:_id,period:_period},
				dataType:"json",
				success:function(data, textStatus){
// 					console.log(">>>data = "+data);
					common['$'].unblockUI();
					var key = data["key"];
					if(key == "0"){
						_text = "发送停止成功！";
						var value = data["value"];
						var _d = data["compList"];
						$.each(_d,function(index,item){
							var compId = item["compId"];
							var status = item["status"];

							var _html = "";
							if(status == 'success'){
								$("#label"+_period+compId).attr("class","label label-success");
								$("#label"+_period+compId).text("成功");
							}else if (status == 'running'){
								$("#label"+_period+compId).attr("class","label label-warning");
								$("#label"+_period+compId).text("执行中..");
							}else if (status == 'wait'){
								$("#label"+_period+compId).attr("class","glyphicon glyphicon-time");
								$("#label"+_period+compId).text("等待运行");
							}else if (status == 'canceling'){
								$("#label"+_period+compId).attr("class","label label-warning");
								$("#label"+_period+compId).text("取消中..");
							}else{
								$("#label"+_period+compId).attr("class","label label-danger");
								$("#label"+_period+compId).text("失败");
							}
						});

						$("#periodStatus"+_period).val(value);
						$("#run"+_period).attr("onclick","run('"+_id+"','"+_period+"','"+value+"');");
						$("#kill"+_period).attr("onclick","kill('"+_id+"','"+_period+"','"+value+"');");

					}else if(key == "2"){
						_text = "操作失败！无可用节点！";
					}else if(key == "1"){
						var value = data["value"];
						if(value == "node_not_used"){
							_text = "操作失败！节点已失联！";
						}else if(value == "flowInfo_offline"){
							_text = "操作失败！该流程已经取消部署！";
						}else if(value == "flowInfo_null"){
							_text = "操作失败！该流程已经被删除！";
						}else{
							_text = value;
						}
					}else if(key == "-1"){
						_text = "停止失败！";
					}else{
						_text = "停止失败！";
					}

					if(_text){
						layer.tips(_text, '#kill'+_period, {
						    tips: [1, '#3595CC'],
						    time: 2000
						});
					}
				},
				error:function(err){
					console.log("加载数据出错！");
					common['$'].unblockUI();

					layer.tips('停止流程出现异常！' + err, '#run'+_period, {
					    tips: [1, '#3595CC'],
					    time: 2000
					});

				}
			});
		}
		if(_text){
			layer.tips(_text, '#kill'+_period, {
			    tips: [1, '#3595CC'],
			    time: 2000
			});
		}

	}

	$("#period").change(function(){
		var period=$("#period").val();
		var flowId=$("#flowId").val();
		href = "/flowStatus?method=history&period="+period+"&flowId="+flowId;
		window.location.href=href;
	});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
