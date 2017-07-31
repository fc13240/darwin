<%@page import="com.stonesun.realTime.services.db.sys.GroupServices"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsHistoryInfo"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsHistoryServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>编辑分析</title>
<%@ include file="/resources/common.jsp"%>
<!-- <script type="text/javascript" src="/resources/js/jquery.blockUI.js"></script> -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<c:if test="${empty plateform}">
	<%@ include file="/resources/common_menu.jsp"%>
	</c:if>
	<div class="page-header" style="margin-top: 60px;">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
<!-- 					组织机构 -->
					权限管理
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">组织机构</a> / 权限管理
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
			<div class="col-md-2">
				 <div>
					<div id="loadImg" style="text-align: left;">
						<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
					</div>
					<ul id="treeDemo" style="display: none;" class="ztree"></ul>
				  </div>
			</div>
			<div class="col-md-4">
				<form id="rightForm" action="<%=request.getContextPath() %>/sys?method=save" method="post" class="form-horizontal" role="form">
				</form>
			</div>
			<div class="col-md-3">
				<div style="min-width: 200px;display: none;" id="menusTreeDiv">
					<input type="button" class="btn default-button" id="saveRolePrivilege"  value="修改角色权限"/>
					<div id="loadImg2" style="text-align: left;">
						<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
					</div>
					<ul id="treeDemo2" style="display: none;" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>
	
<div id="org_div">
	<div class="form-group">
		<div class="col-sm-offset-3 col-sm-10">
			<button class="btn btn-success" type="submit" id="saveOp">保存</button>
			<button class="btn btn-success" type="submit" id="saveOp">删除角色</button>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">编辑当前节点</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-3 control-label">type</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-3 control-label">id</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">组织名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="组织名称" id="name" name="name" data-rule="length[2~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">添加子节点</label>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-3 control-label"></label>
		<div class="col-sm-9">
			<input data-rule="checked" id="addOrgOrRole" name="addOrgOrRole" type="radio" checked="checked"/>添加组织机构
			<input data-rule="checked" id="addOrgOrRole" name="addOrgOrRole" type="radio" />添加角色
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-3 control-label">pid</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="children_pid" id="children_pid" name="children_pid" data-rule="length[2~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">组织名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="组织名称" id="children_name" name="children_name" data-rule="length[2~45];"/>
		</div>
	</div>
</div>

<div id="role_div">
	<div class="form-group">
		<div class="col-sm-offset-3 col-sm-10">
			<button class="btn btn-success" type="submit" id="saveOp">保存</button>
			<a class="btn btn-danger" href="#" id="delRole" onclick="return confirm('确定删除么？')">删除角色</a>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">编辑当前角色</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-3 control-label">type</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-3 control-label">id</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">角色名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="角色名称" id="name" name="name" data-rule="length[1~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">添加用户</label>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">用户名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="用户名称" id="username" name="username" data-rule="length[1~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">密码</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="密码" id="password" name="password" type="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">确认密码</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="确认密码" id="password2" name="password2" type="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="groupIds" class="col-sm-3 control-label">用户组</label>
		<div class="col-sm-9">
			<%
				request.setAttribute("groups", GroupServices.selectList());
			%>
			<c:forEach var="stu" items="${groups}">
				<div class="checkbox">
				    <label>
				      <input name="groupIds" type="checkbox" value="${stu.id}"> ${stu.name}
				    </label>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<!-- 
	<div class="form-group">
		<label for="pid" class="col-sm-3 control-label">pid</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="children_pid" id="children_pid" name="children_pid" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="用户组名称" id="children_name" name="children_name" data-rule="length[1~45];"/>
		</div>
	</div>
	 -->
</div>

<div id="group_div">
	<div class="form-group">
		<div class="col-sm-offset-3 col-sm-10">
			<button class="btn btn-success" type="submit" id="saveOp">保存</button>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">编辑当前用户组</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-3 control-label">type</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-3 control-label">id</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">用户组名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="用户组名称" id="name" name="name" data-rule="length[1~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">添加用户</label>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-3 control-label">pid</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="children_pid" id="children_pid" name="children_pid" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">用户名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="用户名称" id="children_name" name="children_name" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">密码</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="密码" id="children_password" name="children_password" type="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">确认密码</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="确认密码" id="children_password2" name="children_password2" type="password"/>
		</div>
	</div>
</div>

<div id="user_div">
	<div class="form-group">
		<div class="col-sm-offset-3 col-sm-10">
			<button class="btn btn-success" type="submit" id="saveOp">保存</button>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-10 control-label">编辑当前用户组</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-3 control-label">type</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-3 control-label">id</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">用户名称</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="用户名称" id="name" name="name" data-rule="length[1~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">密码</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="密码" id="password" name="password" type="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label">确认密码</label>
		<div class="col-sm-9">
			<input class="form-control input-inline" placeholder="确认密码" id="password2" name="password2" type="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="groupIds" class="col-sm-3 control-label">用户组</label>
		<div class="col-sm-9">
			<%
				request.setAttribute("groups", GroupServices.selectList());
			%>
			<c:forEach var="stu" items="${groups}">
				<div class="checkbox">
				    <label>
				      <input name="groupIds" type="checkbox" value="${stu.id}"> ${stu.name}
				    </label>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
	
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<SCRIPT type="text/javascript">

$(function(){
	
});

</script>
<SCRIPT type="text/javascript">
$(function(){
	
	var org_div = $("#org_div").clone(true);
	var role_div = $("#role_div").clone(true);
	var group_div = $("#group_div").clone(true);
	var user_div = $("#user_div").clone(true);
// 	$("#saveOp").click(function(){
// 		console.log("saveOp...");
// 	});
	
	$("#org_div").remove();
	$("#role_div").remove();
	$("#group_div").remove();
	$("#user_div").remove();
	
	var setting = {
		check: {
			enable: false,
			dblClickExpand: true
		},callback: {
			onMouseDown: onMouseDown
		}
	};
	
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
				
// 				console.log(ids);
			}
		}
	};
	
	//加载组织机构菜单树
	function loadOrgTree(){
		$.ajax({
			url:"<%=request.getContextPath() %>/sys?method=tree",
			type:"post",
			dataType:"text",
			success:function(data, textStatus){
				var zNodes = eval('('+data+')');
				
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				$("#loadImg").hide();
				$("#treeDemo").show();
				
// 				$("span").remove(".ico_docu");
			},
			error:function(){
				console.log("加载数据出错！");
				alert("本次操作请求失败！");
			}
		});
	}
	
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
				
// 				$("span").remove(".ico_docu");
			},
			error:function(){
				console.log("加载数据出错！");
				alert("本次操作请求失败！");
			}
		});
	}
	
	loadOrgTree();

	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		
		if(!treeNode || !treeNode["id"]){
			console.log("节点无效...");
			return;
		}
		
		if(treeNode["nodeType"]=="org"){
			$("#rightForm").html("").append(org_div.html());
		}else if(treeNode["nodeType"]=="role"){
			$("#rightForm").html("").append(role_div.html());
		}else if(treeNode["nodeType"]=="group"){
			$("#rightForm").html("").append(group_div.html());
		}else if(treeNode["nodeType"]=="user"){
			$("#rightForm").html("").append(user_div.html());
		}
		//load data
		$.ajax({
			url:"<%=request.getContextPath() %>/sys?method=select&id=" + treeNode["id"] + "&type=" + treeNode["nodeType"],
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log(data);
				$("#menusTreeDiv").hide();
				$("#rightForm").find("#type").val(treeNode["nodeType"]);
// 				console.log("nodeType="+treeNode["nodeType"]);
				if(treeNode["nodeType"]=="org"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.name);
				}else if(treeNode["nodeType"]=="role"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.name);
					
					
					var delUrl = "<%=request.getContextPath() %>/sys?method=delRole&id="+data.id;
					$("#rightForm").find("#delRole").attr("href",delUrl);
					
					loadMenusTree(data.id);
				}else if(treeNode["nodeType"]=="group"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.name);
				}else if(treeNode["nodeType"]=="user"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.username);
					var groupIds = data.groupIds;
					if(groupIds && groupIds!=''){
						var groupIdsArray = groupIds.split(",");
						for(var i=0;i<groupIdsArray.length;i++){
							var gid = groupIdsArray[i];
							$("input[name='groupIds']").each(function(){
								if($(this).val()==gid){
									$(this).prop("checked",true);
								}
							});
						}
					}
					
// 					$("#rightForm").find("#password").val(data.password);
// 					$("#rightForm").find("#password2").val(data.password);
				}
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				alert("本次操作请求失败！");
				$.unblockUI();
			}
		});
	}
	
	$("#saveRolePrivilege").click(function(){
		createMark();
		var roleId = $("#rightForm").find("#id").val();
	
		var ids = "";
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length==0){
			return false;
		}
		for(var i=0;i<nodes.length;i++){
			ids+=nodes[i].id+",";
		}
		
// 		console.log(roleId);
// 		console.log(ids);
		
// 		if(ids == ""){
// 			alert("");
// 			return;
// 		}
		
		$.ajax({
			url:"<%=request.getContextPath() %>/sys?method=saveRolePrivilege&roleId=" + roleId + "&ids=" + ids,
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log(data);
				$.unblockUI();
				alert("添加权限成功！");
				$.unblockUI();
			},
			error:function(){
				console.log("请求失败！");
				alert("本次操作请求失败！");
				$.unblockUI();
			}
		});
		
	});
});
</SCRIPT>

</body>
</html>