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
<title>用户首页</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_user);%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-12" style="text-align: center;">
				<p><a href="<%=request.getContextPath()%>/user/updatePwd.jsp">基本信息</a></p>
				<p><a href="<%=request.getContextPath()%>/user/updatePwd.jsp">修改密码</a></p>
				<p><a href="<%=request.getContextPath()%>/user/project?method=index">项目管理</a></p>
				<p><a href="<%=request.getContextPath()%>/user/connConf?method=index">连接设置</a></p>
				<p><a href="<%=request.getContextPath()%>/user/monitor?method=index">监控管理</a></p>
				<p><a href="<%=request.getContextPath()%>/user/trigger?method=index">告警管理</a></p>
				<p><a href="<%=request.getContextPath()%>/user?method=exit">退出</a></p>
			</div>
		</div>
		<script>
		</script>

	</div>
</body>
</html>