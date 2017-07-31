<%@page import="com.stonesun.realTime.services.servlet.SearchServlet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
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
<title>检索首页</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="<%=request.getContextPath() %>/resources/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
.tree_add_css{
	color: #007fff;
}
</style>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_search);%>
	<%@ include file="/resources/common_menu.jsp"%>
	
	<%
		String dsId = request.getParameter("dsId");
		String keyword = request.getParameter("keyword");
		String timeRangeSelect = request.getParameter("timeRangeSelect");
		String startTime = request.getParameter("startTime");
		String stopTime = request.getParameter("stopTime");
		String dy_startTime = request.getParameter("dy_startTime");
		String dy_stopTime = request.getParameter("dy_stopTime");
		
		if(StringUtils.isBlank(keyword)){
			keyword = SearchServlet.default_sql;
		}
		request.setAttribute("keyword", keyword);
		if(StringUtils.isBlank(timeRangeSelect)){
			request.setAttribute("timeRangeSelect", 1);
		}else{
			request.setAttribute("timeRangeSelect", timeRangeSelect);
		}
		request.setAttribute("startTime", startTime);
		request.setAttribute("stopTime", stopTime);
		request.setAttribute("dy_startTime", dy_startTime);
		request.setAttribute("dy_stopTime", dy_stopTime);
	%>
	
	<input value="${timeRangeSelect}" id="timeRangeSelectHidden" type="hidden"/>
	<input value="${startTime}" id="startTimeHidden" type="hidden"/>
	<input value="${stopTime}" id="stopTimeHidden" type="hidden"/>
	<input value="${dy_startTime}" id="dy_startTimeHidden" type="hidden"/>
	<input value="${dy_stopTime}" id="dy_stopTimeHidden" type="hidden"/>
	
	
	<form action="<%=request.getContextPath() %>/search/index.jsp" method="post" class="form-horizontal" role="form">
		
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-md-12">
					  <textarea id="keyword" name="keyword" class="form-control" placeholder="请输入收索关键词">${keyword}</textarea>
			    </div>
			</div>
			<div class="row">
				<div class="col-md-2">
					<select id="timeRangeSelect" name="timeRangeSelect" class="form-control">
						<option value="1">所有时间</option>
						<option value="2">指定时间范围</option>
						<option value="3">滑动时间范围</option>
					</select>
				</div>
				<div class="col-md-4" id="StartStopTime" style="display: none;">
					<input placeholder="开始时间" data-rule="required;startTime" class="Wdate form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'stopTime\')||\'2020-10-01\'}'})"/>
					~<input placeholder="结束时间" data-rule="required;stopTime" class="Wdate form-control" id="stopTime" name="stopTime" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'2020-10-01'})"/>
				</div>
				<div class="col-md-4" id="dy_StartStopTime" style="display: none;">
					<input placeholder="开始时间" data-rule="required;dy_startTime" class="form-control" id="dy_startTime" name="dy_startTime"/>
					~<input placeholder="结束时间" data-rule="required;dy_stopTime" class="form-control" id="dy_stopTime" name="dy_stopTime"/>
				</div>
				<div class="col-md-2 text-right r" >
					<button class="btn btn-default" type="submit">搜索</button>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<!-- page header end -->
	</form>
	
	<!-- page content start -->
	<div class="container mh500" style="margin-top: 20px;">
		<div class="row">
			<div class="col-md-6">
				耗时<span id="total_time"></span>秒，<span id="total"></span>个事件数，截至时间<span id="last_time"></span>
			</div>
			<div class="col-md-6">
				<div style="text-align: right;">
					<a id="create_monitor_a" href="<%=request.getContextPath() %>/user/monitor/edit.jsp" onclick="return createMonitorFromSearchFunc(this)">创建监控</a>
					<a style="display: none;" id="create_chart_a" href="<%=request.getContextPath() %>/chart?method=createFromSearch" onclick="return createFromSearchFunc(this)">创建图表</a>
					|<a href="#" style="display: inline;" id="exportExcelA" onclick="return exportExcelFunc()">导出数据</a>
				</div>
			</div>
		</div>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-2" style="display: none;">
				<div style="min-width: 200px;">
					<div id="loadImg" style="text-align: left;">
						<img alt="菜单加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px" id="loadSpan">加载中...</span>
					</div>
					<ul id="treeDemo2" style="display: none;margin-left: -40px;" class="ztree"></ul>
				</div>
			</div>
			
			<div class="col-md-12" style="overflow: auto;">
				<table id="searchTable">
				    <tr>
				        <th w_index="data">data</th>
<!-- 				        <th w_index="dsId" width="5%;">dsId</th> -->
<!-- 				        <th w_index="f1" width="5%;">f1</th> -->
<!-- 				        <th w_index="f2" width="5%;">f2</th> -->
<!-- 				        <th w_index="f3" width="5%;">f3</th> -->
				    </tr>
				</table>
	
				<c:if test="${1==2 }">
					<c:if test="${pager.pagerSize != 0 and false}">
						<div class="col-md-9">
							<table class="table table-hover table-striped">
								<tr class="success">
									<td>data</td>
								</tr>
								<c:forEach var="stu" items="${pager.list}">
									<tr>
										<td>${stu}</td>
									</tr>
								</c:forEach>
							</table>
							<div>
								<%@ include file="/resources/pager.jsp"%>
							</div>
						</div>
					</c:if>
					<c:if test="${pager.pagerSize == 0}">
						没有检索到任何数据！
					</c:if>
				</c:if>
			</div>
		</div>
	</div>

<input id="dynamic_columns_input" type="hidden"/>	

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<!-- grid.simple.min.css, grid.simple.min.js -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css">
<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/codeeditor/sql.js"></script>
<script type="text/javascript">

var editor = null;
function setTextAreaValue() {
	editor.save();
}
var editor = CodeMirror.fromTextArea(document.getElementById("keyword"), {
		mode: {name: "text/x-mariadb",
   		version: 2,
   		singleLineStringErrors: false},
		lineNumbers: true,
		indentUnit: 4
     });
     
     
     
    var gridObj , _hrefMonitor , _hrefChart;
    var _StartStopTime_html,_dy_StartStopTime_html;
    $(function () {
    	_hrefMonitor = $("#create_monitor_a").attr("href");
    	_hrefChart = $("#create_chart_a").attr("href");
    	
    	
    	var _url = getUrl();
    	_url += "&op=search"
    	//设置导出的url
    	//var _exportExcel = _url + "&op=exportExcel&curPage=1&pageSize=20";
    	//$("#exportExcelA").attr("href",_exportExcel);
    	
        gridObj = $.fn.bsgrid.init('searchTable', {
            url: _url,
            pageSizeSelect: true,
            pageSize: 10,
            displayBlankRows: false, // single grid setting
            displayPagingToolbarOnlyMultiPages: true, // single grid setting
            method:"data",
            /*
            extend: {
                settings: {
                    fixedGridHeader: true, // fixed grid header, auto height scroll, default false
                    fixedGridHeight: '400px' // fixed grid height, auto scroll
                }
            },*/
            processUserdata: function (userdata, options) {
            	var total_time = userdata['total_time'] / 1000;
            	var last_time = userdata['last_time'];
            	var total = userdata['total'];
            	$("#total_time").html(total_time);
            	$("#last_time").html(last_time);
            	$("#total").html(total);
            	
                $('#searchTable tr th').remove();
                var dynamic_columns = userdata['dynamic_columns'];
                if(!dynamic_columns){return;}
                $("#dynamic_columns_input").val(dynamic_columns);
                console.log(dynamic_columns);
                var cNum = dynamic_columns.length;
                for (var i = 0; i < cNum; i++) {
                    $('#searchTable tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
                }
            }
        });
        
        $("#timeRangeSelect").change(function(){
        	timeRangeImplFunc($(this).val());
        });
        
        _StartStopTime_html = $("#StartStopTime").html();
		_dy_StartStopTime_html = $("#dy_StartStopTime").html();
		$("#StartStopTime").html("");
		$("#dy_StartStopTime").html("");
		
        $("#timeRangeSelect").val($("#timeRangeSelectHidden").val());
        timeRangeImplFunc($("#timeRangeSelectHidden").val());
    });
    
    function exportExcelFunc(){
    	var _url = getUrl();
    	var _exportExcel = _url + "&op=exportExcel&curPage=1&pageSize=20";
    	console.log(_exportExcel);
    	$("#exportExcelA").attr("href",_exportExcel);
    	console.log(_exportExcel);
    }
    
    function getUrl(){
    	console.log("getUrl..");
    	var keyword= editor.getValue();
    	var dsId = "<%=request.getAttribute("dsId")!=null?request.getAttribute("dsId"):""%>";
    	var _url = "<%=request.getContextPath() %>/d3Test/table_json.jsp?method=socketSql";
    	var val = $("#timeRangeSelectHidden").val()
    	if(val==1){
    		_url += "&keyword="+keyword+"&rangeType=full";
    	}else if(val==2){
    		_url += "&keyword="+keyword+"&rangeType=fix&startTime="+$("#startTimeHidden").val()+"&stopTime="+$("#stopTimeHidden").val();
    	}else if(val==3){
    		_url += "&keyword="+keyword+"&rangeType=dynamic&startTime="+$("#dy_startTimeHidden").val()+"&stopTime="+$("#dy_stopTimeHidden").val();
    	}
    	
    	var _kw = $("div[class='CodeMirror-scroll']").html();
    	console.log("_kw="+_kw)
    	return _url;
    }
    
    function timeRangeImplFunc(val){
    	console.log("timeRangeImplFunc.val="+val);
   		$("#StartStopTime").hide();
   		$("#dy_StartStopTime").hide();
   		
    	if(val==1){
    		$("#StartStopTime").html("");
    		$("#dy_StartStopTime").html("");
    	}else if(val==2){
    		$("#StartStopTime").show();
    		$("#StartStopTime").html(_StartStopTime_html);
    		$("#StartStopTime").find("#startTime").val($("#startTimeHidden").val());
    		$("#StartStopTime").find("#stopTime").val($("#stopTimeHidden").val());
    	}else if(val==3){
    		$("#dy_StartStopTime").show();
    		$("#dy_StartStopTime").html(_dy_StartStopTime_html);
    		$("#dy_StartStopTime").find("#dy_startTime").val($("#dy_startTimeHidden").val());
    		$("#dy_StartStopTime").find("#dy_stopTime").val($("#dy_stopTimeHidden").val());
    	}
    }

    function operate(record, rowIndex, colIndex, options) {
        return '<a href="#" onclick="alert(\'ID=' + gridObj.getRecordIndexValue(record, 'ID') + '\');">Operate</a>';
    }
    
    //创建图表
    function createFromSearchFunc(obj){
    	var _keyword = $("#keyword").val();
    	if(!_keyword || $.trim(_keyword)==''){
    		alert("请输入检索的sql!");
    		return false;
    	}
    	
    	var val = $("#timeRangeSelect").val();
    	var rangeType="",startTime="",stopTime="";
    	if(val==1){
    		rangeType = "full";
    	}else if(val==2){
    		rangeType = "fix";
    		startTime = $("#startTime").val();
    		stopTime = $("#stopTime").val();
    	}else if(val==3){
    		rangeType = "dynamic";
    		startTime = $("#dy_startTime").val();
    		stopTime = $("#dy_stopTime").val();
    	}
    	
    	var _from = _keyword.indexOf("from");
    	if(_keyword.indexOf("group",_from) >= 0){
    		alert("图表不支持group by语句！");
    		return false;
    	}
    	
    	var lastHref = _hrefChart + "&sql=" + _keyword + "&columns="+$("#dynamic_columns_input").val() +"&rangeType="+rangeType+"&startTime="+startTime+"&stopTime="+stopTime;
    	$(obj).attr("href",lastHref);
    	return true;
    }

    //创建监控
    function createMonitorFromSearchFunc(obj){
    	console.log("createMonitorFromSearchFunc...");
    	
    	var val = $("#timeRangeSelect").val();
    	var rangeType,startTime,stopTime;
    	if(val==1){
    		rangeType = "full";
    	}else if(val==2){
    		rangeType = "fix";
    		startTime = $("#startTime").val();
    		stopTime = $("#stopTime").val();
    	}else if(val==3){
    		rangeType = "dynamic";
    		startTime = $("#dy_startTime").val();
    		stopTime = $("#dy_stopTime").val();
    	}
    	
    	var _keyword = editor.getValue();
    	var lastHref = _hrefMonitor + "?sql=" + _keyword+"&rangeType="+rangeType;//+"&startTime="+startTime+"&stopTime="+stopTime;//JSON.stringify(_c);//+"&columns="+$("#dynamic_columns_input").val();
    	if(startTime){
    		lastHref += "&startTime="+startTime;
    	}
    	if(stopTime){
    		lastHref += "&stopTime="+stopTime;
    	}
    	console.log(lastHref);
    	$(obj).attr("href",lastHref);
    	return true;
    }
    
</script>

<SCRIPT type="text/javascript">
$(function(){
	$("#type").change(function(){
		var val = $(this).val();
		console.log(val);
		if(val=="beat"){
			$("#windowInterval").attr("readonly","readonly");
		}else if(val=="slide"){
			$("#windowInterval").attr("readonly","");
		}
	});
	
	$("#windowLength").blur(function(){
		if($("#type").val()=="beat"){
			$("#windowInterval").val($(this).val());
		}
	});
	
var setting = {
		check: {
			enable: true,
			dblClickExpand: false
		},callback: {
			onClick: onClick,
			onMouseDown: onMouseDown
		},
		view:{
			showLine:false
		}
};
function onClick(e,treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
	zTree.expandNode(treeNode);
}

try{
	loadMenusTree();
}catch(e){
	console.log(e);
}

//加载菜单树
function loadMenusTree(){
	$.ajax({
			url:"<%=request.getContextPath() %>/search?method=menus",
			type:"post",
			dataType:"text",
			success:function(data, textStatus){
				//console.log(data);
				var zNodes = eval('('+data+')');
				
				$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
				$("#loadImg").hide();
				$("#treeDemo2").show();
				
				console.log("删除图标1");
				//$("#treeDemo2_1_ul").find("input[class='button ico_docu']").remove();
				$("#treeDemo2_1_ul .ico_docu").remove();
				$("#treeDemo2_1_ul li a span").addClass("tree_add_css");
				
				$("#treeDemo2_1_switch").remove();
				$("#treeDemo2_1_check").remove();
				$("#treeDemo2_1_a").remove();
			},
			error:function(){
				//alert("加载数据出错！");
				$("#loadSpan").text("加载数据出错！");
			}
	});
}
			
			//点击菜单项
			function onMouseDown(event, treeId, treeNode) {
				$("#stageUrl").hide();
				$("#deleteWindowUrl").hide();
				if(treeNode["window_id"]==0){
					//alert("treeNode.window_id="+treeNode.window_id);
					console.log("treeNode.window_id="+treeNode.window_id);
					$("#type").val("").attr("disabled",true);
					$("#type").val("").attr("disabled",true);
					$("#name").val("").attr("disabled",true);
					$("#windowLength").val("").attr("disabled",true);
					$("#windowInterval").val("").attr("disabled",true);
					$("#saveWindowId").attr("disabled",true);
					
					return;
				}
				console.log(treeNode.id+","+treeNode.p_statgeid);
				$("#stageUrl").show();
				if(!treeNode.id || treeNode.p_statgeid>0){
					$("#id").val("").attr("disabled",true);
					$("#type").val("").attr("disabled",true);
					$("#name").val("").attr("disabled",true);
					$("#windowLength").val("").attr("disabled",true);
					$("#windowInterval").val("").attr("disabled",true);
					$("#saveWindowId").attr("disabled",true);
					
					//select stage
					$.ajax({
						url:"<%=request.getContextPath() %>/analytics?method=selectStageById&id="+treeNode.p_statgeid,
						type:"post",
						dataType:"text",
						success:function(data, textStatus){
							console.log(data);
							var stage = eval('('+data+')');
							//$("#type").val(win.type);
							//$("#name").val(win.name);
							//$("#windowLength").val(win.windowLength);
							//$("#windowInterval").val(win.windowInterval);
							
							var _url = "<%=request.getContextPath() %>/analytics/addAna.jsp?window_id="+stage.window_id+"&stage_id="+stage.id;
							
							$("#stageUrl").attr("href",_url);
						},	
						error:function(err){
							console.log(err);
						}
					});
					return;
				}
				
				//select window
				$.ajax({
					url:"<%=request.getContextPath() %>/analytics?method=selectWindowById&id="+treeNode.id,
					type:"post",
					dataType:"text",
					success:function(data, textStatus){
						console.log(data);
						var win = eval('('+data+')');
						$("#id").val(win.id).attr("disabled",false);
						$("#type").val(win.type).attr("disabled",false);
						$("#name").val(win.name).attr("disabled",false);
						$("#windowLength").val(win.windowLength).attr("disabled",false);
						$("#windowInterval").val(win.windowInterval).attr("disabled",false);
						$("#saveWindowId").attr("disabled",false);
						
						var _url = "<%=request.getContextPath() %>/analytics/addAna.jsp?window_id="+win.id;
						$("#stageUrl").attr("href",_url);
						
						var _deleteWindowUrl = "<%=request.getContextPath() %>/analytics?method=deleteWindowById&window_id="+win.id+"&analyticsID="+win.analyticsID;
						$("#deleteWindowUrl").attr("href",_deleteWindowUrl).show();
						
						if($("#type").val()=='beat'){
							$("#windowInterval").attr("readonly","readonly");
						}else{
							$("#windowInterval").attr("readonly","");
						}
					},	
					error:function(err){
						console.log(err);
					}
				});
			}
		});
</SCRIPT>

</body>
</html>