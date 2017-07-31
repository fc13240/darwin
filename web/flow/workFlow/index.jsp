<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="org.apache.hadoop.yarn.webapp.hamlet.HamletSpec.Flow"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.FlowServices"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="com.stonesun.realTime.services.db.FlowStatusServices"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- <%@ include file="/resources/common.jsp"%> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/crontab/cron/jquery-cron.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/crontab/gentleSelect/jquery-gentleSelect.js"></script>
<link type="text/css"  href="<%=request.getContextPath() %>/resources/crontab/gentleSelect/jquery-gentleSelect.css" rel="stylesheet" />
<link type="text/css"  href="<%=request.getContextPath() %>/resources/crontab/cron/jquery-cron.css" rel="stylesheet" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/flow/workFlow/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/flow/workFlow/vendor/sco/sco.message.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/flow/workFlow/vendor/popupsmallmenu/css/jquery.popupSmallMenu.css">
<script type='text/javascript' data-main='<%=request.getContextPath() %>/flow/workFlow/app/components/require.config.js' src='<%=request.getContextPath() %>/flow/workFlow/vendor/require/require.js'></script>

<script type="text/javascript">
    function update(data) {
		angular.element('#wrap').scope().update(data);
	}

	function save (){
		angular.element('#wrap').scope().save();
	}

	function check(){
		//判断流程是否已经保存
		var flowid = $('#flowId').val();
		angular.element('#wrap').scope().check(flowid);
	}
	function unCheck(){
		//判断流程是否已经保存
		var flowid = $('#flowId').val();
		angular.element('#wrap').scope().unCheck(flowid);
	}

</script>

<%
	String id = request.getParameter("id");
	request.setAttribute("id", id);
	String displayStatus="0";
	String shared="n";
// 	System.out.println("info=111");
	boolean periodStatus= false; // 周期状态
	String readStatus= "";
	if(StringUtils.isNotBlank(id)){
		FlowInfo info =  FlowServices.selectByIdToJsp(Integer.valueOf(id));
// 		System.out.println("info=112");
		
		if(info==null){
			throw new ServletException("根据id = " + id + ",查询不到流程！");
		}
		
		if(info!=null && ("offline".equals(info.getStatus()) || "stoped".equals(info.getStatus()))){
			displayStatus="1";
		}
		request.setAttribute("flow", info);
		request.setAttribute("displayStatus", displayStatus);
		shared = info.getShared();
		String displayBut = "true";
		if( "offline".equals(info.getStatus())){
			displayBut = "none";
			request.setAttribute("displayBut", displayBut);
		}
		
		if("online".equals(info.getStatus()) || StringUtils.isNotBlank(id)){
			readStatus = "disabled='disabled'";
		}
		//判断流程日志里面的once周期是否执行完成
		String periodType = info.getPeriodType();
		String cron = info.getCron();
		boolean flowStatus= false;
		
		if(StringUtils.isBlank(periodType) && StringUtils.isBlank(cron)){
			flowStatus = FlowStatusServices.getOncePeriodStatus(id);
			periodStatus=true; // shoudong
		}else if("second".equals(periodType)){
			periodStatus=true; // 短周期
		}else if("rt".equals(periodType)){
			periodStatus=true; // 实时
		}
		request.setAttribute("flowStatus", flowStatus);
// 		System.out.println("info="+info);
	}else{
		periodStatus= true; // 周期状态
	}
	request.setAttribute("periodStatus", periodStatus);
	request.setAttribute("readStatus", readStatus);
	request.setAttribute("shared", shared);
%>

<div id="darwin-flow-status">
<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
<div class="row">
	<div class="col-md-9">
<%-- 		flow.status=${flow.status} --%>
		<c:if test="${flow.isTemplate eq '00000'}">
			<span  class="label label-info">流程内未添加任何组件，请添加组件。</span><br>
		</c:if>
		<c:choose>
			<c:when test="${flow.isTemplate eq 'y'}">
				<span class="label label-default">此为流程模板！</span>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${flow.status eq 'online' or flow.status eq 'running'}">
						<span id="txt" class="label label-success">已部署</span>
						<span id="nodeInfo">(${flow.nodeInfo})</span>
						<a  code="save" class="label label-darwin" href="#" class="darwin-mask" status="offline" id="installFlow">取消部署</a>
					</c:when>
					<c:otherwise>
						<span id="txt" class="label label-default">未部署</span>
						<span id="nodeInfo"></span>
						<a  code="save" class="label label-darwin" href="#" class="darwin-mask" status="online" id="installFlow">部署</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${not empty flow.config}">
					<c:choose>
		<%-- 				<c:when test="${flow.status eq 'online' and statusIndex  eq 'running'}"> --%>
						<c:when test="${flow.status eq 'online' and flow.runStatus eq 'running' and flowStatus}">
							<a class="label label-darwin" href="#" status="kill" id="runOrStopFlow" style="display:none">停止</a>
							<div id='statusDiv'></div>
						</c:when>
						<c:otherwise>
							<a class="label label-darwin1" id="runOrStopFlow1" style="display:none">执行</a>
							<a class="label label-darwin" href="#" status="run" id="runOrStopFlow" style="display:none">执行</a>
							<div id='statusDiv'></div>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		<input  code="save" id="allCheck" type="button" onclick="check();" value="全部选中" class="btn  btn-xs btn-primary" />	
		<input  code="save" id="allUnCheck" type="button" onclick="unCheck();" value="全部取消" class="btn  btn-xs btn-primary" style="margin-left:10px;" />	
	</div>
	<div class="col-md-3" style="display:none">
		<div class=" r">
			<select id="period" name="period" style="">
				<%
					session.setAttribute("periodList", FlowStatusServices.selectPeriods(id));
				%>
				<option value="">--选择周期--</option>
				<c:forEach items="${periodList}" var="list">
		           <option value="${list.period}">${list.period}</option>
		        </c:forEach>
			</select>
		</div>
	</div>
</div>
</div>

<%
	List<com.stonesun.realTime.services.core.KeyValue> cronList = DataCache.cronList;
	StringBuilder _buff = new StringBuilder();
	for(int i=0;i<cronList.size();i++){
		com.stonesun.realTime.services.core.KeyValue item = cronList.get(i);
		_buff.append(item.getKey()+","+item.getValue()).append(";");
	}
%>
<div id="_div_cronList" style="display: none;"><%=_buff.toString() %></div>
<%-- <form action="<%=request.getContextPath() %>/flow?method=save" method="post" class="form-horizontal darwin-flow-form" role="form" style="width:<c:choose><c:when test="${param.id > 0 }">100%</c:when><c:otherwise>80%</c:otherwise></c:choose>;"> --%>

<form action="<%=request.getContextPath() %>/flow?method=save" method="post" 
	data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" 
	class="form-horizontal darwin-flow-form" role="form" style="width:100%;"  accept-charset="utf-8" onsubmit="document.charset='utf-8'" >
	
	<input id="flowId" name="flowId" value="${param.id}" type="hidden"/>
	<input id="displayStatus" name="displayStatus" value="${displayStatus}" type="hidden"/>
	<input id="readStatus" name="readStatus" value="${readStatus}" type="hidden"/>
	<input id="periodStatus" name="periodStatus" value="${periodStatus}" type="hidden"/>
	<%request.setAttribute("topId", "41");%>
	<div id="config" name="config" style="display: none;">${flow.config}</div>
	<input id="flow_disabled" name="flow_disabled" <c:if test="${displayStatus eq '1'}">value="false"</c:if> value="true" type="hidden" />
	<input id="type" name="type" value="1" type="hidden"/>
	<input id="saveFlag" name="saveFlag" value="ok" type="hidden"/>
	<div class="container">
		<div class="row">
			<div class="col-xs-5 col-md-5">
				<div class="form-group">
					<label for="name" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>流程名称</label>
					<div class="col-sm-8">
						<input ${readStatus } data-rule="名称:required;length[1~45];remote[/flow?method=exist&id=${id}&isTemplate=${flow.isTemplate}]" id="flowName" name="name" value="${flow.name}" class="form-control" placeholder="请输入流程名称"/>
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>选择项目</label>
					<div class="col-sm-8">
						<select ${readStatus } data-rule="项目:required;" id="projectId" name="projectId" class="form-control">
							<%
								int uid =((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId();
								session.setAttribute(Container.session_projectList, ProjectServices.selectList(uid));
							%>
							<option value="">--选择项目--</option>
							<c:forEach items="${sessionScope.session_projectList}" var="list">
					           <option <c:if test='${flow.projectId == list.id}'>selected="selected"</c:if> value="${list.id}">${list.name}</option>
					        </c:forEach>
					        <option value="0">--添加新项目--</option>
						</select>
					</div>
				</div>
			</div>
			<div class="col-xs-5 col-md-5">
				<div class="form-group">
					<label for="nodeId" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>部署节点</label>
					<div class="col-sm-8">
<%-- 						flow.nodeId = ${flow} --%>
<%-- 						<select ${readStatus } data-rule="required;nodeId" id="nodeId" name="nodeId" class="form-control"> --%>
						<select ${readStatus } data-rule="required;nodeId" id="nodeId" name="nodeId" class="form-control">
							<%
								String orgId =((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getOrgId();
								List<NodeInfo> nodesList= NodeServices.selectListByOrgId(NodeInfo.node_type_node,orgId);
								request.setAttribute("nodesize", nodesList.size());
								request.setAttribute("nodes", nodesList);
							%>
							<c:if test="${nodesize >0 }">
								<c:forEach items="${nodes}" var="item">
						           <option <c:if test='${flow.nodeId eq item.id}'>selected="selected"</c:if>value="${item.id}">${item.statusWhenSelectOption} ${item.name}(${item.ip}:${item.port})</option>
						        </c:forEach>
					        </c:if>
					        <c:if test="${nodesize <= 0 }">
								<option value="">没有分配资源池</option>
					        </c:if>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="periodType"  class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>调度周期</label>
					<div class="col-sm-8" id="cronDiv">
						<select class="form-control" id="periodType" name="periodType">
							<option <c:if test='${empty flow.periodType}'>selected="selected"</c:if> value="">手动</option>
							<option <c:if test='${flow.periodType eq "second"}'>selected="selected"</c:if> value="second">短周期</option>
							<option <c:if test='${flow.periodType eq "rt"}'>selected="selected"</c:if> value="rt">实时</option>
							<option <c:if test='${not empty flow.periodType && flow.periodType != "rt" && flow.periodType != "second" && flow.periodType != "dict"}'>selected="selected"</c:if> value="crontab">定时任务</option>
							<option <c:if test='${flow.periodType eq "dict"}'>selected="selected"</c:if> value="dict">排期表</option>
						</select>

					</div>
				</div>
		    		
			</div>
			<div class="col-xs-2 col-md-2">
				<c:if test="${shared eq 'n' }">
					<div class="form-group">
						<c:choose>
							<c:when test="${flow.status eq 'online' or flow.status eq 'running'}">
								<input  code="save" id="saveButton" onclick="confirmOnline();" type="button" value="编辑" class="btn btn-primary"/>
								<input  code="save" id="submitButton" type="submit" value="保存" class="btn btn-primary" style="display:none;"/>
							</c:when>
							<c:when test="${empty id}">
								<input code="save" id="saveButton" onclick="" type="button" value="编辑" class="btn btn-default"/>
								<input code="save" id="submitButton" type="submit" value="保存" class="btn btn-primary"/>
							</c:when>
							<c:otherwise>
								<input  code="save" id="saveButton" type="button" onclick="edit();" value="编辑" class="btn btn-primary"/>
								<input  code="save" id="submitButton" type="submit" value="保存" class="btn btn-primary" style="display:none;"/>
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>
				<div class="form-group">
					<c:choose>
						<c:when test="${flow.isTemplate eq 'y'}">
							<input  code="save" type="button" value="使用此模板" class="btn btn-info" id="useThisTemplate"/>
						</c:when>
						<c:otherwise>
							<input  code="save" type="button" value="另存为模板" class="btn btn-default" id="saveToTemplate"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-3 col-md-3">
				<div class="form-group" id="relyMySelfDiv" <c:if test="${periodStatus }">style="display:none;"</c:if>>
					<label for="name" class="col-sm-6 control-label">自依赖</label>
					<div class="col-sm-6 checkbox">
					    <label>
					    	<c:choose>
					    		<c:when test="${not empty flow.relyMySelf and flow.relyMySelf eq 'y'}">
									<input code="save" type="checkbox" id="relyMySelf" name="relyMySelf" checked="checked" value="y"/>
							      	<input code="save" data-rule="required;integer; range[1~30]" id="cronMaxThreads" name="cronMaxThreads" value="${flow.cronMaxThreads}" class="form-control" placeholder="流程周期最大线程数" size="10" maxlength="4"/>
					    		</c:when>
					    		<c:otherwise>
									<input code="save" type="checkbox" id="relyMySelf" name="relyMySelf" value="n"/>
							      	<input code="save" style="display: none;" id="cronMaxThreads" name="cronMaxThreads" value="${flow.cronMaxThreads}" class="form-control" placeholder="流程周期最大线程数" size="10" maxlength="4"/>
					    		</c:otherwise>
					    	</c:choose>
					    </label>
					</div>
				</div>
			</div>
			<div class="col-xs-9 col-md-9" >
			    <div class="row" id="dict" style="display:none;" >
			    	<label class="col-xs-5 col-md-5"></label>
			    	<div class="col-xs-7 col-md-7">
						<input style="width:205px;" class="form-control" placeholder="例:/home/yimr/paiqi.csv" id="crondict" name="crondict" value="${flow.cron}"  type="text">
						<a id="showDict" title="查看排期表" ><span class="glyphicon glyphicon-list-alt"></span></a>
						<a target="_blank" id="view-hdfspath" title="查看排期表所在hdfs路径" ><span class="glyphicon glyphicon-folder-open"></span></a>
						<div class="glyphicon glyphicon-question-sign propmt" data-content="请输入hdfs上的某个文件全路径作为排期表，支持排期格式有两种:如①：2015-09-06 10:00:00，20150902_000000两列，前者为调度时间，后者为获取数据的周期；如②：2015-09-06 10:00:00一列，按照调度时间获取当前周期。支持任意分隔符。" data-toggle="tooltip" data-original-title="" title=""></div>
					</div>
			    </div>
				<div class="row">
					<div id="mei" class="col-xs-1 col-md-1" style="margin-top:10px;margin-right:-40px;display:none">每</div>
					<div class="col-xs-1 col-md-1" id="digital_div"  style="display:none;">
						<input id="digital" name="digital" value="${flow.digital}"  class="gentleselect-label" style="height:27px;width:50px;margin-top:6px;" type="text" data-rule="" >
				    </div>
				    <div class="col-xs-9 col-md-9" id="crontabGroupInput" style="margin-top:10px;">	
				    </div>
				</div>

				<input id="crontab" name="cron" value="${flow.cron}" type="text" style="display:none">
				<input id="crontabType" name="crontabType" value="" type="text" style="display:none" >
				<input id="bushuStatus" value="${flow.status}" style="display:none">

			</div>	
		</div>
	</div>
</form>

<div class="panel panel-default">
	<div id ="wrap" ng-controller="graphpaperCtrl" class="darwin-flow-wrap" style="min-height: 800px;">
		<div style="text-align: center; height: 10px; position: absolute; margin-top: 30%; margin-left: 45%;">
			<img src="<%=request.getContextPath() %>/flow/workFlow/img/loading.gif">
		</div>
	</div>
	<context-menu></context-menu>
</div>
<c:if test="${not empty id}">
<div id="console-switch-wrap1">
		<img title="点此显示日志" src="<%=request.getContextPath() %>/resources/images/hint.png"><br>
</div>
<div id="console-switch-wrap">
	<a id="console-switch">
		<img title="点此显示日志" src="<%=request.getContextPath() %>/resources/images/showLog.png"><br>
	</a>
</div>
</c:if>
<div id="schedule" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-m">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>查看排期表</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="scheduleform" notBindDefaultEvent="true">
				<div id="scheduleTitle"></div>
				<div id="scheduleDiv"></div>
			</form>
	  </div>
    </div>
  </div>
</div>
<script src="<%=request.getContextPath() %>/resources/js/CronClass.js"></script>
<script src="<%=request.getContextPath() %>/resources/layer/extend/layer.ext.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.blockUI.js"></script> --%>

<script>
//输入框说明
$(".propmt").popover({
	trigger:'hover',
	placement:'bottom',
	html: true
});
$(function(){
	
	var initCron = "";
	var crontab=$("#crontab").val();
	var periodType=$("#periodType").val();
	if(crontab=='' || (periodType=="" || periodType=="rt" || periodType=="second" || periodType=="dict")){
		initCron="* * * * *";
	}else if (crontab.indexOf("/")===-1) {
		initCron=crontab;
	}
	var cron_field=$('#crontabGroupInput').cron({
			initial: initCron,
	        onChange: function() {
              $('#crontab').val($(this).cron("value"));

              makeWeek($(this).cron("value"));
              getTag();
			},
			useGentleSelect: true,
	    	effectOpts: {
		        openEffect: "fade",
		        openSpeed: "slow"
	    	}
        }); 

	$('#crontabGroupInput').gentleSelect("setDisabled");
	$("#digital").attr("disabled","disabled");
	var periodType=$("#periodType").val();
	var crontab_type=$("select[name='cron-period']").val()

	//初始化页面时判断是否显示crontab
	if (periodType!="" && periodType!="rt" && periodType!="second" && periodType!="dict") {
		if (!isNaN($("#digital").val())) {

		}else{
			$("#digital").val("");
		};
		$("#crontabGroupInput").show();
		$("#mei").show();
		if (crontab_type=="hour") {
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~23]");
			$("#digital_div").show();
		}else if(crontab_type=="minute"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~59]");
			$("#digital_div").show();
		}else if(crontab_type=="day"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~31]");
			$("#digital_div").show();
		}else if(crontab_type=="week"){
			makeWeek1();
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~4]");
			$("#digital_div").show();
		}else if(crontab_type=="month"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~12]");
			$("#digital_div").show();
		}else{
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","");
			$('form').validator('hideMsg', '#digital');
			$("#digital_div").hide();
		};
	}else if(periodType=="dict"){
		$("#dict").show();
		$("#crondict").attr("disabled","disabled");
		$("#crondict").attr("data-rule","required;remote[/flow?method=checkDict]");
		$("#crontabGroupInput").hide();
		$("#digital_div").hide();
		$("#mei").hide();
		
	}else{
		$("#crontabGroupInput").hide();
		$("#digital_div").hide();
		$("#relyMySelfDiv").hide();
		$("#mei").hide();
		$("#dict").hide();
	};

	$("#digital").change(function(){
    	makeWeek1();
    }) 

	function makeWeek1(){
		if ($("#digital").val()!=""&&$("#digital").val()!=null) {
    		$(".cron-block-dow").attr("style","display:none");
    	}else{
    		$(".cron-block-dow").removeAttr("style");
    	};
	}
	//特殊处理周
	function makeWeek(value){
		var d = value.split(" ");
              if (d[4].indexOf(",")>=0) {
              	$("#digital").attr("disabled","disabled");
              }else{
              	$("#digital").removeAttr("disabled");          	
        };
	}
	
	//给隐藏的输入框赋值
	function getTag(){
		var crontab_type2=$("select[name='cron-period']").val()
        $("#crontabType").val(crontab_type2)

// 		$('form').validator( "destroy" );
		if (crontab_type2=="hour") {
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~23]");
			$("#digital_div").show();
		}else if(crontab_type2=="minute"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~59]");
			$("#digital_div").show();
		}else if(crontab_type2=="day"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~31]");
			$("#digital_div").show();
		}else if(crontab_type2=="week"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~4]");
			$("#digital_div").show();
		}else if(crontab_type2=="month"){
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","range[1~12]");
			$("#digital_div").show();
		}else{
// 			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","");
			$('form').validator('hideMsg', '#digital');
			$("#digital_div").hide();
		};
    }

	$("#periodType").change(function(){
	 	//crontab
		 if ($(this).val()!=""&& $(this).val()!="rt" && $(this).val()!="second" && $(this).val()!="dict") {
			$("#dict").hide();
			$("#crondict").attr("data-rule","");
			$('form').validator('hideMsg', '#crondict');
			
		 	$("#crontabGroupInput").show();
	        $("#relyMySelfDiv").show();
	        $("#digital_div").show();
	        $("#mei").show();
	        $("#crontabType").val(crontab_type);
			$("#crondict").val("0");

			$("#digital").removeAttr("disabled");
			$('#crontabGroupInput').gentleSelect("setAbled");
			$("#saveButton").attr("onclick","");
			$("#saveButton").attr("class","btn btn-default");
			$("#submitButton").attr("style","");
			$("#flowName").attr("disabled",false);
			$("#projectId").attr("disabled",false);
			$("#relyMySelf").attr("disabled",false);
			$("#cronMaxThreads").attr("disabled",false);
			$("#nodeId").attr("disabled",false);
			$("#periodType").attr("disabled",false);
			$("#week").attr("disabled",false);
			$("#month").attr("disabled",false);
			$("#day").attr("disabled",false);
			$("#hour").attr("disabled",false);
			$("#minute").attr("disabled",false);
			$("#crondict").attr("disabled",false);
			$("#saveFlag").val("ng");
			
		 }else if($(this).val()=="dict"){
			$('form').validator( "destroy" );
			$("#digital").attr("data-rule","");
			$('form').validator('hideMsg', '#digital');

			$("#crondict").attr("data-rule","required;remote[/flow?method=checkDict]");
			$("#crontabGroupInput").hide();
			$("#digital_div").hide();
			$("#relyMySelfDiv").hide();
			$("#mei").hide();
	        $("#relyMySelfDiv").show();
	        $("#dict").show();
	        $("#crondict").val("");
		 }else{
			$("#dict").hide();
		 	$('form').validator( "destroy" );
			$("#digital").attr("data-rule","");
			$('form').validator('hideMsg', '#digital');
			$("#crondict").attr("data-rule","");
			$('form').validator('hideMsg', '#crondict');
		 	$("#crontabType").val($(this).val());
		 	$("#digital_div").hide();
			$("#crontabGroupInput").hide();
			$("#relyMySelfDiv").hide();
			$("#relyMySelf").prop("checked",false);
			$("#relyMySelf").attr("value","n");
			$("#cronMaxThreads").removeAttr("data-rule");		
			$("#cronMaxThreads").attr("data-rule","");		
			$("#cronMaxThreads").hide();
			$("#cronMaxThreads").blur();
			$("#mei").hide();
			$("#crondict").val("0");
	
		 };

	});

	$('#view-hdfspath').click(function(){
		var crondict = $('#crondict').val();
		if (crondict !='') {
			var crondictUses = crondict.split("/");
			var crondictUse = "";
			for(var i=0;i<crondictUses.length-1;i++){
				if(crondictUses[i]!=''){
					crondictUse = crondictUse+"/"+crondictUses[i];
				}
			}
			console.log("crondictUse==="+crondictUse);
			window.open("/configure/hdfsManage.jsp?dictPath="+crondictUse);
		}else{
			window.open("/configure/hdfsManage.jsp");
		}
	});
	
	$('#showDict').click(function(){
		var crondict = $('#crondict').val();
		$('#schedule').modal('show');
		if (crondict !='') {
			$.ajax({
				url:'<%=request.getContextPath() %>/flow?method=showDict&crondict='+crondict,
				type:"post",
				dataType:"json",
				async:true,
				success:function(data, textStatus){
// 	 				console.log(">>>data = "+data);
// 	 				var _d = eval('('+data+')');
					var crondictUses = crondict.split("/");
					var crondictUse = "";
					for(var i=0;i<crondictUses.length-1;i++){
						if(crondictUses[i]!=''){
							crondictUse = crondictUse+"/"+crondictUses[i];
						}
					}
					var url = "/configure/hdfsManage.jsp?dictPath="+crondictUse;
					if(data==''){
						var titlehtml ="当前有0个排期。"+"<a target='_blank' href='"+url+"'>查看hdfs目录</a><br>"; 
						$("#scheduleTitle").html(titlehtml);
					}else{
						var _html="<table class='table table-bordered table-hover' id='ruleTable' >";
						_html += "<tr class='success'>";
						_html += "<td>序号</td>";
						_html += "<td>调度排期</td>";
						_html += "<td>获取数据周期</td>";
						_html += "</tr>";
						var n=0;
						$.each(data,function(index,item){
							n++;
							console.log(">>>data = "+item.time);
							_html += "<tr>";
							_html += "<td style='text-align:center;'>"+n+"</td>";
							_html += "<td>"+item.time+"</td>";
							_html += "<td>"+item.period+"</td>";
							_html +="</tr>";
						});
						_html += "</table>";
						$("#scheduleDiv").html(_html);
						var total=data[0].total;
						var count=data[0].count;
						var titlehtml ="当前显示最近"+count+"个调度排期，一共"+total+"个排期。"+"<a target='_blank' href='"+url+"'>查看更多排期</a><br>"; 
						$("#scheduleTitle").html(titlehtml);
					}
					
					common['$'].unblockUI();
				},
				error:function(err){
					console.log("加载数据出错！");
					common['$'].unblockUI();
				}
			});
		}else{
			var titlehtml ="当前有0个排期。"+"<a target='_blank' href='/configure/hdfsManage.jsp'>查看hdfs目录</a><br>"; 
			$("#scheduleTitle").html(titlehtml);
		}
	});
	
	$("#runOrStopFlow").click(function(){
		var _text1 = "";
		
		var _displayStatus = $("#displayStatus").val();
		
		if(_displayStatus == "1"){
			_text1 = "操作失败，请先部署！";
		}else {
			_text1 = "";
		}
		//if(_text1 != ""){
		if(false){
			layer.tips(_text1, '#runOrStopFlow', {
			    tips: [1, '#3595CC'],
			    time: 2000
			});
		}else{
		
		$("div[type='iframe']").remove();
		createMark();
		var _flowId = $("#flowId").val();
		var _status = $(this).attr("status");
		var _url = '<%=request.getContextPath() %>/flow?method='+_status+'&id='+_flowId+'&ajaxReq=true';
		var _flowLogger = '<%=request.getContextPath() %>/flowStatus?method=history2&flowId='+_flowId+'';
		
		$.ajax({
			url:_url,
			type:"post",
			dataType:"text",
			async:true,
			success:function(data, textStatus){
// 				console.log(">>>data = "+data);
				common['$'].unblockUI();
				if(data == "0"){
					
					if(_status=='kill'){
						$("#runOrStopFlow").attr("status","run");
						$("#runOrStopFlow").html("执行");
					}else{
						$("#runOrStopFlow").attr("status","kill");
						$("#runOrStopFlow").html("停止");
					}
					
					layer.open({
				        type: 2,
				        title: [
				                '流程日志',
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
				        content:_flowLogger,
						shift: 2, //从上动画弹出
						min : function(){
							$('.layui-layer-min').click(function(){
								$("#layui-layer3").remove();
								$("#xubox_layer1").remove();
								$("div[type='iframe']").remove();
								$('#console-switch-wrap').show();
						    });
						}
					});
				}else {
					
					layer.tips('执行流程失败！', '#runOrStopFlow', {
					    tips: [1, '#3595CC'],
					    time: 2000
					});
					
				}
				
			},
			error:function(err){
				console.log("加载数据出错！");
				common['$'].unblockUI();
				
				layer.tips('执行流程出现异常！' + err, '#runOrStopFlow', {
				    tips: [1, '#3595CC'],
				    time: 2000
				});
				
			}
		});
		return false;
		}
	});
	
	
	$("#installFlow").click(function(){

		if($("#content input:checked").length==0){
			alert("当前流程没有任何要运行的组件！");
			return;
		}
		
		var saveFlag = $("#saveFlag").val();
		if(saveFlag=='ng'){
			layer.tips("请先保存流程再部署！", '#installFlow', {
				tips: [3, '#3595CC'],
				time: 3000
			});
			return;
		}

		$("div[type='iframe']").remove();
		createMark();
		var _flowId = $("#flowId").val();
		var _status = $(this).attr("status");
		var _flowLogger = '<%=request.getContextPath() %>/flowStatus?method=history2&flowId='+_flowId+'';
		var _url = '<%=request.getContextPath() %>/flow?method=sendFlow&id='+_flowId+'&status='+_status+'&ajaxReq=true';
		$.ajax({
			url:_url,
			type:"post",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
				common['$'].unblockUI();
				var _text = "";
				var _respStatus = data.status;
				if(_respStatus == "node_running_success"){
					_text = "操作成功！";
					// 将crontab设置成不可编辑的状态
					if(_status=='offline'){
						$("#flow_disabled").val("false");
						$("#installFlow").attr("status","online");
						$("#installFlow").html("部署");
						$("#txt").removeClass("label-success").addClass("label-default").html("未部署");
						$("#nodeInfo").html("");
						$("#runOrStopFlow").hide();
						$("#runOrStopFlow1").hide();
						$("#saveButton").attr("onclick","edit();");
					}else{
						$("#flow_disabled").val("true");
						$("#installFlow").attr("status","offline");
						$("#installFlow").html("取消部署");
						$("#txt").removeClass("label-default").addClass("label-success");
						$("#txt").text("已部署");
						$("#nodeInfo").html(data.message);//dataArr[1]);
						$("#saveButton").attr("onclick","confirmOnline();");
						$("#saveButton").attr("type","button");
						$("#flowName").attr("disabled","disabled");
						$("#projectId").attr("disabled","disabled");
						$("#runOrStopFlow").text("执行");
						$("#runOrStopFlow").attr("status","run");
						
						//不是实时的，手动的周期就不需要弹出日志
						var periodStatus = $("#periodStatus").val();
						console.log("periodStatus="+periodStatus);
						if(periodStatus == 'true'){
							
							layer.open({
						        type: 2,
						        title: [
						                '流程日志',
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
						        content:_flowLogger,
								shift: 2, //从上动画弹出
								min : function(){
									$('.layui-layer-min').click(function(){
										$("#layui-layer3").remove();
										$("#xubox_layer1").remove();
										$("div[type='iframe']").remove();
										$('#console-switch-wrap').show();
								    });
								}
							});
						}
					}
				}else if(_respStatus == "node_send_fail"){
					_text = "操作失败！发送请求到节点失败！";
				}else if(_respStatus == "node_resp_timeout"){
					_text = "操作失败！节点响应超时！";
				}else if(_respStatus == "node_running_faild"){
					_text = "执行流程失败！";
				}else if(_respStatus == "unknown_exception"){
					_text = "执行流程失败！未知异常！！";
					console.log(data.message);
				}else if(_respStatus == "node_closed"){
					_text = "操作失败！节点已失联！";
				}else if(_respStatus == "not_any_node"){
					_text = "操作失败！无可用节点！";
				}else if(_respStatus == "node_closed"){
					_text = "操作失败！节点已失联！";
				}else if(_respStatus == "flowComp_Null"){
					_text = "部署失败！该流程没有任何组件！";
				}else if(_respStatus == "config_Null"){
					_text = "部署失败！组件配置信息为空！";
				}else if(_respStatus == "ftp_Null"){
					_text = "部署失败！组件连接不正常！";
				}else if(_respStatus == "aggregate_Null"){
					_text = "部署失败！统计分析组件的统计字段为空！";
				}else if(_respStatus == "schedule_Null"){
					_text = "部署失败！排期表文件不存在！";
				}else if(_respStatus == "flowId_null"){
					_text = "请先保存流程后再部署！";
				}else if(_respStatus == "node_Null"){
					_text = "所属部门还未分配资源池！";
				}else if(_respStatus == "node_is_delete"){
					_text = "节点不存在！";
				}else{
					_text = data;
				}
				
				if(_text){
					layer.tips(_text, '#installFlow', {
						tips: [3, '#3595CC'],
						time: 3000
					});
				}
			},
			error:function(err){
				console.log("加载数据出错！");
				common['$'].unblockUI();
				console.log(err);
				layer.tips('部署流程出现异常！', '#installFlow', {
				    tips: [1, '#3595CC'],
				    time: 5000
				});
			}
		});
		return false;
	});
	
	
	$("#relyMySelf").click(function(){
		if($(this).prop("checked")){
			$(this).attr("value","y");			
			$("#cronMaxThreads").show();			
			$("#cronMaxThreads").attr("data-rule","required;integer; range[1~30]");			
			$("#cronMaxThreads").attr("value","1");
			$("#cronMaxThreads").focus();
		}else{
			$(this).attr("value","n");
			$("#cronMaxThreads").attr("data-rule","");			
			$("#cronMaxThreads").hide();
		}
	});
	
	$("#saveToTemplate").click(function(){
		//prompt层
		layer.prompt({
		    title: '请输入模板名称',
		    formType: 0 //prompt风格，支持0-2
		}, function(newName){
// 			newName = $("#flowName").val();
			var urlname = encodeURI(newName);
		        $.ajax({
		    		url:"<%=request.getContextPath() %>/flow?method=saveToTemplate&id="+$("#flowId").val()+"&newName="+urlname,
		    		//data:{"sql":editor.getValue()},
		    		type:"post",
		    		dataType:"json",
		    		success:function(data, textStatus){
		    			if(data == "0"){
			    			layer.msg('保存完毕！ 模板名称：'+newName);
		    			}else if(data == "2"){
			    			layer.msg('保存失败！ 模板重名啦！('+newName+')');
		    			}else{
			    			layer.msg('保存失败！ 模板名称：'+newName);
		    			}
// 		    			var flowId = data["flowId"];
// 		    			myLayer.hideLayer();
// 		    			myLayer.showLayer(flowId);
		    			
// 		    			common['$'].unblockUI();
		    		},
		    		error:function(){
// 		    			common['$'].unblockUI();
		    			alert("发送请求出错！");
		    		}
		    	});			

		});

	});
	
	$("#useThisTemplate").click(function(){
		
		//prompt层此为流程模板！
		layer.prompt({
		    title: '请输入流程名称',
		    formType: 0 //prompt风格，支持0-2
		}, function(newName){
// 			newName = $("#flowName").val();
				var urlname = encodeURI(newName);
		        $.ajax({
		    		url:"<%=request.getContextPath() %>/flow?method=useThisTemplate&id="+$("#flowId").val()+"&newName="+urlname,
		    		//data:{"sql":editor.getValue()},
		    		type:"post",
		    		dataType:"text",
		    		success:function(data, textStatus){
// 		    			console.log(data);
		    			var r = data.split("_");
		    			if(r[0] == "0"){
			    			layer.msg('新流程创建完毕！ 模板名称：'+newName);
			    			var href = window.location.href;
							//解析地址
							var _left = href.substring(0,href.indexOf("?"));
							var _right = href.substring(href.indexOf("?")+1);
// 							console.log(_left+","+_right);
							href="?id="+r[1];
// 			    			alert("newid = " + r[1]);
			    			if(confirm("是否跳转到新建流程("+r[1]+":"+newName+")页面?")){
			    				  window.location = href;
			    			}else{return false;}
		    			}else if(r[0]=="2"){
		    				layer.msg('流程名称重复！ 创建失败');
		    			}else{
			    			layer.msg('新流程创建失败！ 模板名称：'+newName);
		    			}
// 		    			var flowId = data["flowId"];
// 		    			myLayer.hideLayer();
// 		    			myLayer.showLayer(flowId);
// 		    			common['$'].unblockUI();
		    		},
		    		error:function(){
// 		    			common['$'].unblockUI();
		    			alert("发送请求出错！");
		    		}
		    	});			
		});

	});
	
	
});



function MyLayer(status){
	this.status = status;//running | stoped
	
	this.init = function(){
		
	}

	this.showLayer = function(flowId){
		//var ccc = $("#myTab li:eq(0)").clone();
		//$("#myTab li:eq(0)").append(ccc);
		
// 		console.log("hideLayer...");
// 		$("#layui-layer1").remove();
		$('#console-switch-wrap').hide();
		$("div[type='iframe']").remove();
		
		layer.open({
	        type: 2,
	        title: [
	                '运行日志',
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
	        content:'<%=request.getContextPath() %>/flowStatus?method=history2&flowId='+$('#flowId').val(),
			shift: 2,
			success : function(){
			    $('.layui-layer-close').click(function(){
			    	$('#console-switch-wrap').show();
			    });
			},
			min : function(){
				$('.layui-layer-min').click(function(){
					$("#xubox_layer1").remove();
					$("#layui-layer3").remove();
					$("div[type='iframe']").remove();
					$('#console-switch-wrap').show();
			    });
			}
		});
	}

	this.hideLayer = function(){
		console.log("hideLayer...");
		$("#xubox_layer1").remove();
		$("#layui-layer3").remove();
		$("div[type='iframe']").remove();
		$('#console-switch-wrap').show();
	}
}
$('.layui-layer-min').click(function(){
	$("#xubox_layer1").remove();
	$("#layui-layer3").remove();
	$("div[type='iframe']").remove();
	$('#console-switch-wrap').show();
});
$('#console-switch').click(function(){
	var myLayer = new MyLayer("running");
	myLayer.hideLayer();
	myLayer.showLayer($("#flowId").val());
});

$('#runningBtn').click(function(){
	createMark();
	var myLayer = new MyLayer("running");
	
	
	$.ajax({
		url:"<%=request.getContextPath() %>/flow?method=run&status=" + status + "&id="+$("#flowId").val(),
		//data:{"sql":editor.getValue()},
		type:"post",
		dataType:"json",
		success:function(data, textStatus){
			//this.status = "stoped";
			//console.log("status="+status);
			//if(myLayer.status == "")
			
// 			console.log(data);
			var flowId = data["flowId"];
			myLayer.hideLayer();
			myLayer.showLayer(flowId);
			
			common['$'].unblockUI();
		},
		error:function(){
			common['$'].unblockUI();
			alert("发送请求出错！");
		}
	});
});


</script>

<script>
	$('.darwin-mask').click(function(){
		createMark();
	});
</script>
<script>
	function confirmOnline(){
        layer.tips('请取消部署，再编辑^_^', '#saveButton', {
		    tips: [1, '#3595CC'],
		    time: 2000
		});
	}
	function edit(){
		$("#digital").removeAttr("disabled");
		$('#crontabGroupInput').gentleSelect("setAbled");
		$("#saveButton").attr("onclick","");
		$("#saveButton").attr("class","btn btn-default");
		$("#submitButton").attr("style","");
		$("#flowName").attr("disabled",false);
		$("#projectId").attr("disabled",false);
		$("#relyMySelf").attr("disabled",false);
		$("#cronMaxThreads").attr("disabled",false);
		$("#nodeId").attr("disabled",false);
		$("#periodType").attr("disabled",false);
		$("#week").attr("disabled",false);
		$("#month").attr("disabled",false);
		$("#day").attr("disabled",false);
		$("#hour").attr("disabled",false);
		$("#minute").attr("disabled",false);
		$("#crondict").attr("disabled",false);
		$("#saveFlag").val("ng");

	}
	function refreshInit(){
		$("#flowName").attr("disabled","disabled");
		$("#projectId").attr("disabled","disabled");
		$("#relyMySelf").attr("disabled","disabled");
		$("#cronMaxThreads").attr("disabled","disabled");
		$("#nodeId").attr("disabled","disabled");
		$("#periodType").attr("disabled","disabled");
		$("#week").attr("disabled","disabled");
		$("#month").attr("disabled","disabled");
		$("#day").attr("disabled","disabled");
		$("#hour").attr("disabled","disabled");
		$("#minute").attr("disabled","disabled");
		$("#crondict").attr("disabled","disabled");
	}
	if($("#flowId").val() !=""){
		refreshInit();
	}
	//项目的下拉框选择切换事件
	$("#projectId").change(function(){
		var newSelect = $(this).val();
		if(newSelect=="0"){
			console.log("newSelect="+newSelect);
			href = "/user/project?method=index&flowId="+$("#flowId").val();
			
			window.location.href=href;
		}
	});
	
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>