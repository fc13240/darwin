<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.MonitorInfo"%>
<%@page import="javax.management.monitor.Monitor"%>
<%@page import="com.stonesun.realTime.services.db.MonitorServices"%>
<%@page import="com.stonesun.realTime.services.db.TriggerServices"%>
<%@page import="com.stonesun.realTime.services.db.TaskGroupServices"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>监控编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_monitor);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="container" style="margin-bottom: 100px;">
		<div class="row">
			<div class="col-md-12">
				<%
					String id = request.getParameter("id");
					UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
					if(StringUtils.isNotBlank(id)){
						MonitorInfo info = MonitorServices.selectById(Integer.valueOf(id),user1.getId());
						
						request.setAttribute("monitor", info);
						/*if(StringUtils.isNotBlank(info.getPid())){
							String[] arr = info.getPid().split(TaskInfo.pid_split);
							request.setAttribute("selectedPidList", arr);
						}*/
					}else{
						request.setAttribute("monitor", new MonitorInfo());
					}
					
					//List<MonitorInfo> monitorList = DataCache.monitorList;//MonitorServices.selectList();
					request.setAttribute("monitorList", DataCache.monitorList);
					/*List<TaskInfo> parentTaskList = TaskServices.selectList();
					
					if(StringUtils.isNotBlank(id) && parentTaskList!=null){
						for(Iterator<TaskInfo> it = parentTaskList.iterator();it.hasNext();){
							if(it.next().getId()==Integer.valueOf(id)){
								it.remove();
								break;
							}
						}
					}
					request.setAttribute("parentTaskList", parentTaskList);*/
				%>
				<form action="<%=request.getContextPath()%>/monitor?method=save" class="form-horizontal" role="form" method="post">
					<input type="hidden" value="${monitor.id }" name="id"/>
					
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>监控名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name" value="${monitor.name}" class="form-control" id="name" name="name" placeholder="监控项名称">
						</div>
					</div>
					<div class="form-group">
						<label for="target" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>监控对象</label>
						<div class="col-sm-5">
							<select data-rule="required;target" id="target" name="target" class="form-control ">
								<option></option>
								<c:forEach items="${monitorList}" var="item">
						           <option <c:if test='${monitor.target == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<a href="javascript:history.go(-1);">返回</a> 
							<input type="submit" value="保存" class="btn btn-primary" />
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>
	
	

<!-- Modal选择数据源 -->
<div class="modal fade" id="dsModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">选择数据源</h4>
			</div>
			<div class="modal-body">
				<!-- 选择数据源 -->
				<%@ include file="/task/selectDs.jsp"%>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="dsModalOk">确定</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal2选择分析 -->
<div class="modal fade" id="anaModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">选择分析</h4>
			</div>
			<div class="modal-body">
				<!-- 选择分析 -->
				<%@ include file="/task/selectAna.jsp"%>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="anaModalOk">确定</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	
	$("#showModelBtn").click(function(){
		var _type = $("#type").val();
		//alert(_type);
		if(_type=="dataSource"){
			$(this).attr("data-target","#dsModal");
		}else if(_type=="analysis"){
			$(this).attr("data-target","#anaModal");
		}else{
			alert("请选择数据源类型！");
			return false;
		}
	});
	
	$("#dsModalOk").click(function(){
		var _radio = $("#dsTableList input:radio:checked").val();
// 		console.log(_radio);
		if(!_radio){
			alert("请选择数据源！");
			return;
		}
		
		$("#selectDsId").val(_radio);
		$("#selectDsText").html("【数据源】id="+_radio+",");
		
		$("#dsModal").modal('hide');
	});
	
	$("#anaModalOk").click(function(){
		var _radio = $("#selectDsId").val();
// 		console.log(_radio);
		if(!_radio){
			alert("请选择分析！");
			return;
		}
		$("#anaModal").modal('hide');
	});
	
	$("#cron").change(function(){
		$("#cronValue").val("");
		$("#cronHtml").html("");
		var selVal = $(this).val();
		createHtml(selVal,null);
	});
	
	//回填cron的数据到页面
	var _cronValue = $("#cronValue").val();
	if(_cronValue!=''){
		var arr = _cronValue.split(" ");
		if(arr[4]!="*"){
			$("#cron").val("week");
		}
		//else if(arr[4]!="*"){
			//$("#cron").val("year");
		//}
		else if(arr[3]!="*"){
			$("#cron").val("month");
		}else if(arr[2]!="*"){
			$("#cron").val("day");
		}else if(arr[1]!="*"){
			$("#cron").val("hour");
		}else if(arr[0]!="*"){
			$("#cron").val("minute");
		}
		var selVal = $("#cron").val();
		//createHtml(selVal,_cronValue);
		//$("#cronHtml").html();
		var cronValue = $("#cronValue").val();
		var arr;
		if(cronValue!=''){
			arr = cronValue.split(" ");
			
			for(var i=0;i<arr.length;i++){
				if(arr[i]=="*"){continue;}
				if(i==0){
					$("#minute").val(arr[i]);
				}else if(i==1){
					$("#hour").val(arr[i]);
				}else if(i==2){
					$("#day").val(arr[i]);
				}else if(i==3){
					$("#month").val(arr[i]);
				}
				//else if(i==4){
					//$("#year").val(arr[i]);
				//}
				else if(i==4){
					$("#week").val(arr[i]);
				}
			}
		}
	}
	
});

function createHtml(selVal,_cronValue){
// 	console.log("createHtml.selVal="+selVal);
	var w = "周<input size=4 id='week' onblur='onblurFunc(this)'/>&nbsp;&nbsp;";
	//var yyyy = "年<input size=4 id='year' onblur='onblurFunc(this)'/>&nbsp;&nbsp;";
	var MM = "月<input size=2 id='month' onblur='onblurFunc(this)'/>&nbsp;&nbsp;";
	var dd = "日<input size=2 id='day' onblur='onblurFunc(this)'/>&nbsp;&nbsp;";
	var HH = "时<input size=2 id='hour' onblur='onblurFunc(this)'/>&nbsp;&nbsp;";
	var mm = "分<input size=2 id='minute' onblur='onblurFunc(this)'/>&nbsp;&nbsp;";
	
	if(selVal=='week'){
		$("#cronHtml").html(w+MM+dd+HH+mm);
	}else if(selVal=='year'){
		$("#cronHtml").html(MM+dd+HH+mm);
	}else if(selVal=='month'){
		$("#cronHtml").html(MM+dd+HH+mm);
	}else if(selVal=='day'){
		$("#cronHtml").html(dd+HH+mm);
	}else if(selVal=='hour'){
		$("#cronHtml").html(HH+mm);
	}else if(selVal=='minute'){
		$("#cronHtml").html(mm);
	}
	
	//htian(selVal,null);
}

function onblurFunc(obj){
	var _id = $(obj).attr("id");
	var selVal = $(obj).val();
	if(selVal==''){selVal = "*";}
	htian(_id,selVal);
	
	$("#_cronHtml").val($("#cronHtml").html());
}

function htian(_id,selVal){
// 	console.log("createHtml.htian="+_id);
	var cronValue = $("#cronValue").val();
	var arr;
	if(cronValue==''){
		arr = [];
// 		console.log(arr.length);
		for(var i=0;i<5;i++){
			arr[i] = "*";
		}
	}else{
		arr = cronValue.split(" ");
	}
	
	if(_id=='week'){
		arr[4] = selVal;
		$("#cronValue").val(convert22(arr));
	}
	//else if(_id=='year'){
		//arr[4] = selVal;
		//$("#cronValue").val(convert22(arr));
	//}
	else if(_id=='month'){
		arr[3] = selVal;
		$("#cronValue").val(convert22(arr));
	}else if(_id=='day'){
		arr[2] = selVal;
		$("#cronValue").val(convert22(arr));
	}else if(_id=='hour'){
		arr[1] = selVal;
		$("#cronValue").val(convert22(arr));
	}else if(_id=='minute'){
		arr[0] = selVal;
		$("#cronValue").val(convert22(arr));
	}
}

// Array convert String
function convert22(arr){
	if(!arr){
		return arr;
	}
	
	var buf = "";
	for(var i=0;i<arr.length;i++){
		buf += arr[i] + " ";
	}
	return buf;
}
</script>


</body>
</html>