<%@page import="com.stonesun.realTime.services.core.OpException"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>无权访问</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">
</head>
<body>
	<%@ include file="/resources/common_menu.jsp"%>
	
	<c:if test="${1==2}">
		<div class="container mh500" style="display: none;">
	    	<div class="row">
	    		<div style="text-align:center; font-size:24px;">
					<br><br><br>
					<%=exception.getMessage()%>
	    			<%exception.printStackTrace(response.getWriter()); %>
					<br><br><br><br>
					<a href="javascript:history.back()">返回</a>
				</div>
	    	</div>
		</div>
	</c:if>
	
	<div class="container" style="margin-top: 80px;">
    	<div class="row">
            <div class="demo">
            
            	<%
            	System.out.println("403.jsp");
//             	if(exception instanceof OpException){
// 					System.out.println("exception instanceof OpException!");
// 					exception.printStackTrace(response.getWriter());
            	%>
				
<!-- 				<p><span>4</span><span>0</span><span>3</span></p> -->
				<div style="text-align:center;">
					<img  width="300px;" height="260px;" src="<%=request.getContextPath() %>/resources/images/403.png"/>
				</div>
<!-- 				<p><font color="#000000">403</font></p> -->
				<p>很抱歉，您可能没有权限访问该资源(´･ω･`)</p>
				<%//} %>
				
				
				<p><%=exception!=null ? exception.getMessage() : ""%>
					<%
					String debug = request.getParameter("debug");
					//debug = "false";
					if(Boolean.valueOf(debug)){
						exception.printStackTrace(response.getWriter());
					}%>
				</p>
			</div>
			<br /><br />
			<div style=" width:600px;margin:0 auto; text-align:center; font-size:12px;">
				<p>【<a href="http://9zdata.com/" target="_blank"><font color="#000000">9zdata</font></a>】
					<a href="javascript:history.back()">返回</a>
				</p>
				<p></p>
			</div>
    	</div>
	</div>
	
<%-- 	<%@ include file="/resources/common_footer.jsp"%> --%>
</body>
</html>