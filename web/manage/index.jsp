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
<title>数据源列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_manage);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12" style="text-align: center;">
				<p><a href="<%=request.getContextPath()%>/manage/user?method=index">用户管理</a></p>
				<p><a href="<%=request.getContextPath()%>/manage/user?method=upgrade">系统升级</a></p>
				<p><a href="<%=request.getContextPath()%>/manage/user?method=upgrade">监控</a></p>
			</div>
		</div>
	</div>
</body>
</html>