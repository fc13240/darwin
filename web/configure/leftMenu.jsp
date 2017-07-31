<%@ page contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<div id="myTabContent" class="tab-content">
   <div role="tabpanel" class="tab-pane fade active in" id="lefthome" aria-labelledby="lefthome-tab">
<!--    		<div class="input-group input-group-sm" style="margin: 10px 0;"> -->
<!-- 		  <input id="anaKeywordInput" type="text" class="form-control" placeholder="查询" aria-describedby="basic-addon2"> -->
<!-- 		  <span class="input-group-btn"> -->
<!-- 		  	<button class="btn btn-default" type="button" id="anaSearchKeySpan">搜索</button> -->
<!-- 		  </span> -->
<!-- 		</div> -->
   		<div class="panel panel-default darwin-left-tree">
<!--    			<div class="darwin-left-tree-search-wrap"> -->
<!--  				<input type="text" class="darwin-left-tree-search-q"/> -->
<!--  				<span class="fui-search darwin-left-tree-search-b"></span> -->
<!--    			</div> -->
			<ul id="treeDemomain" class="ztree ztreeDarwin">
			</ul>
		</div>
		<%request.setAttribute("type", request.getAttribute("type"));%>
   </div>
 </div>
<SCRIPT type="text/javascript">
$(function(){
	var zt = null;

	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},callback: {
// 				onMouseDown: onMouseDown,
				onClick: onClickLeft
			},
			view: {
				showLine: false
			}
	};
	
	function onClickLeft(e,treeId, treeNode) {
		$.fn.zTree = zt;
		var zTree = $.fn.zTree.getZTreeObj("treeDemomain");
		zTree.expandNode(treeNode);
	}
	
	//加载菜单树
	function loadMenusTreeLeft(){
// 		console.log("loadmenu..");
		zt = window.$.fn.zTree;
		$.ajax({
				url:"<%=request.getContextPath() %>/manage/user?method=getPrivilegeMenus&topId=${topId}",
				type:"post",
				dataType:"JSON",
				success:function(data, textStatus){
					if(true){
						
 				//		var zNodes = eval('('+data+')');
 				
						$.fn.zTree.init($("#treeDemomain"), setting, data);
						$("#loadImg").hide();
						$("#treeDemomain").show();
						
						return;
						
					}
					
					
// 					var zNodes =[
// 					             { id:1, pId:0, name:"基本配置","page":"/configure/index.jsp",
// 					            	 //icon:"/resources/images/tfp.png", 
// 					            	 children: [
// 					            	        	{ "id":11, "name":"连接管理",
// 					            	        		children: [
// 									            	        	{ "id":111, "name":"FTP","page":"/user/connConf?method=index&type=ftp","type":"ftp"},
// 									            	        	{ "id":112, "name":"数据库","page":"/user/connConf?method=index&type=database"},
// 									            	        	{ "id":113, "name":"HBASE连接管理","page":"/user/connConf?method=index&type=hbase"}
// 									            	        	],open:true},
// 					            	        	{ "id":13, "name":"项目管理"},
// 					            	        	{ "id":14, "name":"系统扩展管理",
// 					            	        		children: [
// 									            	        	{ "id":141, "name":"数据获取脚本"},
// 									            	        	{ "id":142, "name":"自定义组件管理"}
// 									            	        	],open:true}
// 					            	        	],open:true},
// 					             { id:2, pId:1, name:"数据管理",
// 					            	 children: [
// 					            	        	{ "id":21, "name":"HDFS","page":"/configure/hdfsManage.jsp"},
// 					            	        	{ "id":22, "name":"HBASE"},
// 					            	        	{ "id":22, "name":"HIVE"},
// 					            	        	{ "id":22, "name":"索引管理"}
// 					            	        	],open:true},
// 					             { id:3, pId:2, name:"数据处理","page":"/flow/index.jsp"},
// 								 { id:4, pId:3, name:"流程监控"},
// 								 { id:5, pId:4, name:"节点管理"},
// 								 { id:6, pId:5, name:"采集点管理"}
// 					         ];
// 					$.fn.zTree.init($("#treeDemomain"), setting, zNodes);
// 					$("#treeDemomain").show();
					
// 					$("span").remove(".ico_docu");
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
	}
	
	loadMenusTreeLeft();
	
	//点击菜单项
// 	function onMouseDown(event, treeId, treeNode) {
<%-- 		window.location.href="<%=request.getContextPath()%>"+treeNode["page"]; --%>
<%-- 		window.location.href="<%=request.getContextPath()%>/configure/index.jsp?page="+treeNode["page"]; --%>
// 	}
	
});
</SCRIPT>
