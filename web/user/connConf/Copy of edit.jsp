<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="java.util.Map"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.bean.ConnConfInfo"%>
<%@page import="com.stonesun.realTime.services.db.ConnConfServices"%>
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
<title>链接编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%
		request.setAttribute("selectPage", Container.module_user);
	%>

	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					连接编辑
				</div>
				<div class="page-header-links">
					<a>连接管理</a> / 连接编辑
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<form action="<%=request.getContextPath() %>/user/connConf?method=save" method="post" class="form-horizontal" role="form">
				      <input name="id" type="hidden" value="${id}"/>
<%-- 				      <input name="type" type="hidden" value="${sourceType }"/> --%>
				      <!-- 连接配置 -->
	      			  <c:choose>
						<c:when test="${sourceType eq 'ftp' or 1==1}">
				      		  <div class="form-group">
							    <label for="type" class="col-sm-3 control-label">连接类型</label>
							    <div class="col-sm-5">
							      <select data-rule="required;type" id="type" name="type" class="form-control ">
										<%
											request.setAttribute("connTypeMap", DataCache.dsConnMap.get("offLine"));
										%>
										<option></option>
										<c:forEach items="${connTypeMap}" var="list">
								           <option <c:if test='${type == list.type}'>selected="selected"</c:if>value="${list.type}">${list.name}</option>
								        </c:forEach>
									</select>
							    </div>
							  </div>
				      		  <div class="form-group">
							    <label for="name" class="col-sm-3 control-label">ftp连接名称</label>
							    <div class="col-sm-5">
							      <input data-rule="required;name;length[1~45];remote[/user/connConf?method=exist&id=${id}]" class="form-control" id="name" name="name" value="${connConf.name }" placeholder="ftp连接名称">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="host" class="col-sm-3 control-label">主机名(Host)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;host;length[1~45]" class="form-control" id="host" name="host" value="${connConf.host }" placeholder="主机名(Host)">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="port" class="col-sm-3 control-label">端口号(Port)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;port;integer;" class="form-control" id="port" name="port" value="${connConf.port }" placeholder="端口号(Port)">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="username" class="col-sm-3 control-label">用户名(Username)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;username;length[1~45]" class="form-control" id="username" name="username" value="${connConf.username }" placeholder="用户名(Username)">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="password" class="col-sm-3 control-label">密码(Password)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;password;length[5~16]" type="password" class="form-control" id="password" name="password" value="${connConf.password }" placeholder="密码(Password)">
							    </div>
							  </div>
						</c:when>
						<c:when test="${sourceType eq 'scp'}">
						
						</c:when>
						<c:when test="${sourceType eq 'flume'}">
						
						</c:when>
					</c:choose>
					<div class="form-group">
					    <label for="name" class="col-sm-3 control-label"></label>
					    <div class="col-sm-5">
					    	<a href="javascript:history.go(-1);">返回</a> 
				           	<button type="submit" class="btn btn-primary" id="ajaxSubmit">保存</button>
					    </div>
					  </div>			
								
		    	</form>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<%@ include file="/resources/common_footer.jsp"%>	
</body>
</html>