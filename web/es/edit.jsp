<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BigSearch服务</title>

<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style type="text/css">
	.red{background-color:#D9080D;}
	.ztree li span.button.icon00_ico_open, .ztree li span.button.icon00_ico_close{margin-right:2px; title:清理规则; background: url(/resources/images/clearRule.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
</style>
</head>
<body ng-app="angularBtns">
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%request.setAttribute("compId", request.getParameter("compId"));%>
	<%request.setAttribute("compType", request.getParameter("type"));%>
	<%request.setAttribute("topId", "36");%>
	<%
		String id = request.getParameter("id");
		String before = SystemProperties.getInstance().get("es_index");
		String esClusterName = SystemProperties.getInstance().get("es_clusterName");
		request.setAttribute("before", before);
		request.setAttribute("esClusterName", esClusterName);
	%>

	<input type="hidden" name="indexNameHidden" id="indexNameHidden" value="">
	<input type="hidden" name="before" id="before" value="${before }">
	<input type="hidden" name="esClusterName" id="esClusterName" value="${esClusterName }">
	<input type="hidden" name="compId" id="compId" value="${compId }">
	<input type="hidden" name="compType" id="compType" value="${compType }">
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					配置
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
			<form action="<%=request.getContextPath() %>/es?method=saveTree&compId=${compId}&compType=${compType}" method="post" class="form-horizontal" role="form">
				<div class="col-md-9 col-compact">
					<div class="page-header">
						<div class="row">
							<div class="col-xs-6 col-md-6">
								<div class="page-header-desc">
								BigSearch服务
								</div>
							</div>
						</div>
					</div>
					<div class="mh500">
						<div class="row">
							<div class="col-md-4 col-compact">
							    <ul id="myTab" class="nav nav-tabs" role="tablist">
							      <li role="presentation" class="active"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">索引/表/字段</a></li>
							    </ul>
							    <div id="myTabContent" class="tab-content panel panel-body">
							      <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
						      		<div style="overflow:auto;max-height: 360px;">
										<div id="loadImg" style="text-align: left;">
											<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
										</div>
										<ul id="treeDemo" style="display: none;" class="ztree"></ul>
									</div>
							      </div>
							    </div>
							</div>
							<div class="col-md-8 col-compact">
									<input value="" name="id" id="id" type="hidden"/>
									<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<button code="save" class="btn btn-sm btn-primary" type="button" id="newIndex">新建索引</button>
											<button code="save" class="btn btn-sm btn-primary" type="submit">保存</button>
											<a id="searchLink" target="_blank" href="" class="btn btn-sm btn-default" role="button">查看当前索引</a>
											<c:if test="${empty compId }">
												<a id="returnLink" href="/flow/init.jsp" class="btn btn-sm btn-primary" role="button">返回流程</a>
											</c:if>
											<c:if test="${not empty compId and compType=='es'}">
												<a id="returnLink" href="/flow/flowComp/conf.jsp?type=toEs&compId=${compId}" class="btn btn-sm btn-primary" role="button">返回流程</a>
											</c:if>
											<c:if test="${not empty compId and compType=='realtimeReceive'}">
												<a id="returnLink" href="/flow/flowComp/conf.jsp?type=realtimeReceive&compId=${compId}" class="btn btn-sm btn-primary" role="button">返回流程</a>
											</c:if>
											<div ng-controller="shareController" id="shareDiv" style="display:inline-block">
												<common-share></common-share>
											</div>
											<div ng-controller="clearRuleController" id="clearRuleDiv" style="display:inline-block">
												<common-clear-rule></common-clear-rule>
											</div>
										</div>
									</div>
									<div class="form-group" style="display:none">
										<label for="type" class="col-sm-2 control-label">type</label>
										<div class="col-sm-5">
											<input class="form-control input-inline" id="type" name="type"/>
										</div>
									</div>
									<div class="form-group" style="display:none;">
										<label for="id" class="col-sm-2 control-label">索引id</label>
										<div class="col-sm-5">
											<input class="form-control input-inline" placeholder="id" id="id" name="id"/>
										</div>
									</div>
									<div class="form-group">
										<label for="indexName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>索引名称</label>
										<div class="col-sm-5">
											<input data-rule="" class="form-control input-inline" placeholder="name@{yyyyMMdd}" id="indexName" name="indexName" />
										</div>
										<div class="col-sm-5">
											<p class="help-block">
												用于描述您的索引，便于之后的管理。
											</p>
										</div>
									</div>
									<div class="form-group">
										<label for="charset" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>文件编码</label>
										<div class="col-sm-5">
											<select class="form-control" id="charset" name="charset">
												<%
													session.setAttribute("charsetList", DataCache.charsetList);
												%>
												<c:forEach items="${charsetList}" var="list">
										           <option value="${list.key}">${list.value}</option>
										        </c:forEach>
											</select>
										</div>
										<div class="col-sm-5">
											<p class="help-block">
												索引的文件编码格式，用于检索仪表盘的显示。
											</p>
										</div>
									</div>
									<div class="form-group">
										<label for="tableName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>ES表名称</label>
										<div class="col-sm-5">
											<input class="form-control input-inline" placeholder="表名称" id="tableName" name="tableName" data-rule=""/>
										</div>				
										<div class="col-sm-5">
											<p class="help-block">
												用于描述您的table，便于之后的管理。
											</p>
										</div>
									</div>
									<input type="hidden" name="categoryId" id="categoryId" value="">
									<div class="form-group">
										<label for="categoryName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>所属分类</label>
										<div class="col-sm-5">
											<input class="form-control input-inline" placeholder="点击选择所属分类" id="categoryName" name="categoryName" data-rule="required;" readonly="readonly"/>
										</div>
										<div class="col-sm-2">
											<input class="btn btn-default" type="button" name="select" style="height:36px;margin-left:-30px;vertical-align:middle;padding:0px 8px;" value="选择分类">
										</div>			
									</div>
									<div class="form-group">
										<label for="categoryName" class="col-sm-2 control-label">&nbsp;
										</label>
										<div class="col-sm-7">
											<textarea id="tmp_mulit_column" rows="" cols="120"  class="form-control" placeholder="以逗号分隔，可以输入多列，点击自动分隔，系统自动为您生成对应的列。如：col1,col2,col3"></textarea>
										</div>
										<div class="col-sm-2">
											<input type="button" value="自动生成列" class="btn btn-sm btn-primary" id="autoDiv" onClick="autoCreateColumns()"/>
										</div>			
									</div>
<!-- 									<div class="form-group"> -->
<!-- 										<div class="col-sm-12"> -->
<!-- 											<textarea id="tmp_mulit_column" rows="" cols="120"  class="form-control" placeholder="以逗号分隔，可以输入多列，点击自动分隔，系统自动为您生成对应的列。如：col1,col2,col3"></textarea> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="form-group" > -->
<!-- 										<div class="col-sm-12" style="text-align: right;"> -->
<!-- 											<input type="button" value="自动生成列" class="btn btn-success" onClick="autoCreateColumns()"/> -->
<!-- 										</div> -->
<!-- 									</div> -->
									<div class="form-group">
										<label for="tableName" class="col-sm-2 control-label"></label>
										<div class="col-sm-9">
											<button  code="save" class="btn btn-xs btn-primary" type="button" id="newRow">
												<span class="glyphicon glyphicon-plus"></span>添加一行源字段
											</button>
											<label class="help-block">温馨提示：ES的字段只能增加，不能修改已添加的字段。</label>
										</div>
									</div>
									<div class="form-group">
										<label for="tableName" class="col-sm-1 control-label"></label>
										<div class="col-sm-10" id="mainDiv">
											<table class='table table-bordered table-hover' id='ruleTable'>
												<tr>
													<td style="width:5%">No</td>
													<td>类型</td>
													<td>名称</td>
													<td>描述</td>
													<td style="width:8%">操作</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
		</div>
	</div>
	<div id="typeJson" style="display: none;">
		<select class="form-control" name="pamType" id="pamType" data-rule="required;">
			<%
				session.setAttribute("types", DataCache.esTypeList);
			%>
			<c:forEach items="${types}" var="list">
	           <option value="${list.key}">${list.value}</option>
	        </c:forEach>
		</select>
	</div>
	<input id="anaKeywordInputHidden" value="" type="hidden">
	<%-- <c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css">
<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<script src="/flow/flowComp/dataClean/js/lib/angular.js"></script>
<script type="text/javascript">
	angular.module('angularBtns', [
	'common_share', 
	'common_clearRule'
	]);
</script>
<script src="/resources/js/common_share.js"></script>
<script src="/resources/js/common_clearRule.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>

<SCRIPT type="text/javascript">
function showLayer(_id,_value){
	layer.open({
	    type: 2,
// 	    border: [0,1,'#61BA7A'], //不显示边框
	    area: ['400px', '400px'],
// 	    shade: 0.8,
	    closeBtn: true,
	    shadeClose: true,
	    skin: 'layui-layer-molv', //墨绿风格
	    fix: false, //不固定
// 	    maxmin: true,
	    content: '/dataCategory/categoryTree.jsp?compId='+_id+'&pathValue='+_value
		});
	}

	$("input[name=select]").click(function(){
		var _id = $(this).parent().parent().find("input:eq(0)").attr("id");
		var _value = $(this).parent().parent().find("input:eq(0)").val();
		showLayer(_id,_value);
	});
	
$(function(){

	//查看是否有编辑权限
	var saveFlg = false;
	var privilegeBtns = $("#pagePrivilegeBtns").text();
	console.log("privilegeBtns  es ="+privilegeBtns);
	if($.trim(privilegeBtns)!=''){
		var btns = privilegeBtns.split(",");
		for(var b in btns){
			if(btns[b]=="save"){
				saveFlg = true;
				break;
			}
		}
	}else{
		saveFlg = true;
	}
	
	angular.element("#clearRuleDiv").scope().initConfig2({
		"mode":saveFlg,
		"type":"es",
		"common_clearRule_buttonOne_class":"btn btn-primary btn-sm",
		"resources":function(){
			console.log("es.initConfig..resources..");
			return $("#anaKeywordInputHidden").val();
		}
	});

	angular.element("#shareDiv").scope().initConfig({
		"mode":saveFlg,
		"type":"es",
		"common_share_buttonOne_class":"btn btn-success btn-sm",
		"resources":function(){
			console.log("initConfig..resources..");
			try{
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	        	var nodes = zTree.getSelectedNodes();
	        	console.log(nodes);
	        	if(nodes.length==0){
	        		alert("请选择要分享的索引！");
	        	}else{
	        		if(nodes[0].level==0){
	        			return nodes[0].name
	        		}else if(nodes[0].level==1){
	        			console.log("parent:");
	        			console.log(nodes[0].getParentNode());
	        			return nodes[0].getParentNode().name+"."+nodes[0].name;
	        		}
	        	}
			}catch(err){
				console.log(err);
			}
			return "";//getSelectDirNotAlert();
		}
	});
	
	var id=$("#id").val();
	if(id == ''){
		$("#searchLink").addClass("disabled");
	}

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
  				showRemoveBtn: showRemoveBtn,
  				showRenameBtn: false
			},view: {
				expandSpeed:"",
				showTitle: true,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},callback: {
				onClick: onClick,
				beforeRemove: beforeRemove,
				onRemove : onRemove,
				onClick : onMouseDown
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

	var beforeDelete_id;
	var beforeDelete_name;
	var beforeDelete_type;
	var brforeDelete_indexName;
	function beforeRemove(treeId, treeNode) {
// 		className = (className === "dark" ? "":"dark");
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.selectNode(treeNode);
		//获取节点的类型indexName或者是tableName
		beforeDelete_type=treeNode["nodeType"];
		beforeDelete_id=treeNode.id;
		beforeDelete_name=treeNode.name;
		brforeDelete_indexName=$("#indexName").val();
		return confirm("确认删除 节点 -- "+treeNode.name+ " 吗？");

	}

	function getTime() {
		var now= new Date(),
		h=now.getHours(),
		m=now.getMinutes(),
		s=now.getSeconds(),
		ms=now.getMilliseconds();
		return (h+":"+m+":"+s+ " " +ms);
	}

	function onRemove(e, treeId, treeNode) {
		console.log(treeNode);

// 		var parentPath = treeNode["hdfsPath"];
		var deleteData = {};
		deleteData["id"]=beforeDelete_id;
		deleteData["name"]=beforeDelete_name;
		deleteData["nodeType"]=beforeDelete_type;
		if(beforeDelete_type=="tableName"){
			deleteData["indexName"]=brforeDelete_indexName;
		}
		$.ajax({
			url:"<%=request.getContextPath() %>/es?method=delete",
			data:deleteData,
			type:'post',
			dataType:"text",
			success:function(data,testStatus){
				console.log("delete="+data);
				if(data && data == "0"){
// 					console.log("delete成功！");
					loadMenusTree();
					$("#newIndex").click();
				}else{
// 					console.log("delete失败！");
				}
			},
			error:function(){
				console.log("删除出错");
			}
		});
	}
	
	function showRemoveBtn(treeId, treeNode) {
		return (treeNode["nodeType"]=="indexName" || treeNode["nodeType"]=="tableName")  && (parseInt(treeNode.id) < 1000000) && (treeNode["delete"]);
	}

	function removeHoverDom(treeId, treeNode) {
		//console.log("removeHoverDom...");
		//console.log(treeNode);
		
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};

	//加载菜单树
	function loadMenusTree(){
		$.ajax({
				url:"<%=request.getContextPath() %>/es?method=indexTree",
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

	function onClick(e,treeId, treeNode) {
		console.log("isdelete============="+treeNode["isDelete"]);
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.expandNode(treeNode);
			$("#span").remove(".ico_docu");
	}
	
	function loadnewIndex(){
		$("#indexName").attr("data-rule","required;indexName;length[1~25];remote[/es?method=exist]");
		$("#tableName").attr("data-rule","required;tableName;length[1~25];remote[/es?method=existTable01]");
	}
	loadnewIndex();
	
	//新建
	$("#newIndex").click(function(){
		$('#form').validator('hideMsg', '#indexName');
		$('#form').validator('hideMsg', '#tableName');
// 		$('form').validator( "destroy" );
// 		$('form').validator( "cleanUp" );
		$("#type").val("");
		$("#categoryId").val("");
		$("#categoryName").val("");
		$("#indexName").val("");
		$("#indexName").attr("readonly",false);
		$("#indexName").attr("data-rule","required;indexName;length[1~25];remote[/es?method=exist]");
		$("#charset").val("UTF-8");
		$("#tableName").val("");
		$("#tableName").attr("readonly",false);
		$("#tableName").attr("data-rule","required;tableName;length[1~25];remote[/es?method=existTable01]");
		$("#ruleTable").empty();
		var _row ="<tr><td style='width:5%'>No</td><td>类型</td><td>名称</td><td>描述</td><td style='width:8%'>操作</td></tr>";
		$("#ruleTable").append(_row);
		indexId="";
		$("#searchLink").attr("href","");
		$("#searchLink").attr("class","btn btn-sm btn-default");
		$("#searchLink").addClass("disabled");
		$("#shareDiv>div>button").addClass("disabled");
		$("button[name='common_share_buttonOne']").attr("disabled","disabled");
		$("#clearRuleDiv>div>button").addClass("disabled");
		$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
		
		$("#tmp_mulit_column").attr("readonly",false);
		$("#autoDiv").attr("class","btn btn-sm btn-success");
		$('#autoDiv').removeClass("disabled");
		return;
	});

	function getSelectIndexPath(indexPath){
		console.log("getSelectIndexPath。。。"+indexPath);
        return $("#anaKeywordInputHidden").val(indexPath);
    }
	
	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
 		console.log("onMouseDown..");
 		console.log(treeNode);
// 		console.log("treeNode[id]..."+treeNode["id"]);
// 		console.log("treeNode[nodeType]..."+treeNode["nodeType"]);
		
		$('#form').validator('hideMsg', '#indexName');
		$('#form').validator('hideMsg', '#tableName');
		$('#form').validator( "destroy" );
// 		$('form').validator( "cleanUp" );
		
		if(!treeNode){
			console.log("treeNode is null.");
			return;
		}

		//share es
		var esId = treeNode["id"];
// 		console.log("esId="+esId);
		var _shareId = parseInt(esId) - 1000000;

		console.log("level...");
		console.log(treeNode["level"]);
		if(treeNode["level"] > 1){
			console.log("选择字段，则禁用分享按钮...");
			$("#shareDiv>div>button").addClass("disabled");
			$("button[name='common_share_buttonOne']").attr("disabled","disabled");
			$("#clearRuleDiv>div>button").addClass("disabled");
			$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
			return;
		}else{
			if(saveFlg){
				$("#shareDiv>div>button").removeAttr("disabled");
				$("button[name='common_share_buttonOne']").removeAttr("disabled");
				$("#clearRuleDiv>div>button").removeAttr("disabled");
				$("button[name='common_clearRule_buttonOne']").removeAttr("disabled");
			}
		}
		if(saveFlg){
			$("button[name='common_share_buttonOne']").removeAttr("disabled");
			$("button[name='common_clearRule_buttonOne']").removeAttr("disabled");
	
			$("#shareDiv>div>button").removeClass("disabled");
			$("#clearRuleDiv>div>button").removeClass("disabled");
		}
		$("#newIndex").removeClass("disabled");
		$("button[type='submit']").removeClass("disabled");
		$('#searchLink').addClass("disabled");

		var compId = $("#compId").val();
		//not share es
		if(treeNode["nodeType"]=="indexName" || treeNode["nodeType"]=="tableName"){
			createMark();
			$.ajax({
				url:"<%=request.getContextPath() %>/es?method=select&id=" + treeNode["id"] + "&type=" + treeNode["nodeType"]+ "&name="+treeNode["name"],
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					$.unblockUI();
					$("#type").val(treeNode["nodeType"]);
					if(treeNode["nodeType"]=="indexName"){
						console.log("flowId = "+data.flowId);
						var id = data.id;
						indexId=data.id;
						var indexName = data.indexName;
						
						$("#id").val(id);
						$("#indexName").val(indexName);
// 						$("#indexName").attr("readonly",false);
						$("#indexName").attr("readonly","readonly");
						$("#tableName").attr("readonly",false);
						$("#indexName").attr("data-rule","required;indexName;length[1~25];remote[/es?method=exist01&indexId="+indexId+"&oldIndexName="+indexName+"]");
						$("#charset").val(data.charset);
						$("#categoryId").val(data.categoryId);
						$("#categoryName").val(data.categoryName);
						$("#tableName").val("");
						$("#tableName").attr("data-rule","length[1~25];remote[/es?method=existTable&indexId="+indexId+"]");
						$("#ruleTable").empty();
						var _row ="<tr><td style='width:5%'>No</td><td>类型</td><td>名称</td><td>描述</td><td style='width:10%'>操作</td></tr>";
						$("#ruleTable").append(_row);

						var indexSearch = $("#before").val()+data.indexName;
						getSelectIndexPath($("#esClusterName").val()+"/"+indexSearch);
						var leg=0;
						leg = indexSearch.indexOf("@");
						if(leg>0){
							indexSearch = indexSearch.substring(0,leg)+"*";
						}
// 						getSelectIndexPath($("#esClusterName").val()+"/"+indexSearch);
						$("#searchLink").attr("href","/search/dashboard.jsp?id="+indexId);
						$("#searchLink").attr("class","btn btn-sm btn-primary");
						$('#searchLink').removeClass("disabled");
						
						$("#returnLink").attr("class","btn btn-sm btn-default");
						$('#returnLink').addClass("disabled");
						
						//设置indexName的值
						$("#indexNameHidden").val(data.indexName);

						$("#tmp_mulit_column").attr("readonly",false);
						$("#autoDiv").attr("class","btn btn-sm btn-success");
						$('#autoDiv').removeClass("disabled");
						
					}else if (treeNode["nodeType"]=="tableName"){
						$("#returnLink").attr("class","btn btn-sm btn-primary");
						$('#returnLink').removeClass("disabled");
						
						$("#tmp_mulit_column").attr("readonly","readonly");
						$("#autoDiv").attr("class","btn btn-sm btn-default");
						$('#autoDiv').addClass("disabled");
						
						console.log(data);
						var flowId = data.flowId;
						console.log("flowId == "+flowId);
						if(compId == '' && flowId != '0'){
							$("#returnLink").attr("href","/flow/init.jsp?id="+flowId);
						}
						indexId=data.id;
						oldName=data.tableName;
						$("#id").val(data.id);
						$("#indexName").val(data.indexName);
						$("#categoryId").val(data.categoryId);
						$("#categoryName").val(data.categoryName);
						$("#indexName").attr("readonly","readonly");
						$("#tableName").attr("readonly","readonly");
						$("#indexName").attr("data-rule","required;indexName;length[1~25];");
						$("#charset").val(data.charset);
						$("#tableName").val(data.tableName);
						$("#tableName").attr("data-rule","required;length[1~25];remote[/es?method=existTable&indexId="+indexId+"&oldName="+oldName+"]");
						var indexSearch = $("#before").val()+data.indexName;
						getSelectIndexPath($("#esClusterName").val()+"/"+indexSearch+"/"+data.tableName);
						var leg=0;
						leg = indexSearch.indexOf("@");
						if(leg>0){
							indexSearch = indexSearch.substring(0,leg);
						}
						var indexSearch = indexSearch+"/"+data.tableName;
// 						getSelectIndexPath($("#esClusterName").val()+"/"+indexSearch);
						$("#searchLink").attr("href","/search/dashboard.jsp?id="+data.id+"&isTab=true");
						$("#searchLink").attr("class","btn btn-sm btn-primary");
						$('#searchLink').removeClass("disabled");

						//设置indexName的值
						$("#indexNameHidden").val(data.indexName);
						
						if(data.columnNames != "1"){
							$("#ruleTable").empty();
							var _d = eval('('+data.columnNames+')');
							var n=0;

							var _html = "<tr><td style='width:5%'>No</td><td>类型</td><td>名称</td><td>描述</td><td style='width:10%'>操作</td></tr>";
							$.each(_d,function(index,item){
								n+=1;
								_html += "<tr>";
								_html += "<td>"+n+"</td>";
								_html += "<td>";
								_html += "<input style='display:none;' name='pamType' class='form-control' value='"+item["TYPE_NAME"]+"' />";
								_html += "<select class='form-control' name='pamType' id='pamType' data-rule='required;' disabled='disabled'>";
								if(item["TYPE_NAME"] =="integer"){
									_html += "<option value='text'>string</option>";
									_html += "<option value='string'>string(分词)</option>";
									_html += "<option selected='selected' value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								} else if(item["TYPE_NAME"] =="string"){
									_html += "<option value='text'>string</option>";
									_html += "<option selected='selected' value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								} else if(item["TYPE_NAME"] =="long"){
									_html += "<option value='text'>string</option>";
									_html += "<option value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option selected='selected' value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								} else if(item["TYPE_NAME"] =="date"){
									_html += "<option value='text'>string</option>";
									_html += "<option value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option selected='selected' value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								}else if(item["TYPE_NAME"] =="double"){
									_html += "<option value='text'>string</option>";
									_html += "<option value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option selected='selected' value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								}else if(item["TYPE_NAME"] =="boolean"){
									_html += "<option value='text'>string</option>";
									_html += "<option value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option selected='selected' value='boolean'>boolean</option>";
								}else if(item["TYPE_NAME"] =="text"){
									_html += "<option selected='selected' value='text'>string</option>";
									_html += "<option value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								}else if(item["TYPE_NAME"] =="float"){
									_html += "<option value='text'>string</option>";
									_html += "<option selected='selected' value='string'>string(分词)</option>";
									_html += "<option value='integer'>integer</option>";
// 									_html += "<option value='float'>float</option>";
									_html += "<option value='date'>date</option>";
									_html += "<option value='long'>long</option>";
									_html += "<option value='double'>double</option>";
									_html += "<option value='boolean'>boolean</option>";
								}
								_html += "</select>";
								_html += "</td>";
								_html += "<td><input readonly='readonly' name='pamName' id='pamName"+n+"' class='form-control' value='"+item["COLUMN_NAME"]+"' data-rule='required;xxx;' data-rule-xxx='[/^[a-zA-Z].*$/, \"必须字母开头！\"]'/></td>";
								if(item["REMARK"] ==""){
									_html += "<td><input readonly='readonly' name='pamRemark' class='form-control' value='' /></td>";
								}else{
									_html += "<td><input readonly='readonly' name='pamRemark' class='form-control' value='"+item["REMARK"]+"' /></td>";
								}
// 								_html += "<td style='width:100px'><input readonly='readonly' type='button' value='删除' onclick='delFunc(this)' class='btn-del'/></td>";
								_html += "<td style='width:100px'><span class='glyphicon glyphicon-trash'></span></td>";
								_html += "</tr>";
							});

							$("#ruleTable").append(_html);

						}else{
							$("#ruleTable").empty();
							var _html = "<tr><td style='width:5%'>No</td><td>类型</td><td>名称</td><td>描述</td><td style='width:10%'>操作</td></tr>";
							$("#ruleTable").append(_html);
						}
						
					}
					
				},
				error:function(){
					console.log("加载数据失败！");
					$.unblockUI();
				}
			});
		}


		if(treeNode["shared"]){
			console.log("disabled...");
			console.log("_shareId="+_shareId);
			$("#newIndex").addClass("disabled");
			$("#newRow").addClass("disabled");
			$("button[type='submit']").addClass("disabled");
			$('#searchLink').removeClass("disabled");
			$("#searchLink").attr("href","/search/dashboard.jsp?id="+esId+"&isTab=true");
			$("#searchLink").attr("class","btn btn-sm btn-primary");
			$("#shareDiv>div>button").addClass("disabled");
			$("button[name='common_share_buttonOne']").attr("disabled","disabled");
			$("#clearRuleDiv>div>button").addClass("disabled");
			$("button[name='common_clearRule_buttonOne']").attr("disabled","disabled");
			return;
		}else{
			$("#newRow").removeClass("disabled");
		}
	}

	var indexId = "";
	var oldName = "";

	$('#form').validator({
	    rules: {
	        //自定义一个规则，用来代替remote（注意：要把$.ajax()返回出来）
	        myRemote: function(element){
	            return $.ajax({
	            	url:"<%=request.getContextPath() %>/es?method=exist01",
	                type: 'post',
	    			data:{indexName:$("#indexName").val(),indexId:indexId},
	                dataType: 'json',
	                success: function(d){
	                    console.log(d);
	                }
	            });
	        },
	        myRemoteTableIn: function(element){
	            return $.ajax({
	            	url:"<%=request.getContextPath() %>/es?method=existTable",
	                type: 'post',
	    			data:{tableName:$("#children_name").val(),indexId:indexId,oldName:""},
	                dataType: 'json',
	                success: function(d){
	                }
	            });
	        },
	        myRemoteTable: function(element){
	            return $.ajax({
	            	url:"<%=request.getContextPath() %>/es?method=existTable",
	                type: 'post',
	    			data:{tableName:$("#tableName").val(),indexId:indexId,oldName:oldName},
	                dataType: 'json',
	                success: function(d){
	                }
	            });
	        }

	    },
	    fields: {
	        'indexName': 'required; length[1~25]; myRemote;',
	        'tableName': 'length[1~25]; myRemoteTable;'
	    },
	});


});
</SCRIPT>

<script>

	function init(){

		if($("#lineCheckedFlg").val()==true){
			$("#line").prop("checked",true);
		}else{
			$("#line").prop("disabled",false);
		}
		$("#lineCheckedFlg").remove();

	}

	var typelist_select;
	$(function(){
		init();

		typelist_select = $("#typeJson").html();
		$("#typeJson").remove();

		//通用按钮的提交表单事件
		$("form").on("valid.form", function(e, form){
			if(!$("#notParser").prop("checked")){

				var _exist = false;
				$("#ruleTable tr:gt(0)").each(function(index,value){
					var _dirRule = $(this).find("input[name='dirRule']").val();

					if(_dirRule!=''){
						_exist = true;
					}
				});
			}

			createMark();

// 			form.submit();
		});

		//line切换
		$("#line").click(function(){
			if($(this).is(":checked")){
				$("#lineReg").show();
			}else{
				$("#lineReg").hide();
			}
		});

		$("#newRow").click(function(){
			addRow(null,null);
		});

	});

	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow(target,insertBefore,defaultValue){
		var ruleTableTr = $("#ruleTable tr").size();
		if(!defaultValue){
			defaultValue = 'c'+ruleTableTr;
		}
		var _row = "<tr>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td>"+typelist_select+"</td>";
		_row += "<td><input name='pamName' id='pamName"+ruleTableTr+"' placeholder='字段名称' value='"+defaultValue+"' class='form-control' data-rule='required;xxx;' data-rule-xxx='[/^[a-zA-Z].*$/, \"必须字母开头！\"]'/></td>";
		_row += "<td><input name='pamRemark' placeholder='中文描述' class='form-control'/></td>";
		_row += "<td style=\"width:'100px'\"> <input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";

		if(target){
			if(insertBefore){
				$(_row).insertBefore(target);
			}else{
				$(_row).insertAfter(target);
			}
		}else{
			$("#ruleTable").append(_row);
		}
	}

	//del
	function delFunc(obj){
		$(obj).parent().parent().remove();
	}

	function autoCreateColumns(){
		console.log("autoCreateColumns...");

		var str = $("#tmp_mulit_column").val();
    	if($.trim(str)==''){return;}

    	$("#ruleTable tr:gt(0)").remove();
    	var arr = str.split(",");
    	$("#columnNumber").val(arr.length);
    	var _index = 0;
    	for(var i = 0; i<arr.length;i++){
    		if($.trim(arr[i])==''){continue;}
    		addRow(null,null,$.trim(arr[i]));
    	}
	}
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
