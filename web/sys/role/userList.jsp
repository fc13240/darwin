<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>已授权用户列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "48");%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<form action="<%=request.getContextPath() %>/sys/role?method=index" method="post">
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						已授权用户列表管理
					</div>
				</div>
			</div>
		</div>
		<div class="container mh500">
			<div class="row">
		<%-- 	<c:if test="${empty plateform}">
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
									已授权用户列表管理
								</div>
								<div class="page-header-links">
									<a href="<%=request.getContextPath() %>/sys/role?method=index">角色管理列表</a> / 用户列表   / 当前操作角色【${pager.params.roleName}】
								</div>
							</div>
						</div>
					</div>
					<div>当前角色找到 ${pager.total} 个用户</div>
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<td style="width: 2%;"></td>
								<td style="width: 30%;">用户名/姓名</td>
								<td style="width: 38%;">所属部门</td>
								<td style="width: 30%;">操作</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<td></td>
									<td><a href="<%=request.getContextPath() %>/manage/user?method=edit&id=${stu.id}">${stu.username}(${stu.nickname})</a></td>
									<td>${stu.orgName}</td>
									<td>
										<a code="save" onclick="return cancelRole(${stu.id})" href="#">取消角色</a>
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
	<c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if>	
<script>
	function confirmDel(){
		if (confirm("你确定要删除吗？")) {  
			return true;
        }  return false;
	}

	function cancelRole(userId){
		var runFlg = false;
		if (confirm("您是否要取消这个用户的授权？")) {  
			runFlg=true;
        } 

		if(runFlg){
			createMark();
			var _url = "<%=request.getContextPath() %>/sys/role";
			$.ajax({
				url:_url,
				data:{
					"method":"cancelRole",
					"userId":userId
				},
				type:"get",
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					console.log("startStopFunc。。。"+data);
					var status = data.status;
					if(status){
	 					location.reload();
					}else{
						alert("请求失败！");
					}

					$.unblockUI();
				}
				,error:function(err){
					console.log(err);
					$.unblockUI();
					alert("请求失败！请联系管理员！");
				}
			});
		}
	}

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
