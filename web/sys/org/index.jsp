<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.sys.RoleServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
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
<title>用户与组织机构</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("compId", request.getParameter("compId"));%>
	<%request.setAttribute("topId", "48");%>
	<%
		String id = request.getParameter("id");
	%>
	<%
		request.setAttribute("nodes", NodeServices.selectList(NodeInfo.node_type_node));
	%>

	<input type="hidden" name="indexNameHidden" id="indexNameHidden" value="">
	<input value="" id="treeId" name="treeId" type="hidden">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					组织机构
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
			<div class="col-md-9 col-compact">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-3 col-md-3">
							<div class="page-header-desc">
								组织机构管理
							</div>
						</div>
<!-- 						<div style="float:left;"> -->
<!-- 							<a id="addOrgClick" title="新增子机构"><span style="color:green;" class="glyphicon glyphicon-plus"></span></a> -->
<!-- 							<span title="删除当前机构" style="color:red;" class="glyphicon glyphicon-trash"></span> -->
<!-- 							<span title="修改当前机构" style="color:blue;" class="glyphicon glyphicon-pencil"></span> -->
<!-- 						</div> -->
						<div id="topMessage" class="col-xs-8 col-xs-8" style="padding: 0px;padding-top: 10px;">
<!-- 							当前操作机构【总公司】 找到33个对象 -->
						</div>
						
					</div>
				</div>
				<div class="mh500">
					<div class="row">
						<div class="col-md-3 col-compact">
						    <div id="myTabContent" class="tab-content panel panel-body" style="background:#fff;border:1px solid #ccc;padding:5px;">
						      <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
					      		<div style="overflow:auto;">
									<div id="loadImg" style="text-align: left;">
										<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
									</div>
									<ul id="treeDemo" style="display: none;" class="ztree"></ul>
								</div>
						      </div>
						    </div>
						</div>
						<div class="col-md-9  col-compact">
<%-- 							<form action="<%=request.getContextPath() %>/es?method=saveTree&compId=${compId}" method="post"  --%>
<!-- 								class="form-horizontal" role="form" > -->
<!-- 								<div class="page-header"> -->
<!-- 										<div style="float:left;">找到33个对象</div> -->
									<div class="row">
										<div class="col-xs-4 col-md-4">
<!-- 										<div style="float:left;">找到33个对象&nbsp;&nbsp;&nbsp;&nbsp;</div> -->
											<div class="checkbox" name="checkOn00" >
											    <label style="margin-bottom:-5px;margin-left:-10px;">
											      <input onchange="changeval();" name="checkOn" id="checkOn" type="checkbox" >
											     </label> 包括子机构/部门用户 
											</div>
										</div>
										<%
											request.setAttribute("roles", RoleServices.selectList());
										%>
										<div class="col-xs-8 col-md-8">
										用户名/姓名:<input type="search" placeholder="用户名/姓名" id="searchName" name="searchName" value=""  >
												<select id="roleIds" name="roleIds" style="width:120px;">
													<option value="">--角色--</option>
											        <c:forEach items="${roles}" var="item">
											           <option value="${item.id}">${item.name}</option>
											        </c:forEach>
												</select>
<!-- 												<button class="btn btn-primary btn-xs" id="searchId" type="button" href="#"> -->
<!-- 													&nbsp;搜索&nbsp; -->
<!-- 												</button>  -->
												<a class="btn btn-primary btn-xs" id="searchId" >&nbsp;搜索&nbsp;</a>
												<a code="save" class="btn btn-primary btn-xs" href="<%=request.getContextPath() %>/manage/user?method=edit">添加用户</a>
										</div>
									</div>
									<div id="defultList">
<!-- 									<table class="table table-hover table-striped  "> -->
<!-- 										<thead> -->
<!-- 											<tr style="color:#fff;background-color:#9BE1E8;"> -->
<!-- 											<tr> -->
<!-- 												<th>用户名</th> -->
<!-- 												<th>姓名</th> -->
<!-- 												<th style="width: 100px;">角色</th> -->
<!-- 												<th>添加/修改时间</th> -->
<!-- 												<th style="width: 130px;">操作</th> -->
<!-- 											</tr> -->
<!-- 										</thead> -->
<!-- 										<tbody> -->
<!-- 											<tr> -->
<!-- 												<td>lanyijing</td> -->
<!-- 												<td>兰神</td> -->
<!-- 												<td>系统管理员</td> -->
<!-- 												<td>2018/09/10 10:33<br>2020/10/09 10:38</td> -->
<!-- 												<td> -->
<!-- 													<a  href="">编辑</a> -->
<!-- 													<a class="disabled" code="delete" onclick="return confirmDel2()">删除</a> -->
<!-- 												</td> -->
<!-- 											</tr> -->
<!-- 										</tbody> -->
<!-- 									</table> -->
									</div>
									<div id="atoList">
									<table class="table table-hover table-striped  ">
										<tr>
											<th style="width: 15%;">用户名</th>
											<th style="width: 20%;">姓名</th>
											<th style="width: 15%;">角色</th>
											<th style="width: 25%;">添加/修改时间</th>
											<th style="width: 10%;">存储配额</th>
											<th style="width: 15%;">操作</th>
										</tr>
									</table>
									</div>
<!-- 								<div> -->
<%-- 									<%@ include file="/resources/pager.jsp"%> --%>
<!-- 								</div> -->
<!-- 							</form> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%-- 	<c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<jsp:include page="addOrg.jsp"></jsp:include>	
<jsp:include page="editOrg.jsp"></jsp:include>	
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css">
<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<script>
var checkAll="off";
$(function(){
	//添加组织机构
	$('#addOrgClick').click(function(){
		$('#addOrg').modal('show');
	});
	//编辑组织机构
	$('#editOrgClick').click(function(){
		$('#editOrg').modal('show');
	});
});
</script>
<SCRIPT type="text/javascript">
//------------控件设置----------------
$(function(){
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},async:{
				enable:false,
				type: "get",
				autoParam:["hdfsPath=hdfsParentPath"]
			},edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},callback: {
				onClick: onClick,
				beforeRemove: beforeRemove,
				onRemove : onRemove,
				onClick : onMouseDown,
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove,
				onRename: onRename,
				beforeExpand: beforeExpand,
				onCollapse: onCollapse,
				onExpand: onExpand
			},data: {
				keep: {
					parent: true,
					leaf: true
				}
			}
	};
//--------------------------------------------------
	function beforeRemove(treeId, treeNode) {
// 		className = (className === "dark" ? "":"dark");
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.selectNode(treeNode);
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=deleteCheck&id="+treeNode["id"],
			type:'post',
			dataType:"text",
			success:function(data,testStatus){
				console.log("deleteCheck=="+data);
				if(data == "2"){
					alert("请先删除子机构哦~");
					loadMenusTree();
				}else{
					return confirm("删除后底下的用户会到【其他】组，请确认是否删除？");
				}
			},
			error:function(){
				console.log("请求出错");
			}
		});

	}
	
	function beforeEditName(treeId, treeNode) {
		var nowName = treeNode.name;
		var editId = treeNode["id"];
		var pid = treeNode["pid"];
		var nodeId = treeNode["nodeId"];
		console.log("nowName="+nowName);
		console.log("editId="+editId);
		console.log("pid="+pid);
		console.log("nodeId="+nodeId);
		$('#editName').val(nowName);
		$("#editNodeId").val(nodeId);
		var nodeId = $("#editNodeId").val();
		console.log("editNodeId="+nodeId);
		$('#editId').val(editId);
		$('#editPid').val(pid);
		$('#editOrg').modal('show');
	}
// 	function getTime() {
// 		var now= new Date(),
// 		h=now.getHours(),
// 		m=now.getMinutes(),
// 		s=now.getSeconds(),
// 		ms=now.getMilliseconds();
// 		return (h+":"+m+":"+s+ " " +ms);
// 	}
	var beforeRename_name;
	function beforeRename(treeId, treeNode, newName, isCancel) {
		if (newName.length == 0) {
			alert("节点名称不能为空.");
			var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
			setTimeout(function(){zTree.editName(treeNode)}, 10);
			return false;
		}
		beforeRename_name = treeNode.name;
		return true;
	}

	function onRename(e, treeId, treeNode, isCancel) {

	}

	function removeHoverDom(treeId, treeNode) {
	};
	var log, className = "dark";
	function beforeClick(treeId, treeNode) {
		if (treeNode.isParent) {
			return true;
		} else {
			return false;
		}
	}
	function beforeCollapse(treeId, treeNode) {
		className = (className === "dark" ? "":"dark");
		return (treeNode.collapse !== false);
	}

	function onCollapse(event, treeId, treeNode) {
	}
	
	function beforeExpand(treeId, treeNode) {
		className = (className === "dark" ? "":"dark");
		return (treeNode.expand !== false);
	}

	function onExpand(event, treeId, treeNode) {
	}

	function expandNode(e) {
		console.log("expandNode...");
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
		type = e.data.type;

		var hdfsPath = $("#hdfsPath").val();
		nodes = [];
		nodes.push(zTree.getNodeByParam("id", hdfsPath, null));

		var callbackFlag = $("#callbackTrigger").attr("checked");
		for (var i=0, l=nodes.length; i<l; i++) {
			zTree.setting.view.fontCss = {};
			if (type == "expandSon") {
				zTree.expandNode(nodes[i], true, true, null, callbackFlag);
			}
		}
	}

	function showRenameBtn(treeId, treeNode) {
		return !(treeNode["id"]=="-1") && (treeNode["save"]);
	}

	
	function showTreeByPath(path){
		console.log("showTreeByPath..."+path);
		setting.async.otherParam.initShowPath = path;

		loadMenusTree();
	}
	function onRemove(e, treeId, treeNode) {
		var flg=false;
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=deleteCheck&id="+treeNode["id"],
			type:'post',
			dataType:"text",
			success:function(data,testStatus){
				console.log("deleteCheck=="+data);
				if(data == "2"){
					alert("请先删除子机构哦~");
					loadMenusTree();
				}else{
					flg=confirm("删除后底下的用户会到【其他】组，请确认是否删除？");
					console.log("flg=="+flg);
					if(!flg){
						loadMenusTree();
					}else{

						$.ajax({
							url:"<%=request.getContextPath() %>/org?method=deleteOrg&id="+treeNode["id"],
							type:'post',
							dataType:"text",
							success:function(data,testStatus){
								console.log("data===="+data);
								if(data && data == "0"){
									alert("删除成功！该组织机构下成员被分配到【其他】。");
									loadMenusTree();
//				 				}else if(data == "2"){
//				 					alert("请先删除子机构哦~");
//				 					loadMenusTree();
								}else{
									alert("删除失败！");
									loadMenusTree();
								}
							},
							error:function(){
								console.log("删除出错");
							}
						});

					}
				}
			},
			error:function(){
				console.log("请求出错");
			}
		});
		
	}
	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
// 		if((!treeNode["id"] || treeNode["id"]=="-1") || !(treeNode["save"])){
// 			return;
// 		}
		if((!treeNode["id"] || treeNode["id"]=="-1")){
			return;
		}

		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "";
			addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='新增组织机构' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			$("#pid").val(treeNode["pid"]);
			$('#addOrg').modal('show');
		});
	};
	function showRemoveBtn(treeId, treeNode) {
		return !(treeNode["pid"] == "0" || treeNode["id"]=="-1" || treeNode["top"]) && (treeNode["delete"]);
	}

	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};

	//------------------------------加载菜单树--------------------------
	function loadMenusTree(){
		$("#addNodeId").val("36");
		$.ajax({
				url:"<%=request.getContextPath() %>/org?method=orgTree&isTree=false",
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					console.log("data==="+data);
					var zNodes = eval('('+data+')');
					var topId="";
					$.each(zNodes,function(index,item){
						topId = item["id"];
					});
					
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					$("#loadImg").hide();
					$("#treeDemo").show();

					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					var n1 = zTree.getNodeByParam("id", topId, null);
					onMouseDown(null, null, n1);
					zTree.selectNode(n1); 
					zTree.expandNode(n1, true, false, null, false);
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
// 		onMouseDown(event, treeId, treeNode);
	}
//----------------------------------------------------------------
	loadMenusTree();

	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.expandNode(treeNode);
			$("span").remove(".ico_docu");
	}

	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		if(!treeNode || !treeNode["id"]){
			return;
		}
		
		var check = document.getElementById("checkOn");
	    if(check.checked == true){
	    	checkAll="on";;
	    }else{
	    	checkAll="off";
	    }

		$("#treeId").val(treeNode["id"]);
		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=select&id=" + treeNode["id"],
			data:{checkAll:checkAll,newSelect:$("#roleIds").val(),searchName:$("#searchName").val()},
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				$("#pid").val(data.id);
				console.log("isSave==="+data.isSave);
				console.log("isDelete==="+data.isDelete);

// 				var _d = eval('('+data.list+')');
				var n=0;
				var _html="";
				_html += "<table class='table table-hover table-striped'>";
				_html += "<tr><th style='width: 15%;'>用户名</th><th style='width: 20%;'>姓名</th><th style='width: 15%;'>角色</th><th style='width: 25%;'>添加/修改时间</th><th style='width: 10%;'>存储配额</th><th style='width: 15%;'>操作</th></tr>";
				$.each(data.list,function(index,item){
					n++;
					var href="<%=request.getContextPath() %>/manage/user?method=edit&id="+item.id;
					var hrefDel="<%=request.getContextPath() %>/manage/user?method=deleteById&id="+item.id;
					_html += "<tr>";
					_html += "<td>"+item.username+"</td>";
					_html += "<td>"+item.nickname+"</td>";
					_html += "<td>"+item.roleName+"</td>";
					_html += "<td>"+item.createTime;
					if(item.updatetime!=" "){
						_html += "<br>/"+item.updatetime;
					}
					_html += "</td>";
					_html += "<td>"+item.totalSpace+"</td>";
					if(data.isSave){
						_html += "<td><a code='select' href='"+href+"'>编辑</a>&nbsp;";
					}else{
						_html += "<td><a code='select' href='"+href+"'>查看</a>&nbsp;";
					}
					if(data.isDelete){
						_html += "<a class='disabled' code='delete' onclick='return confirmDel2()' href='"+hrefDel+"'>删除</a></td>";
					}else{
						_html += "<a disabled='disabled' style='cursor:not-allowed;color:#999;'>删除</a></td>";
					}
					_html += "</tr>";
				});
				if(n==0){
					_html += "<tr><td colspan='6'>没有查询到任何记录！</td></tr>";
				}
				_html += "</table>";
				$("#topMessage").text("当前操作机构【"+data.fullName+"】"+" 找到"+n+"个用户");
				$("#atoList").html("").html(_html);
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
	}


});
function confirmDel2(){
	if (confirm("确定删除该用户？")) {  
		return true;
    }  return false;
}

function changeval(){
   	var check = document.getElementById("checkOn");
    if(check.checked == true){
    	checkAll="on";;
    }else{
    	checkAll="off";
    }
    
    var id = $("#treeId").val();
	console.log("id===="+id);
	if(id!=""){
		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=select&id=" + id,
			data:{checkAll:checkAll,newSelect:$("#roleIds").val(),searchName:$("#searchName").val()},
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				$("#pid").val(data.id);

// 				var _d = eval('('+data.list+')');
				var n=0;
				var _html="";
				_html += "<table class='table table-hover table-striped'>";
				_html += "<tr><th style='width: 15%;'>用户名</th><th style='width: 20%;'>姓名</th><th style='width: 15%;'>角色</th><th style='width: 25%;'>添加/修改时间</th><th style='width: 10%;'>存储配额</th><th style='width: 15%;'>操作</th></tr>";
				$.each(data.list,function(index,item){
					n++;
					var href="<%=request.getContextPath() %>/manage/user?method=edit&id="+item.id;
					var hrefDel="<%=request.getContextPath() %>/manage/user?method=deleteById&id="+item.id;
					_html += "<tr>";
					_html += "<td>"+item.username+"</td>";
					_html += "<td>"+item.nickname+"</td>";
					_html += "<td>"+item.roleName+"</td>";
					_html += "<td>"+item.createTime;
					if(item.updatetime!=" "){
						_html += "<br>/"+item.updatetime;
					}
					_html += "</td>";
					_html += "<td>"+item.totalSpace+"</td>";
					if(data.isSave){
						_html += "<td><a code='select' href='"+href+"'>编辑</a>&nbsp;";
					}else{
						_html += "<td><a code='select' href='"+href+"'>查看</a>&nbsp;";
					}
					if(data.isDelete){
						_html += "<a class='disabled' code='delete' onclick='return confirmDel2()' href='"+hrefDel+"'>删除</a></td>";
					}else{
						_html += "<a disabled='disabled' style='cursor:not-allowed;color:#999;'>删除</a></td>";
					}
					_html += "</tr>";
				});
				if(n==0){
					_html += "<tr><td colspan='6'>没有查询到任何记录！</td></tr>";
				}
				_html += "</table>";
				$("#topMessage").text("当前操作机构【"+data.fullName+"】"+" 找到"+n+"个用户");
				$("#atoList").html("").html(_html);
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
		
	}
}

//下拉框选择切换事件
$("#roleIds").change(function(){
	var id = $("#treeId").val();
	console.log("id===="+id);
	if(id!=""){
		var newSelect = $(this).val();
		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=select&id=" + id,
			data:{checkAll:checkAll,newSelect:newSelect,searchName:$("#searchName").val()},
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				$("#pid").val(data.id);

// 				var _d = eval('('+data.list+')');
				var n=0;
				var _html="";
				_html += "<table class='table table-hover table-striped'>";
				_html += "<tr><th style='width: 15%;'>用户名</th><th style='width: 20%;'>姓名</th><th style='width: 15%;'>角色</th><th style='width: 25%;'>添加/修改时间</th><th style='width: 10%;'>存储配额</th><th style='width: 15%;'>操作</th></tr>";
				$.each(data.list,function(index,item){
					n++;
					var href="<%=request.getContextPath() %>/manage/user?method=edit&id="+item.id;
					var hrefDel="<%=request.getContextPath() %>/manage/user?method=deleteById&id="+item.id;
					_html += "<tr>";
					_html += "<td>"+item.username+"</td>";
					_html += "<td>"+item.nickname+"</td>";
					_html += "<td>"+item.roleName+"</td>";
					_html += "<td>"+item.createTime;
					if(item.updatetime!=" "){
						_html += "<br>/"+item.updatetime;
					}
					_html += "</td>";
					_html += "<td>"+item.totalSpace+"</td>";
					if(data.isSave){
						_html += "<td><a code='select' href='"+href+"'>编辑</a>&nbsp;";
					}else{
						_html += "<td><a code='select' href='"+href+"'>查看</a>&nbsp;";
					}
					if(data.isDelete){
						_html += "<a class='disabled' code='delete' onclick='return confirmDel2()' href='"+hrefDel+"'>删除</a></td>";
					}else{
						_html += "<a disabled='disabled' style='cursor:not-allowed;color:#999;'>删除</a></td>";
					}
					_html += "</tr>";
				});
				if(n==0){
					_html += "<tr><td colspan='6'>没有查询到任何记录！</td></tr>";
				}
				_html += "</table>";
				$("#topMessage").text("当前操作机构【"+data.fullName+"】"+" 找到"+n+"个用户");
				$("#atoList").html("").html(_html);
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
		
	}else{
		alert("请选择组织机构！");
	}
});

//下拉框选择切换事件
$("#searchId").click(function(){
	var id = $("#treeId").val();
	console.log("id===="+id);
	if(id!=""){
		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=select&id=" + id,
			data:{checkAll:checkAll,newSelect:$("#roleIds").val(),searchName:$("#searchName").val()},
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				$("#pid").val(data.id);

// 				var _d = eval('('+data.list+')');
				var n=0;
				var _html="";
				_html += "<table class='table table-hover table-striped'>";
				_html += "<tr><th style='width: 15%;'>用户名</th><th style='width: 20%;'>姓名</th><th style='width: 15%;'>角色</th><th style='width: 25%;'>添加/修改时间</th><th style='width: 10%;'>存储配额</th><th style='width: 15%;'>操作</th></tr>";
				$.each(data.list,function(index,item){
					n++;
					var href="<%=request.getContextPath() %>/manage/user?method=edit&id="+item.id;
					var hrefDel="<%=request.getContextPath() %>/manage/user?method=deleteById&id="+item.id;
					_html += "<tr>";
					_html += "<td>"+item.username+"</td>";
					_html += "<td>"+item.nickname+"</td>";
					_html += "<td>"+item.roleName+"</td>";
					_html += "<td>"+item.createTime;
					if(item.updatetime!=" "){
						_html += "<br>/"+item.updatetime;
					}
					_html += "</td>";
					_html += "<td>"+item.totalSpace+"</td>";
					if(data.isSave){
						_html += "<td><a code='select' href='"+href+"'>编辑</a>&nbsp;";
					}else{
						_html += "<td><a code='select' href='"+href+"'>查看</a>&nbsp;";
					}
					if(data.isDelete){
						_html += "<a class='disabled' code='delete' onclick='return confirmDel2()' href='"+hrefDel+"'>删除</a></td>";
					}else{
						_html += "<a disabled='disabled' style='cursor:not-allowed;color:#999;'>删除</a></td>";
					}
					_html += "</tr>";
				});
				if(n==0){
					_html += "<tr><td colspan='6'>没有查询到任何记录！</td></tr>";
				}
				_html += "</table>";
				$("#topMessage").text("当前操作机构【"+data.fullName+"】"+" 找到"+n+"个用户");
				$("#atoList").html("").html(_html);
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
		
	}else{
		alert("请选择组织机构！");
	}
});
</SCRIPT>

<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
