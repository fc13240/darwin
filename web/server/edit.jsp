<%@page import="com.stonesun.realTime.services.db.bean.ServerInfo"%>
<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>主机编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	
	<%request.setAttribute("topId", "121");%>
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
								主机编辑
							</div>
							<div class="page-header-links">
								<a href="<%=request.getContextPath() %>/server?method=index">主机管理</a> / 主机编辑
							</div>
						</div>
					</div>
				</div>
					<div class="col-md-9">
					<%
						String id = request.getParameter("id");
						if(StringUtils.isNotBlank(id)){
							ServerInfo pro = ServerServices.selectById(Integer.valueOf(id));
							request.setAttribute("server", pro);
						}
						request.setAttribute("id", id);
					%>
<%-- 					<form action="<%=request.getContextPath()%>/server?method=save" class="form-horizontal" role="form" method="post"> --%>
					<form class="form-horizontal" role="form" id="addhostform" notBindDefaultEvent="true">
						<input type="hidden" value="${server.id }" name="id"/>
						<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>服务器名称</label>
							<div class="col-sm-5">
								<input data-rule="required;name;length[1~45];remote[/ajaxServer?method=existName&id=${id}];" value="${server.name}" class="form-control" id="name" name="name" placeholder="服务器名称">
							</div>
						</div>
						<div class="form-group">
							<label for="host" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>主机地址</label>
							<div class="col-sm-5">
								<c:choose>
									<c:when test="${server.id gt 0}">
										<input data-rule="required;host;remote[/ajaxServer?method=existHost&id=${id}]" value="${server.host}" class="form-control" id="host" name="host" placeholder="host" readonly="readonly">
									</c:when>
									<c:otherwise>
										<input data-rule="required;host;remote[/ajaxServer?method=existHost&id=${id}]" value="${server.host}" class="form-control" id="host" name="host" placeholder="host">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group">
							<label for="rootPwd" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>root密码</label>
							<div class="col-sm-5">
								<c:choose>
									<c:when test="${server.id eq 0}">
										<input data-rule="required;" type="password" value="" class="form-control" id="rootPwd" name="rootPwd" placeholder="root的密码">
									</c:when>
									<c:otherwise>
										<input type="password" value="" class="form-control" id="rootPwd" name="rootPwd" placeholder="root的密码">
									</c:otherwise>
								</c:choose>
							</div>
							<c:if test="${not empty id }">
							<div class="col-sm-5">
								<label class="help-block">*root密码为空表示不做修改</label>
							</div>
							</c:if>
						</div>
						<div class="form-group">
							<label for="sshdPort" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>SSH端口</label>
							<div class="col-sm-5">
								<input data-rule="required;integer;range[1-65535]" value="${server.sshdPort}" class="form-control" id="sshdPort" name="sshdPort" placeholder="ssh的端口,默认22">
							</div>
						</div>
						<div class="form-group">
							<label for="communicatePort" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>Agent端口</label>
							<div class="col-sm-5">
								<input data-rule="required;integer;range[1-65535]" value="${server.communicatePort}" class="form-control" id="communicatePort" name="communicatePort" placeholder="Agent端口,默认18099">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label"></label>
							<div class="col-sm-5">
								<a href="javascript:history.go(-1);">返回</a>
								<input code="save" type="submit"  value="保存" class="btn btn-primary" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if> --%>
</body>

<script>
$(function() {
	$('#addhostform').validator({

    	valid: function(form){
    		console.log("valid ok");
        	createMark();
			$.ajax({
				url:'/ajaxServer?method=saveServer',
				data:$('#addhostform').serialize(),
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					console.log(data);
					$.unblockUI();
					var status = data.status;
					if(status){
						window.location.href="/server?method=index";
					}else{
						alert(data.cause);
					}
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("保存失败！");
				}
			});
    	},
    	invalid:function(form){
			console.log("invalid");
    	}
	});

});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</html>
