<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>分析列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_analytics);%>
			
	<form action="<%=request.getContextPath() %>/analytics?method=index" method="post" class="form-horizontal" role="form">
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-xs-3 col-md-3">
					<div class="page-header-desc">
						分析
					</div>
				</div>
				<div class="col-xs-9 col-md-9">
					<div class="page-header-op r">
						<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/analytics/edit.jsp">新增分析</a>
					</div>
					<div class="page-search r">
						<div class="form-group">
							<div class="input-group">
								<input type="search" placeholder="分析名称" name="name" value="${pager.params.name}" class="form-control" >
								<span class="input-group-btn">
									<button class="btn" type="submit" href="datasources?method=index">
										<span class="fui-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="page-header-op r" style="margin: 0 0 5px;">
						<select id="status" name="status" class="form-control">
							<%
								request.setAttribute("statusMap", DataCache.statusMap);
							%>
							<option value="">--选择状态--</option>
							<c:forEach items="${statusMap}" var="list">
					           <option <c:if test='${pager.params.status == list.key}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
					        </c:forEach>
						</select>
					</div>
					<div class="page-header-op r" style="margin: 0 5px;">
						<select id="projectId" name="projectId" class="form-control">
							<%
								session.setAttribute(Container.session_projectList, ProjectServices.selectList());
							%>
							<option value="">--选择项目--</option>
							<c:forEach items="${sessionScope.session_projectList}" var="list">
					           <option <c:if test='${pager.params.projectId == list.id}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
					        </c:forEach>
						</select>
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
						<th>分析名称</th>
						<th>信息</th>
						<th>所属项目</th>
						<th>涉及数据</th>
<!-- 						<th>状态</th> -->
						<th width="150px">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="stu" items="${pager.list}">
						<tr>
							<td>${stu.id}</td>
							<td>${stu.name}</td>
							<td>输出数据索引:
							</td>
							<td>${stu.projectName}</td>
							<td>${stu.containDatasource}</td>
<%-- 							<td>${stu.status}</td> --%>
							<td>
								<a href="analytics/edit.jsp?id=${stu.id}">编辑</a>
<!-- 								<a href="#">任务</a> -->
								<a href="#" class="disable">导出</a>
								<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/analytics?method=deleteById&id=${stu.id}">删除</a>
								<br>
								
								<a href="#" class="disable">查看输出数据</a><br>
								<a href="#" class="disable">检索输出数据</a><br>
								<a href="#" class="disable">分析输出数据</a><br>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- page content end -->
		<div>
			<%@ include file="/resources/pager.jsp"%>
		</div>
	</form>
		<%-- 		<c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
</body>
</html>