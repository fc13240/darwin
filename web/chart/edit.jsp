<%@page import="com.stonesun.realTime.services.servlet.AnalyticsServlet"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.bean.ChartInfo"%>
<%@page import="com.stonesun.realTime.services.db.ChartServices"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>图表编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_chart);%>
	<%@ include file="/resources/common_menu.jsp"%>
	
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					添加图表
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/chart?method=index2">图表管理</a> / <a href="<%=request.getContextPath() %>/chart/edit.jsp">添加图表</a> / 选择分析
				</div>
			</div>
		</div>
	</div>
	
	<div class="container" style="margin-bottom: 100px;">
		<div class="row">
			<div class="col-md-12">
				<%
					String method = request.getParameter("method");
					if (!"add".equals(method)) {
						String id = request.getParameter("id");
						if(StringUtils.isNotBlank(id)){
							ChartInfo info = ChartServices.selectById(Integer.valueOf(id));
							request.setAttribute("chart", info);
						}else{
							ChartInfo chart = new ChartInfo();
							request.setAttribute("chart", chart);
						}
					}
				%>
				<c:choose>
					<c:when test="${not empty chart.id}">
						<form action="<%=request.getContextPath()%>/chart/p2.jsp?id=${chart.id}" class="form-horizontal" role="form" method="post">
					</c:when>
					<c:otherwise>
						<form action="<%=request.getContextPath()%>/chart/p2.jsp" class="form-horizontal" role="form" method="post">
					</c:otherwise>
				</c:choose>
					<input type="hidden" value="${chart.id }" name="id"/>
<!-- 					<div class="form-group"> -->
<!-- 						<label for="name" class="col-sm-2 control-label">连接名称</label> -->
<!-- 						<div class="col-sm-5"> -->
<%-- 							<input data-rule="required;name;" id="name" name="name" class="form-control" value="${chart.name}"/> --%>
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">连接类型</label>
						<div class="col-sm-5">
							<select data-rule="required;connType" id="connType" name="connType" class="form-control ">
								<%
									request.setAttribute("chartConnType", DataCache.chartConnType);
								%>
								<c:forEach items="${chartConnType}" var="item">
						           <option <c:if test='${chart.connType == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">选择数据</label>
						<div class="col-sm-5">
							<select data-rule="required;dsId" id="dsId" name="dsId" class="form-control ">
								<%
									//request.setAttribute("dsList", DatasourceServices.selectList());
									request.setAttribute("dsList", AnalyticsServlet.anaTables());
								%>
								<option></option>
								<c:forEach items="${dsList}" var="item">
						           <option <c:if test='${chart.dsId == item.name}'>selected="selected"</c:if>value="${item.name}">${item.name}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
<%-- 							<a href="<%=request.getHeader("Referer")%>">返回</a> --%>
							<a href="javascript:history.go(-1);">返回</a> 
							<input type="submit" value="下一步" class="btn btn-primary" />
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>

</body>
</html>