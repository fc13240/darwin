<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.FlowStatusServices"%>
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
<title>日志详情</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<%request.setAttribute("topId", "41");%>
	<form action="" method="post" class="form-horizontal" role="form">
	<div class="container mh500" style="margin-top:80px">
		<div class="row">
			日志详情：<br>${detail}
		</div>
	</div>
	</form>
<%-- <%@ include file="/resources/common_footer.jsp"%> --%>
</body>
</html>