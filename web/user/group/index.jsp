<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.UserServices"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>用户组列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "48");%>
	
	<form action="<%=request.getContextPath() %>/user/group?method=index" method="post">
	
	
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					用户组管理
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
				<!-- page header start -->
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								用户组管理
							</div>
							<div class="page-header-links">
								用户组管理列表
							</div>
						</div>
						<div class="col-xs-6 col-md-6">
							<div class="page-header-op r">
								<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/group?method=edit">新增用户组</a>
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
							<th style="display: none;">ID</th>
							<th>名称</th>
							<th>大小</th>
							<th>单位</th>
<!-- 							<th>添加日期</th> -->
							<th style="width: 100px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td style="display: none;">${stu.id}</td>
								<td>${stu.name}</td>
								<td>${stu.total}</td>
								<td>${stu.unit}</td>
<%-- 								<td>${stu.createTime}</td> --%>
								<td>
<%-- 									<a href="group?method=edit&id=${stu.id}">修改</a>  --%>
									<a onclick="return confirmDel(${stu.id})"  href="group?method=deleteById&id=${stu.id}">删除</a>
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
	<%@ include file="/resources/common_footer.jsp"%>	
	<script>
		function confirmDel(id){
			
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
</body>
</html>