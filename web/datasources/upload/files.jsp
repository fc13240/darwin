<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>上传本地文件</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%session.setAttribute("files", "yyyyyyy");%>
	<%@ include file="/resources/common_menu.jsp"%>
	<!-- page header start -->
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					配置
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">配置</a> / 管理配置
				</div>
			</div>
		</div>
	</div>
	<!-- page header end -->
	
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								添加离线数据源
							</div>
							<div class="page-header-links">
								<a href="<%=request.getContextPath() %>/datasources?method=index">数据源管理</a> / <a href="<%=request.getContextPath() %>/datasources/add.jsp">选择数据的添加方式</a> / 添加离线数据源
							</div>
						</div>
					</div>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<%
								String id = request.getParameter("id");
								String source = request.getParameter("source");
								String sourceType = request.getParameter("sourceType");
								DatasourceInfo ds = null;
								String files = "";
								if(StringUtils.isNotBlank(id)){
									ds = DatasourceServices.selectById(id);
									
									source = ds.getSource();
									sourceType = ds.getSourceType();
									if(StringUtils.isNotBlank(ds.getSourceDetail())){
										files = JSON.parseObject(ds.getSourceDetail()).getString("files");
									}
									if(StringUtils.isBlank(files)){
										files = "";
									}
								}else{
									source = request.getParameter("source");
									sourceType = request.getParameter("sourceType");
								}
							
								request.setAttribute("source",source);
								request.setAttribute("sourceType",sourceType);
								request.setAttribute("dsConnMap", DataCache.dsConnMap.get(source));
							%>
							
							<%!
							String getIdParam(HttpServletRequest request){
								String id = request.getParameter("id");
								if(StringUtils.isNotBlank(id)){
									return "&id="+id;
								}
								return "";
							}
							%>
							<form 
								action="<%=request.getContextPath()%>/datasources?method=toDone"
								class="form-horizontal" role="form" method="post">
								
								
								
								<div id="errorTips" style="color: red;"></div>
								<input name="files" id="files" value="<%=files %>" type="hidden"/> 
								<input class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" />
								<div class="well well-lg" id="selectedList" style="margin-top: 20px;"></div>
								<div class="form-group">
									<label >请选择Hadoop Path: </label>
									<p>
									</p>
<!-- 									<div class="col-sm-5"> -->
<!-- 										<input value="" name="fileRule" class="form-control input-sm" /> -->
<!-- 									</div> -->
<!-- 									<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal" onclick="return showConnFunc()"> -->
<!-- 									  选择上传路径 -->
<!-- 									</button> -->
									<div style="min-width: 500px;">
										<div id="loadImg" style="text-align: left;">
											<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
										</div>
										<ul id="pathtree" style="display: none;" class="ztree"></ul>
									</div>
								</div>
								<hr>
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"></label>
									<div class="col-sm-5">
										<a href="javascript:history.go(-1);">返回</a> 
										<input type="submit" value="下一步" class="btn btn-primary"/>
									</div>
								</div>
							</form>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/kindeditor-all.js"></script>
	<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script>
		KindEditor.ready(function(K) {
			var editor = K.editor({
				allowFileManager : true
			});
			K('#insertfile').click(function() {
				editor.loadPlugin('insertfile', function() {
					editor.plugin.fileDialog({
						fileUrl : K('#files').val(),
						clickFn : function(url, title) {
							var files = K('#files').val();
							//K('#files').val(files?files:"" + url + ";");
							K('#files').val(files?files:"" + url);
							
							files = K('#files').val();
							if(files){
								init(files);
							}
							editor.hideDialog();
						}
					});
				});
			});
			
			init($("#files").val());
			
			function init(files){
				files = files.split(";");
				for(var i=0;i<files.length;i++){
					$("#selectedList").html("<div>"+files[i]+"</div>");
				}
			}
		});
		
		function onsubmitFunc(){
			var files = $("#files").val();
			
			if(files){
				return true;
			}
			$("#errorTips").html("请先选择文件!");
			return false;
		}
	</script>
	
<SCRIPT type="text/javascript">
$(function(){
	var setting = {
			check: {
				enable: true,
				//dblClickExpand: false,
				chkStyle: "radio",
				radioType: "all"
			},callback: {
				onClick: onClick,
				onCheck: onCheck
				//onMouseDown: onMouseDown
			}
	};
	
	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("pathtree");
		zTree.expandNode(treeNode);
		$("span").remove(".ico_docu");
		
	}
	
	//加载菜单树
	function loadMenusTree(){
		$.ajax({
				url:"<%=request.getContextPath() %>/config/hdfs?method=getMenus",
				type:"post",
				dataType:"JSON",
				success:function(data, textStatus){
					
					$.fn.zTree.init($("#pathtree"), setting, data);
					$("#loadImg").hide();
					$("#pathtree").show();
					
					$("span").remove(".ico_docu");
					
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
	}
	
	loadMenusTree();
	
	$("#anaSearchKeySpan").click(function(){
		loadMenusTree();
	});

	// 选中
	function onCheck(e,treeId,treeNode){
			var treeObj = $.fn.zTree.getZTreeObj("pathtree");
			var nodes = treeObj.getCheckedNodes(true);
			

            for(var i=0;i<nodes.length;i++){
		            alert(nodes[i].id+nodes[i].path); //获取选中节点的值
		            $.ajax({
		            	url:"<%=request.getContextPath() %>/datasources?method=toDone&treeNodeId="+nodes[i].id,
						type:"post",
						dataType:"json",
						success:function(data, textStatus){
							console.log("success...");
							console.log(data);
							var win = data;
							//var win = eval('('+data+')');
							//console.log("win...");
							//console.log(data);
							
													},
						error:function(){
							console.log("加载数据失败！");
							$.unblockUI();
						}
				});
                }
            }
	
	//点击菜单项
// 	function onMouseDown(event, treeId, treeNode) {
// 		if(!treeNode || !treeNode["id"]){
// 			$("#id").val("");
// 			$("#name").val("");
// 			$("#projectId").val("");
// 			$("#sql").val("");
// 			editor.setValue("");
// 			$('#runningBtn').addClass("disabled");
// 			$('#anaHistoryA').addClass("disabled");
// 			return;
// 		}
		
// 		createMark();
// 		//load data
// 		$.ajax({
<%-- 				url:"<%=request.getContextPath() %>/analytics?method=selectById&id="+treeNode.id, --%>
// 				type:"post",
// 				dataType:"json",
// 				success:function(data, textStatus){
// 					//console.log("success...");
// 					//console.log(data);
// 					var win = data;
// 					//var win = eval('('+data+')');
// 					//console.log("win...");
// 					//console.log(data);
					
// 					$("#id").val(data.id);
// 					$("#name").val(data.name);
// 					$("#projectId").val(data.projectId);
// 					$("#sql").val(data.sql);
// 					editor.setValue(data.sql);
// 					$('#runningBtn').removeClass("disabled");
// 					$('#anaHistoryA').removeClass("disabled");
					
<%-- 					var _historyUrl = "<%=request.getContextPath() %>/analyticsHistory?method=index&anaId=" + $("#id").val(); --%>
// 					$('#anaHistoryA').attr("href",_historyUrl);
					
// 					$.unblockUI();
// 				},
// 				error:function(){
// 					console.log("加载数据失败！");
// 					$.unblockUI();
// 				}
// 		});
		
// 	}
	
});
</SCRIPT>
</body>
</html>