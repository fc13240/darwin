<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>任务分组列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_user);%>
	
	<form action="<%=request.getContextPath() %>/user/taskGroup?method=index" method="post">
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						任务组
					</div>
					<div class="page-header-links">
						<a>个人设置</a> / 任务组
					</div>
				</div>
				<div class="col-xs-6 col-md-6">
					<div class="page-header-op r">
						<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/taskGroup?method=edit">新增任务组</a>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!-- page header end -->	
		<!-- page content start -->
		<div class="container mh500">
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th>项目组名称</th>
						<th>添加日期</th>
						<th style="width: 100px;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="stu" items="${pager.list}">
						<tr>
							<td>${stu.id}</td>
							<td>${stu.name}</td>
							<td>${stu.createTime}</td>
							<td>
								<a href="taskGroup?method=edit&id=${stu.id}">编辑</a> 
								<a onclick="confirmDel()" href="taskGroup?method=deleteById&id=${stu.id}">删除</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div>
				<%@ include file="/resources/pager.jsp"%>
			</div>
		</div>
	</form>
	<%@ include file="/resources/common_footer.jsp"%>	
	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
</body>
</html>