<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.core.PagerModel"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%

//PagerModel pmAna = new PagerModel();
//pmAna.setOffset(0);
///pmAna = AnalyticsServices.selectPagerList(null,null,pmAna);
//request.setAttribute("pager", pmAna);

//String json = JSON.toJSONString(DatasourceServices.selectDsTree());
//System.out.println("json="+json);
//resp.getWriter().println(json);

%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">

<div style="min-width: 200px;">
	<div id="loadImg" style="text-align: left;">
		<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
	</div>
	<ul id="treeDemo2" style="display: none;" class="ztree"></ul>
</div>

	
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<SCRIPT type="text/javascript">
$(function(){
	var setting = {
		check: {
			enable: false,
			dblClickExpand: false
			//radioType:"all",
			//chkStyle:"radio"
		},callback: {
			onClick: onClick,
			onMouseDown: onMouseDown
		}
	};
	
	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.expandNode(treeNode);
	}
	
	loadMenusTree();
	
	//加载菜单树
	function loadMenusTree(){
		$.ajax({
			url:"<%=request.getContextPath() %>/analytics?method=menus&id=<%=request.getParameter("id")%>",
			type:"post",
			dataType:"text",
			success:function(data, textStatus){
				//console.log(data);
				var zNodes = eval('('+data+')');
				
				$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
				$("#loadImg").hide();
				$("#treeDemo2").show();
			},
			error:function(){
				console.log("加载数据出错！");
			}
		});
	}
	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		console.log("treeNode.id="+treeNode.id+",treeId="+treeId);
		
		if(treeNode.id){
			$("#selectDsId").val(treeNode.id);
			$("#selectDsText").html("【分析】id="+treeNode.id+",");
		}else{
			alert("请选择分析！");
		}
	}
});
</SCRIPT>