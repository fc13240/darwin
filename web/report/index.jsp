<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page import="com.stonesun.realTime.services.servlet.DashBoardServlet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>报表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
<%request.setAttribute("selectPage", Container.module_report);%>
<%request.setAttribute("isAdmin", DatasourceServlet.getUid(request));%>
<%request.setAttribute("topId", "172");%>

<form action="<%=request.getContextPath() %>/dashBoard?method=report" method="post">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					报表
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
		<c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								报表
							</div>
						</div>
 						<div class="col-xs-6 col-md-6">
						</div>
					</div>
				</div>
				<div>报表管理，当前找到  ${pager.total} 个报表</div><p></p>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>报表名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list }" varStatus="status">
							<tr>
								<td>${stu.id}</td>
								<td>${stu.title}</td>
								<td>
									<a target="_blank" href="/search/dashboard.jsp?dashbordName=${stu.title}">在检索仪表盘打开</a>
									&nbsp;
									<a code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/dashBoard?method=deleteReport&title=${stu.title}">删除</a>
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
<script>
	function confirmDel(){
		if (confirm("您确定要删除此仪表盘吗？")) {  
			return true;
        }  return false;
	}
</script>
<c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>