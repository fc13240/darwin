<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>字典表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "1");%>

	<form action="<%=request.getContextPath() %>/user/trigger?method=index" method="post" >
		<!-- page header start -->
		<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
<!-- 		<div class="page-header" style="margin-top: 60px;"> -->
		<div class="page-header" >
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						字典管理
					</div>
<!-- 					<div class="page-header-links"> -->
<!-- 						字典管理列表 -->
<!-- 					</div> -->
				</div>
<!-- 				<div class="col-xs-6 col-md-6"> -->
<!-- 					<div class="page-header-op r"> -->
<%-- 					  <a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/trigger?method=edit">新增字典</a> --%>
<!-- 					</div> -->
<!-- 					<div class="page-header-op r" style="margin: 0 5px;"> -->
<!-- 						<select id="priority" name="priority" class="form-control"> -->
<%-- 						<% --%>
// 							request.setAttribute("taskPriority", DataCache.taskPriority);
<%-- 						%> --%>
<!-- 							<option value="">--选择等级--</option> -->
<%-- 							<c:forEach items="${taskPriority}" var="item"> --%>
<%-- 				           		<option <c:if test='${pager.params.priority == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option> --%>
<%-- 				       	    </c:forEach> --%>
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 					<div class="clear"></div> -->
<!-- 				</div> -->
			</div>
		</div>
		
		<!-- page header end -->	
		<!-- page content start -->
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
									字典管理
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
								  <a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/keyvalue?method=edit">新增字典</a>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<div>字典管理列表，找到 ${pager.total} 个字典对象</div>
					
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>字典名称</th>
								<th width="150px">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<td>${stu.id}</td>
									<td>${stu.field}</td>
									<td>
										<a href="keyvalue/edit.jsp?id=${stu.id}">编辑</a>
										<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/user/keyvalue?method=deleteById&id=${stu.id}">删除</a>
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
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if>	 --%>
	<script type="text/javascript">
	function confirmDel(){
		if (confirm("你确定要删除吗？")) {  
			return true;
        }  return false;
	}
	</script>
	
<script type="text/javascript">
	$("#priority").change(function(){
		var priority=$("#priority").val();
		href = "/user/trigger?method=index&priority="+priority;
		window.location.href=href;
		
	});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>