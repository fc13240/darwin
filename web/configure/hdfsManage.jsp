<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowCompInfo"%>
<%@page import="com.stonesun.realTime.services.db.FlowCompServices"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>

<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>数据管理</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/uploadify/uploadify.css" type="text/css">

<style type="text/css">
	
	.uploadify{
		display: inline-block;
		position: relative;
		  margin-bottom: 1em;
		  display: inline-block;
	}
</style>
</head>
<body ng-app="angularBtns">
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%request.setAttribute("leftTreeType", "dataConfOpen");%>
	<%request.getSession().setAttribute(Container.session_leftTreeTopId,"36"); %>
	<%request.setAttribute("topId", "36");%>
	<%request.setAttribute("type", request.getParameter("type"));%>
	<%
		try{
			String dictPath = request.getParameter("dictPath");
			if(StringUtils.isNotBlank(dictPath)){
				request.setAttribute("hdfsPath", dictPath);
			}
			String hdfsPath = request.getParameter("hdfsPath");
			String compId = request.getParameter("compId");
			if(StringUtils.isNotBlank(compId) && Integer.valueOf(compId) > 0){
				UserInfo userInfo = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo));
				if(userInfo==null){
					System.out.println("登录已经失效！");
				}else{
					FlowCompInfo flowComp = FlowCompServices.selectById(Integer.valueOf(compId),userInfo.getId());
					if(flowComp == null){
						response.sendRedirect("/resources/403.jsp");
						return;
					}else{
						if(StringUtils.isNotBlank(flowComp.getConfig())){
							JSONObject c2 = JSON.parseObject(flowComp.getConfig());
							if(c2.getString("code").equals("dataClean")
									|| c2.getString("code").equals("participle")
									|| c2.getString("code").equals("emotionAnalysis")){
								//这儿，清洗组件有多个输出HDFS目录，需要每一个都打开，这个稍后做。
								hdfsPath = c2.getJSONArray("storeinfo").getJSONObject(0).getString("paDataDir");
							}else if(c2.getString("code").equals("realtimeToHdfs")){
								hdfsPath = c2.getJSONObject("storeinfo").getString("paDataDir");
							}else{
								request.setAttribute("storeinfo", c2.getJSONObject("storeinfo"));
								hdfsPath = c2.getJSONObject("storeinfo").getString("path");
							}
							System.out.println("hdfsPath = " + hdfsPath);
							request.setAttribute("hdfsPath", hdfsPath);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	%>

	<div class="page-header" >
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					数据管理 / HDFS数据管理
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500" >
		<div class="row">
<%-- 		<c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>

			<div class="col-md-9 col-compact">
				<div class="row">
					<div class="col-md-8 col-compact">
						<a id="refreshNode" href="#" onclick="return false;" style="display:none;">重新加载</a>

						<div class="input-group input-group-sm" style="margin-right:15px;">
							
						  <div class="input-group-addon" style="border-left: 1px solid #999;vertical-align: middle;white-space: nowrap;" id="hdfsRootPath">${sessionScope.session_userInfo.hdfsRootPath}</div>
						  <input id="anaKeywordInput" type="text" class="form-control" placeholder="请输入hdfs全路径" value="${hdfsPath }" aria-describedby="basic-addon2">
						  <input id="anaKeywordInputHidden" value="${hdfsPath }" aria-describedby="basic-addon2" type="hidden">
						  <input id="hdfsPath" name="hdfsPath" value="${hdfsPath }" type="hidden">
						  <input style="display:none;" type="checkbox" id="callbackTrigger" checked />
						  <span class="input-group-btn" style="vertical-align: middle;white-space: nowrap;">
						  		<button class="btn btn-default" type="button" id="expandSonBtn" onclick="return false;">GO</button>
						  </span>
						</div>
					</div>
					<div class="col-md-4 col-compact">
						<div ng-controller="shareController" id="shareDiv" style="display:inline-block">
							<common-share></common-share>
						</div>
						<div ng-controller="clearRuleController" id="clearRuleDiv" style="display:inline-block">
							<common-clear-rule></common-clear-rule>
						</div>
						<input id="uploadButton" type="button" class="btn btn-xs" value="本地上传" style="display:none;" />
						<code>本地上传支持的格式：txt,zip,jar,csv,tsv,xlsx,docx,log</code>
					</div>
					<div class="col-md-12 col-compact">
						<div class="alert alert-danger" id="fileNotFoundDiv" style="display:none;margin:15px 15px 15px 0px;"></div>
					</div>
				</div>

				<div class="row" style="margin-bottom:15px;">

					<div class="col-md-4 col-compact">

						<div id="myTabContent" class="tab-content" style="background:#fff;border:1px solid #ccc;padding:5px;">
						  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">

								<div style="min-width: 200px;overflow:auto;">
									<div id="loadImg2" style="text-align: left;">
										<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
									</div>
									<ul id="treeDemo2" class="ztree">
									</ul>
								</div>
						  </div>
						</div>
					</div>

					<div class="col-md-8 col-compact" style="margin-bottom:5px;">
						<input type="button" class="btn btn-danger btn-xs" value="删除" id="deleteSelected"/>
						<br>
						<table id="hdfsListTable" style="margin-top:5px;">
							<tr>
								<th w_check="true" width="3%;"></th>
								<th w_index="type" width="10%;">类型</th>	
								<th w_index="name" width="30%;" style="text-align:left;">文件名称</th>
								<th w_index="size" w_sort="size" width="10%;">大小</th>
								<th w_index="privilege" width="10%;">权限</th>
								<th w_index="user" width="10%;">用户</th>
								<th w_index="group" width="10%;">权限组</th>
								<th w_index="createdate" w_sort="createdate" width="10%;">创建日期</th>
								<th w_index="option" width="8%;">操作</th>
							</tr>
							<!--<tr>
								<td w_check="true" width="3%;">Dir</td>
								<td width="10%;">类型</td>	
								<td width="30%;">文件名称</td>
								<td width="10%;">大小</td>
								<td width="10%;">权限</td>
								<td width="10%;">用户</td>
								<td width="10%;">权限组</td>
								<td width="10%;">创建日期</td>
								<td width="130%;">操作1</td>
							</tr>-->
						</table>

						<form style="display: none;"
							action="<%=request.getContextPath() %>/analytics?method=save" method="post"
							class="form-horizontal" role="form" onclick="return func();">

							<div id="u40" class="text">
								<p><span>当前为【/dataroot/beijing/】的子路径/文件，共 3 个对象</span></p>
							</div>
							<input value="${ana.id}" name="id" id="id" type="hidden"/>
							<!-- page content start -->
							<div class="container mh500" style="margin:0;padding:0;">
								<table class="table table-hover table-striped">
									<thead>
										<tr>
											<th>类型</th>
											<th>文件名</th>
											<th>大小</th>
											<th>权限</th>
											<th>用户</th>
											<th>权限组</th>
											<th>创建日期</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="stu" items="${pager.list}">
											<tr>
												<td>${stu.id}</td>
												<td>${stu.name}</td>
												<td>输出数据索引:</td>
												<td>${stu.projectName}</td>
												<td>${stu.containDatasource}</td>
												<td>
													<div class="dropdown">
													<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">
													  请选择<span class="caret"></span>
													</a>
													<ul class="dropdown-menu dropdown-menu-right" role="menu">
														<li>
															<a href="analytics/edit.jsp?id=${stu.id}">编辑</a>
														</li>
														<li>
															<a href="#" class="disable">导出</a>
														</li>
														<li>
															<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/analytics?method=deleteById&id=${stu.id}">删除</a>
														</li>
														<li>
															<a href="#" class="disable">查看输出数据</a>
														</li>
														<li>
															<a href="#" class="disable">检索输出数据</a>
														</li>
														<li>
															<a href="#" class="disable">分析输出数据</a>
														</li>
													</ul>
												</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- page content end -->
						</form>

					</div>

				</div>

			</div>



		</div>

	</div>

	<input name="share" type="hidden"/>
	<input name="clearRule" type="hidden"/>
	<div style="display:none;" id="session_hdfsGlobalBtnPrivilege">${sessionScope.session_hdfsGlobalBtnPrivilege}</div>
<%-- 	sessionScope.session_userInfo.roleId=${sessionScope.session_userInfo.roleId} --%>
	<c:choose>
		<c:when test="${sessionScope.session_userInfo.roleId eq '3'}">
			<input id="readonlyAccount" value="true" type="hidden"/>
		</c:when>
		<c:otherwise>
			<input id="readonlyAccount" value="false" type="hidden"/>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${sessionScope.session_hdfsDeletePrivilege}">
			<input id="isDelete" value="true" type="hidden"/>
		</c:when>
		<c:otherwise>
			<input id="isDelete" value="false" type="hidden"/>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${sessionScope.session_hdfsSavePrivilege}">
			<input id="isSave" value="true" type="hidden"/>
		</c:when>
		<c:otherwise>
			<input id="isSave" value="false" type="hidden"/>
		</c:otherwise>
	</c:choose>

<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script> --%>
<!-- grid.simple.min.css, grid.simple.min.js -->

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
	.ztree li span.button.icon00_ico_open, .ztree li span.button.icon00_ico_close{margin-right:2px; title:清理规则; background: url(/resources/images/clearRule.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
</style>
<%-- <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css"> --%>
<%-- <script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script> --%>
<%-- <script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script> 

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>
<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/kindeditor-all.js"></script>
<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/lang/zh_CN.js"></script>--%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/uploadify/jquery.uploadify.js"></script>

<script src="<%=request.getContextPath() %>/flow/flowComp/dataClean/js/lib/angular.js"></script>
<script type="text/javascript">
	angular.module('angularBtns', [
	//'comp.filters',
	//'comp.services',
	'common_share', 
	'common_clearRule'
	]);
</script>
<script src="<%=request.getContextPath() %>/resources/js/common_share.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/common_clearRule.js"></script>

<SCRIPT type="text/javascript">

$(function(){

	var hdfsPath = $("#hdfsPath").val();
	var readonlyAccount;
	if($("#readonlyAccount").val()==="true"){
		readonlyAccount = true;
		$("#deleteSelected").attr("disabled",true);
		$("#uploadButton-button").addClass("disabled");
	}else{
		readonlyAccount = false;
	}

	var isSave;
	if($("#isSave").val()==="false"){
		isSave = false;
		$("#uploadButton-button").addClass("disabled");
	}else{
		isSave = true;
	}

	var isDelete;
	if($("#isDelete").val()==="false"){
		isDelete = false;
		$("#deleteSelected").attr("disabled",true);
	}else{
		isDelete = true;
	}

	//
	var hdfsGlobalBtnPrivilege = eval('('+$("#session_hdfsGlobalBtnPrivilege").html()+')');
	hdfsGlobalBtnPrivilegeSetting();
	//

	if(hdfsPath && $.trim(hdfsPath)!=''){
		hdfsPath = hdfsPath
		var rootPath = $("#hdfsRootPath").text();
		if(rootPath===hdfsPath){
			$("#anaKeywordInput").val("");
		}else{
			$("#anaKeywordInput").val(hdfsPath.substring(rootPath.length));
		}
		hdfsPath = $("#anaKeywordInput").val();
	}
	console.log("hdfsPath.hdfsPath.hdfsPath="+hdfsPath);

	function getInputHdfsPath(){
		if($.trim($("#anaKeywordInput").val())==''){
			return $("#hdfsRootPath").text();
		}
		console.log(">>1="+$("#hdfsRootPath").text());
		console.log(">>2="+$("#anaKeywordInput").val());
		return $("#hdfsRootPath").text()+$("#anaKeywordInput").val();
	}

	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},async:{
				enable:true,
				url:"<%=request.getContextPath() %>/config/hdfs?method=getMenus",
				type: "get",
				autoParam:["hdfsPath","shared","rootPath"],
				otherParam: { "initShowPath":getInputHdfsPath()}
			},edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},view: {expandSpeed:"fast",
				addHoverDom: addHoverDom,
				showTitle: true,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},callback: {
				onClick: onClick,
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove,
				onRename: onRename,
				beforeExpand: beforeExpand,
				onCollapse: onCollapse,
				onExpand: onExpand,
				onAsyncSuccess: onAsyncSuccess,
				onAsyncError:onAsyncError,
				beforeAsync:beforeAsync
			},data: {
				key: {
					title:"title"
				},
				keep: {
					parent: true,
					leaf: true
				}
			}
	};

	function beforeAsync(treeId, treeNode){
		console.log("beforeAsync..");
		console.log(treeNode);
		if(treeNode && treeNode.hdfsPath==='-'){
			return false;
		}
		return true;
	}

	function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown){
		alert("异步加载出现异常!");
		console.log(errorThrown);
		console.log(XMLHttpRequest);
		$("#loadImg2").hide();
	}

	function onAsyncSuccess(event, treeId, treeNode, msg) {
 		console.log("onAsyncSuccess...");
 		$("#loadImg2").hide();

		if(msg.indexOf("-1") == 0){
			alert(msg);
			return;
		}

		var s = eval('('+msg+')');
		var hdfsDefaultRootPath = "";

		if($.isArray(s)){
			if(s.length==0){
				console.log("目录下没有任何文件或文件夹");
				setting_uploadify();
				refreshRightTable();
				return;
			}
			hdfsDefaultRootPath = s[0].name
		}else{
			hdfsDefaultRootPath = s.name;	
		}
		console.log("hdfsDefaultRootPath="+hdfsDefaultRootPath);

		var inputValue = $("#anaKeywordInput").val();
		if(s[0].exists==false){
			//$("#fileNotFoundDiv").show().html("搜索的Hdfs路径不存在！"+s[0].error);
			$("#fileNotFoundDiv").show().html(s[0].error);
			return;
		}else{
			$("#fileNotFoundDiv").hide().html("");
			if(inputValue=='' || inputValue=='/' || !inputValue || readonlyAccount || !isSave){
				$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
				$("#anaKeywordInputHidden").val("");
			}else{
				$("button[name='common_clearRule_buttonOne']").removeAttr("disabled");
				$("#anaKeywordInputHidden").val(getInputHdfsPath());
			}
			
		}

		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        var nodes = zTree.getSelectedNodes();
        console.log("nodes.length="+nodes.length);
        if(nodes.length==0){
            console.log("设置默认的目录被选中");

            var hdfsPath22 = getInputHdfsPath();
            console.log("hdfsPath22.1="+hdfsPath22);
            if($.trim(hdfsPath22)==''){
            	hdfsPath22 = hdfsDefaultRootPath;
	            $("#anaKeywordInput").val(hdfsPath22);
	            $("#anaKeywordInputHidden").val(hdfsPath22);
            }
            console.log("hdfsPath22.2="+hdfsPath22);
            var n1 = zTree.getNodeByParam("id", hdfsPath22, null);
            console.log("n1");
            console.log(n1);
            if(n1){
            	n1.async = true;
				zTree.selectNode(n1);

				var nodes = zTree.getSelectedNodes();
	        	console.log("nodes.length222="+nodes.length);

				zTree.expandNode(n1, true, false, null, false);
            }
        }else{
	        hdfsGlobalBtnPrivilegeSetting();
        }
        setting_uploadify();
		refreshRightTable();
	}

	function getSelectShareAndClearPath(hdfsPath){
		console.log("getSelectShareAndClearPath。。。"+hdfsPath);
        return $("#anaKeywordInputHidden").val(hdfsPath);
    }
    
	function refreshRightTable(){
		console.log("refreshRightTable++");
        var hdfsPath = getSelectDir(true);
        console.log("hdfsPath = "+hdfsPath);

		gridObj22.options.otherParames = {rootPath:$("#hdfsRootPath").text(),"hdfsPath":hdfsPath};
		gridObj22.page(1);

		console.log("refreshRightTable....");
		//$("#hdfsListTable > thead > tr:eq(1)").find("th:eq(0)").hide();
		//console.log($("#hdfsListTable > tbody > tr:eq(1)").html());

//http://bsgrid.coding.io/examples/grid/extend.html bsgrid表格的数据是异步加载的，这个怎么才能回调我的方法呢？！
		/*$.bsgrid.forcePushPropertyInObject($.fn.bsgrid.defaults.extend.initGridMethods, 'extend_init', function(gridId, options){
			console.log('extend init method.');
			console.log($("#hdfsListTable > tbody > tr:eq(1)").html());
			$("#hdfsListTable tr:eq(1)").find("th:eq(0)").hide();

		});*/

	}

	function showRemoveBtn(treeId, treeNode) {
		if(!treeNode["pId"]){
			return;
		}
		if(treeNode && treeNode.hdfsPath==='-'){
			return;
		}
		return !(treeNode["level"] == "0") && !readonlyAccount && isDelete;
	}

	function showRenameBtn(treeId, treeNode) {
		if(!treeNode["pId"]){
			return;
		}
		if(treeNode && treeNode.hdfsPath==='-'){
			return;
		}
		return !(treeNode["level"] == "0")  && !readonlyAccount && isSave;
	}

	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
		if(!treeNode["pId"] || readonlyAccount || !isSave){
			return;
		}

		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
			var _name = "NewFolder";
			var _newNode = {id:(100 + newCount), pId:treeNode.id, name:_name,hdfsPath:treeNode["hdfsPath"],isParent:true};

			$.ajax({
				url:"<%=request.getContextPath() %>/config/hdfs?method=mkdir",
				data:_newNode,
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					if(data && data!=''){
						_newNode["name"] = data;
						_newNode["hdfsPath"] = treeNode["hdfsPath"] + "/" + data;
						var node = zTree.getNodeByParam("id", _newNode["hdfsPath"], null)
						if(treeNode.open){
							zTree.addNodes(treeNode,_newNode);
							zTree.reAsyncChildNodes(treeNode,"refresh");
						}else{
							zTree.reAsyncChildNodes(treeNode,"refresh");
						}
					}else{
						alert("新增目录失败！");
					}
				},
				error:function(){
					alert("新增目录出错！");
				}
			});
			return false;
		});
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
// 		console.log("hdfsPath...");
	}

	function expandNode(e) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
		type = e.data.type;

		var hdfsPath = $("#hdfsPath").val();
		getSelectShareAndClearPath(hdfsPath);
		
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

	function showTreeByPath(path){
		console.log("showTreeByPath.path="+path);
		setting.async.otherParam.initShowPath = path;

		loadMenusTree();
	}

	$("#expandSonBtn").click(function(){
		var path = getInputHdfsPath();
		if($.trim(path)==''){
			alert("查询的路径不能为空!");
			return;
		}
		showTreeByPath(path);
	});

	var beforeDelete_name;
	function beforeRemove(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.selectNode(treeNode);
		beforeDelete_name=treeNode.name;
		return confirm("确认删除 节点 -- " + treeNode.name+ " 吗？");
	}

	function onRemove(e, treeId, treeNode) {
		if(readonlyAccount && !isDelete){
			alert("只读账号不支持此操作！");
			return;
		}
		var parentPath = treeNode["hdfsPath"];
		var path = parentPath.substring(0,parentPath.indexOf(beforeDelete_name));
		var deleteData = {};
		var pId = treeNode["pId"];
		var renameData = {};
		console.log("delete = "+treeNode["hdfsPath"]);
		deleteData["path"]= treeNode["hdfsPath"];//pId + "/" + beforeDelete_name;

		$.ajax({
			url:"<%=request.getContextPath() %>/config/hdfs?method=delete",
			data:deleteData,
			type:'post',
			dataType:"text",
			success:function(data,testStatus){
				if(data && data == "0"){
					console.log("delete成功！");
					//set default select root node
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
					var nodes = treeObj.getNodes();
					console.log("nodes.length="+nodes.length);
					if (nodes.length>0) {
						treeObj.selectNode(nodes[0]);

						refreshNode("");
					}

					//refreshRightTable();
				}else{
					alert("删除失败！");
				}
			},
			error:function(){
				alert("删除失败");
			}
		});
	}

	function beforeEditName(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.selectNode(treeNode);
	}
	function getTime() {
		var now= new Date(),
		h=now.getHours(),
		m=now.getMinutes(),
		s=now.getSeconds(),
		ms=now.getMilliseconds();
		return (h+":"+m+":"+s+ " " +ms);
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
		if(readonlyAccount && !isSave){
			alert("只读账号不支持此操作！");
			return;
		}
		var nowName = treeNode.name;
// 		var pId = treeNode["pId"];
		var renameData = {};
		renameData["oldPath"] = treeNode["hdfsPath"];// +"/"+ beforeRename_name;
		renameData["newPath"] = treeNode.getParentNode().hdfsPath+"/"+ nowName;//pId +"/"+ nowName;
		console.log(treeNode.getParentNode().hdfsPath);
		console.log(renameData);
		var oldrelativePath = treeNode.relativePath;
		console.log("old relativePath="+oldrelativePath);
		var oldrelativePaths = oldrelativePath.split("/");
		var newrelativePath = "";
		for(var i=0;i<oldrelativePaths.length-1;i++){
			newrelativePath += oldrelativePaths[i]+"/";
		}
		console.log("newrelativePath="+newrelativePath);
		newrelativePath = newrelativePath+nowName;
		
		$.ajax({
			url:"<%=request.getContextPath() %>/config/hdfs?method=rename",
			data:renameData,
			type:"post",
			dataType:"text",
			success:function(data, textStatus){
				if(data && data == "0"){
					treeNode["hdfsPath"] = renameData["newPath"];
					var _oldUri = treeNode["hdfsUri"];
					if(_oldUri && _oldUri.startWith("hdfs://")) {
					      var pos = _oldUri.indexOf("/", 9);
					      var firstPart = _oldUri.substring(0, pos);
					      var newUri = firstPart + renameData["newPath"];
						  treeNode["hdfsUri"] = newUri;
					} else {
					}
					treeNode.relativePath = newrelativePath;
				}else{
					alert("重命名失败！");
				}
			},
			error:function(){
				alert("重命名失败！");
			}
		});

	}

	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};

	//加载菜单树
	function loadMenusTree(){
		$("#loadImg2").show();
		$("#treeDemo2").show();
		$.fn.zTree.init($("#treeDemo2"), setting);

		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");

		//
		if(false){
			$.ajax({
					url:"<%=request.getContextPath() %>/config/hdfs?method=getMenus",
					type:"post",
					dataType:"JSON",
					success:function(data, textStatus){
						$.fn.zTree.init($("#treeDemo2"), setting, data);
						$("#treeDemo2").show();
					},
					error:function(){
						alert("加载数据出错！");
					}
			});
		}
	}

	loadMenusTree();

	function onClick(e,treeId, treeNode) {
		console.log("onClick...");
		console.log(treeNode);
		console.log(treeNode.getParentNode());

		console.log("treeNode.hdfsPath="+treeNode.hdfsPath);

		if(treeNode.hdfsPath==="-"){
			console.log("return by-");
			return;
		}

		if(!treeNode["pId"]){
			return;
		}

		//if(!readonlyAccount && isSave){

		if(!treeNode["shared"]){
			hdfsGlobalBtnPrivilegeSetting();
		}else{
			$("button[name='common_share_buttonOne']").attr("disabled","disabled");
			$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
		}

		refreshNode({type:"refresh", silent:false});
	}

	var gridObj22 = $.fn.bsgrid.init('hdfsListTable', {
        url: '<%=request.getContextPath() %>/config/hdfs?method=hdfsList',
        pageSizeSelect: true,
        pageSize: 10,
        multiSort: true // multi column sort support, default false
    });

	gridObj22.options.otherParames = {rootPath:$("#hdfsRootPath").text(),"hdfsPath":""};
	gridObj22.page(1);

	function hdfsGlobalBtnPrivilegeSetting(){
		console.log("hdfsGlobalBtnPrivilege.length="+hdfsGlobalBtnPrivilege.length);
		console.log(hdfsGlobalBtnPrivilege);
		console.log(hdfsGlobalBtnPrivilege == false);
		if(JSON.stringify(hdfsGlobalBtnPrivilege) == "{}"){
			$("button[name='common_share_buttonOne']").attr("disabled","disabled");
			$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
			return;
		}

		console.log("hdfsGlobalBtnPrivilegeSetting....");
		if(hdfsGlobalBtnPrivilege.shareBtns.indexOf("save")!=-1){
			console.log("not disabled share btn...");
			$("button[name='common_share_buttonOne']").removeAttr("disabled");
		}else{
			console.log("disabled share btn...");
			$("button[name='common_share_buttonOne']").attr("disabled","disabled");	
		}

		if(hdfsGlobalBtnPrivilege.clearRuleBtns.indexOf("save")!=-1){
			console.log("not disabled clearRule...");
			$("button[name='common_clearRule_buttonOne']").removeAttr("disabled");
		}else{
			console.log("disabled clearRule...");
			$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
		}
	}

	function ajaxRequest(_url,tableID,hdfsPath){

		gridObj22.options.otherParames = {rootPath:$("#hdfsRootPath").text(),"hdfsPath":hdfsPath};
		gridObj22.page(1);

		if(1==1){
			return;
		}
		//createMark();
		$.ajax({
			url:_url,
			type:"post",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
				if(!data || data==''){
					console.log("data is null!");
					return;
				}
				gridObj.options.otherParames = {"param1":"param1"};
				gridObj22.page(1);

				//showTable0(data,tableID);
				//$.unblockUI();
			},
			error:function(){
				console.log("加载数据出错！");
				//$.unblockUI();
				alert("本次请求出错！请重试或联系管理员。");
			}
		});
	}

	function showTable0(localData,tableID){
// 		console.log("showTable0...");
		$("#" + tableID + "_pt_outTab").remove();
		var gridObj = $.fn.bsgrid.init(tableID, {
            pageSizeSelect: true,
            longLengthAotoSubAndTip: false,
            displayBlankRows: false, // single grid setting
            displayPagingToolbarOnlyMultiPages: true, // single grid setting
            localData: localData,
            processUserdata: function (userdata, options) {
                $("#" + tableID + ' tr th').remove();
                var dynamic_columns = userdata['dynamic_columns'];
//                 console.log("dynamic_columns="+dynamic_columns);
                if(!dynamic_columns){return;}
                var cNum = dynamic_columns.length;
//                 console.log("cNum="+cNum);
                for (var i = 0; i < cNum; i++) {
                    var filename = dynamic_columns[i];
                    if(filename == 'name'){
                        console.log("filename = "+filename);
                    }
                    $("#"+tableID+' tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
                }
            }
        });
	}

	function refreshNode(e) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
		type = "refresh";
		silent = false;
		nodes = zTree.getSelectedNodes();
		if (nodes.length == 0) {
			alert("请先选择一个父节点");
			return;
		}

		//for (var i=0, l=nodes.length; i<l; i++) {
		//	zTree.reAsyncChildNodes(nodes[i], type, silent);
		//}

		console.log("reAsyncChildNodes:");
		console.log(nodes[0]);
		zTree.reAsyncChildNodes(nodes[0], type, silent);

		var rootPath = nodes[0].pId;
		var relativePath = nodes[0].relativePath;
		console.log(">>>>>refreshNode.rootPath="+rootPath+",relativePath="+relativePath);

		$("#hdfsRootPath").text(rootPath);
		$("#anaKeywordInput").val(relativePath);
		if(relativePath=='' || !relativePath || relativePath=='/' || readonlyAccount || !isSave){
			$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
			$("#anaKeywordInputHidden").val("");
		}else{
			$("button[name='common_clearRule_buttonOne']").removeAttr("disabled");
			$("#anaKeywordInputHidden").val(rootPath+relativePath);
		}
		
	}

	$("#refreshNode").bind("click", {type:"refresh", silent:false}, refreshNode);


	function goToDir2(path){
		console.log("goToDir...");
		showTreeByPath(path);
	}

	function getSelectDirNotAlert(){
		console.log("getSelectDirNotAlert。。。"+$("#anaKeywordInputHidden").val());
        return $("#anaKeywordInputHidden").val();
    }

	function getSelectDir(showAlert){

        var path = getInputHdfsPath();
        if($.trim(path)==''){
    		alert("请选择一个目录！");
    		return;
    	}
    	return path;

        /*if(1==1){
        	if(nodes.length==0){
	        	

	        	var path = getInputHdfsPath();

	        	if(path==''){
	        		alert("请选择一个目录！");
	        		return;
	        	}
	        	return path;
	        }else{
	        	return nodes[0].hdfsPath;
	        }
        }*/
        
        /*
        if(nodes.length==0 && showAlert){
        	alert("请选择上传的目录！");
        	return false;
        }else if(nodes.length==0){
        	console.log("getSelectDir.nodes.length=0");
        	return false;
        }
        console.log("getSelectDir="+nodes[0].hdfsPath);
        return nodes[0].hdfsPath;*/
	}

	function setting_uploadify(){
		console.log("setting_uploadify...");
		var dscDir = getSelectDir(true);
		console.log("dscDir="+dscDir);
		$("#uploadButton").show();
		if(!readonlyAccount && isSave){
			$("#uploadButton").uploadify({
				//formData:{'dscDir2':"'"+dscDir+"'",'abc':'aaac大多数'},
				swf           : '/resources/uploadify/uploadify.swf',
				uploader      : '/resources/uploadify/upload_json.jsp?dir=file&dscDir='+encodeURI(encodeURI(dscDir)),
				fileTypeExts:"*.txt;*.log;*.zip;*.jar;*.csv;*.tsv;*.xls;*.xlsx;*.doc;*.docx;*.log",
				fileTypeDesc:"*.txt,*.log,*.zip,*.jar,*.csv,*.tsv,*.xls,*.xlsx,*.doc,*.docx;*.log",
				auto:true,
				multi:true,
				buttonText:"本地上传",
				buttonClass:"btn btn-danger btn-xs",
				onInit:function(){
					console.log("onInit");
					//$("#uploadButton").uploadify("disable",true);
				},
				onCheck:function(file, exists){
					console.log("onCheck..");
				},
				onDialogOpen:function(){
					console.log("onDialogOpen..");
					return false;
				},
				onUploadStart:function(){
					console.log("onUploadStart..");
					return false;
				},
				onFallback:function(){
					console.log("onFallback...");
				},
				onAddQueueItem:function(){
					console.log("onAddQueueItem...");
				},
				onOpen:function(event,queueId,fileObj){
					console.log("onOpen...");
					alert("open...");
				},
				onSelect:function(event,queueID,fileObj){
					console.log("onSelect..");
					return false;
				},
				onSelectOnce:function(){
					console.log("onSelectOnce..");
				},
				onError:function(event,queueId,fileObj,errorObj){
					console.log("onError..");
				},
				onProgress:function(event,queueId,fileObj,data){
					console.log("onProgress..");
				},
				onComplete:function(event,queueId,fileObj,response,data){
					console.log("onComplete...");
					
				},
				onAllComplete:function(event,data){
					console.log("onAllComplete..");
				},
				onUploadComplete:function(file, data){
					console.log("onUploadComplete..");
					refreshRightTable();
				},
				onUploadError:function(file, errorCode, errorMsg, errorString){
					alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
				},
				onUploadProgress:function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal){

				},
				onUploadSuccess:function(file, data, response){
					console.log('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);
					var ss = eval('('+$.trim(data)+')');
					if(ss.error==0){

					}else{
						alert("上传文件"+file.name+"出错,错误信息:"+ss.message);
					}
				},
				onSelectError:function(){

				}

			});
		}
		
//$("#uploadButton").uploadify("disable",true);
		if(readonlyAccount){
			//$("#uploadButton-button").addClass("disabled");
			//$("#uploadButton-button").off();
			
		}

// 		$("button[name='common_share_buttonOne']").removeAttr("disabled");
// 		$("button[name='common_clearRule_buttonOne']").removeAttr("disabled");
	}

	$("#deleteSelected").click(function(){

		var _delArray = [];
		$("#hdfsListTable tr:gt(0)").each(function(){
			if($(this).find("input:checked").prop("checked")){
				var _td = $($(this).find("td").get(2));
				console.log(_td.html()+","+_td.has("a").length);
				if(_td.has("a").length > 0){
					_delArray.push(_td.find("a").text());
				}else if(_td.has("span").length > 0){
					_delArray.push(_td.find("span").text());
				}else{
					_delArray.push(_td.html());
				}
			}
		});

		console.log(_delArray);

		var dscDir = getSelectDir(true);

		if(dscDir==''){
			alert("请选择Hdfs树节点！");
		} else if(_delArray.length==0){
			alert("请选择删除的文件或目录！");
		} else{
			deleteSelected0(dscDir,_delArray);
		}
	});

	function deleteSelected0(dscDir,_delArray){
		var _url = "<%=request.getContextPath() %>/config/hdfs?method=deleteSelected";
		
		$.ajax({
			url:_url,
			data:{
				dscDir:dscDir,
				_delArray:_delArray.toString()
			},
			type:"post",
			dataType:"json",
			async:true,
			timeout:10*60000,
			success:function(data, textStatus){
				console.log(data);
				$.unblockUI();
				var _status = data["status"];
				if(_status){
					//refreshRightTable();
					
					
					var delFailed = data["delFailed"];
					if(delFailed!=''){
						alert("部分文件删除失败！"+delFailed);
					}
					
					$("#expandSonBtn").trigger("click");
					
				}
			},error:function(err){
				console.log("ajax.error");
				console.log(err);
				var _e = err["statusText"];
				console.log(_e);
				
				$.unblockUI();
			}
		});
	}
	
	//console.log(">>>>");
	//console.log(angular.element("#shareDiv").scope());
	//console.log(angular.element("#clearRuleDiv").scope());

	angular.element("#shareDiv").scope().initConfig({
		"type":"hdfs",
		"common_share_buttonOne_class":"btn btn-success btn-xs",
		"resources":function(){
			return getSelectDirNotAlert();
		}
	});
	
	angular.element("#clearRuleDiv").scope().initConfig2({
		"type":"hdfs",
		"common_clearRule_buttonOne_class":"btn btn-info btn-xs",
		"resources":function(){
			return getSelectDirNotAlert();
		}
	});

});


function readHdfsFile(filepath){
	$("div[type='iframe']").remove();
// 	console.log("readHdfsFile..."+filepath);
	layer.open({
        type: 2,
        title: [
                'hdfs文件内容片段  文件路径:'+filepath,
                'border:none; background:#61BA7A; color:#fff;'
        ],
        zIndex: 19891014,
        //fix: true,
        maxmin: true,
        move: false,
        shade: false, //不显示遮罩
        border: [0,1,'#61BA7A'], //不显示边框
        area: [$("body").width()+'px', '300px'],
        offset: 'rb', //右下角弹出
//         content:'readHdfsFile.jsp?path='+filepath,
        content:'<%=request.getContextPath() %>/configure/readHdfsFile.jsp?path='+filepath,
		shift: 2 //从上动画弹出
	});

};

function goToDir(rootPath,relativePath){
		console.log("goToDir..."+rootPath+",relativePath="+relativePath);
		//$("#anaKeywordInput").val(path);
		//$("#anaKeywordInputHidden").val(path);

		$("#hdfsRootPath").text(rootPath);
		$("#anaKeywordInput").val(relativePath);
		$("#anaKeywordInputHidden").val(relativePath);

		$("#expandSonBtn").trigger("click",{"path":path});
	}

</SCRIPT>

</body>
</html>
