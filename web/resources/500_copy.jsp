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
<!-- <title>500错误</title> -->
<title>error页面</title>
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
//             	if(exception instanceof OpException){
// 					System.out.println("exception instanceof OpException!");
// 					exception.printStackTrace(response.getWriter());
            	%>
				
<!-- 				<p><span>5</span><span>0</span><span>0</span></p> -->
<!-- 				<p>很抱歉，您刚才的操作出错了(´･ω･`)</p> -->
				<div style="text-align:center;">
					<img  width="300px;" height="250px;" src="<%=request.getContextPath() %>/resources/images/500.png"/>
				</div>
				<p>很抱歉，您刚才的操作出错了(´･ω･`)，请联系管理员。</p>
				<%//} %>
				
				
				<p><%=exception!=null ? exception.getMessage() : ""%>
				</p>
				
				<div id="detail" style="display: none;">
					<%
					String debug = request.getParameter("debug");
					//debug = "true";
					if(debug!=null && Boolean.valueOf(debug)){
						exception.printStackTrace(response.getWriter());
					}%>
				</div>
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