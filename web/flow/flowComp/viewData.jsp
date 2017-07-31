<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>查看数据</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_analytics);%>
	<%request.setAttribute("mode", request.getParameter("mode"));%>
	<%
		try{
	%>
	<c:choose>
		<c:when test="${param.type eq 'toHbase'}">
<%-- 			<%@ include file="/analytics/edit.jsp?linktype=Hbase"%> --%>
<%-- 			<%@ include file="/analytics/edit.jsp"%> --%>
				<jsp:include page="/analytics/edit.jsp">
					<jsp:param value="Hbase" name="linktype"/>
				</jsp:include>
		</c:when>
		<c:when test="${param.type eq 'toEs'}">
			<%@ include file="/search/dashboard.jsp"%>
		</c:when>
		<c:when test="${param.type eq 'realtimeReceive'}">
			<%@ include file="/search/dashboard.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="/configure/hdfsManage.jsp"%>
		</c:otherwise>
	</c:choose>
<%}catch(Throwable e){e.printStackTrace();} %>
<%-- <%@ include file="/resources/common_footer.jsp"%> --%>

<script type="text/javascript">
$(function(){
	$('#myTab a').click(function (e) { 
      	e.preventDefault();//阻止a链接的跳转行为 
      	$(this).tab('show');//显示当前选中的链接及关联的content 
    })
    var mode = "${mode}";
	if (mode=='read') {
		$("#rightForm input[type='submit']").hide();
		$("#rightForm button[type='submit']").hide();
		$("#rightForm select").attr('disabled','true');
		$("#rightForm input").attr('disabled','true');
	}
	$('.dropdown-toggle').dropdown();
});


</script>
</body>
</html>