<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>资源菜单</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "48");%>
	<%
// 		UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
// 		if(user1 != null){
// 			if(!"1".equals(user1.getRoleId())){
// 				response.sendRedirect("/resources/403.jsp");
// 				return;
// 			}
// 		}
	%>

	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					资源管理
				</div>
<!-- 				<div class="page-header-links"> -->
<%-- 					<a href="<%=request.getContextPath() %>/analytics?method=index">组织机构</a> / 角色权限管理 --%>
<!-- 				</div> -->
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
			<div class="col-md-3">
				<button code="delete" id="deleteMenus" class="btn btn-danger btn-sm">删除选中菜单</button>
				<input type="checkbox" id="deleteParent"/>级联删除父节点
			    <div style="min-width: 200px;">
					<div id="loadImg" style="text-align: left;">
						<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
					</div>
					<ul id="treeDemo" style="display: none;" class="ztree"></ul>
				</div>
			</div>
			<div class="col-md-6">
				<form id="rightForm" action="<%=request.getContextPath() %>/sys?method=save" method="post" class="form-horizontal" role="form">
				</form>
			</div>
		</div>
	</div>
	
<div id="module_div">
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button code="save" class="btn btn-success" type="submit">保存</button>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-5 control-label">编辑当前模块</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-2 control-label">type</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">id</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">模块名称</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="模块名称" id="name" name="name"/>
		</div>
	</div>
	<div class="form-group">
		<label for="top_orderNum" class="col-sm-2 control-label">排序</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="排序" id="top_orderNum" name="top_orderNum" value=""/>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-5 control-label">添加子节点</label>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-2 control-label"></label>
		<div class="col-sm-5">
			<input data-rule="checked;" name="addModuleOrPage" type="radio" checked="checked" value="topModule"/>添加顶级模块
			<input data-rule="checked;" name="addModuleOrPage" type="radio" checked="checked" value="module"/>添加子模块
			<input data-rule="checked;" name="addModuleOrPage" type="radio" value="page"/>添加页面
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-2 control-label">pid</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="children_pid" id="children_pid" name="children_pid" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">名称</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="名称" id="children_name" name="children_name" data-rule="length[2~45]"/>
		</div>
	</div>
	<div class="form-group" style="display: none;">
		<label for="children_url" class="col-sm-2 control-label">url</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="url" id="children_url" name="children_url"/>
		</div>
	</div>
	<div class="form-group">
		<label for="children_orderNum" class="col-sm-2 control-label">排序</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="排序" id="children_orderNum" name="children_orderNum" value=""/>
		</div>
	</div>
</div>

<div id="page_div">
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button code="save" class="btn btn-success" type="submit">保存</button>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-5 control-label">编辑当前页面</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-2 control-label">type</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">id</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">页面名称</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="页面名称" id="name" name="name" data-rule="length[2~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="url" class="col-sm-2 control-label">url</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="url" id="url" name="url"/>
		</div>
	</div>
	<div class="form-group">
		<label for="orderNum" class="col-sm-2 control-label">排序</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="排序" id="orderNum" name="orderNum"/>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-5 control-label">添加按钮</label>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-2 control-label">pid</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="children_pid" id="children_pid" name="children_pid" data-rule="length[2~45];" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">按钮名称</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="按钮名称" id="children_name" name="children_name" data-rule="length[2~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="buttonCode" class="col-sm-2 control-label">按钮编码</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="按钮编码" id="buttonCode" name="buttonCode" data-rule="length[2~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="orderNumButton" class="col-sm-2 control-label">排序</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="排序" id="orderNumButton" name="orderNumButton"/>
		</div>
	</div>
</div>

<div id="button_div">
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button code="save" class="btn btn-success" type="submit">保存</button>
		</div>
	</div>
	<div class="form-group">
		<label for="pid" class="col-sm-5 control-label">编辑当前按钮</label>
	</div>
	<div class="form-group">
		<label for="type" class="col-sm-2 control-label">type</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">id</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="id" id="id" name="id" readonly="readonly"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">按钮名称</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="按钮名称" id="name" name="name" data-rule="length[2~45];"/>
		</div>
	</div>
	<div class="form-group">
		<label for="url" class="col-sm-2 control-label">按钮编码</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="按钮编码" id="url" name="url"/>
		</div>
	</div>
	<div class="form-group">
		<label for="orderNum" class="col-sm-2 control-label">排序</label>
		<div class="col-sm-5">
			<input class="form-control input-inline" placeholder="排序" id="orderNum" name="orderNum"/>
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
	var module_div = $("#module_div").clone(true);
	var page_div = $("#page_div").clone(true);
	var button_div = $("#button_div").clone(true);
	
	$("#module_div").remove();
	$("#page_div").remove();
	$("#button_div").remove();
	
	var setting = {
			check: {
				enable: true,
				dblClickExpand: true
			},callback: {
				onMouseDown: onMouseDown
			}
	};
	
	//加载菜单树
	function loadMenusTree(){
		$.ajax({
				url:"<%=request.getContextPath() %>/sys?method=menuTree",
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					$("#loadImg").hide();
					$("#treeDemo").show();
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
	}
	
	loadMenusTree();

	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		if(!treeNode || !treeNode["id"]){
			console.log("点击无效！");
			return;
		}

// 		console.log("nodeType="+treeNode["nodeType"]);
		if(treeNode["nodeType"]=="module"){
			$("#rightForm").html("").append(module_div.html());
		}else if(treeNode["nodeType"]=="page"){
			$("#rightForm").html("").append(page_div.html());
		}else if(treeNode["nodeType"]=="button"){
			$("#rightForm").html("").append(button_div.html());
		}

		var pagePrivilegeBtns = $("#pagePrivilegeBtns").text();
		if($.trim(pagePrivilegeBtns)!=''){
			var btns = pagePrivilegeBtns.split(",");
// 			console.log("btns:"+btns);
			$("button,a").each(function(index,value){
				var code = $(value).attr("code");
				if(code && $.trim(code)!=''){
					setCompDisabled(btns,code,value);
				}
			});
			
		}

		function setCompDisabled(btns,code,codeThis){
			var find = false;
			for(var b in btns){
				if(btns[b]==code){
					find = true;
					break;
				}
			}
			if(!find){
				$(codeThis).attr("disabled",!find).attr("href","javascript:void(0);");
				$(codeThis).attr("onclick","");
				$(codeThis).css({"cursor":"not-allowed","color":"#999"});
				$(codeThis).off();
			}
		}
		
		$.ajax({
			url:"<%=request.getContextPath() %>/sys?method=select&id=" + treeNode["id"] + "&type=" + treeNode["nodeType"],
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log(data);
				$("#rightForm").find("#type").val(treeNode["nodeType"]);
// 				console.log("nodeType="+treeNode["nodeType"]);
				if(treeNode["nodeType"]=="module"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.name);
					$("#rightForm").find("#top_orderNum").val(data.orderNum);
					
					$("#rightForm").find("input[name=addModuleOrPage]").click(function(){
// 						console.log($(this).val());
						if($(this).val()=="page"){
							$("#rightForm").find("#children_url").parent().parent().show();
						}else{
							$("#rightForm").find("#children_url").parent().parent().hide();
						}
					});
					
				}else if(treeNode["nodeType"]=="page"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.name);
					$("#rightForm").find("#url").val(data.url);
					$("#rightForm").find("#orderNum").val(data.orderNum);
				}else if(treeNode["nodeType"]=="button"){
					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#name").val(data.name);
					$("#rightForm").find("#url").val(data.url);
					$("#rightForm").find("#orderNum").val(data.orderNum);
				}
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
	}
	
	
	//删除菜单
	$("#deleteMenus").click(function(){
		
		if(!confirm("确定删除选择的菜单项?")){
			return false;
		}
		var ids = "";
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length==0){
			return false;
		}
		for(var i=0;i<nodes.length;i++){
			ids+=nodes[i].id+",";
		}
		
		$.ajax({
			url:"<%=request.getContextPath() %>/sys?method=deleteMenu",
			type:"post",
			data:{ids:ids,deleteParent:$("#deleteParent").prop("checked")?"1":"-1"},
			dataType:"text",
			success:function(data){
				if(data==1){
					loadMenusTree();
				}else{
					alert("删除菜单失败！");
				}
			},
			error:function(){
				alert("删除菜单失败！");
			}
		});
	});
	
	
});
</SCRIPT>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>