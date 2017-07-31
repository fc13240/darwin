<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
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
					<a href="<%=request.getContextPath() %>/chart?method=index2">图表管理</a> / <a href="<%=request.getContextPath() %>/chart/edit.jsp">添加图表</a> / 配置分析规则
				</div>
			</div>
		</div>
	</div>
	
	<div class="container" style="margin-bottom: 100px;">
		<div class="row">
			<form action="<%=request.getContextPath()%>/chart?method=save" class="form-horizontal" role="form" method="post">
			<%
				ChartInfo chart = null;
				String id = request.getParameter("id");
				if(StringUtils.isNotBlank(id) && Integer.valueOf(id) > 0){
					//更新上一步的数据
					//ChartInfo chartInfo = new ChartInfo();
					//chartInfo.setName(name);
					//chartInfo.setConnType(connType);
					//chartInfo.setDsId(dsId);
					//ChartServices.update_p2(chartInfo);
					
					chart = ChartServices.selectById(Integer.valueOf(id));
					
					request.setAttribute("chart", chart);
				}else{
					chart = (ChartInfo)session.getAttribute(Container.session_insert_chart);
				}
				
				String[] checkboxArray = request.getParameterValues("checkbox1");
				if(checkboxArray==null || checkboxArray.length==0){
					System.out.println("checkboxArray="+checkboxArray.length);
					chart.setDs_fields(new JSONArray());
				}else{
					JSONArray ds_fields = new JSONArray();
					for(int i=0;i<checkboxArray.length;i++){
						System.out.println("checkboxArray="+checkboxArray[i]);
						String[] _item = checkboxArray[i].split(":");
						JSONObject _obj = new JSONObject();
						_obj.put("name", _item[0]);
						_obj.put("type", _item[1]);
						ds_fields.add(_obj);
					}
					chart.setDs_fields(ds_fields);
				}
				
				System.out.println("chart.getFields()="+chart.getDs_fields());
				request.setAttribute("groupFields", chart.getDs_fields());
				request.setAttribute("chartTypeList", DataCache.chartTypeList);
			%>
			<div class="col-md-3">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">图列表</h3>
<%-- 						${chart.chartType} --%>
					</div>
					<ul class="list-group">
						<c:forEach items="${chartTypeList}" var="item">
							<li class="list-group-item">
								<label>
								
								</label>
								<input data-rule="checked" type="radio" name="chartType" value="${item.key}" 
								<c:if test='${chart.chartType == item.key}'>checked="checked"</c:if>/>${item.value}
							</li>
						</c:forEach>
					</ul>
				</div>
				
			</div>
			<div class="col-md-9">
					<input type="hidden" value="${chart.id }" name="id"/>
					
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;" id="name" name="name" class="form-control" value="${chart.name}"/>
						</div>
					</div>
					<div class="form-group">
						<label for="quota" class="col-sm-2 control-label">指标</label>
						<div class="col-sm-3">
							<select data-rule="required;quota" id="quota" name="quota" class="form-control ">
								<option></option>
								<c:forEach items="${groupFields}" var="item">
						           <option <c:if test='${chart.quota == item.name}'>selected="selected"</c:if>value="${item.name}">${item.name}</option>
						        </c:forEach>
							</select>
						</div>
						<div class="col-sm-2">
							<select data-rule="required;connType" id="quotaFunc" name="quotaFunc" class="form-control ">
								<%
									request.setAttribute("chartConnType", DataCache.chartFuncList);
								%>
								<option></option>
								<c:forEach items="${chartConnType}" var="item">
						           <option <c:if test='${chart.quotaFunc == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="groupFields" class="col-sm-2 control-label">分组字段</label>
						<div class="col-sm-5">
							<select id="groupFields" name="groupFields" class="form-control ">
								<option></option>
								<c:forEach items="${groupFields}" var="item">
						           <option <c:if test='${chart.groupFields == item.name}'>selected="selected"</c:if>value="${item.name}">${item.name}</option>
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
				</div>
			</form>
		</div>
	</div>

</body>
</html>