<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>404页面</title>
<%@ include file="/resources/common.jsp"%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">

</head>
<body>
	<%@ include file="/resources/common_menu.jsp"%>
	
	<div class="container" style="margin-top: 80px;">
    	<div class="row">
            <div class="demo">
<!-- 				<p><span>4</span><span>0</span><span>1</span></p> -->
				<div style="text-align:center;">
					<img  width="300px;" height="250px;" src="<%=request.getContextPath() %>resources/images/401.png"/>
				</div>
				<p>不好意思，您的产品授权已过期(´･ω･`)</p>
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
<%-- <%@ include file="/resources/common_footer.jsp"%> --%>
</body>
</html>