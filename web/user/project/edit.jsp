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
<title>项目编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%
		String id = request.getParameter("id");
		String flowId = request.getParameter("flowId");
		request.setAttribute("id", id);
		if(StringUtils.isNotBlank(id)){
			UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
			ProjectInfo pro = ProjectServices.selectById(Integer.valueOf(id),user1.getId());
			if(pro==null){
				response.sendRedirect("/resources/403.jsp");
				return;
			}
			request.setAttribute("project", pro);
		}
	%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<%request.setAttribute("topId", "1");%>
	<%request.setAttribute("flowId", flowId);%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					配置
				</div>
				<!-- 
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">配置</a> / 管理配置
				</div>
				 -->
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
		<%-- <c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								项目编辑
							</div>
							<div class="page-header-links">
								<a href="<%=request.getContextPath() %>/user/project?method=index">项目管理列表</a> / 项目编辑
							</div>
						</div>
					</div>
				</div>
				<div class="container mh500">
					<div class="row">
						<div class="col-md-12">
							<form action="<%=request.getContextPath()%>/user/project?method=save&flowId=${flowId}" class="form-horizontal" role="form" method="post">
								<input type="hidden" value="${project.id }" name="id"/>
								<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>项目名称</label>
									<div class="col-sm-5">
										<input data-rule="required;name;length[1~45];remote[/user/project?method=exist&id=${id}]" value="${project.name}" class="form-control" id="name" name="name" placeholder="项目名称">
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label"></label>
									<div class="col-sm-5">
										<a href="javascript:history.go(-1);">返回</a> 
										<input code="save" type="submit" value="保存" class="btn btn-primary" />
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if>	 --%>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
