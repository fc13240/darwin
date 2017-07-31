<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.ServerInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>系统设置</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
<%-- 	<%request.setAttribute("selectPage", Container.module_configure);%> --%>
	<%request.setAttribute("fileName", request.getSession().getAttribute(Container.session_configure_fileName));%>
	<%request.setAttribute("upCount", request.getSession().getAttribute(Container.session_configure_updateCount));%>
	<%request.setAttribute("errorMessage", request.getSession().getAttribute(Container.session_configure_errorMessage));%>
<%-- 	<%request.setAttribute("topId", "1");%> --%>
	<%
		
		String nodeId = "0";
		String nodeName = "";
		String server = "";
		if(StringUtils.isNotBlank(nodeId)){
			NodeInfo nodeInfo = NodeServices.selectById(Integer.valueOf(nodeId));
			if(nodeInfo != null){
				nodeName = nodeInfo.getName()+"("+nodeInfo.getIp()+":"+nodeInfo.getPort()+")";
				int serverId =nodeInfo.getServerID();
				if(serverId>0){
					ServerInfo pro = ServerServices.selectById(serverId);
					if(pro!=null){
						server = "["+pro.getHost()+":"+pro.getCommunicatePort()+"]";
					}
				}
			}
		}
		request.setAttribute("server", server);
		request.setAttribute("nodeName", nodeName);
		request.setAttribute("nodeId", nodeId);
		
	%>
	<input id="nodeId" value="${nodeId}" type="hidden"/>
	<input id="fileName" value="${fileName}" type="hidden"/>
	<input id="fileNameUpdate" value="" type="hidden"/>
	<input id="upCount" value="${upCount}" type="hidden"/>
	<input id="errorMessage" value="${errorMessage}" type="hidden"/>
	
	<form id="fId" method="post" class="form-horizontal" role="form" notBindDefaultEvent="true" 
			action="<%=request.getContextPath() %>/configure?method=save" >
		<div class="page-header" style="margin-top: 50px;">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						系统设置
					</div>
					<div class="page-header-links">
						配置列表 / <a target="_blank"  href="<%=request.getContextPath() %>/node?method=index">返回服务管理列表页</a>
					</div>
				</div>
				<div class="col-xs-6 col-md-6">
					<div class="page-header-op r" style="margin-top: 20px;">
<!-- 						温馨提示：重启服务后，标记有<span class='glyphicon glyphicon-exclamation-sign'></span> 的设置才会生效。 -->
						温馨提示：标记<span class='glyphicon glyphicon-exclamation-sign'></span> 的意思是，该项配置和默认配置不一致。
						<button class="btn btn-default btn-xs" type="button" id="reboot" >恢复出厂设置</button>
						<input id="save001" class="btn btn-primary btn-xs" type="submit" value="保存更改"/>
						<button class="btn btn-primary btn-xs" type="button" id="sendConfig" >重新同步配置</button>
<!-- 						<button class="btn btn-primary btn-xs" type="button" id="loadFile" >重新加载配置</button> -->
						<br>
					</div>
				</div>
			</div>
		</div>
		<div class="container mh500">
			<div class="row">
				<div class="col-md-12">
					<div class="mh500">
						<div class="row">
							<div class="col-md-3">
							    <div id="myTabContent" class="tab-content panel panel-body">
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
							<div class="col-md-9">
<!-- 								<div class="alert alert-warning alert-dismissible" > -->
								<c:if test="${not empty upCount }">
									<div class="alert alert-info alert-dismissible" >
									<c:if test="${upCount == '-1' and not empty errorMessage }">
										<c:if test="${errorMessage == '操作失败！'}">
											<span style='color:red;' class="glyphicon glyphicon-remove-sign"></span>
										</c:if>
										<c:if test="${errorMessage != '操作失败！'}">
											<span style='color:green;' class="glyphicon glyphicon-ok-sign"></span>
										</c:if>
										<strong>${errorMessage}</strong>
									</c:if>
									<c:if test="${upCount != '-1' and not empty errorMessage }">
										<span style='color:red;' class="glyphicon glyphicon-remove-sign"></span>
										<strong>${errorMessage}</strong>
									</c:if>
									<c:if test="${empty errorMessage }">
										<span style='color:green;' class="glyphicon glyphicon-ok-sign"></span>
										<c:choose>
											<c:when test="${upCount == '0' }">
												<strong>已保存 ${upCount } 处更改。</strong>
											</c:when>
											<c:when test="${fileName == 'system.properties' }">
												<strong>已保存 ${upCount } 处更改。修改的前端配置已经生效。</strong>
											</c:when>
											<c:when test="${fileName == 'c3p0.properties' }">
												<strong>已保存 ${upCount } 处更改。修改的前端配置已经生效。</strong>
											</c:when>
											<c:otherwise>
												<strong>已保存 ${upCount } 处更改。修改的后台配置已经生效。</strong>
											</c:otherwise>
										</c:choose>
									</c:if>
									</div>
									<div style="margin-top:-30px;">
								</c:if>
								<c:if test="${empty upCount }">
									<div>
								</c:if>
									<table class="table table-bordered table-hover" id="ruleTable" >
										<tr class="success">
	<!-- 										<td width="15%">属性   [标记<span class='glyphicon glyphicon-retweet'></span> ：与默认值不同]</td> -->
											<td width="25%">属性</td>
											<td width="40%">值</td>
											<td width="35%">说明</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="form-group" style="display:none;">
								<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>名称</label>
								<div class="col-sm-4">
									<input data-rule="required;" id="name" name="name" value="1111111111111" class="form-control" placeholder="名称"/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<%@ include file="/resources/common_footer.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/codeeditor/sql.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<SCRIPT type="text/javascript">
// function confirmDel(){
// 	if (confirm("你确定要删除吗？")) {  
// 		return true;
//     }  return false;
// }
var fileName=$("#fileName").val();
	if(fileName==""){
		fileName="system.properties";
	}
	
$(function(){
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},async:{
				enable:false,
				type: "get",
				autoParam:["hdfsPath=hdfsParentPath"]
			},view: {
				expandSpeed:"",
				selectedMulti: false
			},callback: {
				onClick: onClick,
				onMouseDown : onMouseDown,
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
	
	function beforeExpand(treeId, treeNode) {
// 		className = (className === "dark" ? "":"dark");
// 		console.log("className..."+className);
		return (treeNode.expand !== false);
	}
	
	function onExpand(event, treeId, treeNode) {
		
	}
	function onCollapse(event, treeId, treeNode) {
	}
	//加载菜单树
	function loadMenusTree(){

// 			var zNodes =[
// 			             { id:2, pId:1, name:"后台配置",
//             	        	children: [
//   			            	        	{ "id":21, "name":"/bin",
//   			            	        		children: [
//   	  			 			            	        	{ "id":211, "name":"darwin-env.sh",open:true}
//   	  			 			            	        	],open:true},
//   			            	        	{ "id":22, "name":"/lib/darwin/config",
// 			            	        		children: [
// 			 			            	        	{ "id":21, "name":"APP.properties","page":""},
// 			 			            	        	{ "id":22, "name":"elasticsearch.conf"},
// 			 			            	        	{ "id":22, "name":"spark.conf"}
// 			 			            	        	]
//   			            	        		,open:true},
// 		            	        		{ "id":23, "name":"/lib/darwin/config/prod",
// 			            	        		children: [
// 			 			            	        	{ "id":22, "name":"ALERT_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"API_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"CREATE_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"CT_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"DS_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"HDFS_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"jdbc.properties"},
// 			 			            	        	{ "id":22, "name":"log4j.properties"},
// 			 			            	        	{ "id":22, "name":"MD5_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"SLOG_BIZ.properties"},
// 			 			            	        	{ "id":22, "name":"SPARK_BIZ.properties"}
// 			 			            	        	]
// 	 			            	        		,open:true}
//   			            	        	],open:true},
// 			             { id:3, pId:2, name:"es配置",
//    			            	 children: [
// 			            	        	{ "id":21, "name":"/config",
// 			            	        		children: [
// 			   			            	        	{ "id":21, "name":"elasticsearch.yml"}
// 			   			            	        	],open:true},
// 			            	        	{ "id":22, "name":"/bin",
//    			            	        		children: [
//    			   			            	        	{ "id":21, "name":"elasticsearch"}
//    			   			            	        	],open:true}
// 			            	        	],open:true}
// 			         ];
// 			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
// 			$("#loadImg").hide();
// 			$("#treeDemo").show();
		
// 			$("span").remove(".ico_docu");
		var nodeId = $("#nodeId").val();
		$.ajax({
				url:"<%=request.getContextPath() %>/configure?method=configMenusAll",
				type:"post",
				data:{"nodeId":nodeId},
				dataType:"text",
				success:function(data, textStatus){
// 					console.log("configMenus......"+data);
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					$("#loadImg").hide();
					$("#treeDemo").show();
					
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					var n1 = zTree.getNodeByParam("fileName", fileName, null);
// 					onMouseDown(null, null, n1);
					onClick(null, null, n1);
					zTree.selectNode(n1); 
					zTree.expandNode(n1, true, false, null, false);
					
				},
				error:function(){
				}
		});
	}
	
	
	
	function expandNode(e) {
// 		console.log("hdfsPath...");
		
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		type = e.data.type;

		var hdfsPath = "API_BIZ.properties";
// 		console.log("hdfsPath..."+hdfsPath);
		nodes = [];
		nodes.push(zTree.getNodeByParam("fileName", fileName, null));
// 		console.log(nodes);
		//nodes.push(zTree.getNodeByParam("id", hdfsPath, null));
		
		var callbackFlag = 1;
		for (var i=0, l=nodes.length; i<l; i++) {
			zTree.setting.view.fontCss = {};
// 			console.log("expandSon.nodes..."+nodes[i]);
			if (type == "expandSon") {
// 				console.log("expandSon.nodes2..."+nodes[i]);
				zTree.expandNode(nodes[i], true, true, null, callbackFlag);
			}
		}
	}
	
	loadMenusTree();
	
	$("#").click(function(){
		$("#loadImg").show();
		$("#treeDemo").hide();
		loadMenusTree();
	});
	
	$("#fId").on("valid.form", function(e, form){
		createMark();
		form.submit();
		$.unblockUI();
	});
	
	function onMouseDown(e,treeId, treeNode) {
// 		console.log("onMouseDown...");
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.expandNode(treeNode);
// 			console.log("treeNode......"+treeNode);
	}
	
// 	$("#loadFile").click(function(){
// 		console.log("loadFile...");
// 		var nodeId = $("#nodeId").val();
// 	       $.ajax({
<%-- 	   		url:"<%=request.getContextPath() %>/configure?method=copyFile", --%>
// 	   		data:{"nodeId":nodeId},
// 	   		type:"post",
// 	   		dataType:"text",
// 	   		success:function(data, textStatus){
// 	   			if(data == "0"){
// 	    			alert("成功读取该节点配置信息！");
// 	   			}else if(data == "2"){
// 	   				alert("读取配置信息失败！");
// 	   			}
// 	   		},
// 	   		error:function(){
// 	   			alert("发送请求出错！");
// 	   		}
//    		});			

// 	});
	
	$("#sendConfig").click(function(){
		console.log("reboot...");
		createMark();
		var nodeId = $("#nodeId").val();
	       $.ajax({
	   		url:"<%=request.getContextPath() %>/configure?method=sendConfig",
	   		data:{"nodeId":nodeId,"fileName":$("#fileNameUpdate").val()},
	   		type:"post",
	   		dataType:"text",
	   		success:function(data, textStatus){
	   			window.location.href=window.location.href;
	   			$.unblockUI();
// 	   			if(data == "0"){
// 	    			alert(data);
// 	   			}else if(data == "2"){
// 	   				alert("恢复出厂设置失败！");
// 	   			}
	   		},
	   		error:function(){
	   			$.unblockUI();
	   			alert("发送请求出错！");
	   		}
   		});			

	});
	
	$("#reboot").click(function(){
		console.log("reboot...");
		createMark();
		var nodeId = $("#nodeId").val();
	       $.ajax({
	   		url:"<%=request.getContextPath() %>/configure?method=reboot",
	   		data:{"nodeId":nodeId,"fileName":$("#fileNameUpdate").val()},
	   		type:"post",
	   		dataType:"text",
	   		success:function(data, textStatus){
	   			window.location.href=window.location.href;
	   			$.unblockUI();
// 	   			if(data == "0"){
// 	    			alert(data);
// 	   			}else if(data == "2"){
// 	   				alert("恢复出厂设置失败！");
// 	   			}
	   		},
	   		error:function(){
	   			$.unblockUI();
	   			alert("发送请求出错！");
	   		}
   		});			

	});
	
	//点击菜单项
	function onClick(event, treeId, treeNode) {
		$("#ruleTable").empty();
		var nodeId = $("#nodeId").val();
		var fileName = treeNode.fileName;
		$("#fileNameUpdate").val(fileName);
// 		console.log("onClick..."+nodeId);
		console.log("onClick..."+fileName);
// 		console.log("onClick.fileNameUpdate.."+$("#fileNameUpdate").val());
		createMark();
		$.ajax({
				url:"<%=request.getContextPath() %>/configure?method=selectById",
				type:"post",
				data:{nodeId:nodeId,fileName:fileName},
				dataType:"json",
				success:function(data, textStatus){
					console.log("success...");
					$.unblockUI();
// 					console.log(data);
					var _row ="<tr class='success'><td width='25%'>属性</td><td width='40%'>值</td><td width='35%'>说明</td></tr>";
					$("#ruleTable").append(_row);
					var saveButtonStatus = "0";
					$.each(data,function(index,item){
						var status =item.status;
						var updateFlag =item.updateFlag;
						var key =item.key;
						var value =item.value;
						var valueDef =item.valueDef;
// 						console.log("value="+value+",valueDef="+valueDef+",="+(value!=valueDef));
						var _row ="";
						_row += "<tr>";
						_row += "<td>";
						if(status=="off"){
							_row += "【已失效】";
						}
						_row += "<input name='conKey' value='"+key+"' type='hidden'/><input name='conValueOld' value='"+value+"' type='hidden'/>"+key;
						if(valueDef != undefined && value!=valueDef){
							_row += "<br><span class='glyphicon glyphicon-exclamation-sign'></span>&nbsp;&nbsp;";
						}
// 						if(valueDef!=value){
// 							_row += "<span class='glyphicon glyphicon-retweet'></span>&nbsp;&nbsp;";
// 						}
						_row += "</td>";
						if("APP.properties" == fileName){
							saveButtonStatus="1";
							_row += "<td>"+"【固定值】"+value+"</td>";
						}else if("API_BIZ.properties" == fileName){
							if(key == "clean_time"){
								_row += "<td><input name='conValue' placeholder='默认值' value='"+item.value+"' class='form-control'/></td>";
							}else{
								_row += "<td><input name='conValue' value='"+value+"' type='hidden'/>"+"【固定值】"+value+"</td>";
							}
// 						}else if("c3p0.properties" == fileName){
// 							_row += "<td>"+""+value+"</td>";
// 							saveButtonStatus="1";
// 						}else if("jdbc.properties" == fileName){
// 							_row += "<td>"+"【固定值】"+value+"</td>";
// 							saveButtonStatus="1";
						}else{
							if(status=="off"){
								_row += "<td><input class='form-control' name='conValue' value='"+value+"'/></td>";
							}else if(key=="DARWIN_HOME" || key=="server_port"){
								_row += "<td><input name='conValue' value='"+value+"' type='hidden'/>"+value+"</td>";
							}else if(key.indexOf("password")>=0){
								_row += "<td><input type='password' name='conValue' value='"+item.value+"' class='form-control'/></td>";
							}else{
								_row += "<td>";
								if(value =='true'){
									_row += "<select class='form-control' style='width:80px;' id='conValue' name='conValue'>";
									_row += "<option selected='selected' value='true'>true</option>";
									_row += "<option value='false'>false</option>";
									_row += "</select>";
								}else if(value =='false'){
									_row += "<select class='form-control' style='width:80px;' id='conValue' name='conValue'>";
									_row += "<option value='true'>true</option>";
									_row += "<option selected='selected' value='false'>false</option>";
									_row += "</select>";
								}else{
									
									
// 									_row += "<div id='edit"+key+" >";
// 									_row += "<a onclick='editFile('"+key+"');'><span class='glyphicon glyphicon-pencil' ></span></a>"+item.value;
// 									_row += "</div>";
// 									_row += "<div id='save"+key+"' style='display:none;'>";
// 									_row += "<a onclick='closeFile('"+key+"');'><span class='glyphicon glyphicon-pencil' ></span></a><input id='input"+key+"' value='"+item.value+"'>"; 
// 									_row += "<a class='btn btn-primary btn-xs' onclick='saveFile('"+key+"');'>保存</a>";
// 									_row += "</div>";
									
									if(key == 'HADOOP_SPARK_CLASSPATH' || key=='app.preloads' 
											|| key=='yialert.text.format' 
											|| key=='alert_shell_env_format_text'
											|| key=='depend_files' || key=='hive_depend_jars'){
										_row += "<textarea name='conValue' id='conValue' rows='8' cols='230' class='form-control'>"+item.value+ "</textarea>";
									}else{
										_row += "<input name='conValue' placeholder='默认值' value='"+item.value+"' class='form-control'/>";
									}
								}
								_row += "</td>";
							}
							
						}
						
						_row += "<td>"+item.remark+"</td>";
						_row += "</tr>";
						$("#ruleTable").append(_row);
					});
					if(saveButtonStatus=="0"){
						$("#save001").attr("type","submit");
						$("#save001").attr("class","btn btn-primary btn-xs");
						$("#fileName").val(fileName);
						var _actionUrl = "<%=request.getContextPath() %>/configure?method=save&fileName="+fileName;
						$('#fId').attr("action",_actionUrl);
					}else{
						$("#save001").attr("type","button");
						$("#save001").attr("class","btn btn-default btn-xs");
					}
					
					
					$.unblockUI();
				},
				error:function(){
					console.log("加载数据失败！");
					$.unblockUI();
				}
		});
		
	}
	
});
</SCRIPT>

</body>
</html>