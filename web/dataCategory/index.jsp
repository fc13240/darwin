<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.sys.RoleServices"%>
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
<title>数据分类</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%request.setAttribute("compId", request.getParameter("compId"));%>
	<%request.setAttribute("topId", "36");%>
	<%
		String id = request.getParameter("id");
	%>

	<input type="hidden" name="indexNameHidden" id="indexNameHidden" value="">
	<input value="" id="treeId" name="treeId" type="hidden">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					数据分类
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
								数据分类管理
							</div>
						</div>
						<div id="topMessage" class="col-xs-9 col-xs-9" style="padding: 0px;padding-top: 10px;">
						</div>
					</div>
				</div>
				<div class="mh500">
					<div class="row">
						<div class="col-md-3 col-compact">
						    <div id="myTabContent" class="tab-content panel panel-body" style="background:#fff;border:1px solid #ccc;padding:5px;">
						      <div>
					      		<div style="overflow:auto;">
									<div id="loadImg" style="text-align: left;">
										<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
									</div>
									<ul id="treeDemo" style="display: none;" class="ztree"></ul>
								</div>
						      </div>
						    </div>
						</div>
						<div class="col-md-9 col-compact">
							<ul id="myTab" class="nav nav-tabs" role="tablist">
							    <li role="presentation" class="active"><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile">查看索引</a></li>
							    <li role="presentation"><a href="#moniter" role="tab" id="moniter-tab" data-toggle="tab" aria-controls="moniter">查看监控</a></li>
							    <li role="presentation"><a href="#trigger" role="tab" id="trigger-tab" data-toggle="tab" aria-controls="trigger">查看告警</a></li>
							    <li role="presentation"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home">创建数据分类</a></li>
					    	</ul>
						    <div id="myTabContent" class="tab-content panel panel-body">
						        <div role="tabpanel" class="tab-pane fade active in" id="profile" aria-labelledby="profile-tab">
						        	<div id="esList">
										<table class="table table-hover table-striped  ">
											<tr>
												<th>索引</th>
												<th>表名</th>
												<th style="width: 180px;">添加日期</th>
											</tr>
										</table>
									</div>
								</div>
						        <div role="tabpanel" class="tab-pane fade" id="moniter" aria-labelledby="moniter-tab">
						        	<div id="monitorList">
										<table class="table table-hover table-striped  ">
											<tr>
												<th>监控名称</th>
												<th>监控类型</th>
												<th>监控对象</th>
												<th style="width: 180px;">添加日期</th>
											</tr>
										</table>
									</div>
								</div>
						        <div role="tabpanel" class="tab-pane fade" id="trigger" aria-labelledby="trigger-tab">
						        	<div id="triggerList">
										<table class="table table-hover table-striped  ">
											<tr>
												<th>告警名称</th>
												<th>告警级别</th>
												<th>告警状态</th>
												<th style="width: 180px;">添加日期</th>
											</tr>
										</table>
									</div>
								</div>
								<div role="tabpanel" class="tab-pane fade" id="home" aria-labelledby="home-tab">
									<form class="form-horizontal" role="form" id="indexSaveform" notBindDefaultEvent="true">
										<div class="form-group">
											<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>分类名称</label>
											<div class="col-sm-5">
												<input data-rule="required;checkname;length[1~45];remote[/dataCategory?method=exist&pid=0]" class="form-control" id="name" name="name" placeholder="分类名称">
											</div>
											<div class="col-sm-5">
												<input code="save" id="indexSave" type="submit" value="保存" class="btn btn-primary" />
											</div>
										</div>
									</form>
							    </div>
						    </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- <c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<jsp:include page="add.jsp"></jsp:include>	
<jsp:include page="edit.jsp"></jsp:include>	
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css">
<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<script>
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

function isIE() { //ie?  
    if (!!window.ActiveXObject || "ActiveXObject" in window){
		console.log("ie");
        return true; 
    } else{
    	console.log("not ie");
        return false;  
    }
}  

</script>
<SCRIPT type="text/javascript">

$(function(){

	$('#indexSaveform').validator({
		valid: function(form){
        	createMark();
			$.ajax({
				url:'/dataCategory?method=save',
				data:$('#indexSaveform').serialize(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					window.location.href=window.location.href;
					$.unblockUI();
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("添加失败！");
				}
			});
    	},
    	invalid:function(form){
			console.log("invalid");
			console.log(form);
    	}
	});
	$('#esIndexForm').validator({
		valid: function(form){
        	createMark();
			$.ajax({
				url:'/dataCategory?method=index',
				data:$('#esIndexForm').serialize(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					window.location.href=window.location.href;
					$.unblockUI();
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("添加失败！");
				}
			});
    	},
    	invalid:function(form){
			console.log("invalid");
			console.log(form);
    	}
	});
	
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
				onClick: onMouseDown,
				beforeRemove: beforeRemove,
				onRemove : onRemove,
				onClick : onClick,
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

	function beforeRemove(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.selectNode(treeNode);

	}
	
	function beforeEditName(treeId, treeNode) {
		var nowName = treeNode.name;
		var editId = treeNode["id"];
		var pid = treeNode["pid"];
		console.log("nowName="+nowName);
		console.log("editId="+editId);
		console.log("pid="+pid);
// 		$('#editName').attr("data-rule","required;checkname;length[1~45];remote[/dataCategory?method=exist01&id="+editId+"&pid="+pid+"]");
		$('#editName').val(nowName);
		$('#editId').val(editId);
		$('#editPid').val(pid);
		
		$('#editOrg').modal('show');
	}
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
		return (treeNode["id"]!="-1" && (treeNode["save"]));
	}

	
	function showTreeByPath(path){
		console.log("showTreeByPath..."+path);
		setting.async.otherParam.initShowPath = path;

// 		loadMenusTree();
	}
	function onRemove(e, treeId, treeNode) {
		var flg=false;
		$.ajax({
			url:"<%=request.getContextPath() %>/dataCategory?method=deleteNode&id="+treeNode["id"]+"&pid="+treeNode["id"],
			type:'post',
			dataType:"text",
			success:function(data,testStatus){
				console.log("deleteNode=="+data);
				if(data && data == "0"){
					alert("删除成功！");
				}else if(data == "2"){
					alert("请先删除该分类下的索引，监控项，告警！");
					loadMenusTree();
				}else{
					alert("删除失败！");
					loadMenusTree();
				}
			},
			error:function(){
				console.log("请求出错");
			}
		});
		
	}
	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
		if(treeNode["id"]=="-1" || !(treeNode["save"])){
			return;
		}

		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "";
			addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='新增子分类' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			$("#pid").val(treeNode["id"]);
			$('#addOrg').modal('show');
		});
	};
	function showRemoveBtn(treeId, treeNode) {
// 		return !(treeNode["pid"] == "0" || treeNode["id"]=="-1" || treeNode["top"]) && (treeNode["delete"]);
		return (treeNode["id"]!="-1" && (treeNode["delete"]));
	}

	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};

	//加载菜单树
	function loadMenusTree(){
		$.ajax({
				url:"<%=request.getContextPath() %>/dataCategory?method=mainTree&isTree=false",
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
// 					console.log("data==="+data);
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
// 					onMouseDown(null, null, n1);
// 					zTree.selectNode(n1); 
// 					zTree.expandNode(n1, true, false, null, false);
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
// 		onMouseDown(event, treeId, treeNode);
	}

	loadMenusTree();

	function onClick(e,treeId, treeNode) {
		console.log("onClick...");
		console.log("onMouseDown...");
		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/dataCategory?method=selectNode&id=" + treeNode["id"],
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				// 索引列表
				var n=0;
				var _html="";
				_html += "<table class='table table-hover table-striped'>";
				_html += "<tr><th>索引</th><th>表名[多个用逗号隔开]</th><th>添加时间</th></tr>";
				$.each(data.listIndexs,function(index,item){
					n++;
					_html += "<tr>";
					_html += "<td>"+item.indexName+"</td>";
					_html += "<td><span style='float: left;text-overflow: ellipsis;word-wrap:break-word;word-break:break-all;width: 260px;'>"+item.tableName+"</span></td>";
					_html += "<td>"+item.createTime+"</td>";
					_html += "</tr>";
				});
				if(n==0){
					_html += "<tr><td colspan='6'>当前分类没有查询到任何索引！</td></tr>";
				}
				_html += "</table>";
				$("#esList").html("").html(_html);

				// 监控列表
				var n1=0;
				var _html1="";
				_html1 += "<table class='table table-hover table-striped'>";
				_html1 += "<tr><th>监控名称</th><th>监控类型</th><th>监控对象</th><th>添加时间</th></tr>";
				$.each(data.listMonitors,function(index,item){
					n1++;
					_html1 += "<tr>";
					_html1 += "<td>"+item.name+"</td>";
					_html1 += "<td>"+item.type+"</td>";
					_html1 += "<td>"+item.target+"</td>";
					_html1 += "<td>"+item.createTime+"</td>";
					_html1 += "</tr>";
				});
				if(n1==0){
					_html1 += "<tr><td colspan='6'>当前分类没有查询到任何监控项！</td></tr>";
				}
				_html1 += "</table>";
				$("#monitorList").html("").html(_html1);
				
				// 告警列表
				var n2=0;
				var _html2="";
				_html2 += "<table class='table table-hover table-striped'>";
				_html2 += "<tr><th>告警名称</th><th>告警级别</th><th>告警状态</th><th>添加时间</th></tr>";
				$.each(data.listTriggers,function(index,item){
					n2++;
					_html2 += "<tr>";
					_html2 += "<td>"+item.name+"</td>";
					_html2 += "<td>"+item.priority+"</td>";
					_html2 += "<td>"+item.status+"</td>";
					_html2 += "<td>"+item.createTime+"</td>";
					_html2 += "</tr>";
				});
				if(n2==0){
					_html2 += "<tr><td colspan='6'>当前分类没有查询到任何告警！</td></tr>";
				}
				_html2 += "</table>";
				$("#triggerList").html("").html(_html2);
				
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
	}

	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		console.log("onMouseDown...");
	}
});

</SCRIPT>

<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
