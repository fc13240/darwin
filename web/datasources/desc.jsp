<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
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
<title>填写数据源配置信息</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%
		request.setAttribute("selectPage", Container.module_datasources);
	%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					添加离线数据源
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/datasources?method=index">数据源管理</a> / <a href="<%=request.getContextPath() %>/datasources/add.jsp">选择数据的添加方式</a> / 添加离线数据源
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<%
					String id = request.getParameter("id");
					String source = request.getParameter("source");
					String sourceType = request.getParameter("sourceType");
					DatasourceInfo ds = null;
					if(StringUtils.isNotBlank(id)){
						ds = DatasourceServices.selectById(id);

						request.setAttribute("ds", ds);
						source = ds.getSource();
						sourceType = ds.getSourceType();
					}else{
						source = request.getParameter("source");
						sourceType = request.getParameter("sourceType");
						
						ds = new DatasourceInfo();
						ds.setSource(source);
						ds.setSourceType(sourceType);
						request.setAttribute("ds", ds);
					}
					
					if(ds.getSource().equals(DatasourceInfo.ds_source_realTime)){
						ds.setAddLuceneIndex("y");
					}
				
					request.setAttribute("source",source);
					request.setAttribute("sourceType",sourceType);
					request.setAttribute("dsConnMap", DataCache.dsConnMap.get(source));
					request.setAttribute("charsetList", DataCache.charsetList);
				%>
				
				<%!
				String getIdParam(HttpServletRequest request){
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						return "&id="+id;
					}
					return "";
				}
				%>
				<form
					action="<%=request.getContextPath()%>/datasources?method=toDone&source=${source}&sourceType=${sourceType}<%=getIdParam(request) %>"
					class="form-horizontal" role="form" method="post">
					<input name="sourceType" value="${sourceType}" type="hidden"/>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<ul class="darwin-page-op-nav">
								<li>
									<a href="javascript:history.go(-1);">返回</a> 
								</li>
								<li>
									<input type="submit" value="下一步" class="btn btn-primary"/>
								</li>
							</ul>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">数据源名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;length[1~45]" value="${ds.name}" class="form-control" id="name" name="name" placeholder="数据源名称">
						</div>
						<div class="col-sm-4">
							<p class="help-block">
								用于描述您的数据源，便于之后的管理。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-sm-2 control-label">数据源注释</label>
						<div class="col-sm-5">
							<input data-rule="remark;length[~100]" class="form-control" value="${ds.remark}" id="remark" name="remark" placeholder="数据源注释">
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								用于详细描述您的数据源。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="tags" class="col-sm-2 control-label">标签</label>
						<div class="col-sm-5">
							<input data-rule="tags;length[~45]" class="form-control" value="${ds.tags}" id="tags" name="tags" placeholder="标签">
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								多个标签以逗号分隔。
							</p>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="hidden" id="addLuceneIndex_input" value="${ds.addLuceneIndex}"/>
							<input type="hidden" id="accelerate_input" value="${ds.accelerate}"/>
							<div class="checkbox">
								<label>
									<c:choose>
										<c:when test="${source eq 'realTime'}">
											<input type="checkbox" checked="${ds.addLuceneIndex}" id="addLuceneIndex" name="addLuceneIndex" class="disabled" disabled="disabled" title="实时流数据必须建立索引。">数据添加到索引
										</c:when>
										<c:otherwise>
											<input type="checkbox" checked="${ds.addLuceneIndex}" id="addLuceneIndex" name="addLuceneIndex">数据添加到索引
										</c:otherwise>
									</c:choose>
								</label>
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" checked="${ds.accelerate}" id="accelerate" name="accelerate">是否加速
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="tags" class="col-sm-2 control-label">所属项目</label>
						<div class="col-sm-5">
							<%
									//加载用户的项目列表
									session.setAttribute(Container.session_projectList,ProjectServices.selectList());
								%> <select data-rule="required;projectId" id="projectId" name="projectId" class="form-control">
									<option></option>
									<c:forEach items="${sessionScope.session_projectList}" var="item">
										<option
											<c:if test='${ds.projectId == item.id}'>selected="selected"</c:if>
											value="${item.id}">${item.name}</option>
									</c:forEach>
							</select>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								按照项目对数据源进行分门别类的管理，如需管理项目，请点击<a href="<%=request.getContextPath()%>/user/project?method=index" target="_blank">这里</a>。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="tags" class="col-sm-2 control-label">数据有效期(单位：天)</label>
						<div class="col-sm-5">
							<input class="form-control" value="${ds.validDay}" id="validDay" name="validDay" placeholder="数据有效期" value="0">
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								默认为0，数据永久有效。如果填写数字，则代表N天有效。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="tableName" class="col-sm-2 control-label">数据源英文名称(唯一标识)</label>
						<div class="col-sm-5">
							<input id="tableName" name="tableName" value="${ds.tableName}" class="form-control" placeholder="请输入数据源的表名" data-rule="required;tableName;remote[/datasources?method=exist&id=${ds.id}]" data-rule-tableName="[/^([a-zA-Z]|_)+([0-9]|[a-zA-Z]|_)*$/, '只能以字母、下划线开头，且不能包含特殊字符!']">
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								用于唯一标识数据源的英文名称。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="charset" class="col-sm-2 control-label">数据源编码</label>
						<div class="col-sm-5">
							<select data-rule="required;charset" id="charset" name="charset" class="form-control">
								<c:forEach items="${charsetList}" var="item">
									<option <c:if test='${ds.charset == item.key}'>selected="selected"</c:if>
										value="${item.key}">${item.value}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								请根据您的数据源，指定正确的编码，否则将会出现乱码问题。
							</p>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<%@ include file="/resources/common_footer.jsp"%>
	
	<script type="text/javascript">
	$(function(){
		var addLuceneIndex_input = $("#addLuceneIndex_input").val();		
		var accelerate_input = $("#accelerate_input").val();
		$("#addLuceneIndex_input").remove();
		$("#accelerate_input").remove();
		
		$("#addLuceneIndex").prop("checked",addLuceneIndex_input=="y" ? true : false);
		$("#accelerate").prop("checked",accelerate_input=="y" ? true : false);
	});
	</script>
</body>
</html>