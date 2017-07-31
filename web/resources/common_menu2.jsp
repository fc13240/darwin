<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
class Tmp{
	String getA(String pageName,HttpServletRequest request){
		String selectPage = null;
		if(request.getAttribute("selectPage")!=null){
			selectPage = request.getAttribute("selectPage").toString();
		}else{
			return "";
		}
		if(selectPage.equals(pageName)){
			return "active";
		}
		return "";
	}
}

Tmp tt = new Tmp();
%>

