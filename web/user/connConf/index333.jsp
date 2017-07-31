<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
	<%request.setAttribute("selectPage", Container.module_user);%>
	<%request.setAttribute("page", request.getAttribute("page"));%>
	page=${page}
	
	<form action="<%=request.getContextPath() %>/user/connConf?method=index" method="post">
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
					<c:if test="${page eq 'ftp' }" >
						FTP/SCP连接管理
					</c:if>
					<c:if test="${page eq 'database' }" >
						数据库连接管理
					</c:if>	
					<c:if test="${page eq 'hbase' }" >
						HBASE连接管理
					</c:if>	
					</div>
					<div class="page-header-links">
						连接管理列表
					</div>
				</div>
				<div class="col-xs-6 col-md-6">
					<div class="page-header-op r">
						<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/connConf?method=edit">新增连接</a>
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
						<td>ID</td>
						<td>连接名称</td>
						<td style="width: 200px;">添加日期</td>
						<td style="width: 100px;">操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="stu" items="${pager.list}">
						<tr>
							<td>${stu.id}</td>
							<td>${stu.name}</td>
							<td>${stu.createTime}</td>
							<td>
								<a href="<%=request.getContextPath() %>/user/connConf?method=edit&id=${stu.id}">修改</a> 
								<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/user/connConf?method=deleteById&id=${stu.id}">删除</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div>
<%-- 				<%@ include file="/resources/pager.jsp"%> --%>
			</div>
		</div>
	</form>
	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
