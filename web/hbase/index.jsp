<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsHistoryInfo"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsHistoryServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hbase hive</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_analytics);%>
	<%@ include file="/resources/common_menu.jsp"%>
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
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
								HBSAE/HIVE管理
						</div>
					</div>
				</div>
				<div class="container mh500">
					<div class="row">
						<div class="col-md-3">
				      		<div class="input-group input-group-sm" style="margin: 10px 0;">
							  <input id="anaKeywordInput" type="text" class="form-control" placeholder="搜索关键字" aria-describedby="basic-addon2">
							  <span class="input-group-btn">
							  	<button class="btn btn-default" type="button" id="anaSearchKeySpan">搜索</button>
							  </span>
							</div>
				      		
				      		<div style="min-width: 200px;">
								<div id="loadImg" style="text-align: left;">
									<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
								</div>
								<ul id="menustree" style="display: none;" class="ztree"></ul>
							</div>
						</div>
						<div class="col-md-8">
							<%
								//try{
									String id = request.getParameter("id");
									String historyId = request.getParameter("historyId");
									AnalyticsInfo anaInfo = null;
									
									String historySql = null;
									if(StringUtils.isNotBlank(historyId)){
										AnalyticsHistoryInfo info = AnalyticsHistoryServices.selectById(Integer.valueOf(historyId));
										historySql = info.getSql();
									}
									
									if(StringUtils.isNotBlank(id)){
										anaInfo = AnalyticsServices.selectById(id,0);
									}else{
										anaInfo = new AnalyticsInfo();
									}
									
									if(StringUtils.isNotBlank(historySql)){
										anaInfo.setSql(historySql);
									}
									
									JSONObject periodJSON = new JSONObject();
									if(StringUtils.isNotBlank(anaInfo.getPeriodJSON())){
										periodJSON = JSON.parseObject(anaInfo.getPeriodJSON());
									}
									
									request.setAttribute("ana", anaInfo);
									request.setAttribute("periodJSON", periodJSON);
								//}catch(Exception e){
								//	e.printStackTrace();
								//}
								
							%>
							<form action="<%=request.getContextPath() %>/hbase?method=save" method="post" class="form-horizontal" role="form" onclick="return func();">
								<input value="${ana.id}" name="id" id="id" type="hidden"/>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button class="btn btn-success" type="submit" href="<%=request.getContextPath() %>/hdfs?method=index">保存</button>
<!-- 										<button class="btn btn-info" type="button" id="runningBtn" inte_type="runJob">立即运行</button> -->
			<%-- 							<button class="btn btn-default" type="submit" href="<%=request.getContextPath() %>/analytics?method=index">运行历史</button> --%>
<%-- 										<a id="anaHistoryA" class="btn btn-default" target="_blank" href="<%=request.getContextPath() %>/analyticsHistory?method=index&anaId=${ana.id}">运行历史</a> --%>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">建表名称</label>
									<div class="col-sm-5">
										<input data-rule="required;name;length[1~45]" id="name" name="name" value="${ana.name}" class="form-control" placeholder="名称"/>
									</div>
									<div class="col-sm-5">
										<p class="help-block">
											用于描述您的分析，便于之后的管理。
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="projectId" class="col-sm-2 control-label">所属项目</label>
									<div class="col-sm-5">
										<select data-rule="required;projectId" id="projectId" name="projectId" class="form-control">
												<%
													//加载用户的项目列表
													int uid = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId();
													session.setAttribute(Container.session_projectList, ProjectServices.selectList(uid));
												%>
												<option></option>
												<c:forEach items="${sessionScope.session_projectList}" var="item">
										           <option <c:if test='${ana.projectId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
										        </c:forEach>
										</select>
									</div>
									<div class="col-sm-5">
										<p class="help-block">
											按照项目对分析进行分门别类的管理，如需管理项目，请点击<a href="<%=request.getContextPath()%>/user/project?method=index" target="_blank">这里</a>。
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="anaMethod" class="col-sm-2 control-label">分析方法</label>
									<div class="col-sm-5">
										<select data-rule="required;anaMethod" id="anaMethod" name="anaMethod" class="form-control">
												<%
													request.setAttribute("analyticsMethodList", DataCache.analyticsMethodList);
												%>
												<c:forEach items="${analyticsMethodList}" var="item">
										           <option <c:if test='${ana.anaMethod == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
										        </c:forEach>
										</select>
									</div>
									<div class="col-sm-5">
										<p class="help-block">
											支持SQL分析、自定义脚本、单机脚本的分析，目前已开放SQL分析。
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">SQL</label>
									<div class="col-sm-10">
										<textarea data-rule="required;sql" id="sql" name="sql" rows="20" class="form-control input-sm" placeholder="分析名称">${ana.sql}</textarea>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
			<!-- 							SQL帮助信息<pre>查询类：SELECT field1, field2 AS f2 WHERE field>3<br>统计类：SELECT field1, field2 AS f2 WHERE field>3<br>SQL函数： -->
			<!-- 							</pre> -->
										<address>
										  <strong>查询类：</strong><br>
										  	SELECT field1, field2 AS f2 from table1 WHERE field > 3<br>
										</address>
										<address>
										  <strong>统计类：</strong><br>
										  	SELECT sum(field1) as f1_sum, count(field2) as f2_count from table1 WHERE field1>3 group by field3<br>
										</address>
										<address>
										  <strong>SQL函数：</strong><br>
										  	
										</address>
									</div>
								</div>
								<div class="form-group" style="display: none;">
									<label for="name" class="col-sm-2 control-label">输出设置</label>
									<div class="col-sm-5">
									        id(numeric)     host(string)       message(text) 
									</div>
								</div>
								<div class="form-group">
									<label for="indexName" class="col-sm-2 control-label">索引配置</label>
									<div class="col-sm-10">
										<div class="checkbox">
											<label class="checkbox-inline">
												<input name="addLuceneIndex" id="addLuceneIndex" type="checkbox" <c:if test='${ana.addLuceneIndex eq "y"}'>checked="checked"</c:if>/>添加到索引
											</label>
										</div>
										<div class="row" id="periodJSONDiv">
											<div class="col-md-12">
												<div class="form-group">
													<label for="indexName" class="col-sm-2 control-label">索引名称</label>
													<div class="col-sm-5">
														<input class="form-control input-inline" placeholder="请输入：索引名称" id="indexName" name="indexName" value="${ana.indexName}" 
														data-rule="length[2~45];indexName;remote[/analytics?method=indexNameExist&id=${ana.id}]"/>
													</div>
												</div>
												<div class="form-group">
													<label for="periodColumn" class="col-sm-2 control-label">列名</label>
													<div class="col-sm-5">
														<input class="form-control input-inline" placeholder="请输入时间列" id="periodColumn" name="periodColumn" value="${periodJSON.periodColumn}" 
														data-rule="length[2~45];periodColumn"/>
													</div>
												</div>
												<div class="form-group">
													<label for="periodFormat" class="col-sm-2 control-label">列格式</label>
													<div class="col-sm-5">
														<input class="form-control input-inline" placeholder="请输入时间列的格式：yyyy/MM/dd" id="periodFormat" name="periodFormat" value="${periodJSON.periodFormat}" 
														data-rule="length[2~45];"/>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group" style="display: none;">
									<div class="col-sm-offset-2 col-sm-10">
										<div class="checkbox">
											<label class="checkbox-inline">
												<input name="isLanding" type="checkbox" <c:if test='${ana.isLanding eq "y"}'>checked="checked"</c:if>/>数据落地
											</label>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css">
<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/codeeditor/sql.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>

<SCRIPT type="text/javascript">
var editor = null;
function setTextAreaValue() {
	editor.save();
}
var editor = CodeMirror.fromTextArea(document.getElementById("sql"), {
	mode: {name: "text/x-mariadb",
	 		version: 2,
	 		singleLineStringErrors: false},
	lineNumbers: true,
	indentUnit: 14
});

$(function(){
	var id=$("#id").val();
	console.log("id="+id);
	if(parseInt(id) == 0){
		$("#runningBtn").addClass("disabled");
		$("#anaHistoryA").addClass("disabled");
	}
	
	$('#runningBtn').click(function(){
		clearLayer();
		createMark();
		var inte_type = $(this).attr("inte_type");
		
		runOrStop(inte_type);
	});
	
	function runOrStop(inte_type){
// 		console.log("runOrStop.inte_type="+inte_type);
		
		$.ajax({
			url:"<%=request.getContextPath() %>/analytics?method=running&inte_type=" + inte_type + "&id="+$("#id").val(),
			data:{"sql":editor.getValue()},
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				
				console.log(data);
				var respStatus = data["respStatus"];
				var jobId = data["jobId"];
				if(!jobId){
					alert("立即运行失败！");
				}else{
					if(respStatus=="0"){
						if(inte_type=="runJob"){
							showLayer(jobId);
						}else{
							stopLayer(jobId);
						}
					}else if(respStatus="-1"){
						inte_type = "killJob";
						alert("获取总线服务响应超时！");
					}else{
						inte_type = "killJob";
						alert("立即运行失败！");
					}
				}
// 				console.log(inte_type);
				/*
				if(inte_type=="runJob"){
					$('#runningBtn').text("立即停止");
					$('#runningBtn').attr("inte_type" , "killJob");
					$('#runningBtn').removeClass("btn btn-info").addClass("btn btn-danger");
				}else{
					$('#runningBtn').text("立即运行");
					$('#runningBtn').attr("inte_type" , "runJob");
					$('#runningBtn').removeClass("btn btn-danger").addClass("btn btn-info");
				}
				$('#runningBtn').removeClass("disabled");
				*/
				$.unblockUI();
			},
			error:function(){
				$.unblockUI();
				alert("请求出错！请联系站点管理员。");
			}
		});
	}
	
	//弹出分析层
	function showLayer(jobId){
		var ccc = $("#myTab li:eq(0)").clone();
		$("#myTab li:eq(0)").append(ccc);
		
		$.open({
	        type: 2,
	        title: [
	                '分析结果',
	                'border:none; background:#61BA7A; color:#fff;' 
	        ],
	        zIndex: 19891014,
	        //fix: true,
	        maxmin: true,
	        move: false,
	        shade: [0], //不显示遮罩
	        border: [0,1,'#61BA7A'], //不显示边框
	        area: [$("body").width()+'px', '300px'],
	        //page: {url: 'http://localhost/analytics/anaResult.jsp'},
	        iframe:{src:'anaResult.jsp?id='+$("#id").val()+"&jobId="+jobId,scrolling: 'auto'},
			shift: 'bottom' //从上动画弹出
		});
		
		$("#myTab li li").remove();
	}
	
	function stopLayer(jobId){
		console.log("stopLayer...");
		$("#xubox_layer1").remove();
		$("div[type='iframe']").remove();
	}
	
	function clearLayer(){
		console.log("stopLayer...");
		$("#xubox_layer1").remove();
		$("div[type='iframe']").remove();
	}
	
	function addToIndexFunc0(flg){
		if(flg){
			$("#periodJSONDiv").show();
			$("#indexName").attr("data-rule","required;indexName;");
// 			$("#periodColumn").attr("data-rule","required;periodColumn;");
// 			$("#periodFormat").attr("data-rule","required;periodFormat;");
		}else{
			$("#periodJSONDiv").hide();
			
			$("#indexName").attr("data-rule","");
// 			$("#periodColumn").attr("data-rule","");
// 			$("#periodFormat").attr("data-rule","");
		}
	}
	
	$("#addLuceneIndex").change(function(){
		addToIndexFunc0($(this).prop("checked"));
	});
	
	addToIndexFunc0($("#addLuceneIndex").prop("checked"));
	
});

function func(){
	$("#sql").val(editor.getValue());
}

</script>
<SCRIPT type="text/javascript">
$(function(){
	
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},callback: {
				onClick: onClick,
				onMouseDown: onMouseDown
			}
	};
	
	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("menustree");
		zTree.expandNode(treeNode);
		$("span").remove(".ico_docu");
	}
	
	//加载菜单树
	function loadMenusTree(){
		$.ajax({
				url:"<%=request.getContextPath() %>/analytics?method=menus&id=<%=request.getParameter("id")%>&anaKeyword="+$("#anaKeywordInput").val(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#menustree"), setting, zNodes);
					$("#loadImg").hide();
					$("#treeDemo").show();
					
					if(false){
						console.log("删除图标1");
						//$("#treeDemo2_1_ul").find("input[class='button ico_docu']").remove();
						$("#treeDemo_1_ul .ico_docu").remove();
						$("#treeDemo_1_ul li a span").addClass("tree_add_css");
						
						$("#treeDemo_1_switch").remove();
						$("#treeDemo_1_check").remove();
						$("#treeDemo_1_a").remove();
						
					}
// 					$("span .ico_docu").remove();
					//$("span").hasClass("ico_docu").remove();
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

	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		if(!treeNode || !treeNode["id"]){
			$("#id").val("");
			$("#name").val("");
			$("#projectId").val("");
			$("#sql").val("");
			editor.setValue("");
			$('#runningBtn').addClass("disabled");
			$('#anaHistoryA').addClass("disabled");
			return;
		}
		
		createMark();
		//load data
		$.ajax({
				url:"<%=request.getContextPath() %>/analytics?method=selectById&id="+treeNode.id,
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					//console.log("success...");
					//console.log(data);
					var win = data;
					//var win = eval('('+data+')');
					//console.log("win...");
					//console.log(data);
					
					$("#id").val(data.id);
					$("#name").val(data.name);
					$("#projectId").val(data.projectId);
					$("#sql").val(data.sql);
					editor.setValue(data.sql);
					$('#runningBtn').removeClass("disabled");
					$('#anaHistoryA').removeClass("disabled");
					
					var _historyUrl = "<%=request.getContextPath() %>/analyticsHistory?method=index&anaId=" + $("#id").val();
					$('#anaHistoryA').attr("href",_historyUrl);
					
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



<SCRIPT type="text/javascript">
$(function(){
	
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},callback: {
				//onClick: onClick
				onMouseDown: onMouseDown
			}
	};
	
	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.expandNode(treeNode);
		$("span").remove(".ico_docu");
	}

	//加载菜单树
	function loadMenusTree(){
		var id = <%=request.getParameter("id")%>;
		//if(!id || id==""){$("#loadImg2").hide();return;}
		
		$.ajax({
				url:"<%=request.getContextPath() %>/analytics?method=dsMenus&id=<%=request.getParameter("id")%>"+"&dsKeyword="+$("#dsKeywordInput").val(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
					$("#loadImg2").hide();
					$("#treeDemo2").show();
					
					if(false){
						console.log("删除图标1");
						//$("#treeDemo2_1_ul").find("input[class='button ico_docu']").remove();
						$("#treeDemo2_1_ul .ico_docu").remove();
						$("#treeDemo2_1_ul li a span").addClass("tree_add_css");
						
						$("#treeDemo2_1_switch").remove();
						$("#treeDemo2_1_check").remove();
						$("#treeDemo2_1_a").remove();
					}
					
					$("span").remove(".ico_docu");
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
	}
	
	loadMenusTree();
	
	$("#dsSearchKeySpan").click(function(){
		loadMenusTree();
	});

	//点击菜单项
	function onMouseDown(event, treeId, treeNode) {
		if(!treeNode.id){
			$("#id").val("");
			$("#name").val("");
			$("#projectId").val("");
			$("#sql").val("");
			editor.setValue("");
			$('#runningBtn').addClass("disabled");
			$('#anaHistoryA').addClass("disabled");
			return;
		}
		
		//load data
		$.ajax({
				url:"<%=request.getContextPath() %>/analytics?method=selectById&id="+treeNode.id+"&dsKeyword="+$("#dsKeywordInput").val(),
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					console.log("success...");
					console.log(data);
					var win = data;
					//var win = eval('('+data+')');
					console.log("win...");
					console.log(data);
					
					$("#id").val(data.id);
					$("#name").val(data.name);
					$("#projectId").val(data.projectId);
					$("#sql").val(data.sql);
					editor.setValue(data.sql);
					$('#runningBtn').removeClass("disabled");
					$('#anaHistoryA').removeClass("disabled");
				},	
				error:function(){
					console.log("加载数据失败！");
				}
		});
	}
	
});
</SCRIPT>

</body>
</html>