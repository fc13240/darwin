<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Darwin(智通易平台)是基于Spark,无需代码开发的可视化数据分析处理平台。">
<meta name="keywords" content="Hadoop,Spark,Big data">
<meta name="author" content="idataworks">
<meta name="application-name" content="idataworks.com">
<title>session.jsp</title>
<%@ include file="/resources/common.jsp"%>
<link href="<%=request.getContextPath() %>/resources/site/css/login.css" rel="stylesheet">
</head>
<body>
<%  
     //System.out.println(session.getId());  
     //out.println("<br> This is (TOMCAT1|TOMCAT2), SESSION ID:" + session.getId()+"<br>");  
    out.println(session.getAttribute(Container.session_userPrivilegeBtns));
    %> 
</body>
</html>