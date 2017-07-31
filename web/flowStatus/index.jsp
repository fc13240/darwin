<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="com.stonesun.realTime.services.db.FlowStatusServices"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
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
<title>流程监控页面</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	<%request.setAttribute("topId", "41");%>
	<%request.setAttribute("nodeId", request.getParameter("id"));%>

	<%@ include file="/resources/common_menu2.jsp"%>
	
	<form action="<%=request.getContextPath()%>/flowStatus?method=index"
		method="post" class="form-horizontal" role="form">
		
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">流程监控</div>
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
						<div class="row">
							<div class="col-xs-3 col-md-3">
								<div class="page-header-desc">流程监控历史</div>
							</div>
							<div class="col-xs-9 col-md-9">
								<div class="page-search r">
									<div class="form-group">
										<div class="input-group">
											<input type="search" placeholder="流程名称" name="flowName"
												value="${pager.params.flowName}" class="form-control">
<%-- 											<input type="text" name="nodeId" value="${nodeId}"> --%>
<%-- 											<input type="text" name="nodeId" value="${pager.params.id}"> --%>
											<span class="input-group-btn">
												<button class="btn" type="submit"
													href="<%=request.getContextPath()%>/flowStatus?method=index">
													<span class="fui-search"></span>
												</button>
											</span>
										</div>
									</div>
								</div>
								<div class="page-header-op r" style="margin: 0 5px;width: 180px;">
									<select id="projectId" name="projectId" class="form-control">
										<%
											int uid = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId();
											session.setAttribute(Container.session_projectList,ProjectServices.selectList(uid));
										%>
										<option value="">--选择项目--</option>
										<c:forEach items="${sessionScope.session_projectList}"
											var="list">
											<option
												<c:if test='${pager.params.projectId == list.id}'>selected="selected"</c:if>
												value="${list.id}">${list.name}</option>
										</c:forEach>
									</select>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<!-- page header end -->
					<div class="table-result">
						当前找到 ${pager.total} 个流程的监控历史
					</div>
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<c:if test="${isAdmin}">
									<th>ID</th>
								</c:if>
								<th>流程名称</th>
								<c:if test="${isAdmin}">
									<th>用户</th>
								</c:if>
								<th>项目</th>
								<th style="width: 140px;">最后执行时间与状态</th>
								<th>所在节点</th>
								<th style="width: 150px;">调度</th>
								<th style="width: 100px;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<c:if test="${isAdmin}">
										<td>${stu.flowId}</td>
									</c:if>
									<td><span title="${stu.flowId}/${stu.flowName}"  style="display: block;overflow: hidden;text-overflow: ellipsis;width: 180px;">${stu.flowName}</span></td>
									<c:if test="${isAdmin}">
										<td>${stu.createAccount}</td>
									</c:if>
									<td><span title="${stu.projectName}" style="display: block;overflow: hidden;text-overflow: ellipsis;width: 120px;">${stu.projectName}</span></td>
									<td>${stu.runTime}<br>
									<c:choose>
											<c:when test="${stu.periodStatus eq 'success' }">
												<span class="label label-success">成功</span>
											</c:when>
											<c:when test="${stu.periodStatus eq 'failed' }">
												<span class="label label-danger">失败</span>
											</c:when>
											<c:when test="${stu.periodStatus eq 'canceling' }">
												<span class="label label-warning">取消中</span>
											</c:when>
											<c:when test="${stu.periodStatus eq 'wait' }">
												<span class="label label-warning">等待运行</span>
											</c:when>
											<c:otherwise>
												<span class="label label-warning">执行中</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${stu.nodeInfo}<br>${stu.nodeIp}
									</td>
									<td>
										<c:choose>
											<c:when test="${empty stu.periodType}">
												调度周期：手动
											</c:when>
											<c:when test="${stu.periodType eq 'second'}">
												调度周期：短周期
											</c:when>
											<c:when test="${stu.periodType eq 'rt'}">
												调度周期：实时
											</c:when>
											<c:when test="${stu.periodType eq 'dict'}">
												调度周期：<span title="${stu.cron}">排期表</span>
											</c:when>
											<c:otherwise>
												调度周期：${stu.periodType}<br>(${stu.cron})
											</c:otherwise>
										</c:choose>
<!-- 										<br> -->
<%-- 							           	<c:choose> --%>
<%-- 											<c:when test="${stu.periodStatus eq 'success' }"> --%>
<!-- 												<span class="label label-success">成功</span> -->
<%-- 											</c:when> --%>
<%-- 											<c:when test="${stu.periodStatus eq 'failed' }"> --%>
<!-- 												<span class="label label-danger">失败</span> -->
<%-- 											</c:when> --%>
<%-- 											<c:when test="${stu.periodStatus eq 'canceling' }"> --%>
<!-- 												<span class="label label-warning">取消中</span> -->
<%-- 											</c:when> --%>
<%-- 											<c:when test="${stu.periodStatus eq 'wait' }"> --%>
<!-- 												<span class="label label-warning">等待运行</span> -->
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>
<!-- 												<span class="label label-warning">执行中</span> -->
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
									</td>
									<td><input value="${stu.flowId}" name="flowId" id="flowId" type="hidden" /> 
										<a href="flowStatus?method=history&flowId=${stu.flowId}">查看详细</a>
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
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if> --%>
	<script>
		//项目的下拉框选择切换事件
		$("#projectId").change(function() {
			if (true) {
				var newSelect = $(this).val();
				if(newSelect==""){
					href = "flowStatus?method=index";
				}else{
					href = "flowStatus?method=index&projectId=" + newSelect;
				}
				window.location.href = href;
			}
		});
	</script>
</body>
</html>
