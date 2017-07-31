<%@page import="test.EsSearchProxyServiceTest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>es查询测试页面</title>
<%@ include file="/resources/common.jsp"%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">

</head>
<body>
<%-- 	<%@ include file="/resources/common_menu.jsp"%> --%>

	<div class="container" style="margin-top: 21px;min-height: 500px;">
    	<div class="row">
    	
    		<%
//     		out.println("sign="+EsSearchProxyServiceTest.createSign());
    		%>
			<form action="<%=request.getContextPath() %>/api/es?method=query" method="post">
				sign:<input name="sign" size="100" value="<%=EsSearchProxyServiceTest.createSign()%>"/><br><br>
				conf:<textarea name="conf" rows="15" cols="100"></textarea><br>
				<input value="提交" type="submit"/>
		  	</form>
    	</div>
	</div>
<script type="text/javascript">
$(function(){
	$("#checkAgree").click(function(){
		if($(this).prop("checked")){
			$("#nextBtn").removeClass("disabled");
		}else{
			$("#nextBtn").addClass("disabled");
		}
	});

});
</script>
<script type="text/javascript">
	if($("#checkAgree").prop("checked")){
		$("#nextBtn").removeClass("disabled");
	}else{
		$("#nextBtn").addClass("disabled");
	}
</script>
	<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>
