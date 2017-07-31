<%@page import="com.stonesun.realTime.services.db.TaskGroupServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.TaskGroupInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
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
<title>任务分组编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%
		request.setAttribute("selectPage", Container.module_project);
	%>

	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					任务组编辑
				</div>
				<div class="page-header-links">
					<a>个人设置</a> / <a>任务组管理</a> / 任务组编辑
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-12">
				<%
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						TaskGroupInfo pro = TaskGroupServices.selectById(Integer.valueOf(id));
						request.setAttribute("taskGroup", pro);
					}
				%>
				<form action="<%=request.getContextPath()%>/user/taskGroup?method=save" class="form-horizontal" role="form" method="post">
					<input type="hidden" value="${taskGroup.id }" name="id"/>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">任务组名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;length[1~45]" value="${taskGroup.name}" class="form-control" id="name" name="name" placeholder="任务组名称">
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<a href="javascript:history.go(-1);">返回</a> 
							<input type="submit" value="保存" class="btn btn-primary" />
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/resources/common_footer.jsp"%>	
</body>
</html>