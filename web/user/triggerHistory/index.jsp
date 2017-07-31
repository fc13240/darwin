<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>告警历史列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "137");%>
	<%
		String triggerId = request.getParameter("triggerId");
		request.setAttribute("triggerId", triggerId);
	%>
	
	<form action="<%=request.getContextPath() %>/user/trigger?method=index" method="post">
		<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						告警历史回溯
					</div>
				</div>
			</div>
		</div>
		<!-- page header end -->	
		<!-- page content start -->
		<div class="container mh500">
			<div class="row">
			<%-- 	<div class="col-md-3">
					<%@ include file="/configure/leftMenu.jsp"%>
				</div> --%>
				<div class="col-md-9">
					<div class="page-header">
						<div class="row">
							<div class="col-xs-6 col-md-6">
								<div class="page-header-desc">
									告警历史回溯
								</div>
								<div class="page-header-links">
									<a href="<%=request.getContextPath() %>/user/trigger?method=index">告警管理列表</a>
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
									<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/trigger?method=edit">新增告警</a>
								</div>
								<div class="page-header-op r">&nbsp;&nbsp;</div>
								<div class="page-header-op r">
									<a class="btn btn-primary btn-new"  href="<%=request.getContextPath() %>/user/trigger?method=edit&id=${triggerId}">查看告警</a>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<div>告警历史回溯列表，找到 ${pager.total} 个对象</div>
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th width="150px">告警时间</th>
								<th>告警明细</th>
								<th width="150px">告警类型</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="stu">
								<tr>
									<td>${stu.triggerDateTime}</td>
									<td>${stu.context}</td>
									<td>${stu.type}</td>
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
	<%-- <%@ include file="/resources/common_footer.jsp"%>	 --%>
	<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>