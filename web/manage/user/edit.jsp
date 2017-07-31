<%@page import="com.stonesun.realTime.services.db.sys.UserServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
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
<title>用户编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%
		request.setAttribute("selectPage", Container.module_user);
	%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<%
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						UserInfo pro = UserServices.selectById(Integer.valueOf(id));
						request.setAttribute("user", pro);
					}
				%>
				<form action="<%=request.getContextPath()%>/manage/user?method=save" class="form-horizontal" role="form" method="post">
					<input type="hidden" value="${user.id }" name="id"/>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<a href="javascript:history.go(-1);">返回</a>
							<input type="submit" value="保存" class="btn btn-primary" />
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">昵称</label>
						<div class="col-sm-5">
							<input data-rule="required;nickname" value="${user.nickname}" class="form-control" id="nickname" name="nickname" placeholder="昵称">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-5">
							<input data-rule="required;username;remote[/manage/user?method=exist&id=${id}]" value="${user.username}" class="form-control" id="username" name="username" placeholder="用户名">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-5">
							<input data-rule="required;password" value="${user.password}" class="form-control" id="password" name="password" placeholder="密码">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">确认密码</label>
						<div class="col-sm-5">
							<input data-rule="required;password2" value="${user.password2}" class="form-control" id="password2" name="password2" placeholder="确认密码">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-5">
							<input data-rule="required;email" value="${user.email}" class="form-control" id="email" name="email" placeholder="邮箱">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>