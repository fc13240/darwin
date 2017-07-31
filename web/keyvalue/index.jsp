<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>告警触发列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "137");%>
	<%@ include file="/resources/common_menu.jsp"%>
	<form action="<%=request.getContextPath() %>/user/trigger?method=index" method="post" >
		<!-- page header start -->
		<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
<!-- 		<div class="page-header" style="margin-top: 60px;"> -->
		<div class="page-header" >
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						告警管理
					</div>
<!-- 					<div class="page-header-links"> -->
<!-- 						告警管理列表 -->
<!-- 					</div> -->
				</div>
<!-- 				<div class="col-xs-6 col-md-6"> -->
<!-- 					<div class="page-header-op r"> -->
<%-- 					  <a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/trigger?method=edit">新增告警</a> --%>
<!-- 					</div> -->
<!-- 					<div class="page-header-op r" style="margin: 0 5px;"> -->
<!-- 						<select id="priority" name="priority" class="form-control"> -->
<%-- 						<% --%>
// 							request.setAttribute("taskPriority", DataCache.taskPriority);
<%-- 						%> --%>
<!-- 							<option value="">--选择等级--</option> -->
<%-- 							<c:forEach items="${taskPriority}" var="item"> --%>
<%-- 				           		<option <c:if test='${pager.params.priority == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option> --%>
<%-- 				       	    </c:forEach> --%>
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 					<div class="clear"></div> -->
<!-- 				</div> -->
			</div>
		</div>
		
		<!-- page header end -->	
		<!-- page content start -->
		<div class="container mh500">
			<div class="row">
				<div class="col-md-3">
					<%@ include file="/configure/leftMenu.jsp"%>
				</div>
				<div class="col-md-9">
					<div class="page-header">
						<div class="row">
							<div class="col-xs-6 col-md-6">
								<div class="page-header-desc">
									告警管理
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
								  <a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/trigger?method=edit">新增告警</a>
								</div>
								<div class="page-header-op r" style="margin: 0 5px;">
									<select id="priority" name="priority" class="form-control">
									<%
										request.setAttribute("taskPriority", DataCache.taskPriority);
									%>
										<option value="">--选择等级--</option>
										<c:forEach items="${taskPriority}" var="item">
							           		<option <c:if test='${pager.params.priority == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
							       	    </c:forEach>
									</select>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<div>告警管理列表，找到 ${pager.total} 个告警对象</div>
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<c:if test="${isAdmin}"><th>ID</th></c:if>
								<th style="width:25%;">告警名称</th>
								<th style="width:13%;">告警周期</th>
								<th style="width:12%;">告警级别</th>
								<th style="width:10%;">状态</th>
								<th style="width:20%;">处理节点</th>
								<th style="width:20%;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="stu">
								<tr>
									<c:if test="${isAdmin}"><td>${stu.id}</td></c:if>
									<td>${stu.name}</td>
									<td>
										<c:choose>
											<c:when test="${stu.periodType eq 'second'}">
		<!-- 										<span style="color: red;">实时</span> -->
												实时
											</c:when>
											<c:otherwise>${stu.periodType}<br>：${stu.cron}</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${stu.priority eq 'high'}">
												<span class="label label-danger">高</span>
											</c:when>
											<c:when test="${stu.priority eq 'middle'}">
												<span class="label label-warning">中</span>
											</c:when>
											<c:otherwise>
												<span class="label label-success">低</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${stu.status eq 'on'}">
												<span class="label label-success">已生效</span>
											</c:when>
											<c:otherwise>
												<span class="label label-default">已失效</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td id="node${stu.id}"><c:choose>
											<c:when test="${stu.nodeId eq '0'}">
											</c:when>
											<c:otherwise>
												[${stu.nName}] ${stu.nIp}:${stu.nPort}
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${stu.status eq 'on'}">
												<a href="<%=request.getContextPath() %>/user/trigger?method=edit&id=${stu.id}">查看</a>
											</c:when>
											<c:otherwise>
												<a code="select" href="<%=request.getContextPath() %>/user/trigger?method=edit&id=${stu.id}">编辑</a>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${stu.status eq 'on'}">
												<a code="save" onclick="changeOffLine(${stu.id},'off');" id="changeStatus${stu.id}" status="off" class="darwin-mask">失效</a>
		<%-- 										href="<%=request.getContextPath() %>/user/trigger?method=changeOnLine&id=${stu.id}&onLine=off&type=alert" --%>
											</c:when>
											<c:otherwise>
												<a code="save" onclick="changeOffLine(${stu.id},'on');" id="changeStatus${stu.id}" status="on" class="darwin-mask">生效</a>
		<%-- 										<a href="<%=request.getContextPath() %>/user/trigger?method=changeOnLine&id=${stu.id}&onLine=on&type=alert" class="darwin-mask">生效</a> --%>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${stu.status eq 'on'}">
												<a code="delete" onclick="return confirm('请先失效，在删除！')">删除</a>
											</c:when>
											<c:otherwise>
												<a code="delete" onclick="return confirm('确定删除告警  ${stu.id} 吗？')" href="<%=request.getContextPath() %>/user/trigger?method=deleteById&id=${stu.id}">删除</a>
											</c:otherwise>
										</c:choose>
										<c:if test="${stu.triggerDateTime gt 0}">
											<a href="<%=request.getContextPath() %>/user/triggerHistory?method=index&triggerId=${stu.id}">告警历史</a>
										</c:if>
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
	<%@ include file="/resources/common_footer.jsp"%>	
	<script type="text/javascript">
		function changeOffLine(id,_status){
			var offline=$("#changeStatus"+id);
			var node=$("#node"+id);
			var _url="<%=request.getContextPath() %>/user/trigger?method=changeOnLine&id="+id+"&onLine="+_status+"&type=alert";
			$.ajax({
				url: _url ,
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					common['$'].unblockUI();
					var _text = "";
					var _respStatus = data.status;
					if(_respStatus == "node_running_success"){
						_text = "成功！";
// 						if(_status=='off'){
// 							offline.attr("status","on");
// 							offline.attr("onclick","changeOffLine("+id+",'on');");
// 							offline.html("生效");
// 							node.html("");
// 						}else{
							location.href="<%=request.getContextPath() %>/user/trigger?method=index";
// 						}
					}else if(_respStatus == "node_send_fail"){
						_text = "操作失败！发送请求到节点失败！";
					}else if(_respStatus == "node_resp_timeout"){
						_text = "操作失败！节点响应超时！";
					}else if(_respStatus == "node_running_faild"){
						_text = "生效失败！";
					}else if(_respStatus == "unknown_exception"){
						_text = "生效失败！未知异常！！";
						console.log(data.message);
					}else if(_respStatus == "node_closed"){
						_text = "操作失败！节点已失联！";
					}else if(_respStatus == "not_any_node"){
						_text = "操作失败！无可用节点！";
					}else if(_respStatus == "not_any_node"){
						_text = "操作失败！无可用节点！";
					}else if(_respStatus == "node_closed"){
						_text = "操作失败！节点已失联！";
					}else if(_respStatus == "triggerInfo_null"){
						_text = "没有告警啦！！";
					}else{
						_text = data;
					}
					
					if(_text){
						layer.tips(_text, offline, {
							tips: [3, '#3595CC'],
							time: 30000
						});
					}
				},
				error:function(err){
					console.log("加载数据出错！");
					common['$'].unblockUI();
					console.log(err);
					layer.tips('出现异常！', offline, {
					    tips: [1, '#3595CC'],
					    time: 20000
					});
				}
			});
		}
		
		function confirmDel2(){
			if (confirm("请先失效，再删除！")) {  
				return true;
	        }
		}
	</script>
	
<script type="text/javascript">
	$("#priority").change(function(){
		var priority=$("#priority").val();
		href = "/user/trigger?method=index&priority="+priority;
		window.location.href=href;
		
	});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>