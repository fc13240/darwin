<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.stonesun.realTime.services.db.hive.bean.ColumnInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.bean.AnaTree"%>
<%@page import="com.stonesun.realTime.services.servlet.AnalyticsServlet"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="java.util.List"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
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
					<a href="<%=request.getContextPath() %>/chart?method=index2">图表管理</a> / <a href="<%=request.getContextPath() %>/chart/edit.jsp">添加图表</a> / 选择分析列
				</div>
			</div>
		</div>
	</div>
	
	<div class="container" style="margin-bottom: 100px;">
		<div class="row">
			<div class="col-md-12">
				<%
					ChartInfo chart = null;
					String id = request.getParameter("id");
					//String name = request.getParameter("name");
					String connType = request.getParameter("connType");
					String dsId = request.getParameter("dsId");
					
					System.out.println("===========id==="+id);
					
					if(StringUtils.isNotBlank(id) && Integer.valueOf(id) > 0){
						if(StringUtils.isBlank(dsId)){
							chart = ChartServices.selectById(Integer.valueOf(id));
							dsId = chart.getDsId();
							connType = chart.getConnType();
						}
						
						//更新上一步的数据
						ChartInfo chartInfo = new ChartInfo();
// 						chartInfo.setName(name);
						chartInfo.setConnType(connType);
						chartInfo.setDsId(dsId);
						chartInfo.setId(Integer.valueOf(id));
						ChartServices.update_p1(chartInfo);
						
						chart = ChartServices.selectById(Integer.valueOf(id));
						
						
						System.out.println("===========dsId==="+dsId);
						
						request.setAttribute("chart", chart);
					}else{
						request.setAttribute("chart", new ChartInfo());
						
						chart = (ChartInfo)session.getAttribute(Container.session_insert_chart);
						if(chart==null){
							chart = new ChartInfo();
						}
					}
					
// 					chart.setName(name);
					chart.setConnType(connType);
					chart.setDsId(dsId);
					
					//根据上一步选择的信息,读取出数据源的解析信息
					//DatasourceInfo dataInfo = DatasourceServices.selectById(chart.getDsId());
					//JSONArray ds_fields = JSON.parseObject(dataInfo.getRuleConf()).getJSONArray("columns");
					//request.setAttribute("ds_fields", ds_fields);
					//chart.setDs_fields(ds_fields);
					
					//try{
						List<ColumnInfo> columns = AnalyticsServlet.anaColumns(dsId);
						request.setAttribute("ds_fields", columns);
						
						JSONArray ds_fields = new JSONArray();
						ds_fields.addAll(columns);
						chart.setDs_fields(ds_fields);
						
						session.setAttribute(Container.session_insert_chart,chart);
					//}catch(Exception e){
					//	e.printStackTrace();
					//}
				%>
				<c:choose>
					<c:when test="${not empty chart.id}">
						<form action="<%=request.getContextPath()%>/chart/p3.jsp?id=${chart.id}" class="form-horizontal" role="form" method="post">
					</c:when>
					<c:otherwise>
						<form action="<%=request.getContextPath()%>/chart/p3.jsp" class="form-horizontal" role="form" method="post">
					</c:otherwise>
				</c:choose>
					<input type="hidden" value="${chart.id}" name="id"/>
					
					<table class="table table-bordered">
						<tr class="success">
							<td><input type="checkbox" id="checkboxOp"/></td>
							<td>列名称</td>
							<td>列格式</td>
						</tr>
						<c:forEach var="stu" items="${ds_fields}">
							<tr>
								<td><input type="checkbox" name="checkbox1" value="${stu.name}:${stu.type}"/></td>
								<td>${stu.name}</td>
								<td>${stu.type}</td>
							</tr>
						</c:forEach>
					</table>
				
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
<%-- 							<a href="<%=request.getHeader("Referer")%>">返回</a>  --%>
							<a href="javascript:history.go(-1);">返回</a> 
							<input type="submit" value="下一步" class="btn btn-primary" />
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>
<script type="text/javascript">
$(function(){
	$("#checkboxOp").prop("checked",true);
	$("input[name='checkbox1']").each(function(){
   		$(this).prop("checked",true);
    });
	
	$("#checkboxOp").click(function(){
		$("input[name='checkbox1']").each(function(){
	   		$(this).prop("checked",!this.checked);
	    });
	});
});
</script>
</body>
</html>