<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>角色列表</title>
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
						角色管理
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
									角色管理
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
									<a code="save" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/sys/role?method=edit">新增角色</a>
								</div>
								<div class="page-search r">
									<div class="form-group">
										<div class="input-group">
											<input type="search" placeholder="角色名称" name="name" value="${pager.params.name}" class="form-control" >
											<span class="input-group-btn">
												<button class="btn" type="submit" href="<%=request.getContextPath() %>/sys/role?method=index">
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
					<!-- page header end -->	
					<!-- page content start -->
					<div>当前找到 ${pager.total} 个角色</div>
					<table class="table table-hover table-striped">
						<thead>
							<tr>
<!-- 								<td  style="width: 100px;">ID</td> -->
								<td style="width: 25%;">角色名称</td>
								<td style="width: 25%;">添加时间</td>
								<td style="width: 15%;">用户数</td>
								<td style="width: 15%;">状态</td>
								<td style="width: 20%;text-align: center;">操作</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
<%-- 									<td>${stu.id}</td> --%>
									<td>${stu.name}</td>
									<td>${stu.createTime}</td>
									<td>${stu._totalUser}</td>
									<td id="ajaxStatus${stu.id}">
										<c:choose>
											<c:when test="${stu.status eq 'y'}">
												正常
											</c:when>
											<c:otherwise>
												禁用
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<a code="select" href="<%=request.getContextPath() %>/sys/role?method=edit&id=${stu.id}">编辑</a>&nbsp; 
										<c:choose>
											<c:when test="${empty stu.status or stu.status eq 'n'}">
												<a id="changeStatusId${stu.id}" code="save" href="#" onclick="return startStopFunc('onlineRole',${stu.id})">启用</a>
											</c:when>
											<c:otherwise>
												<a id="changeStatusId${stu.id}" code="save" href="#" onclick="return startStopFunc('offlineRole',${stu.id})">禁用</a>
											</c:otherwise>
										</c:choose> &nbsp;
										<a href="<%=request.getContextPath() %>/sys/role?method=userList&roleId=${stu.id}&roleName=${stu.name}">用户列表</a> &nbsp;
<!-- 										<a id="select-udc-his" href="#">用户列表</a> &nbsp; -->
<%-- 										<a href="<%=request.getContextPath() %>/sys/role?method=edit&id=${stu.id}">功能权限关联</a>  --%>
										<a code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/sys/role?method=deleteById&id=${stu.id}">删除</a>
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
<%-- 	<c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>	
	</c:if> --%>
<script>
	function confirmDel(){
		if (confirm("你确定要删除吗？")) {  
			return true;
        }  return false;
	}

	function startStopFunc(flg,roleId){
		var runFlg = false;
		var statusMess="";
		var statusOncick="";
		var statusOncickEvent="";
		if(flg=="onlineRole"){
			if (confirm("您确认要启用这个角色吗？")) {  
				runFlg=true;
				statusMess = "正常";
				statusOncick = "禁用";
				statusOncickEvent = "return startStopFunc('offlineRole',"+roleId+")";
	        }  
		}else{
			if (confirm("您确认要禁用这个角色吗？")) {  
				runFlg=true;
				statusMess = "禁用";
				statusOncick = "启用";
				statusOncickEvent = "return startStopFunc('onlineRole',"+roleId+")";
	        }
		}

		if(runFlg){
			createMark();
			var _url = "<%=request.getContextPath() %>/sys/role";
			$.ajax({
				url:_url,
				data:{
					"method":flg,
					"roleId":roleId
				},
				type:"get",
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					console.log("startStopFunc。。。"+data);
					var status = data.status;
					if(status){
						$("#ajaxStatus"+roleId).text(statusMess);
						$("#changeStatusId"+roleId).text(statusOncick);
						$("#changeStatusId"+roleId).attr("onclick",statusOncickEvent);
//	 					location.reload();
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

	$('#select-udc-his').click(function(){
		layer.open({
			title:"用户列表",
		    type: 2,
		    area: ['900px', '500px'],
		    closeBtn: true,
		    shadeClose: true,
		    skin: 'layui-layer-molv', //墨绿风格
		    fix: false, //不固定
		    content: '/sys/role/userList.jsp'
		});
	});
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
