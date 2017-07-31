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
	<%request.setAttribute("selectPage", Container.module_task);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<form action="<%=request.getContextPath() %>/task?method=index" method="post" class="form-horizontal" role="form">
	
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-xs-3 col-md-3">
					<div class="page-header-desc">
						任务
					</div>
				</div>
				<div class="col-xs-9 col-md-9">
					<div class="page-header-op r">
						<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/task/edit.jsp">新增任务</a>
					</div>
					<div class="page-search r">
						<div class="form-group">
							<div class="input-group">
								<input type="search" placeholder="任务名称" name="name" value="${pager.params.name}" class="form-control" >
								<span class="input-group-btn">
									<button class="btn" type="submit" href="task?method=index">
										<span class="fui-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="page-header-op r">
						<select id="onLine" name="onLine" class="form-control" placeholder="任务状态">
							<%
								//加载用户的项目列表
								//session.setAttribute(Container.session_projectList, ProjectServices.selectList());
								request.setAttribute("taskOnline", DataCache.taskOnline);
							%>
							<option value="">--选择状态--</option>
							<c:forEach items="${taskOnline}" var="item">
					           <option <c:if test='${pager.params.onLine == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
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
						<th>任务名称</th>
<!-- 						<th>类型</th> -->
						<th>状态</th>
						<th>调度</th>
						<th width="150px">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="stu" items="${pager.list}">
						<tr>
							<td>${stu.id}</td>
							<td>${stu.name}</td>
<%-- 							<td>${stu.typeText}</td> --%>
							<td>
								<c:choose>
									<c:when test="${stu.onLine eq 'on'}">
										<span class="label label-success">${stu.onLineText}</span>
									</c:when>
									<c:otherwise>
										<span class="label label-default">${stu.onLineText}</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:if test="${not empty stu.period}">
									上次：${stu.period}
								</c:if>
							</td>
							<td>
								<a href="task/edit.jsp?id=${stu.id}">编辑</a>
								<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/task?method=deleteById&id=${stu.id}">删除</a>
								
								<c:if test="${stu.onLine eq 'off' or stu.onLine eq 'add'}">
									<a href="<%=request.getContextPath() %>/task?method=changeOnLine&id=${stu.id}&onLine=on&type=dataSource">上线</a>
								</c:if>
								<c:if test="${stu.onLine eq 'on'}">
									<a href="<%=request.getContextPath() %>/task?method=changeOnLine&id=${stu.id}&onLine=off&type=dataSource">下线</a>
								</c:if>
								<br>
								<c:choose>
									<c:when test="${stu.onLine eq 'on'}">
										<a href="<%=request.getContextPath() %>/task?method=changeStatus&id=${stu.id}&status=running">立即执行</a>
									</c:when>
									<c:when test="${stu.status eq 'running'}">
										<a href="<%=request.getContextPath() %>/task?method=changeStatus&id=${stu.id}&status=stoped">终止</a>
									</c:when>
								</c:choose>
								
								<c:if test="${not empty stu.period}">
									<a href="task/history.jsp?id=${stu.id}">执行历史</a>
								</c:if>
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