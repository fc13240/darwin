<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowCompInfo"%>
<%@page import="com.stonesun.realTime.services.db.FlowCompServices"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<title>组件配置</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_analytics);%>
	<%request.setAttribute("topId", "41");%>
	<%request.setAttribute("mode", request.getParameter("mode"));%>
	<%
		if(StringUtils.isNotBlank(request.getParameter("compId"))){
			FlowCompInfo _flowCompInfo = FlowCompServices.selectById0(Integer.valueOf(request.getParameter("compId")),DatasourceServlet.getUid(request));
			if(_flowCompInfo == null){
				response.sendRedirect("/resources/403.jsp");
				return;
			}
		}
	%>
	
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					<a href="<%=request.getContextPath() %>/flow?method=index">流程管理</a> / 组件设置
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
			
				<%
				try{
				%>
				<c:choose>
					<c:when test="${param.type eq 'sFTP'}">
						<%@ include file="sFTP.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'sFTPIncrement'||param.type eq 'realtimeWatch'}">
						<%@ include file="sFTP.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'scp'}">
						<%@ include file="scp.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'localMonitor'}">
						<%@ include file="localMonitor.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'simpleCustom'}">
						<%@ include file="simpleCustom.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'uds'}">
						<%@ include file="uds.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'toHbase'}">
						<%@ include file="toHbase.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'toEs'}">
						<%@ include file="toEs.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'mysql'}">
						<%@ include file="mysql.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'oracle'}">
						<%@ include file="oracle.jsp"%>
					</c:when>
					<c:when test="${param.type eq 'dataClean'}">
						<jsp:include flush="true" page="dataClean.jsp">
							<jsp:param name="ss" value="dataClean"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'dataStat'}">
						<jsp:include flush="true" page="dataStat.jsp">
							<jsp:param name="ss" value="dataStat"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'participle' }">
						<jsp:include flush="true" page="participle.jsp">
							<jsp:param name="ss" value="participle"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'emotionAnalysis' }">
						<jsp:include flush="true" page="emotionAnalysis.jsp">
							<jsp:param name="ss" value="emotionAnalysis"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'realtimeReceive'}">
						<jsp:include flush="true" page="realtimeReceive.jsp">
							<jsp:param name="ss" value="realtimeReceive"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'realtimeToHdfs'}">
						<jsp:include flush="true" page="realtimeToHdfs.jsp">
							<jsp:param name="ss" value="realtimeToHdfs"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'esExport'}">
						<jsp:include flush="true" page="esExport.jsp">
							<jsp:param name="ss" value="esExport"/> 
						</jsp:include>
					</c:when>
					<c:when test="${param.type eq 'sqoopSwap' }">
						<%@ include file="sqoopSwap.jsp"%>
					</c:when>
					<c:otherwise>
						缺少组件类型
					</c:otherwise>
				</c:choose>
				<%}catch(Throwable e){e.printStackTrace();} %>
			</div>
		</div>

	</div>
<%@ include file="/resources/common_footer.jsp"%>

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
});
</script>
</body>
</html>