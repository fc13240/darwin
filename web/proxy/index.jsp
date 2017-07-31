<%@page import="com.stonesun.realTime.services.servlet.NodeServlet"%>
<%@page import="com.stonesun.realTime.services.servlet.UserServlet"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="com.sun.xml.internal.messaging.saaj.util.ByteOutputStream"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.stonesun.realTime.services.servlet.SearchServlet"%>
<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>
<%@page import="com.stonesun.realTime.utils.UrlUtils"%>
<%@page import="com.stonesun.realTime.utils.HttpUtils"%>
<%@page import="org.apache.http.client.*"%>
<%@page import="org.apache.http.client.methods.*"%>
<%@page import="org.apache.http.NameValuePair"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.http.Header"%>
<%@page import="java.io.BufferedReader"%>
<%
	Log logger = LogFactory.getLog(this.getClass());
// out.println(UserServlet.esHttpReq(request, response).trim());

UserServlet.esHttpReq(request, response);



 %> 