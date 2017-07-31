<%@page import="java.util.*"%>
<%@page import="com.alibaba.fastjson.*"%>
<%@page import="com.stonesun.realTime.services.db.bean.*"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsHistoryServices"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
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
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>

	<%request.setAttribute("topId", "36");%>
	<%
		String before = SystemProperties.getInstance().get("es_index");
		request.setAttribute("before", before);
	%>
	<!-- page header start -->
	<input id="before" value="${before}" type="hidden"/>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					BigSearch服务
				</div>
			</div>
		</div>
	</div>
	<!-- page header end -->
	<input type="hidden" name="indexName" id="indexName" value="">
	<div class="container mh500">
		<div class="row">
		<%-- <c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9 col-compact">
				<div class="page-header" >
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								BigSearch服务
							</div>
							<div class="page-header-links">
								<a href="">索引</a> / 表  / 字段(类型)
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 col-compact">
					    <div style="min-width: 200px;height: 400px;overflow:auto;">
							<div id="loadImg" style="text-align: left;">
								<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
							</div>
							<ul id="treeDemo" style="display: none;" class="ztree"></ul>
						</div>
					</div>
					<div class="col-md-9 col-compact">
						<form id="rightForm" action="<%=request.getContextPath() %>/es?method=saveTree" method="post" class="form-horizontal" role="form">
						</form>
					</div>
				</div>
				<div id="module_div_top">
					<div class="form-group">
						<label for="pid" class="col-sm-5 control-label">添加索引</label>
					</div>
					<div class="form-group">
						<label for="indexNameinsert" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>索引名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;length[1~25];remote[/es?method=exist]" class="form-control input-inline" placeholder="name@{yyyyMMdd}" id="indexNameinsert" name="indexNameinsert" />
						</div>
					</div>
					<div class="form-group">
						<label for="tableName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>表名称</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="表名称" id="tableName" name="tableName" data-rule="required;tableName;length[1~25];remote[/es?method=existTable01]"/>
						</div>
					</div>
					<div class="form-group">
						<label for="charset" class="col-sm-2 control-label">文件编码</label>
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
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button  code="save"  class="btn btn-info" type="submit">保存</button>
						</div>
					</div>
				</div>

				<div id="module_div">
					<div class="form-group">
						<label for="pid" class="col-sm-5 control-label">编辑当前索引</label>
						<div class="col-sm-4 r">
							<a id="searchLink" target="_blank" href="" class="btn btn-primary btn-xs" role="button">查看当前索引</a>
						</div>
					</div>
					<div class="form-group" style="display:none">
						<label for="type" class="col-sm-2 control-label">type</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label for="id" class="col-sm-2 control-label">索引id</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="id" id="id" name="id" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group" id="indexNameDiv">

					</div>
					<div class="form-group">
						<label for="pid" class="col-sm-5 control-label">添加索引表</label>
					</div>
					<div class="form-group">
						<label for="pid" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
<!-- 							<input data-rule="checked" name="addModuleOrPage" type="radio" checked="checked" value="topModule"/>添加新的索引 -->
							<input data-rule="checked" name="addModuleOrPage" type="radio" checked="checked" value="tableName"/>添加tableName
						</div>
					</div>
					<div class="form-group" style="display:none">
						<label for="pid" class="col-sm-2 control-label">pid</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="children_pid" id="children_pid" name="children_pid" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group" id="tableNameDiv">

					</div>
					<div class="form-group" style="display: none;">
						<label for="children_url" class="col-sm-2 control-label">表名</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="tableName" id="children_url" name="children_url"/>
						</div>
					</div>
					<div class="form-group" style="display:none">
						<label for="children_orderNum" class="col-sm-2 control-label">排序</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="排序" id="children_orderNum" name="children_orderNum"/>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button  code="save"  class="btn btn-info" type="submit">保存</button>
						</div>
					</div><br><br><br><br><br><br><br><br><br>
				</div>

				<div id="page_div">
					<div class="form-group">
						<label for="pid" class="col-sm-5 control-label">编辑当前索引表</label>
						<div class="col-sm-4 r">
							<a id="searchLink" target="_blank" href="" class="btn btn-primary btn-xs" role="button">查看当前索引</a>
						</div>
					</div>
					<div class="form-group" style="display:none">
						<label for="type" class="col-sm-2 control-label">type</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" id="type" name="type" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label for="id" class="col-sm-2 control-label">索引id</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="id" id="id" name="id" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">索引名称</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="name@{yyyyMMdd}" id="indexName" name="indexName" readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>索引表名称</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="tableName" id="name" name="name" data-rule="required;name;length[1~25];"/>
						</div>
					</div>
					<div class="form-group">
						<div id="selectDiv"> </div>
					</div>
					<div class="form-group">
						<div class="col-sm-2">
							<button  code="save"  class="btn btn-xs btn-primary" type="button" id="newRow" onClick="addRow('','')">
								<span class="glyphicon glyphicon-plus"></span>添加一行源字段
							</button>
						</div>
						<div class="col-sm-9">
							<label class="help-block">温馨提示：ES的字段只能增加，删除，不能修改已添加的字段。将来会升级，敬请期待。</label>
						</div>
					</div>
					<div class="form-group">
						<div id="mainDiv"> </div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button  code="save"  class="btn btn-info" type="submit">保存</button>
						</div>
					</div>
				</div>
			</div>
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

<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<SCRIPT type="text/javascript">
$(function(){
	var module_div_top = $("#module_div_top").clone(true);
	var module_div = $("#module_div").clone(true);
	var page_div = $("#page_div").clone(true);
	$("#module_div_top").remove();
	$("#module_div").remove();
	$("#page_div").remove();
	$("#rightForm").html("").append(module_div_top.html());

	var setting = {
			check: {
				enable: false,
				dblClickExpand: true
			},callback: {
				onMouseDown: onMouseDown123,
				beforeRemove: beforeRemove,
				onRemove : onRemove
			},edit: {
				enable: true,
  				showRemoveBtn: showRemoveBtn,
  				showRenameBtn: false
			},view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom
			}
	};

	function addHoverDom(treeId, treeNode) {
		var aObj = $("#" + treeNode.tId + "_a");
		if ($("#diyBtn_"+treeNode.id).length>0) return;
		var editStr = "<span id='diyBtn_space_" +treeNode.id+ "' > </span>"
			+ "<button type='button' class='diyBtn1' id='diyBtn_" + treeNode.id
			+ "' title='"+treeNode.name+"' onfocus='this.blur();'></button>";
		aObj.append(editStr);
		var btn = $("#diyBtn_"+treeNode.id);
	};

	function removeHoverDom(treeId, treeNode) {
	};

	function showRemoveBtn(treeId, treeNode) {
		return treeNode.isParent;
	}

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
				if(data && data == "0"){
// 					console.log("delete成功！");
					loadMenusTree();
					$("#rightForm").html("").append(module_div_top.html());
				}else{
// 					console.log("delete失败！");
				}
			},
			error:function(){
				console.log("删除出错");
			}
		});
	}

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

	//点击菜单项
	function onMouseDown123(event, treeId, treeNode) {
		console.log("treeNode1111:");
		console.log(treeNode);
		if(!treeNode || !treeNode["id"]){
// 			console.log("点击无效！");
			return;
		}

		if(treeNode["nodeType"]=="indexName"){
			$("#rightForm").html("").append(module_div.html());
		}else if(treeNode["nodeType"]=="tableName"){
			$("#rightForm").html("").append(page_div.html());
		}

		$.ajax({
			url:"<%=request.getContextPath() %>/es?method=select&id=" + treeNode["id"] + "&type=" + treeNode["nodeType"],
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				$("#rightForm").find("#type").val(treeNode["nodeType"]);
				if(treeNode["nodeType"]=="indexName"){
					var id = data.id;
					var name = data.indexName;
					indexId=data.id;
					$("#rightForm").find("#id").val(id);
					var _html = "";
					_html += "<label for='indexNameEdit' class='col-sm-2 control-label'>索引名称</label>";
					_html += "<div class='col-sm-5'>";
					_html += "<input class='form-control' data-rule='required;indexNameEdit;length[1~25];' value='"+name+"' placeholder='indexName' id='indexNameEdit' name='indexNameEdit'/>";
					_html += "</div>";
					$("#indexNameDiv").html("").html(_html);

					//设置indexName的值
					$("#indexName").val(data.indexName);

					var _htmlTable = "";
					_htmlTable += "<label for='children_name' class='col-sm-2 control-label'>名称</label>";
					_htmlTable += "<div class='col-sm-5'>";
					_htmlTable += "<input class='form-control' value='' data-rule='required;children_name;length[1~25];' placeholder='名称' id='children_name' name='children_name'/>";
					_htmlTable += "</div>";
					$("#tableNameDiv").html("").html(_htmlTable);

					var indexSearch = $("#before").val()+data.indexName;
					var leg=0;
					leg = indexSearch.indexOf("@");
					if(leg>0){
						indexSearch = indexSearch.substring(0,leg)+"*";
					}

					$("#rightForm").find("#searchLink").attr("href","/search/dashboard.jsp?id="+indexId);

					$("#rightForm").find("input[name=addModuleOrPage]").click(function(){
						if($(this).val()=="topModule"){
							$("#rightForm").find("#children_url").parent().parent().show();
							$("#rightForm").find("#children_name").removeAttr("data-rule");
						}else{
							$("#rightForm").find("#children_url").parent().parent().hide();
							$("#rightForm").find("#children_name").removeAttr("data-rule");
						}
					});

				}else if(treeNode["nodeType"]=="tableName"){
					indexId=data.id;
					oldName=data.tableName;
					//设置indexName的值
					$("#indexName").val(data.indexName);

					$("#rightForm").find("#id").val(data.id);
					$("#rightForm").find("#indexName").val(data.indexName);
					$("#rightForm").find("#name").val(data.tableName);
					var indexSearch = $("#before").val()+data.indexName;
					var leg=0;
					leg = indexSearch.indexOf("@");
					if(leg>0){
						indexSearch = indexSearch.substring(0,leg);
					}
					var indexSearch = indexSearch+"/"+data.tableName;
					$("#rightForm").find("#searchLink").attr("href","/search/dashboard.jsp?id="+indexId+"&isTab=true");

					var _select="";
					if(data.charset == "1"){
						_select += "<label for='charset' class='col-sm-2 control-label'>文件编码</label>";
						_select += "<div class='col-sm-5'>";
						_select += "<select class='form-control' id='charset' name='charset'>";
						_select += "<option value='UTF-8'>UTF-8</option>";
						_select += "<option value='GBK'>GBK</option>";
						_select += "<option value='ISO-8859-1'>ISO-8859-1</option>";
						_select += "<option value='GB2312'>GB2312</option>";
						_select += "<option value='Unicode'>Unicode</option>";
						_select += "</select>";
						_select += "</div>";
					}else if(data.charset == "UTF-8"){
						_select += "<label for='charset' class='col-sm-2 control-label'>文件编码</label>";
						_select += "<div class='col-sm-5'>";
						_select += "<select class='form-control' id='charset' name='charset'>";
						_select += "<option selected='selected' value='UTF-8'>UTF-8</option>";
						_select += "<option value='GBK'>GBK</option>";
						_select += "<option value='ISO-8859-1'>ISO-8859-1</option>";
						_select += "<option value='GB2312'>GB2312</option>";
						_select += "<option value='Unicode'>Unicode</option>";
						_select += "</select>";
						_select += "</div>";
					}else if(data.charset == "GBK"){
						_select += "<label for='charset' class='col-sm-2 control-label'>文件编码</label>";
						_select += "<div class='col-sm-5'>";
						_select += "<select class='form-control' id='charset' name='charset'>";
						_select += "<option value='UTF-8'>UTF-8</option>";
						_select += "<option selected='selected' value='GBK'>GBK</option>";
						_select += "<option value='ISO-8859-1'>ISO-8859-1</option>";
						_select += "<option value='GB2312'>GB2312</option>";
						_select += "<option value='Unicode'>Unicode</option>";
						_select += "</select>";
						_select += "</div>";
					}else if(data.charset == "ISO-8859-1"){
						_select += "<label for='charset' class='col-sm-2 control-label'>文件编码</label>";
						_select += "<div class='col-sm-5'>";
						_select += "<select class='form-control' id='charset' name='charset'>";
						_select += "<option value='UTF-8'>UTF-8</option>";
						_select += "<option value='GBK'>GBK</option>";
						_select += "<option selected='selected' value='ISO-8859-1'>ISO-8859-1</option>";
						_select += "<option value='GB2312'>GB2312</option>";
						_select += "<option value='Unicode'>Unicode</option>";
						_select += "</select>";
						_select += "</div>";
					}else if(data.charset == "GB2312"){
						_select += "<label for='charset' class='col-sm-2 control-label'>文件编码</label>";
						_select += "<div class='col-sm-5'>";
						_select += "<select class='form-control' id='charset' name='charset'>";
						_select += "<option value='UTF-8'>UTF-8</option>";
						_select += "<option value='GBK'>GBK</option>";
						_select += "<option value='ISO-8859-1'>ISO-8859-1</option>";
						_select += "<option selected='selected' value='GB2312'>GB2312</option>";
						_select += "<option value='Unicode'>Unicode</option>";
						_select += "</select>";
						_select += "</div>";
					}else if(data.charset == "Unicode"){
						_select += "<label for='charset' class='col-sm-2 control-label'>文件编码</label>";
						_select += "<div class='col-sm-5'>";
						_select += "<select class='form-control' id='charset' name='charset'>";
						_select += "<option value='UTF-8'>UTF-8</option>";
						_select += "<option value='GBK'>GBK</option>";
						_select += "<option value='ISO-8859-1'>ISO-8859-1</option>";
						_select += "<option value='GB2312'>GB2312</option>";
						_select += "<option selected='selected' value='Unicode'>Unicode</option>";
						_select += "</select>";
						_select += "</div>";
					}
					$("#selectDiv").html(_select);

					if(data.columnNames != "1"){
						var _d = eval('('+data.columnNames+')');
						var n=0;

						var _html="<table class='table table-bordered table-hover' id='ruleTable' style='margin-bottom: 100px;'>";
						_html += "<tr><td>序号</td><td>字段类型</td><td>字段名</td><td>描述</td><td>操作</td></tr>";
						$.each(_d,function(index,item){
							n+=1;
							_html += "<tr>";
							_html += "<td>"+n+"</td>";
							_html += "<td>";
							_html += "<input style='display:none;' name='pamType' class='form-control' value='"+item["TYPE_NAME"]+"' />";
							_html += "<select class='form-control' name='pamType' id='pamType' data-rule='required;' disabled='disabled'>";
							if(item["TYPE_NAME"] =="Integer"){
								_html += "<option value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option selected='selected' value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
								_html += "<option value='double'>double</option>";
								_html += "<option value='boolean'>boolean</option>";
							} else if(item["TYPE_NAME"] =="String"){
								_html += "<option value='text'>String</option>";
								_html += "<option selected='selected' value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
								_html += "<option value='double'>double</option>";
								_html += "<option value='boolean'>boolean</option>";
							} else if(item["TYPE_NAME"] =="long"){
								_html += "<option value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option selected='selected' value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
								_html += "<option value='double'>double</option>";
								_html += "<option value='boolean'>boolean</option>";
							} else if(item["TYPE_NAME"] =="datetime"){
								_html += "<option value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option selected='selected' value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
								_html += "<option value='double'>double</option>";
								_html += "<option value='boolean'>boolean</option>";
							}else if(item["TYPE_NAME"] =="float"){
								_html += "<option value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option selected='selected' value='float'>float</option>";
								_html += "<option value='double'>double</option>";
								_html += "<option value='boolean'>boolean</option>";
							}else if(item["TYPE_NAME"] =="double"){
								_html += "<option value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
								_html += "<option selected='selected' value='double'>double</option>";
								_html += "<option value='boolean'>boolean</option>";
							}else if(item["TYPE_NAME"] =="boolean"){
								_html += "<option value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
								_html += "<option value='double'>double</option>";
								_html += "<option selected='selected' value='boolean'>boolean</option>";
							}else if(item["TYPE_NAME"] =="text"){
								_html += "<option selected='selected' value='text'>String</option>";
								_html += "<option value='String'>String(分词)</option>";
								_html += "<option value='Integer'>Integer</option>";
								_html += "<option value='datetime'>datetime</option>";
								_html += "<option value='long'>long</option>";
// 								_html += "<option value='float'>float</option>";
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
							_html += "<td style='width:100px'><input readonly='readonly' type='button' value='删除' onclick='delFunc(this)' class='btn-del'/></td>";
							_html += "</tr>";
						});

						_html +="</table>";
						$("#mainDiv").html(_html);

					}else{
						var _html="<table class='table table-bordered table-hover' id='ruleTable' style='margin-bottom: 100px;'>";
						_html += "<tr><td>序号</td><td>字段类型</td><td></td><td>描述</td><td>操作</td></tr>";
						_html +="</table>";
						$("#mainDiv").html(_html);
					}

				}
				$.unblockUI();
			},
			error:function(){
				console.log("加载数据失败！");
				$.unblockUI();
			}
		});
	}

	var indexId = "";
	var oldName = "";

	$('#rightForm').validator({
	    rules: {
	        //自定义一个规则，用来代替remote（注意：要把$.ajax()返回出来）
	        myRemote: function(element){
	            return $.ajax({
	            	url:"<%=request.getContextPath() %>/es?method=exist01",
	                type: 'post',
	    			data:{indexNameEdit:$("#indexNameEdit").val(),indexId:indexId},
	                dataType: 'json',
	                success: function(d){
// 	                    console.log(d);
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
// 	                    console.log(d);
	                }
	            });
	        },
	        myRemoteTableEdit: function(element){
	            return $.ajax({
	            	url:"<%=request.getContextPath() %>/es?method=existTable",
	                type: 'post',
	    			data:{tableName:$("#name").val(),indexId:indexId,oldName:oldName},
	                dataType: 'json',
	                success: function(d){
// 	                    console.log(d);
	                }
	            });
	        }

	    },
	    fields: {
	        'indexNameEdit': 'required; length[1~25]; myRemote;',
	        'children_name': 'length[1~25];myRemoteTableIn;',
	        'name': 'required; length[1~25]; myRemoteTableEdit;'
	    },
	});

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
<script>

	function confirmDel(){
		if (confirm("你确定要删除吗？")) {
			return true;
        }  return false;
	}

	function init(){
		if($("#lineCheckedFlg").val()==true){
			$("#line").prop("checked",true);
// 			$("#line").prop("disabled",true);
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

			form.submit();
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
	function addRow(target,insertBefore){
		var ruleTableTr = $("#ruleTable tr").size();
		var _row = "<tr>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td>"+typelist_select+"</td>";
		_row += "<td><input name='pamName' id='pamName"+ruleTableTr+"' placeholder='字段名称' value='c"+ruleTableTr+"' class='form-control' data-rule='required;xxx;' data-rule-xxx='[/^[a-zA-Z].*$/, \"必须字母开头！\"]'/></td>";
		_row += "<td><input name='pamRemark' placeholder='中文描述' class='form-control'/></td>";
		_row += "<td style=\"width:'100px'\"> <input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";

		if(target){
			if(insertBefore){
				//$(target).insertBefore(_row);
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
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
