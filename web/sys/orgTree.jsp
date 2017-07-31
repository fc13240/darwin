<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<div style="min-width: 200px;">
			<div id="loadImg3" style="text-align: left;">
				<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
			</div>
			<ul id="treeDemo3" style="display: none;" class="ztree"></ul>
	  	</div>
<input id="compIdHidden" value="${param.compId}" type="hidden"/>
<input id="pathValue" value="${param.pathValue}" type="hidden"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>
<SCRIPT type="text/javascript">
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
				showRemoveBtn: false,
				showRenameBtn: false
			},view: {
				selectedMulti: false
			},callback: {
				onClick: onClick
			},data: {
				keep: {
					parent: true,
					leaf: true
				}
			}
	};
	
	function getTime() {
		var now= new Date(),
		h=now.getHours(),
		m=now.getMinutes(),
		s=now.getSeconds(),
		ms=now.getMilliseconds();
		return (h+":"+m+":"+s+ " " +ms);
	}
	function showLog(str) {
		if (!log) log = $("#log");
		log.append("<li class='"+className+"'>"+str+"</li>");
		if(log.children("li").length > 8) {
			log.get(0).removeChild(log.children("li")[0]);
		}
	}
	
// 	function showRenameBtn(treeId, treeNode) {
// 		return false;
// 	}
// 	function showRemoveBtn(treeId, treeNode) {
// 		return false;
// 	}
// 	function removeHoverDom(treeId, treeNode) {
// // 		console.log("removeHoverDom...");
// 		$("#addBtn_"+treeNode.tId).unbind().remove();
// 	};
	
	//加载资源菜单树
	function loadMenusTree(roleId){
		console.log("loadmenu..");
		$.ajax({
			url:"<%=request.getContextPath() %>/org?method=orgTree&isTree=true",
			type:"post",
			dataType:"JSON",
			success:function(data, textStatus){
				console.log("data="+data);
				$.fn.zTree.init($("#treeDemo3"), setting, data);
				$("#loadImg3").hide();
				$("#treeDemo3").show();
			},
			error:function(){
				console.log("加载数据出错！");
			}
		});
	}
	
	loadMenusTree();
	
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	
	function onClick(e,treeId, treeNode) {
		var ss = $("#compIdHidden").val();//"compId";
		var orgPath = treeNode["fullName"];
		parent.$('#'+ss).val(orgPath);
		parent.$('#orgId').val(treeNode["id"]);
		parent.$('#'+ss).blur();
		if (typeof(parent.setPath) == 'function') {
			parent.setPath(orgPath,ss);
		}
	    parent.layer.close(index);
	}
	
	
	
});
</SCRIPT>