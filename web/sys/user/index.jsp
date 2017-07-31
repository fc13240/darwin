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
<title>用户列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "48");%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<form action="<%=request.getContextPath() %>/manage/user?method=index" method="post">
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						用户管理
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
									用户管理
								</div>
								<div class="page-header-links">
									用户管理列表
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
									<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/manage/user?method=edit">新增用户</a>
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
								<c:if test="${isAdmin}"><td>ID</td></c:if>
								<td>用户名</td>
								<td>昵称</td>
								<td>邮箱</td>
								<td>角色</td>
								<td>添加日期</td>
								<td style="width: 100px;">操作</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<c:if test="${isAdmin}"><td>${stu.id}</td></c:if>
									<td>${stu.username}</td>
									<td>${stu.nickname}</td>
									<td>${stu.email}</td>
									<td>${stu.roleName}</td>
									<td>${stu.createTime}</td>
									<td>
										<a code="select" href="<%=request.getContextPath() %>/manage/user?method=edit&id=${stu.id}">编辑</a> 
										<a code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/manage/user?method=deleteById&id=${stu.id}">删除</a>
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
