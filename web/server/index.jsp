<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.UserServices"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>主机管理</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("topId", "121");%>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	
	<form action="<%=request.getContextPath() %>/server?method=index" method="post">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					主机管理
				</div>
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
				<!-- page header start -->
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								主机管理
							</div>
							<div class="page-header-links">
								主机管理列表
							</div>
						</div>
						<div class="col-xs-6 col-md-6">
							<div class="page-header-op r">
								<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/server?method=edit">新增主机</a>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->	
				<!-- page content start -->
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th style="display: none;">ID</th>
							<th>主机名称</th>
							<th>主机地址</th>
							<th>SSH端口</th>
							<th>Agent端口</th>
							<th>Agent状态</th>
							<th style="width: 100px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td style="display: none;">${stu.id}</td>
								<td>${stu.name}</td>
								<td>${stu.host}</td>
								<td>${stu.sshdPort}</td>
								<td>${stu.communicatePort}</td>
								<td>
									<c:choose>
										<c:when test="${stu.status eq 'add'}">新增</c:when>
										<c:when test="${stu.status eq 'success'}">已连接</c:when>
										<c:otherwise>连接失败</c:otherwise>
									</c:choose>
								</td>
								<td>
									<a code="select" href="server?method=edit&id=${stu.id}">编辑</a> 
									<a code="delete" onclick="delHost(${stu.id});">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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

	function delHost(hostid){
  		if (!confirm('您确定要删除这个主机吗？如果删除，可能会导致服务异常')) {
  			return false;
  		}

  		createMark();
  		$.ajax({
  			url:'/ajaxServer?method=deleteServerById&id='+hostid,
  			type:"post",
  			dataType:"json",
  			success:function(data, textStatus){
  				console.log(data);
  				$.unblockUI();
  				var status = data.status;
  				if(status){
  					alert("删除成功！");
  					window.location.href=window.location.href;
  					console.log("success");
  				}else{
  					alert(data.cause);
  				}
  			},error:function(err){
  				console.log("error")
  				console.log(err);
  				$.unblockUI();
  				alert("删除失败！");
  			}
  		});
  	}
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>