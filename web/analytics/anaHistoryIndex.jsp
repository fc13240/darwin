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
						分析运行历史
					</div>
				</div>
				<div class="col-xs-9 col-md-9">
					<div class="page-header-op r">
					</div>
					<div class="page-search r">
						<div class="form-group">
							<div class="input-group">
								<input type="search" placeholder="sql关键字" name="keyword" value="${keyword}" class="form-control" >
								<span class="input-group-btn">
									<button class="btn" type="submit" href="datasources?method=index">
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
		<!-- page content start -->
		<div class="container mh500">
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th>分析sql</th>
<!-- 						<th width="150px">操作</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach var="stu" items="${pager.list}">
						<tr>
							<td>${stu.id}</td>
							<td>${stu.sql}</td>
<!-- 							<td> -->
<%-- 								<a href="analyticsHistory?method=run&id=${stu.id}&anaId=${stu.anaId}">重新分析</a> --%>
<!-- 							</td> -->
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

	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
</body>
</html>