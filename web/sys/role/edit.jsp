<%@page import="com.stonesun.realTime.services.db.bean.sys.RoleInfo"%>
<%@page import="com.stonesun.realTime.services.db.sys.RoleServices"%>
<%@page import="com.stonesun.realTime.services.db.sys.GroupServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.sys.GroupInfo"%>
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
<title>角色编辑</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<%request.setAttribute("topId", "48");%>
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
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
								角色编辑
							</div>
							<div class="page-header-links">
								<a href="<%=request.getContextPath() %>/sys/role?method=index">角色管理列表</a> / 角色编辑
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-9">
					<%
						String id = request.getParameter("id");
						if(StringUtils.isNotBlank(id)){
							RoleInfo role = RoleServices.selectById(Integer.valueOf(id));
							request.setAttribute("role", role);
						}
					%>
					<form action="<%=request.getContextPath()%>/sys/role?method=save" class="form-horizontal" role="form" method="post" >
						<input type="hidden" value="${role.id}" name="id" id="id"/>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label"></label>
							<div class="col-sm-5">
								<a href="javascript:history.go(-1);">返回</a>
								<input code="save" id="saveRolePrivilege" value="保存" class="btn btn-primary" />
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>角色名称</label>
							<div class="col-sm-5">
								<input data-rule="required;name;length[2~45];remote[/sys/role?method=exist&id=${role.id}]" value="${role.name }" class="form-control" id="name" name="name" placeholder="角色名称">
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">角色权限</label>
							<div class="col-sm-5">
								<div class="col-md-3">
									<div style="min-width: 200px;display: none;" id="menusTreeDiv">
<!-- 										<input type="button" class="btn default-button" id="saveRolePrivilege"  value="修改角色权限"/> -->
										<div id="loadImg2" style="text-align: left;">
											<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
										</div>
										<ul id="treeDemo2" style="display: none;" class="ztree"></ul>
									</div>
								</div>
								
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<%-- 	<c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if> --%>
	<script type="text/javascript">
	$('input[name="name"]').trigger("validate");
// 	$('#form').trigger("submit");
	$(function(){
		var setting2 = {
				check: {
					enable: true,
					dblClickExpand: true
				},callback: {
					onCheck:function(){
						var ids = "";
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
						var nodes = treeObj.getCheckedNodes(true);
						if(nodes.length==0){
							return false;
						}
						for(var i=0;i<nodes.length;i++){
							ids+=nodes[i].id+",";
						}
						
// 						console.log(ids);
					}
				}
			};

		//加载资源菜单树
		function loadMenusTree(roleId){
			$("#menusTreeDiv").show();
			$.ajax({
				url:"<%=request.getContextPath() %>/sys?method=menuTree&roleId="+roleId,
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
					$("#loadImg2").hide();
					$("#treeDemo2").show();
					
//		 				$("span").remove(".ico_docu");
				},
				error:function(){
					console.log("加载数据出错！");
					alert("本次操作请求失败！");
				}
			});
		}
		
		loadMenusTree($("#id").val());
		
		
		$("#saveRolePrivilege").click(function(){
			if($.trim($("#name").val())==''){
				$("#name").focus();
				return;
			}
			createMark();
			var roleName = encodeURI($("#name").val());
			$.ajax({
				url:"/sys/role?method=exist01&name="+roleName+"&id="+$("#id").val(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					if(data == "0"){
						$.unblockUI();
						$("#name").focus();
						return;
					}else {

						var roleId = $("#id").val();
						var ids = "";
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
						var nodes = treeObj.getCheckedNodes(true);
// 						console.log(nodes);
						if(nodes.length==0){
							alert("请勾选角色的权限！");
							$.unblockUI();
							return false;
						}
						for(var i=0;i<nodes.length;i++){
							ids+=nodes[i].id+",";
						}
						
// 						console.log(roleId);
// 						console.log(ids);
						
				 		if(ids == ""){
				 			$.unblockUI();
				 			alert("请勾选角色的权限！");
				 			return;
				 		}
				 		
// 				 		createMark();
						$.ajax({
							url:"<%=request.getContextPath() %>/sys/role?method=save&roleId=" + roleId + "&ids=" + ids+"&name="+roleName,
							type:"post",
							dataType:"json",
							success:function(data, textStatus){
// 								console.log(data);
								
								alert("添加权限成功！");
								if(data >0){
			<%-- 						location.href = "<%=request.getContextPath() %>/sys/role?method=edit&id="+data; --%>
									location.href = "/sys/role?method=index";
								}
								
			// 					$.unblockUI();
								$.unblockUI();
							},
							error:function(){
								console.log("请求失败！");
								alert("本次操作请求失败！");
								$.unblockUI();
							}
						});
					}
				},
				error:function(){
					console.log("请求失败！");
				}
			});
			});
		
		
	});
	</script>
	<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
