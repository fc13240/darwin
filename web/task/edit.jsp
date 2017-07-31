<%@page import="com.stonesun.realTime.services.db.bean.TaskGroupInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.TriggerServices"%>
<%@page import="com.stonesun.realTime.services.db.TaskGroupServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.TaskInfo"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.TaskServices"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>任务编辑</title>
<%@ include file="/resources/common.jsp"%>
<script src="<%=request.getContextPath() %>/resources/js/CronClass.js"></script>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_task);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					任务管理
				</div>
				<div class="page-header-links">
					<a>任务管理</a> / 添加任务
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-12">
				<%
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						TaskInfo param = new TaskInfo();
						param.setId(Integer.valueOf(id));
// 						param.setType(TaskInfo.TaskInfo_type_dataSource);
						TaskInfo info = TaskServices.selectById0(param.getId());
						
						request.setAttribute("task", info);
						if(info!=null && StringUtils.isNotBlank(info.getPid())){
							String[] arr = info.getPid().split(TaskInfo.pid_split);
							request.setAttribute("selectedPidList", arr);
						}
					}else{
						TaskInfo _task = new TaskInfo();
						_task.setCron("* * * * *");
						request.setAttribute("task", _task);
					}
					
					List<TaskGroupInfo> groupList = TaskGroupServices.selectList(1);
					request.setAttribute("groupList", groupList);
					List<TaskInfo> parentTaskList = TaskServices.selectList();
					
					if(StringUtils.isNotBlank(id) && parentTaskList!=null){
						for(Iterator<TaskInfo> it = parentTaskList.iterator();it.hasNext();){
							if(it.next().getId()==Integer.valueOf(id)){
								it.remove();
								break;
							}
						}
					}
					request.setAttribute("parentTaskList", parentTaskList);
				%>
				<form action="<%=request.getContextPath()%>/task?method=save" class="form-horizontal" role="form" method="post">
					<input type="hidden" value="${task.id }" name="id"/>
					<input type="hidden" value="${task.onLine }" name="onLine"/>
<%-- 					<input type="hidden" value="${task.pid }" name="pid"/> --%>
<%-- 					<input type="hidden" value="${task.triggerId }" name="triggerId"/> --%>
					
					<c:if test="${task.onLine eq 'on'}">
						<div class="alert alert-danger alert-dismissible fade in">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
							任务已上线，请先下线才能修改！
						</div>
					</c:if>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">任务类型</label>
						<div class="col-sm-5">
							<select data-rule="required;type" id="type" name="type" class="form-control ">
								<%
									request.setAttribute("taskType", DataCache.taskType);
								%>
								<option></option>
								<c:forEach items="${taskType}" var="item">
						           <option <c:if test='${task.type == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								数据源任务用于将数据周期性或实时的获取到Darwin平台中来；分析任务用于周期性调度分析以获得分析结果。
							</p>
						</div>
					</div>
					<!--  -->
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"></label>
						<div class="col-sm-1">
							<button type="button" class="btn btn-info " data-toggle="modal" data-target="#myModal2" id="showModelBtn">
							  选择数据源
							</button>
						</div>
						<div class="col-sm-5">
							<input data-rule="数据源:required;selectDsId" id="selectDsId" name="selectDsId" class="form-control" readonly="readonly" type="hidden" value="${task.dsId}"/>
							<span style="padding:0 0 20px 20px;font-size: 18px;vertical-align: middle;" id="selectDsText">${task.selectDsText}</span>
<%-- 							<div class="alert alert-info">${task.selectDsText}</div> --%>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">任务分组</label>
						<div class="col-sm-5">
							<select data-rule="required;groupId" id="groupId" name="groupId" class="form-control ">
								<option></option>
								<c:forEach items="${groupList}" var="item">
						           <option <c:if test='${task.groupId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
						        </c:forEach>
							</select>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								便于管理任务，如需编辑分组点击<a href="<%=request.getContextPath()%>/user/taskGroup?method=index" target="_blank">这里</a>。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">任务名称</label>
						<div class="col-sm-5">
							<input data-rule="required;nickname;length[1~45];" value="${task.name}" class="form-control" id="name" name="name" placeholder="任务名称">
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-sm-2 control-label">任务描述</label>
						<div class="col-sm-5">
							<input value="${task.remark}" class="form-control" id="remark" name="remark" placeholder="任务描述">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">依赖父任务</label>
						<div class="col-sm-5">
							<select multiple size="10" id="pid" name="pid" class="form-control ">
								<c:forEach items="${parentTaskList}" var="item">
									<c:set var="notFind" value="true" />
									<c:set var="flag" value="true" />
									<c:forEach items="${selectedPidList}" var="selectItem">
										<c:if test="${flag}">
											<c:if test='${selectItem == item.id}'>
												<c:set var="flag" value="false"/>
												<c:set var="notFind" value="false" />
									            <option <c:if test='${selectItem == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
											</c:if>
										</c:if>
									</c:forEach>
									
									<c:if test="${notFind}">
										<option <c:if test='${selectItem == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
									</c:if>
						        </c:forEach>
							</select>
							<div style="color: red;">【提示】按住Ctrl或Shift可以用鼠标选中多个依赖的父任务。</div>
							<a href="<%=request.getContextPath()%>/task?method=clearPid" id="clearPid" class="btn btn-default btn-sm">清除已选中的依赖任务</a>
						</div>
					</div>
					<div class="form-group" style="display: none;">
						<label for="scheduled" class="col-sm-2 control-label">执行参数</label>
						<div class="col-sm-5">
							<input  value="${task.scheduled}" class="form-control" id="scheduled" name="scheduled" placeholder="执行参数">
							<div>可以使用@{yyyymmddhhii +/-xymdhi}表示当前时间之前年/月/日/小时/分钟</div>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">优先级</label>
						<div class="col-sm-5">
							<select data-rule="required;priority" id="priority" name="priority" class="form-control ">
								<%
									request.setAttribute("taskPriority", DataCache.taskPriority);
								%>
								<option></option>
								<c:forEach items="${taskPriority}" var="item">
						           <option <c:if test='${task.priority == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								优先级越高，任务便可尽快获得需要的计算资源。
							</p>
						</div>
					</div>
					<c:if test="${false}">
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">触发告警</label>
							<div class="col-sm-5">
								<select data-rule="required;triggerId" id="triggerId" name="triggerId" class="form-control ">
									<%
										request.setAttribute("triggerList", TriggerServices.selectList());
									%>
									<option></option>
									<c:forEach items="${triggerList}" var="item">
							           <option <c:if test='${task.triggerId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
							        </c:forEach>
								</select>
							</div>
						</div>
					</c:if>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">调度周期</label>
						<div class="col-sm-5">
							<select id="periodType" name="periodType" class="form-control ">
								<%
									request.setAttribute("cronList", DataCache.cronList);
								%>
								<option></option>
								<c:forEach items="${cronList}" var="item">
						           <option <c:if test='${task.periodType == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
							<div id="cronHtml" style="margin: 10px;"></div>
							<div style="display: none;">cron:<input name="cronValue" id="cronValue" type="text" value="${task.cron}" readonly="readonly"/></div>
							<input id="_periodType" value="${task.periodType}"/>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								类似crontab方式，如果设置为周期性的调度，则按照crontab的方式填写调度的周期即可。
							</p>
						</div>
					</div>
					<div class="form-group" id="crontabGroupInput">
						<div id="crontabGroupInputLable">
							<label for="crontabGroupInput" class="col-sm-2 control-label"></label>
						</div>
						<div id="weekDiv">
							<div class="col-sm-1">
								<div class="input-group input-group-sm">
									<input id='week' data-rule='required;week' style="width: 60px;" type="text" class="form-control" placeholder="周" aria-describedby="sizing-addon2" maxlength="4">
									<span class="input-group-addon" id="sizing-addon2">周</span>
								</div>
							</div>
						</div>
						<div id="monthDiv">
							<div class="col-sm-1">
								<div class="input-group input-group-sm">
									<input id='month' data-rule='required;month' style="width: 60px;" type="text" class="form-control" placeholder="月" aria-describedby="sizing-addon2" maxlength="4">
									<span class="input-group-addon" id="sizing-addon2">月</span>
								</div>
							</div>
						</div>
						<div id="dayDiv">
							<div class="col-sm-1">
								<div class="input-group input-group-sm">
									<input id='day' data-rule='required;day;' style="width: 60px;" type="text" class="form-control" placeholder="日" aria-describedby="sizing-addon2" maxlength="4">
									<span class="input-group-addon" id="sizing-addon2">日</span>
								</div>
							</div>
						</div>
						<div id="hourDiv">
							<div class="col-sm-1">
								<div class="input-group input-group-sm">
									<input id='hour' data-rule='required;hour' style="width: 60px;" type="text" class="form-control" placeholder="时" aria-describedby="sizing-addon2" maxlength="4">
									<span class="input-group-addon" id="sizing-addon2">时</span>
								</div>
							</div>
						</div>
						<div id="minuteDiv">
							<div class="col-sm-1">
								<div class="input-group input-group-sm">
									<input id='minute' data-rule='required;minute' style="width: 60px;" type="text" class="form-control" placeholder="分" aria-describedby="sizing-addon2" maxlength="4">
									<span class="input-group-addon" id="sizing-addon2">分</span>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<a href="javascript:history.go(-1);">返回</a> 
							<c:choose>
								<c:when test="${task.onLine eq 'on'}">
									<input type="submit" value="保存" class="btn btn-primary disabled"/>
								</c:when>
								<c:otherwise>
									<input type="submit" value="保存" class="btn btn-primary" />
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${task.onLine eq 'on'}">
									<a href="<%=request.getContextPath() %>/task?method=changeStatus&id=${task.id}&status=running">立即执行</a>
								</c:when>
								<c:when test="${task.status eq 'running'}">
									<a href="<%=request.getContextPath() %>/task?method=changeStatus&id=${task.id}&status=stoped">终止</a>
								</c:when>
							</c:choose>
							
							<c:if test="${not empty task.period}">
								<a href="task/history.jsp?id=${task.id}">执行历史</a>
							</c:if>
							
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>
	
	

<!-- Modal选择数据源 -->
<div class="modal fade" id="dsModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
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
<%@ include file="/resources/common_footer.jsp"%>
<script type="text/javascript">
$(function(){
	
	$("#clearPid").click(function(){
		var $options = $('#pid option');//获取当前选中的项
		$options.each(function(){
			$(this).attr("selected",null);//删除下拉列表中选中的项
		});
		//var $remove = $options.attr("selected","");//删除下拉列表中选中的项
		return false;
	});
	
	$("#showModelBtn").click(function(){
		var _type = $("#type").val();
		if(_type=="dataSource"){
			$(this).attr("data-target","#dsModal");
		}else if(_type=="analysis"){
			$(this).attr("data-target","#anaModal");
		}else{
			alert("请选择任务类型！");
			return false;
		}
	});
	
	$("#dsModalOk").click(function(){
		var _dsId = $("#dsTableList input:radio:checked").val();
		var _dsName = $("#dsTableList input:radio:checked").attr("dsName");
		if(!_dsId){
			alert("请选择数据源！");
			return;
		}
		
		$("#selectDsId").val(_dsId);
		$("#selectDsText").html("【数据源】"+_dsName + "<a target='_blank' href='<%=request.getContextPath() %>/datasources/conn.jsp?method=edit&id="+_dsId+"'>查看</a>");
		
		$("#dsModal").modal('hide');
	});
	
	$("#anaModalOk").click(function(){
		var _radio = $("#selectDsId").val();
		console.log(_radio);
		if(!_radio){
			alert("请选择分析！");
			return;
		}
		$("#anaModal").modal('hide');
	});
	
	var cron = new CronClass();
	cron.init();
});
</script>


</body>
</html>