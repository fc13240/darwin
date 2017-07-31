<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>任务列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_monitor);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
			<form action="<%=request.getContextPath() %>/monitor?method=index" method="post" class="form-horizontal" role="form">
				<table class="table table-bordered" border="0">
					<tr>
						<td colspan="21">
							<div class="row">
								<div class="col-md-3">
									<button class="btn btn-primary" type="submit" href="<%=request.getContextPath() %>/monitor?method=index">查询</button>
									<a class="btn btn-success" href="<%=request.getContextPath() %>/monitor/edit.jsp">新增</a>
								</div>
								<div class="col-md-9">
									<%@ include file="/resources/pager.jsp"%>
								</div>
							</div>
						</td>
					</tr>
				</table>
					
				
				<table class="table table-hover table-striped">
					<tr class="success">
						<td>ID</td>
						<td>名称</td>
						<td>监控对象</td>
						<td>调度</td>
						<td width="150px">操作</td>
					</tr>
					<c:forEach var="stu" items="${pager.list}">
						<tr>
							<td>${stu.id}</td>
							<td>${stu.name}</td>
							<td>
								<a code="select" href="monitor/edit.jsp?id=${stu.id}">编辑</a>
								<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/monitor?method=deleteById&id=${stu.id}">删除</a>
							</td>
						</tr>
					</c:forEach>
				</table>
				<div>
					<%@ include file="/resources/pager.jsp"%>
				</div>
			</form>
			</div>
		</div>
		<script>
			function confirmDel(){
				if (confirm("你确定要删除吗？")) {  
					return true;
		        }  return false;
			}
		</script>

	</div>
</body>
</html>