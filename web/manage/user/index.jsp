<%@page import="com.stonesun.realTime.services.servlet.Container"%>
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
	<%request.setAttribute("selectPage", Container.module_manage);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<ol class="breadcrumb">
					<li><a href="#">首页</a></li>
					<li><a href="<%=request.getContextPath()%>/manage/index.jsp">系统管理</a></li>
					<li class="active">用户管理</li>
				</ol>
				
				<form action="<%=request.getContextPath() %>/manage/user?method=index" method="post">
					<table class="table table-bordered" border="0">
						<tr>
							<td colspan="21">
								<div class="row">
									<div class="col-md-3">
										<button class="btn btn-primary" type="submit">查询</button>
										<a class="btn btn-success" href="<%=request.getContextPath() %>/manage/user?method=edit">新增</a>
									</div>
									<div class="col-md-9">
<%-- 										<%@ include file="/resources/pager.jsp"%> --%>
									</div>
								</div>
							</td>
						</tr>
					</table>
	
					<table class="table table-hover table-striped">
						<tr class="success">
							<td>用户名</td>
							<td>昵称</td>
							<td>邮箱</td>
							<td>添加日期</td>
							<td style="width: 100px;">操作</td>
						</tr>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td>${stu.username}</td>
								<td>${stu.nickname}</td>
								<td>${stu.email}</td>
								<td>${stu.createTime}</td>
								<td>
									<a href="<%=request.getContextPath() %>/manage/user?method=edit&id=${stu.id}">编辑</a> 
									<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/manage/user?method=deleteById&id=${stu.id}">删除</a>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div>
<%-- 						<%@ include file="/resources/pager.jsp"%> --%>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
</body>
</html>