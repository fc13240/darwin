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
<title>监控项列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "137");%>
	
	<form action="<%=request.getContextPath() %>/user/monitor?method=index" method="post" class="form-horizontal" role="form">
	<!-- page header start -->
		<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						监控项管理
					</div>
				</div>
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
								监控项管理
							</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
									<a style="display: none;" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/user/monitor/edit.jsp">新增监控</a>
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<div>监控项管理列表，找到 ${pager.total} 个监控对象</div>
					<p>
					</p>
					<table class="table table-hover table-striped">
							<tr>
								<c:if test="${isAdmin}"><th>ID</th></c:if>
								<th>监控名称</th>
								<th>监控类型</th>
								<th>监控对象</th>
								<th width="150px">操作</th>
							</tr>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<c:if test="${isAdmin}"><td>${stu.id}</td></c:if>
									<td>${stu.name}</td>
									<td>${stu.type}</td>
									<td>${stu.target}</td>
									<td>
										<a code="select" href="<%=request.getContextPath() %>/user/monitor/edit.jsp?id=${stu.id}">编辑</a>
										<a code="save" href="<%=request.getContextPath() %>/user/trigger/edit.jsp?monitorId=${stu.id}">增加告警</a>
<%-- 										<a code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/user/monitor?method=deleteById&id=${stu.id}">删除</a> --%>
										<a code="delete" onclick="return confirmDel(this,${stu.id})" href="#">删除</a>
									</td>
								</tr>
							</c:forEach>
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
	</c:if> --%>
	<script>
		function confirmDel(thisObj,id){
			if (confirm("确定要删除此监控项吗？")) {
				del(thisObj,id);
				return true;
			}
			return false;
		}
		
		function del(thisObj,id){
			createMark();
			var _url = "<%=request.getContextPath() %>/user/monitor?method=deleteById";
			$.ajax({
				url:_url,
				data:{
					"id":id,
				},
				type:"post",
				dataType:"text",
				async:true,
				success:function(data, textStatus){
					console.log("deleteById+"+data);
					if(data=='0'){
						location.reload();
						return;
					}else if(data=='-1'){
						alert("删除失败！");
					}else{
						alert("删除失败！此监控项正在告警"+data+"中使用！");
					}
					$.unblockUI();
				}
				,error:function(err){
					console.log(err);
					$.unblockUI();
					alert("删除失败！"+err.responseText);
				}
			});
		}
	</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>