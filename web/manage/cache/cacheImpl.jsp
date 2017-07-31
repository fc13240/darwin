<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%

String method = request.getParameter("method");
if(StringUtils.isBlank(method)){
	
}else if(method.equals("load_systemProperties")){
	SystemProperties.getInstance().load();
	out.println("success!");
}

%>