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
<title>连接管理列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%session.setAttribute("type", request.getParameter("type"));%>
	<%request.setAttribute("topId", "1");%>
	<%request.setAttribute("compId", request.getParameter("compId"));%>
	<%request.setAttribute("compType", request.getParameter("compType"));%>

	<form action="<%=request.getContextPath() %>/user/connConf?method=index" method="post">
		<!-- page header start -->
		<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						连接管理
					</div>
				</div>
			</div>
		</div>
		<!-- page header end -->
		<!-- page content start -->
		<div class="container mh500">
			<div class="row">
				<div class="col-md-3">
					<%-- <%@ include file="/configure/leftMenu.jsp"%> --%>
				</div>
				<div class="col-md-9">
					<!-- page header start -->
					<div class="page-header">
						<div class="row">
							<div class="col-xs-6 col-md-6">
								<div class="page-header-desc">
								<c:if test="${type eq 'ftp' }" >
									FTP/SCP连接管理
								</c:if>
								<c:if test="${type eq 'database' }" >
									Mysql/Oracle/SqlServer/DB2数据库连接管理
								</c:if>	
								<c:if test="${type eq 'hbase' }" >
									HBASE连接管理
								</c:if>	
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
									<c:if test="${empty compId }">
										<a href="/flow/init.jsp" class="btn btn-primary" role="button">返回流程</a>
									</c:if>
									<c:if test="${not empty compId }">
										<a href="/flow/flowComp/conf.jsp?type=${compType}&compId=${compId}" class="btn btn-primary" role="button">返回流程</a>
									</c:if>
								</div>
								<div class="page-header-op r">
									&nbsp;&nbsp;
								</div>
								<div class="page-header-op r">
									<c:if test="${empty compId }">
										<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/connConf?method=edit&type=${sessionScope.type}">新增连接</a>
									</c:if>
									<c:if test="${not empty compId }">
										<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/connConf?method=edit&type=${sessionScope.type}&compType=${compType}&compId=${compId}">新增连接</a>
									</c:if>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<!-- page header end -->
					<div>当前找到 ${pager.total} 个连接</div>
					<p>
					</p>
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<c:if test="${isAdmin}">
									<th>ID</th>
								</c:if>
								<th>连接名称</th>
								<th>连接类型</th>
								<c:if test="${isAdmin}">
									<th>用户</th>
								</c:if>
								<th style="width: 200px;">添加日期</th>
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
									<td>${stu.type}</td>
									<c:if test="${isAdmin}">
										<td>${stu.createUsername}</td>
									</c:if>
									<td>${stu.createTime}</td>
									<td>
										<c:if test="${empty compId }">
											<a code="select" href="<%=request.getContextPath() %>/user/connConf?method=edit&id=${stu.id}">编辑</a>
										</c:if>
										<c:if test="${not empty compId }">
											<a code="select" href="<%=request.getContextPath() %>/user/connConf?method=edit&id=${stu.id}&compType=${compType}&compId=${compId}">编辑</a>
										</c:if>
										 
										<a code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/user/connConf?method=deleteById&id=${stu.id}&type=${type}">删除</a>
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
<%-- 	<%@ include file="/resources/common_footer.jsp"%> --%>
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