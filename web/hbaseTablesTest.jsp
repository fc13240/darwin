<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.utils.PhoenixUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.commons.io.*"%>
<%@page import="com.stonesun.realTime.services.servlet.UserServlet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%

//HUANGFEI.PHOENIXBULK4
//out.println(JSON.toJSONString(PhoenixUtil.getTableDescByTableName("admin","JIAOTONG")));
out.println(JSON.toJSONString(PhoenixUtil.getTableDescByTableName("HUANGFEI","PHOENIXBULK4")));
%>