<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.servlet.MonitorServlet"%>
<%@page import="com.stonesun.realTime.services.core.KeyValue"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.MonitorInfo"%>
<%@page import="javax.management.monitor.Monitor"%>
<%@page import="com.stonesun.realTime.services.db.MonitorServices"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>监控项编辑</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="<%=request.getContextPath() %>/resources/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "137");%>

	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					监控编辑
				</div>
			</div>
		</div>
	</div>
	
	<%
					try{
						String id = request.getParameter("id");
						String display = "";
						String backUrl="javascript:history.back();";
						if(StringUtils.isBlank(id) || "0".equals(id)){
							display="style='display: none'";
							backUrl="/search/dashboard.jsp";
						}
						request.setAttribute("display", display);
						request.setAttribute("id", id);
						request.setAttribute("backUrl", backUrl);
						
						UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
						MonitorInfo monitor = null;

						if(StringUtils.isNotBlank(id)){
							String time = request.getParameter("time");
							if(StringUtils.isNotBlank(time)){
								MonitorInfo param = new MonitorInfo();
								param.setId(Integer.valueOf(id));
								param.setTime(time);
								MonitorServices.updateTime(param);
							}
							
							monitor = MonitorServices.selectById(Integer.valueOf(id),user1.getId());
							if(monitor==null){
								response.sendRedirect("/resources/403.jsp");
								return;
							}

							//验证操作修改cond条件
							if(StringUtils.isNotBlank(request.getParameter("method"))){
							String newCond = request.getParameter("query");
								if(StringUtils.isBlank(newCond)){
									throw new Exception("newCond is null");
								}
								monitor.setCond(newCond);
							}


							
							if(StringUtils.isNotBlank(monitor.getGroupFields())){
								List<String> _selectGroupFields = new LinkedList<String>();
								String[] _arr = monitor.getGroupFields().split(",");
								for(int i=0;i<_arr.length ;i++){
									_selectGroupFields.add(_arr[i]);
								}
								request.setAttribute("selectGroupFields", _selectGroupFields);
							}
							
							if(StringUtils.isNotBlank(monitor.getCond()) && monitor.getType().equals(MonitorInfo.monitorInfo_type_es)){
								JSONObject condJson = JSON.parseObject(monitor.getCond());
								condJson.remove("aggregations");
								monitor.setCond( condJson.toJSONString() );
							}
							
							request.setAttribute("timeRangeSelect", monitor.getRangeType());
							if(StringUtils.isNotBlank(monitor.getRangeType())){
								if(monitor.getRangeType().equals("fix")){
									request.setAttribute("startTime", monitor.getStartTime());
									request.setAttribute("stopTime", monitor.getStopTime());
								}else if(monitor.getRangeType().equals("dynamic")){
									request.setAttribute("dy_startTime", monitor.getStartTime());
									request.setAttribute("dy_stopTime", monitor.getStopTime());
								}
							}else{
								request.setAttribute("timeRangeSelect", 1);
							}
						}else{
							monitor = new MonitorInfo();
// 							monitor.setCond(request.getParameter("sql"));
							monitor.setIndex(request.getParameter("index"));
							monitor.setCond(request.getParameter("query"));
							monitor.setRangeType(request.getParameter("rangeType"));
							monitor.setStartTime(request.getParameter("startTime"));
							monitor.setStopTime(request.getParameter("stopTime"));
							String categoryId = request.getParameter("typeId");
							if(StringUtils.isNotBlank(categoryId) 
									&& !"-1".equals(categoryId)
									&& !"0".equals(categoryId)){
								monitor.setCategoryId(Integer.valueOf(categoryId));
								monitor.setCategoryName(request.getParameter("type"));
							}
// 							if(StringUtils.isBlank(monitor.getCond())){
// 								throw new Exception("监控条件不能为空！");
// 							}


							
							request.setAttribute("timeRangeSelect", monitor.getRangeType());
							if(StringUtils.isNotBlank(monitor.getRangeType())){
								if(monitor.getRangeType().equals("fix")){
									request.setAttribute("startTime", monitor.getStartTime());
									request.setAttribute("stopTime", monitor.getStopTime());
								}else if(monitor.getRangeType().equals("dynamic")){
									request.setAttribute("dy_startTime", monitor.getStartTime());
									request.setAttribute("dy_stopTime", monitor.getStopTime());
								}
							}
							
						}
						
						String fromAnaId = request.getParameter("fromAnaId");//来源于hbase分析的id
						if(StringUtils.isNotBlank(fromAnaId)){
							AnalyticsInfo anaInfo = AnalyticsServices.selectById(fromAnaId,user1.getId());
							System.out.print(anaInfo);
							if(anaInfo==null){
								response.sendRedirect("/resources/403.jsp");
								return;
							}else{
								monitor.setCond(anaInfo.getSql());
								monitor.setType("hbase");
							}
						}
						
						if(StringUtils.isBlank(monitor.getType())){
							monitor.setType("es");
						}

						request.setAttribute("monitor", monitor);
						request.setAttribute("monitorList", DataCache.monitorList);
						request.setAttribute("polymerizationList", DataCache.polymerizationList);
						
						request.setAttribute("groupFields", MonitorServlet.columns(monitor.getIndex()));
						request.setAttribute("maxMin", DataCache.maxMin);
					}catch(Exception e){
						e.printStackTrace();
					}
				%>
	<div class="container mh500">
		<div class="row">
		<%-- <c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<div class="page-header">
					  <ol class="breadcrumb">
						  <li><a href="<%=request.getContextPath() %>/user/monitor?method=index">监控项管理列表</a></li>
						  <li class="active">编辑监控项</li>
					  </ol>
				  </div>
				<div class="row">
					<div class="col-md-12">
					    
						<input value="${timeRangeSelect}" id="timeRangeSelectHidden" type="hidden"/>
						<input value="${startTime}" id="startTimeHidden" type="hidden"/>
						<input value="${stopTime}" id="stopTimeHidden" type="hidden"/>
						<input value="${dy_startTime}" id="dy_startTimeHidden" type="hidden"/>
						<input value="${dy_stopTime}" id="dy_stopTimeHidden" type="hidden"/>
			
						<form action="<%=request.getContextPath()%>/user/monitor?method=save" class="form-horizontal" role="form" method="post">
							<input value="${monitor.type}" id="monitorType" name="type" type="hidden"/>
							<input type="hidden" value="${monitor.id }" name="id" id="id"/>
							<input value="" id="isCreatTriger" name="isCreatTriger" type="hidden"/>
							<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
							<div class="form-group">
								<label for="testBtn" class="col-sm-2 control-label"></label>
								<div class="col-sm-5">
									<c:if test="${empty id}">
										<a href="javascript:window.opener=null;window.close();">取消</a>
									</c:if>
									<c:if test="${not empty id}">
										<a href="javascript:history.go(-1);">返回</a>
									</c:if>
									<input code="save" type="submit" value="保存" onclick="confirmOnline();" class="btn btn-primary" />
									<input type="button" value="测试" style="display: none;" class="btn btn-default" id="testBtn"/>
								</div>
							</div>
							<c:if test="${monitor.type eq 'es'}">
								<div class="form-group">
									<label for="index" class="col-sm-2 control-label">索引名称</label>
									<div class="col-sm-5">
										<input data-rule="required;index;length[1~145]" readonly="readonly" value="${monitor.index}" class="form-control" id="index" name="index" placeholder="索引名称">
									</div>
								</div>
							</c:if>
							<div class="form-group">
								<label for="type" class="col-sm-2 control-label">监控类型</label>
								<label for="type" class="col-sm-1 control-label">${monitor.type}</lable>
								
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>监控名称</label>
								<div class="col-sm-5">
									<input data-rule="required;name;length[1~45];remote[/user/monitor?method=exist&id=${monitor.id}]" value="${monitor.name}" class="form-control" id="name" name="name" placeholder="监控项名称">
								</div>
							</div>
							<div class="form-group">
								<label for="cond" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>监控条件</label>
								<div class="col-sm-7">
									<textarea readonly="readonly" data-rule="required;cond;length[1~1024]" rows="6" cols="120" class="form-control" id="cond" name="cond" placeholder="检索条件">${monitor.cond}</textarea>
									<div ${display }><a target="blank" href="/search/dashboard.jsp?type=monitor&id=${monitor.id}">验证</a></div>
								</div>
							</div>
							<div class="form-group">
								<label for="target" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>监控对象</label>
								<div class="col-sm-3">
									<select data-rule="required;target" id="target" name="target" class="form-control" onchange="targetChange(this)">
										<c:forEach items="${monitorList}" var="item">
								           <option <c:if test='${monitor.target == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								        </c:forEach>
									</select>
								</div>
								<div class="col-sm-2" id="polyMethodDiv">
									<select data-rule="required;polyMethod" id="polyMethod" name="polyMethod" class="form-control ">
										<c:forEach items="${polymerizationList}" var="item">
								           <option <c:if test='${monitor.polyMethod == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								        </c:forEach>
									</select>
								</div>
								<div class="col-sm-2" id="colNameDiv">
									<input data-rule="required;length[1~45];" <c:if test="${empty monitor.colName}">value="c1"</c:if>value="${monitor.colName}" class="form-control" id="colName" name="colName" placeholder="输入字段名称">
								</div>
							</div>
							<input type="hidden" name="categoryId" id="categoryId" value="${monitor.categoryId}">
							<div class="form-group">
								<label for="categoryName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>所属分类</label>
								<div class="col-sm-5">
									<input class="form-control input-inline" placeholder="点击选择所属分类" id="categoryName" name="categoryName" data-rule="required;" value="${monitor.categoryName}" readonly="readonly"/>
								</div>
								<div class="col-sm-2">
									<input class="btn btn-default" type="button" name="select" style="height:36px;margin-left:-30px;vertical-align:middle;padding:0px 8px;" value="选择分类">
								</div>			
							</div>
							<div class="form-group">
								<label for="remark" class="col-sm-2 control-label">监控描述</label>
								<div class="col-sm-7">
									<textarea data-rule="length[1~1024]" rows="4" cols="120" class="form-control" id="remark" name="remark" placeholder="监控描述">${monitor.remark}</textarea>
								</div>
							</div>
							
							<div class="form-group" id="timeRangeDiv">
								<label for="timeRangeSelect" class="col-sm-2 control-label">时间范围</label>
								<div class="col-sm-3">
									<select id="timeRangeSelect" name="rangeType" class="form-control">
										<option value="full">所有时间</option>
										<option value="fix">指定时间范围</option>
										<option value="dynamic">滑动时间范围</option>
									</select>
								</div>
								<div class="col-sm-3">
									<div class="col-md-12" id="StartStopTime" style="display: none;">
										<input placeholder="开始时间" data-rule="required;startTime" class="Wdate form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'stopTime\')||\'2020-10-01\'}'})"/>
										~<input placeholder="结束时间" data-rule="required;stopTime" class="Wdate form-control" id="stopTime" name="stopTime" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'2020-10-01'})"/>
									</div>
									<div class="col-md-12" id="dy_StartStopTime" style="display: none;">
										<input placeholder="开始时间" data-rule="required;dy_startTime" class="form-control" id="dy_startTime" name="dy_startTime"/>
										~<input placeholder="结束时间" data-rule="required;dy_stopTime" class="form-control" id="dy_stopTime" name="dy_stopTime"/>
									</div>
								</div>
								<c:if test="${monitor.type eq 'hbase'}">
									<div class="col-sm-3" style="display: none;" id="datetimeFieldDiv">
										<input data-rule="required;datetimeField;length[1~45]" value="${monitor.datetimeField}" class="form-control" id="datetimeField" name="datetimeField" placeholder="表的时间字段">
									</div>
								</c:if>
							</div>
							<div class="form-group" id="quota_div" style="display:none">
								<label for="quota" class="col-sm-2 control-label" id="zhibiao">指标</label>
								<div class="col-sm-5">
									<select id="quota" name="quota" class="form-control ">
										<option></option>
										<c:forEach items="${groupFields}" var="item">
								           <option <c:if test='${monitor.quota == item.key}'>selected="selected"</c:if>value="${item.key}">${item.key}(${item.value})</option>
								        </c:forEach>
									</select>
								</div>
								<div class="col-sm-3">
									<select id="quotaFunc" name="quotaFunc" class="form-control ">
										<%
											request.setAttribute("chartConnType", DataCache.chartFuncList);
										%>
<!-- 										<option>--指标计算函数--</option> -->
										<option></option>
										<c:forEach items="${chartConnType}" var="item">
								           <option <c:if test='${monitor.quotaFunc == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								        </c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group" id="groupMainDiv" style="display: none;">
								<label for="groupFields" class="col-sm-2 control-label">分组字段</label>
								<div class="col-sm-5">
									已选择的分组字段：
									<select multiple id="selectGroupFields" name="selectGroupFields" class="form-control">
										<c:forEach items="${selectGroupFields}" var="item">
								           <option value="${item}" selected="selected">${item}</option>
								        </c:forEach>
									</select>
									
									<div style="color: red;">【提示】按住Ctrl或Shift可以用鼠标选中多个依赖的父任务。</div>
									<a href="/user/monitor/edit.jsp?id=${monitor.id}" id="clearPid" class="btn btn-default btn-sm">清除已选中的依赖任务</a>
									
									<br>
									全部字段：
									<select multiple id="groupFields" name="groupFields" class="form-control " style="height: 300px;">
										<option></option>
										<c:forEach items="${groupFields}" var="item">
								           <option <c:if test='${monitor.groupFields == item.key}'>selected="selected"</c:if>value="${item.key}">${item.key}(${item.value})</option>
								        </c:forEach>
									</select>
									
									<ul id="treeDemo" class="ztree" style="display: none;"></ul>
									
								</div>
<!-- 								<div class="col-sm-1"></div> -->
								<div class="col-sm-3">
									<select id="maxMin" name="maxMin" class="form-control ">
<!-- 										<option>--取分组最大最小值--</option> -->
										<option></option>
										<c:forEach items="${maxMin}" var="item">
								           <option <c:if test='${monitor.maxMin == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								        </c:forEach>
									</select>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" id="searchTableDiv">
						
					</div>
				</div>
			</div>
		</div>

	</div>
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery-1.4.4.min.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>

<!-- grid.simple.min.css, grid.simple.min.js -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script>

<script type="text/javascript">
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
	
function targetChange(t){
	var val = $(t).val();
	if(val == 'searchCount'){
		// 记录数监控
		$("#polyMethodDiv").attr("style","display:none;");
		$("#colNameDiv").attr("style","display:none;");
		$("#colName").val("c1");
	}else{
		$("#polyMethodDiv").removeAttr("style");
		$("#colNameDiv").removeAttr("style");
		$("#colName").val("");
	}
}

function confirmOnline(){
	var check = false;
	if($.trim($("#name").val())==''){
		$("#name").focus();
		return false;
	}else{
// 		$.ajax({
// 			url:"/user/monitor?method=exist&id="+$("#id").val()+"&name="+$("#name").val(),
// 			type:"post",
// 			dataType:"text",
// 			success:function(data, textStatus){
// 				console.log("data="+data);
// 				if(data.indexOf("error")>=0){
// 					$("#name").focus();
// 					return false;
// 				}else{
					
// 				}
// 			},
// 			error:function(){
// 				return false;
// 			}
// 		});

		if($.trim($("#target").val())!='searchCount'){
			if($.trim($("#colName").val())==''){
				$("#colName").focus();
				return false
			}else{check=true;}
		}else{check=true;}
		if(check){
			if (confirm("是否基于这个监控项创建告警？")) {  
				$("#isCreatTriger").val("1");
				return true;
		    } else{ 
		    	$("#isCreatTriger").val("2");
		        return false;
			}
		}
	}
	
}

$(function(){
	if($.trim($("#target").val())=='searchCount'){
		$("#polyMethodDiv").attr("style","display:none;");
		$("#colNameDiv").attr("style","display:none;");
		$("#colName").val("c1");
	}else{
		$("#polyMethodDiv").removeAttr("style");
		$("#colNameDiv").removeAttr("style");
	}
		
	var _StartStopTime_html,_dy_StartStopTime_html;
	$("#quota_div").attr("style","display:none");
	
	$("#timeRangeSelect").change(function(){
    	timeRangeImplFunc($(this).val());
    });
    
	var monitorType = $("#monitorType").val();
	
	if(monitorType=='es'){
		$("#timeRangeDiv").hide();
	}
	
    _StartStopTime_html = $("#StartStopTime").html();
	_dy_StartStopTime_html = $("#dy_StartStopTime").html();
 	_datetimeFieldDiv_html = $("#datetimeFieldDiv").html();
	$("#StartStopTime").html("");
	$("#dy_StartStopTime").html("");
 	$("#datetimeFieldDiv").html("");
	
    $("#timeRangeSelect").val($("#timeRangeSelectHidden").val());
    timeRangeImplFunc($("#timeRangeSelectHidden").val());
	
	function timeRangeImplFunc(val){
		
//     	console.log("timeRangeImplFunc.val="+val);
   		$("#StartStopTime").hide();
   		$("#dy_StartStopTime").hide();
   		$("#datetimeFieldDiv").hide();
   		
    	if(val=='full'){
    		$("#StartStopTime").html("");
    		$("#dy_StartStopTime").html("");
    		$("#datetimeFieldDiv").html("");
    	}else if(val=='fix'){
    		$("#StartStopTime").show();
    		$("#datetimeFieldDiv").show();
    		$("#StartStopTime").html(_StartStopTime_html);
    		if(monitorType == 'hbase'){
        		$("#datetimeFieldDiv").html(_datetimeFieldDiv_html);
    		}
    		$("#StartStopTime").find("#startTime").val($("#startTimeHidden").val());
    		$("#StartStopTime").find("#stopTime").val($("#stopTimeHidden").val());
    	}else if(val=='dynamic'){
    		$("#dy_StartStopTime").show();
    		$("#datetimeFieldDiv").show();
    		$("#dy_StartStopTime").html(_dy_StartStopTime_html);
    		if(monitorType == 'hbase'){
        		$("#datetimeFieldDiv").html(_datetimeFieldDiv_html);
    		}
    		$("#dy_StartStopTime").find("#dy_startTime").val($("#dy_startTimeHidden").val());
    		$("#dy_StartStopTime").find("#dy_stopTime").val($("#dy_stopTimeHidden").val());
    	}
    }
	
	function initTable(){
		var _table = "<table id=\"searchTable\">";
		_table += "<tr>";
		_table += "<th w_index=\"data\">data</th>";
		_table += "</tr>";
		_table += "</table>";
		
		$("#searchTableDiv").html(_table);
		
		//table
		var _url = "/d3Test/table_json.jsp?method=socketSql&keyword=select%20*%20from%20es_index%20limit%2010&rangeType=full&op=search";
		_url += "&op=search"
		
	    var gridObj = $.fn.bsgrid.init('searchTable', {
	        url: _url,
	        pageSizeSelect: true,
	        pageSize: 10,
	        displayBlankRows: false, // single grid setting
	        displayPagingToolbarOnlyMultiPages: true, // single grid setting
	        method:"data",
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
//	             console.log(dynamic_columns);
	            var cNum = dynamic_columns.length;
	            for (var i = 0; i < cNum; i++) {
	                $('#searchTable tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
	            }
	        }
	    });
	}
	
	$("#testBtn").click(function(){
		initTable();
	});
	
	function getColumns(){
		$.ajax({
			url:"<%=request.getContextPath() %>/user/monitor?method=getColumns",
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log(data);
				
			},
			error:function(){
				console.log("加载字段集合出错!");
			}
		});
	}
	
	//getColumns();
	
	$("#target").change(function(){
		var s = $(this).val();
		func0(s);
	});
	
	function func0(s){
// 		console.log("s="+s);
		if(s=="searchCount"){
			$("#quota_div").hide();
			$("#groupMainDiv").hide();
			$("#quota_div").hide();
// 			$("#groupFields").val("");
			$("#maxMin").removeAttr("data-rule");
		}else if(s=="groupSearchCount"){
			var quota=$("#quota").children().length;
			if(quota>1){
				$("#quota").show();
				$("#quotaFunc").show();
				$("#zhibiao").show();
			}else{
				$("#quota").hide();
				$("#quotaFunc").hide();
				$("#zhibiao").hide();
// 				
			}
			$("#quota_div").show();
			$("#groupMainDiv").show();
// 			$("#quota_div").show();
		}
		initEvent0();
	}
	
	func0($("#target").val());
	
	//选择了指标，则指标函数不能为空
	$("#quota").change(function(){
		if($(this).val() != ""){
			$("#quotaFunc").attr("data-rule","required;quotaFunc");
		}
	});
	
	$("#groupFields").change(function(){
		if($(this).val() != ""){
			$("#maxMin").attr("data-rule","required;maxMin");
		}
	});
	
	function initEvent0(){
		if($("#quota").val() != ""){
			$("#quotaFunc").attr("data-rule","required;quotaFunc");
		}else{
// 			$("#quotaFunc").attr("data-rule","quotaFunc");
			$("#quotaFunc").removeAttr("data-rule");
		}
		
// 		console.log(">>>"+$.trim($("#groupFields").val()));
		if($.trim($("#groupFields").val()) != ""){
			$("#maxMin").attr("data-rule","required;maxMin");
		}else{
			$("#maxMin").removeAttr("data-rule");
// 			$("#maxMin").attr("data-rule","maxMin");
		}
	}
	
	initEvent0();
});
</script>

<script type="text/javascript">
$(function(){
	
	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},callback: {
				onClick: onClick
				//onMouseDown: onMouseDown
			},
			view:{
				showLine:false
			}
	};
	function onClick(e,treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
		zTree.expandNode(treeNode);
	}
	
	$("#clearPid").click(function(){
		var $options = $('#selectGroupFields option');//获取当前选中的项
		$options.each(function(){
			$(this).attr("selected",null);//删除下拉列表中选中的项
		});
		//var $remove = $options.attr("selected","");//删除下拉列表中选中的项
		return false;
	});

// 	try{
// 		loadMenusTree();
// 	}catch(e){
// 		console.log(e);
// 	}

	//加载菜单树
	function loadMenusTree(){
		$.ajax({
				url:"<%=request.getContextPath() %>/search?method=menus",
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
// 					console.log(data);
					var zNodes = eval('('+data+')');
					
					$.fn.zTree.init($("#treeDemo2"), setting, zNodes);
					$("#loadImg").hide();
					$("#treeDemo2").show();
					
					if(false){
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
					//alert("加载数据出错！");
					$("#loadSpan").text("加载数据出错！");
				}
		});
	}
	
	$("#type").change(function(){
		func0($(this).val());
	});
	
	function func0(type){
// 		console.log("type="+type);
		if(type=='hbase'){
			$("#target").parent().parent().hide();
			$("#quota_div").hide();
		}else if(type='es'){
			$("#target").parent().parent().show();
			$("#quota_div").hide();
		}
	}
	
	func0($("#monitorType").val());
});


</script>




<SCRIPT type="text/javascript">
		<!--
		var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onCheck: onCheck
			}
		};

		var zNodes =[
			{id:4, pId:0, name:"河北省", open:true, nocheck:true},
			{id:41, pId:4, name:"石家庄"},
			{id:42, pId:4, name:"保定"},
			{id:43, pId:4, name:"邯郸"},
			{id:44, pId:4, name:"承德"},
			{id:5, pId:0, name:"广东省", open:true, nocheck:true},
			{id:51, pId:5, name:"广州"},
			{id:52, pId:5, name:"深圳"},
			{id:53, pId:5, name:"东莞"},
			{id:54, pId:5, name:"佛山"},
			{id:6, pId:0, name:"福建省", open:true, nocheck:true},
			{id:61, pId:6, name:"福州"},
			{id:62, pId:6, name:"厦门"},
			{id:63, pId:6, name:"泉州"},
			{id:64, pId:6, name:"三明"}
		 ];

		function beforeClick(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getCheckedNodes(true),
			v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
		}
		
		function loadMenusTree_groupFields(){
			$.ajax({
					url:"<%=request.getContextPath() %>/search?method=menus",
					type:"post",
					dataType:"text",
					success:function(data, textStatus){
						var zNodes = eval('('+data+')');
						
						$.fn.zTree.init($("#treeDemo"), setting, zNodes);
						$("#loadImg").hide();
						$("#treeDemo").show();
// 						$("span").remove(".ico_docu");
					},
					error:function(){
						//alert("加载数据出错！");
						$("#loadSpan").text("加载数据出错！");
					}
			});
		}
		
		//loadMenusTree_groupFields();

		$(document).ready(function(){
			//$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});
		//-->
	</SCRIPT>
	
	
	
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>