<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
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
<title>数据源配置完成</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					添加离线数据源
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/datasources?method=index">数据源管理</a> / <a href="<%=request.getContextPath() %>/datasources/add.jsp">选择数据的添加方式</a> / 添加离线数据源
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12" style="text-align: center;margin-top: 100px;">
				<%
				String source = request.getParameter("source");
				request.setAttribute("source", source);
				%>
				<c:if test="${!(source eq 'realTime')}">
					<p><a href="<%=request.getContextPath()%>/task/edit.jsp">立即添加任务</a></p>
				</c:if>
				<p><a href="#" class="disable">分析此数据</a></p>
				<p><a href="#" class="disable">数据透视</a></p>
			</div>
		</div>
	</div>
</body>
</html>