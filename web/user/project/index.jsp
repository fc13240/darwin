<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>项目列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "1");%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<%request.setAttribute("flowId", request.getParameter("flowId"));%>
	<form action="<%=request.getContextPath() %>/user/project?method=index" method="post">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					项目管理
				</div>
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
				<!-- page header start -->
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								项目管理
							</div>
							<div class="page-header-links">
								项目管理列表
							</div>
						</div>
						<div class="col-xs-6 col-md-6">
							<div class="page-header-op r">
								<c:if test="${empty flowId }">
									<a href="/flow/init.jsp" class="btn btn-primary" role="button">返回流程</a>
								</c:if>
								<c:if test="${not empty flowId }">
									<a href="/flow/init.jsp?id=${flowId}" class="btn btn-primary" role="button">返回流程</a>
								</c:if>
							</div>
							<div class="page-header-op r">
								&nbsp;&nbsp;
							</div>
							<div class="page-header-op r">
								<c:if test="${empty flowId }">
									<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/project?method=edit">新增项目</a>
								</c:if>
								<c:if test="${not empty flowId }">
									<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/project?method=edit&flowId=${flowId}">新增项目</a>
								</c:if>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->	
				<!-- page content start -->
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<c:if test="${isAdmin}">
								<th>ID</th>
							</c:if>
							<th>项目名称</th>
							<c:if test="${isAdmin}">
								<th>用户</th>
							</c:if>
							<th>添加日期</th>
							<th style="width: 100px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<c:if test="${isAdmin}">
									<td>${stu.id}</td>
								</c:if>
								<td>${stu.name}</td>
								<c:if test="${isAdmin}">
									<td>${stu.createUsername}</td>
								</c:if>
								<td>${stu.createTime}</td>
								<td>
									<a code="select" href="project?method=edit&id=${stu.id}">编辑</a> 
									<a code="delete" onclick="confirmDel()" href="project?method=deleteById&id=${stu.id}">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
