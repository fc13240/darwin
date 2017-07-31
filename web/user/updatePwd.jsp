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
<title>修改密码</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%
		request.setAttribute("selectPage", Container.module_user);
	%>
	
	<div class="page-header" style="margin-top: 60px;">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					个人设置
				</div>
				<div class="page-header-links">
					个人设置 / 修改密码
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-12">
				<form action="<%=request.getContextPath()%>/manage/user?method=updatePwd" class="form-horizontal" role="form" method="post">
					
					<c:if test="${not empty sessionScope.updatePwdSuccess}">
						<div class="alert alert-success">${sessionScope.updatePwdSuccess}
						</div>
					</c:if>
					<%
						session.setAttribute("updatePwdSuccess",null);
					%>
					
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>原密码</label>
						<div class="col-sm-5">
							<input data-rule="required;oldPwd;remote[ajaxCheck?method=ajaxCheck]" value="${user.oldPwd}" class="form-control" id="oldPwd" name="oldPwd" type="password" placeholder="原密码">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>新密码</label>
						<div class="col-sm-5">
							<input data-rule="新密码:required;password" value="${user.password}" class="form-control" id="password" name="password" type="password" placeholder="新密码">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>确认密码</label>
						<div class="col-sm-5">
							<input data-rule="确认密码:required;password2;match(password);" value="${user.password2}" class="form-control" id="password2" name="password2" type="password" placeholder="确认密码">
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
<%-- 	<%@ include file="/resources/common_footer.jsp"%>	 --%>
</body>
</html>