<%@ page contentType="text/html; charset=UTF-8"%>

<%
	UserInfo userIndex0 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
	if (userIndex0.getRoleId().equals("1")) {
%>
<%@ include file="/adminIndex.jsp"%>

<%
	} else {
%>

<%@ include file="/userIndex.jsp"%>

<%
	}
%>
