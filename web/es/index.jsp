<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>es索引管理</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_es);%>
	<%request.setAttribute("topId", "36");%>

	<form action="<%=request.getContextPath() %>/es?method=index" method="post" class="form-horizontal" role="form">
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					es索引管理
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
				<div class="page-header">
					<div class="row">
						<div class="col-xs-3 col-md-3">
							<div class="page-header-desc">
								<a type="button" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/es/edit.jsp">添加索引</a>
							</div>
						</div>
						<div class="col-xs-9 col-md-9">
							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="" name="name" value="${pager.params.name}" class="form-control" >
										<span class="input-group-btn">
											<button class="btn" type="submit" href="es?method=index">
												<span class="fui-search"></span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->
					<div>当前找到 ${pager.total} 个自定义组件</div>
					<p>
					</p>
<!-- 				<div class="container mh500"> -->
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th style="width: 40px;">ID</th>
								<th>索引</th>
								<th style="width: 200px;">添加日期</th>
								<th>类型</th>
								<th>表名</th>
								<th style="width: 100px;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<td>${stu.id}</td>
									<td>${stu.indexName}</td>
									<td>${stu.createTime}</td>
									<td>${stu.type}</td>
									<td>${stu.tableName}</td>
									<td>
										<a href="es?method=edit&id=${stu.id}">编辑</a>
										<br>
										<a href="es?method=abc">pdf</a>
										<br>
										<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/es?method=deleteById&id=${stu.id}">删除</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
<!-- 				</div> --> 
				<!-- page content start -->
				<div>
					<%@ include file="/resources/pager.jsp"%>
				</div>
			</div>
		</div>
	</div>
	</form>
<%-- 	<c:if test="${empty plateform}">
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