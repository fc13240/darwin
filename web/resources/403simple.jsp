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
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">
</head>
<body>
	<div class="container" style="margin-top: 80px;">
    	<div class="row">
            <div class="demo">
            	<%
            	System.out.println("403simple.jsp");
            	%>
<!-- 				<p><span>4</span><span>0</span><span>3</span></p> -->
				<div style="text-align:center;">
					<img  width="300px;" height="250px;" src="<%=request.getContextPath() %>/resources/images/403.png"/>
				</div>
				<p>很抱歉，您可能没有权限访问该资源(´･ω･`)</p>
			</div>
    	</div>
	</div>
</body>
</html>