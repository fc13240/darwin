<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>自定义数据获取脚本管理</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "1");%>
	<form action="<%=request.getContextPath() %>/script?method=index" method="post" class="form-horizontal" role="form">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					自定义数据获取脚本管理
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
			</div>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-3 col-md-3">
							<div class="page-header-desc">
								<a code="save" type="button" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/script/edit.jsp">添加脚本</a>
							</div>
						</div>
						<div class="col-xs-9 col-md-9">
							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="脚本名称" name="name" value="${pager.params.name}" class="form-control" >
										<span class="input-group-btn">
											<button class="btn" type="submit" href="script?method=index">
												<span class="fui-search"></span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<div>当前找到 ${pager.total} 个自定义数据获取脚本</div>
				<p>
				</p>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<c:if test="${isAdmin}"><th>ID</th></c:if>
							<th>名称</th>
							<th style="width: 200px;">添加日期</th>
							<th>类型</th>
							<th>描述</th>
							<th>状态</th>
							<th style="width: 100px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<c:if test="${isAdmin}"><td>${stu.id}</td></c:if>
								<td>${stu.name}<p>${stu.version}</p>
								</td>
								<td>${stu.createTime}</td>
								<td>${stu.type}</td>
								<td>${stu.remark}</td>
								<td>${stu.status}</td>
								<td>
									<a code="select" href="script?method=edit&id=${stu.id}">编辑</a>
									<br>
									<a code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/script?method=deleteById&id=${stu.id}">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
				<div>
					<%@ include file="/resources/pager.jsp"%>
				</div>
			</div>
		</div>
	</div>
	</form>
<%-- <%@ include file="/resources/common_footer.jsp"%> --%>
	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
	</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>