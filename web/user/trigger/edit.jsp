<%@page import="com.stonesun.realTime.services.db.DsTemplateServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.DsTemplateInfo"%>
<%@page import="com.stonesun.realTime.services.core.KeyValue"%>
<%@page import="com.stonesun.realTime.services.db.bean.MonitorInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.BaseLineInfo"%>
<%@page import="com.stonesun.realTime.services.db.MonitorServices"%>
<%@page import="com.stonesun.realTime.services.db.BaseLineServices"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.TriggerInfo"%>
<%@page import="com.stonesun.realTime.services.db.TriggerServices"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>编辑触发告警</title>
<%@ include file="/resources/common.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/crontab/cron/jquery-cron.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/crontab/gentleSelect/jquery-gentleSelect.js"></script>
<link type="text/css"  href="<%=request.getContextPath() %>/resources/crontab/gentleSelect/jquery-gentleSelect.css" rel="stylesheet" />
<link type="text/css"  href="<%=request.getContextPath() %>/resources/crontab/cron/jquery-cron.css" rel="stylesheet" />
<script src="<%=request.getContextPath() %>/resources/js/CronClass.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "137");%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					监控告警
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
			<div class="col-md-9">
				<div class="page-header">
					  <ol class="breadcrumb">
						  <li><a href="<%=request.getContextPath() %>/user/trigger?method=index">告警管理列表</a></li>
						  <li class="active">编辑告警内容</li>
					  </ol>
				  </div>
				<%
					//List<DatasourceInfo> dsList = DatasourceServices.selectList();
					int uid = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId();
					String monitorId = request.getParameter("monitorId");
					String id = request.getParameter("id");

					TriggerInfo trigger = null;
					if(StringUtils.isNotBlank(id)){
						trigger = TriggerServices.selectByIdToJsp(Integer.valueOf(id),uid);
						if(trigger==null){
							response.sendRedirect("/resources/403.jsp");
							return;
						}else{
							String noticeEmail = JSON.parseArray(trigger.getNotice()).getJSONObject(0).getString("email");
							request.setAttribute("trigger", trigger);
							request.setAttribute("noticeEmail", noticeEmail);
						}
					}else{
						trigger = new TriggerInfo();
					}
					
					String triggerName = "";
					String monitorName = "";
					if(StringUtils.isNotBlank(monitorId) && StringUtils.isBlank(id)){
						MonitorInfo monitorInfo = MonitorServices.selectById(Integer.valueOf(monitorId),uid);
						if(monitorInfo == null){
							response.sendRedirect("/resources/403.jsp");
							return;
						}else{
							monitorName = monitorInfo.getName();
							triggerName = monitorInfo.getName()+"的告警";
							trigger.setCategoryId(monitorInfo.getCategoryId());
							trigger.setCategoryName(monitorInfo.getCategoryName());
						}
					}
					request.setAttribute("triggerName", triggerName);
					request.setAttribute("monitorName", monitorName);
					request.setAttribute("monitorId", monitorId);
					
					String username = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getUsername();
					List<MonitorInfo> monitorList = MonitorServices.selectList(username);
					request.setAttribute("monitorList", monitorList);
					
					List<BaseLineInfo> baselineList = BaseLineServices.selectList();
					request.setAttribute("baselineList", baselineList);
					
					//加载数据源模板数据
					try{
						List<DsTemplateInfo> list = DsTemplateServices.selectList(((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId(),DsTemplateInfo.DsTemplateInfo_type_trigger);
						request.setAttribute("dsTemplateList", list);
						request.setAttribute("dsTemplateListSize", list.size());
						String tmpId = request.getParameter("tmpId");
						request.setAttribute("tmpId", tmpId);
						if(StringUtils.isNotBlank(tmpId)){
							DsTemplateInfo dsTmpInfo = DsTemplateServices.selectById(Integer.valueOf(tmpId));
							if(dsTmpInfo!=null && StringUtils.isNotBlank(dsTmpInfo.getRuleConf())){
								trigger.setStrategy(dsTmpInfo.getRuleConf());
								String ruleConf = dsTmpInfo.getRuleConf();
								if(StringUtils.isNotBlank(ruleConf)){
									JSONObject c2 = JSON.parseObject(ruleConf);
									String periodType = c2.getString("periodType");
									String crontabType = c2.getString("crontabType");
									if("second".equals(periodType)){
										trigger.setPeriodType(periodType);
									}else{
										trigger.setPeriodType(crontabType);
									}
									trigger.setDigital(c2.getString("digital"));
									trigger.setCron(c2.getString("crontab"));
									trigger.setMaxTimes(Integer.valueOf(c2.getString("maxTimes")));
									trigger.setPriority(c2.getString("priority"));
									trigger.setNoticeTemplate(c2.getString("noticeTemplate"));
								}
							}
						}
					}catch(Exception e){
						e.printStackTrace();
					}
					
					StringBuilder default_noticeTmp = new StringBuilder();
					default_noticeTmp.append("<p>Dear Master,\r\n");
					default_noticeTmp.append("<p>There is A Alert From [<ALERT_TITLE>]\r\n");
					default_noticeTmp.append("\r\n");
					default_noticeTmp.append("<p>Priority:[<ALERT_PRIORITY>]\r\n");
					default_noticeTmp.append("<p>Monitor Result:\r\n");
					default_noticeTmp.append("<p><MONITOR_RESULT>\r\n");
					default_noticeTmp.append("<p>\r\n");
					default_noticeTmp.append("<p>[Darwin Server Alert]\r\n");
					default_noticeTmp.append("<p>Date:<ALERT_DATETIME>\r\n");
					
					if(StringUtils.isBlank(trigger.getNoticeTemplate())){
						trigger.setNoticeTemplate(default_noticeTmp.toString());
					}
					request.setAttribute("trigger", trigger);
				%>
				<div class="row">
					<div class="col-md-12">
						<form  action="<%=request.getContextPath() %>/user/trigger?method=save&status=${trigger.status}" method="post"  
							data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" 
							id="form" onsubmit="return submitFunc()" class="form-horizontal" role="form" >
							<input name="id" id="id" type="hidden" value="${trigger.id }"/>
							<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
							<input name="status" id="status" type="hidden" value="${trigger.status }"/>
							<input name="html" id="html" type="hidden"/>
							<input id="simple_defualt_check" value="${monitorName }" type="hidden"/>
							
							<div class="form-group">
								<div id="test" class="col-sm-offset-2 col-sm-3" style="display: inline;">
									<button code="save" class="btn btn-primary" id="save" onclick="return isSave();" disabled="true" type="submit" >保存</button>
									<input code="save" type="button" value="删除模板" class="btn btn-danger" id="delSelectDsTmpBtn" style="display: none;" onclick="delSelectDsTmpFunc()"/>
									<input code="save" type="button" value="另存为模板" class="btn" onclick="saveToDsTemplateFunc(this)"/>
								</div>
								<div class="col-sm-4" style="display: inline;" id="dsTemplateInput"></div>
							</div>
							<div class="form-group">
								<label for="moduleList" class="col-sm-2 control-label">使用已有模板</label>
								<div class="col-sm-3">
									<select class="form-control" name="moduleList" id="moduleList">
										<c:choose>
								    		<c:when test="${dsTemplateListSize==0}">
												<option value="">无</option>
								    		</c:when>
								    		<c:otherwise>
								    			<option value=""></option>
												<c:forEach items="${dsTemplateList}" var="item">
										        	<option <c:if test='${tmpId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
										        </c:forEach>
								    		</c:otherwise>
								    	</c:choose>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>告警名称</label>
								<div class="col-sm-5">
									<input data-rule="required;name;length[1~45];remote[/user/trigger?method=exist&id=${trigger.id}]" id="name" name="name" <c:if test='${not empty triggerName}'>value="${triggerName}"</c:if>value="${trigger.name}" class="form-control input-sm" placeholder="告警名称"/>
								</div>
							</div>
							<input type="hidden" name="categoryId" id="categoryId" value="${trigger.categoryId}">
							<div class="form-group">
								<label for="categoryName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>所属分类</label>
								<div class="col-sm-5">
									<input class="form-control input-inline" placeholder="点击选择所属分类" value="${trigger.categoryName}" id="categoryName" name="categoryName" data-rule="required;" readonly="readonly"/>
								</div>
								<div class="col-sm-2">
									<input class="btn btn-default" type="button" name="select" style="height:36px;vertical-align:middle;padding:0px 8px;" value="选择分类">
								</div>			
							</div>
							<div class="form-group">
								<label for="strategy" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>告警策略</label>
								<div class="col-sm-10" id="strategyMainDiv" >
									<div id="strategyItem">
										<div>
											<a href="#" op="addSimpleStrategy">增加策略</a>
											<a href="#" op="addFullStrategy">增加运算策略</a>
											<input name="strategyCheck" id="strategyCheck" value="1" type="hidden"/>
											<span id="strategyError" style="display:none;" class="msg-box" for="strategyCheck"></span>
											<input name="strategyNameCheck" id="strategyNameCheck" value="1" type="hidden"/>
											<span id="strategyNameError" style="display:none;" class="msg-box" for="strategyNameCheck"></span>
										</div>
										
										<div nickname="full" style="padding: 8px;display: none;">
											<input name="full_num" style="display: none;"/>
											<input style="width:100px;background:#F5F8F8;" id="full_m1" name="full_m1" value="" onmousemove="show_div('full_m1')" onmouseout="hid_div('full_m1')" readonly="readonly"/>
											<input id="id_full_m1" name="id_full_m1" value="" type="hidden"/>
											<button style="margin-left:-6px;" name="select-monitor1" type="button">选择</button>
											<select name="full_evalOp">
												<option value="+">+</option>
												<option value="-">-</option>
												<option value="*">*</option>
												<option value="/">/</option>
											</select>
											<input style="width:100px;background:#F5F8F8;"  id="full_m2" name="full_m2" value="" readonly="readonly"/>
											<input id="id_full_m2" name="id_full_m2" value="" type="hidden"/>
											<button style="margin-left:-6px;" name="select-monitor2" type="button">选择</button>
											<select name="full_compareOp" id="full_compareOp">
												<option value="&gt;">></option>
												<option value="&lt;"><</option>
												<option value="=">=</option>
												<option value="&gt;=">>=</option>
												<option value="&lt;="><=</option>
											</select>
											<select name="full_category" id="full_category" onchange="fullChange0(this)">
												<option value="fixedThreshold">固定阀值</option>
												<option value="dynamicBaseline">动态基线</option>
											</select>
											<select name="full_jixian" id="full_jixian" style="display:none;">
										        <option value="0">无</option>
												<c:forEach items="${baselineList}" var="item">
										           <option value="${item.id}">${item.name}</option>
										        </c:forEach>
											</select>
											<input style="width:50px;" value="0.1" name="full_result" id="full_result"/>
											<select name="full_andOr">
												<option value="and">and</option>
												<option value="or">or</option>
											</select>
											<a href="#" op="removeRow">删除</a>
										</div>
										<c:if test="${not empty monitorId }">
											<div style="padding: 8px;" nickname="simple_defualt" >
												<input name="simple_num" value="1" style="display: none;"/>
												<input style="width:100px;background:#F5F8F8;" id="simple_m11" name="simple_m1" value="${monitorName }" onmousemove="show_div('simple_m11')" onmouseout="hid_div('simple_m11')" readonly="readonly"/>
												<input id="id_simple_m11" name="id_simple_m1" value="${monitorId }" type="hidden"/>
												<button style="margin-left:-6px;" name="select-monitor" onclick="popLayer('simple_m11');" type="button">选择</button>
												<select name="simple_compareOp" id="simple_compareOp">
													<option value="&gt;">></option>
													<option value="&lt;"><</option>
													<option value="=">=</option>
													<option value="&gt;=">>=</option>
													<option value="&lt;="><=</option>
												</select>
												<select name="simple_category" id="simple_category" onchange="simpleChange0(this)">
													<option value="fixedThreshold">固定阀值</option>
													<option value="dynamicBaseline">动态基线</option>
												</select>
												<select name="simple_jixian" id="simple_jixian" style="display:none;" >
													<option value="0">无</option>
													<c:forEach items="${baselineList}" var="item">
											           <option value="${item.id}">${item.name}</option>
											        </c:forEach>
												</select>
												<input style="width:50px;" value="0.1" name="simple_result" id="simple_result"/>
												<select name="simple_andOr">
													<option value="and">and</option>
													<option value="or">or</option>
												</select>
												<a href="#" op="removeRow">删除</a>
											</div>
										</c:if>
										<div nickname="simple" style="padding: 8px;display: none;">
											<input name="simple_num" style="display: none;"/>
											<input style="width:100px;background:#F5F8F8;" name="simple_m1" value="" readonly="readonly"/>
											<input id="id_simple_m1" name="id_simple_m1" value="" type="hidden"/>
											<button style="margin-left:-6px;" name="select-monitor" type="button">选择</button>
											<select name="simple_compareOp" id="simple_compareOp">
												<option value="&gt;">></option>
												<option value="&lt;"><</option>
												<option value="=">=</option>
												<option value="&gt;=">>=</option>
												<option value="&lt;="><=</option>
											</select>
											<select name="simple_category" id="simple_category" onchange="simpleChange0(this)">
												<option value="fixedThreshold">固定阀值</option>
												<option value="dynamicBaseline">动态基线</option>
											</select>
											<select name="simple_jixian" id="simple_jixian" style="display:none;">
												<option value="0">无</option>
												<c:forEach items="${baselineList}" var="item">
										           <option value="${item.id}">${item.name}</option>
										        </c:forEach>
											</select>
											<input style="width:50px;" value="0.1" name="simple_result" id="simple_result"/>
											<select name="simple_andOr">
												<option value="and">and</option>
												<option value="or">or</option>
											</select>
											<a href="#" op="removeRow">删除</a>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="periodType" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>调度周期</label>
								<div class="col-sm-5" id="cronDiv">
									<select class="form-control" id="periodType" name="periodType">
										<option <c:if test='${trigger.periodType eq "second"}'>selected="selected"</c:if> value="second">实时</option>
										<option <c:if test='${trigger.periodType != "second"}'>selected="selected"</c:if> value="crontab">定时任务</option>
									</select>
								</div>
							</div>
							<div  class="form-group" style="margin-left:50px">
								<div id="mei" class="col-xs-1 col-md-1" style="margin-right:-60px;display:none">每</div>
								<div class="col-xs-1 col-md-1" id="digital_div"  style="display:none;">
									<input id="digital" name="digital" value="${trigger.digital}"  class="gentleselect-label" style="height:27px;width:70px;margin-top:-10px;" type="text" data-rule="" >
							    </div>
								<div class="col-xs-9 col-md-9" id="crontabGroupInput" >	
							    </div>
							    <input id="crontab" name="cron" value="${trigger.cron}" type="text" style="display:none">
								<input id="crontabType" name="crontabType" value="" type="text" style="display:none" >
						    </div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">告警方式</label>
								<div class="col-sm-5">
									<select name="noticeType" class="form-control">
										<option value="email">邮件发送</option>
									</select>
									<br>
									<textarea rows="3" cols="10" class="form-control" name="emailList" placeholder="输入邮箱名称，多个邮箱多行分布">${noticeEmail}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="maxTimes" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>最大发送次数</label>
								<div class="col-sm-5">
									<input id='maxTimes' name="maxTimes" value="${trigger.maxTimes}" data-rule='required;maxTimes;integer;range[1~10000]' class="form-control" placeholder="最大发送次数">
								</div>
								<p class='help-block'><span id="maxTimesLable"></span></p>
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">选择执行脚本</label>
								<div class="col-sm-5">
									<div id="errorTips" style="color: red;"></div>
									<input name="shellFile" id="shellFile" value="${trigger.shellFile}" class="form-control " readonly="readonly"/> 
								</div>
								<div class="col-sm-2">
									<input class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" />
									<button class="btn btn-default input-sm" onclick="removeShell()" type="button">
										<span class="glyphicon glyphicon-trash"></span>
									</button>
								</div>
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>优先级</label>
								<div class="col-sm-5">
									<select data-rule="required;priority" id="priority" name="priority" class="form-control ">
										<%
											request.setAttribute("taskPriority", DataCache.taskPriority);
										%>
										<c:forEach items="${taskPriority}" var="item">
								           <option <c:if test='${trigger.priority == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								        </c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="noticeTemplate" class="col-sm-2 control-label">通知模板</label>
								<div class="col-sm-5">
									<textarea rows="10" cols="10" class="form-control" id="noticeTemplate" name="noticeTemplate" placeholder="请输入通知模板内容">${trigger.noticeTemplate}</textarea>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="strategy_div" style="display: none;">${trigger.strategy}</div>	
	<%
	List<KeyValue> cronList = DataCache.cronList;
	StringBuilder _buff = new StringBuilder();
	for(int i=0;i<cronList.size();i++){
		KeyValue item = cronList.get(i);
		_buff.append(item.getKey()+","+item.getValue()).append(";");
	}
	%>
	<div id="_div_cronList" style="display: none;"><%=_buff.toString() %></div>
	<div id="Below_new" style="border: 1px solid #CCC;width: 320px;height: 280px;display:none;">
		<div style="padding:5px;">
			<div id="monitorName"></div>
			<div id="monitorIndex" style="word-break:break-all;width:280px;"></div>
			<div id="monitorTerm"></div>
			<div id="monitorObj"></div>
			<div id="monitorUrl" style="margin-left:220px;"></div>
		</div>
	</div>
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
	</c:if> --%>
<script type="text/javascript">
function showLayer(_id,_value){
	layer.open({
	    type: 2,
// 	    border: [0,1,'#61BA7A'], //不显示边框
	    area: ['500px', '500px'],
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
	
	window.onload=function(){
	    document.onmousedown=function(ev){
	        var oEvent=ev||event;
	        var mouX = oEvent.screenX;
	        var mouY = oEvent.screenY;
// 			var top1=$("#Below_new").position().top; 
// 			var left1=$("#Below_new").position().left;
			var top=$("#Below_new").offset().top-60;  //Y
			var left=$("#Below_new").offset().left+60; //X
			console.log("mouX="+mouX+",top="+top+",mouY="+mouY+",left"+left);
			// mouX=613,left602.61669921875  
			if((left+320)<mouX || mouX<left){
				console.log("mouX="+mouX+",left"+left);
	 			$("#Below_new").attr("style","display:none;");
			}
			// top=323.6000061035156,mouY=331,
			if(mouY<top+10){
				console.log("top="+top+",mouY="+mouY);
	 			$("#Below_new").attr("style","display:none;");
			}
	    }
	}
	function show_div(t){
		 var offsettop=$("#"+t).offset().top+25;  
		 var offsetleft=$("#"+t).offset().left+10;
		 var id = $("#id_"+t).val();
		 var name = $("#"+t).val();
// 		 console.log("id="+id);
		 $.ajax({
				url:"<%=request.getContextPath() %>/user/monitor?method=viewDetails&id="+id,
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
// 	 				console.log(data);
					var monitorIndex = data.indexName;
	 				$("#monitorName").text(name);
	 				$("#monitorIndex").text("查询索引："+data.indexName);
	 				var html = "监控条件：";
	 				html += "<textarea disabled='disabled' rows='6' cols='120' class='form-control'>"+data.cond+"</textarea>";
	 				$("#monitorTerm").html(html);
	 				$("#monitorObj").html("监控对象："+data.target);
	 				$("#monitorUrl").html("<a target='blank' href='/search/dashboard.jsp?type=monitor&id="+id+"' >在检索中打开</a>");
		 			$("#Below_new").attr("style","display:block;background:#DDDDDD;z-index:2;position: absolute;border: 1px solid #CCC;width: 320px;height: 280px;top:"+offsettop+"px;left:"+offsetleft+"px;");
				},
				error:function(){
					console.log("加载监控项详细信息出错!");
				}
			}); 
	}
	
	function hid_div(t){
		$("#Below_new").attr("style","display:none;");
	}
	
	// 下拉菜单切换动态基线和固定阈值
	function simpleChange0(t){
		var val = $(t).val();
		if(val=="fixedThreshold"){
			$(t).parent().find("select[id='simple_compareOp']").attr("style","");
			$(t).parent().find("select[id='simple_jixian']").attr("style","display:none;");
// 			$(t).parent().find("select[id='simple_jixian']").removeAttr("data-rule");
			$(t).parent().find("input[id='simple_result']").attr("style","width:50px;");
			$(t).parent().find("input[id='simple_result']").val("0.1");
		}else{
			$(t).parent().find("select[id='simple_compareOp']").attr("style","display:none;");
			$(t).parent().find("select[id='simple_jixian']").attr("style","");
// 			$(t).parent().find("select[id='simple_jixian']").attr("data-rule","required;");
			$(t).parent().find("input[id='simple_result']").attr("style","width:50px;display:none;");
			$(t).parent().find("input[id='simple_result']").val("0.1");
		}
		$('form').validator("cleanUp");
	}
	
	function fullChange0(t){
		var val = $(t).val();
		if(val=="fixedThreshold"){
			$(t).parent().find("select[id='full_compareOp']").attr("style","");
			$(t).parent().find("select[id='full_jixian']").attr("style","display:none;");
// 			$(t).parent().find("select[id='full_jixian']").removeAttr("data-rule");
			$(t).parent().find("input[id='full_result']").attr("style","width:50px;");
			$(t).parent().find("input[id='full_result']").val("0.1");
		}else{
			$(t).parent().find("select[id='full_compareOp']").attr("style","display:none;");
			$(t).parent().find("select[id='full_jixian']").attr("style","");
// 			$(t).parent().find("select[id='full_jixian']").attr("data-rule","required;");
			$(t).parent().find("input[id='full_result']").attr("style","width:50px;display:none;");
			$(t).parent().find("input[id='full_result']").val("0.1");
		}
		$('form').validator("cleanUp");
	}

	function removeShell(){
		$("#shellFile").val("");
	}
	
	function isSave(){
		var status= $("#status").val();
		if(status=='on'){
			alert("该告警已经生效，不允许修改");
			return false;
		}else{
			return true;
		}
		
	}
	
	$(function(){
		var initCron
		var crontab=$("#crontab").val();
		if(crontab==''){
			initCron="* * * * *";
		}else if (crontab.indexOf("/")===-1) {
			initCron=crontab;
	    }
		var cron_field=$('#crontabGroupInput').cron({
			initial: initCron,
	        onChange: function() {
              $('#crontab').val($(this).cron("value"));
              getTag();
			},
			useGentleSelect: true,
	    	effectOpts: {
		        openEffect: "fade",
		        openSpeed: "slow"
	    	}
        });

		var periodType=$("#periodType").val();
		var crontab_type=$("select[name='cron-period']").val()


    	//初始化页面时判断是否显示crontab
		if (periodType!="second") {
			if (!isNaN($("#digital").val())) {
	
			}else{
				$("#digital").val("");
			};
			$("#crontabGroupInput").show();
			$("#mei").show();
			if (crontab_type=="hour") {
				$("#digital").attr("data-rule","range[1~23]");
				$("#digital_div").show();
			}else if(crontab_type=="minute"){
				$("#digital").attr("data-rule","range[1~59]");
				$("#digital_div").show();
			}else if(crontab_type=="day"){
				$("#digital").attr("data-rule","range[1~31]");
				$("#digital_div").show();
			}else{
				$("#digital").attr("data-rule","");
				$('form').validator('hideMsg', '#digital');
				$("#digital_div").hide();
			};
	        $("#maxTimesLable").text("");
		}else{
			$("#crontabGroupInput").hide();
			$("#digital_div").hide();
			$("#mei").hide();
	        $("#maxTimesLable").text("1小时内连续告警最大次数");
		};

	    //给隐藏的输入框赋值
		function getTag(){
			var crontab_type2=$("select[name='cron-period']").val()
	        $("#crontabType").val(crontab_type2)
			if (crontab_type2=="hour") {
				$("#digital").attr("data-rule","range[1~23]");
				$("#digital_div").show();
			}else if(crontab_type2=="minute"){
				$("#digital").attr("data-rule","range[1~59]");
				$("#digital_div").show();
			}else if(crontab_type2=="day"){
				$("#digital").attr("data-rule","range[1~31]");
				$("#digital_div").show();
			}else{
				$("#digital").attr("data-rule","");
				$('form').validator('hideMsg', '#digital');
				$("#digital_div").hide();
			};
	    }
	
		$("#periodType").change(function(){
		 if ($(this).val()!="second") {
		 	$("#crontabGroupInput").show();
	        $("#digital_div").show();
	        $("#mei").show();
	        $("#crontabType").val(crontab_type);
	        $("#maxTimesLable").text("");
		 }else{
			$("#digital").attr("data-rule","");
			$('form').validator('hideMsg', '#digital');
		 	$("#crontabType").val($(this).val());
		 	$("#digital_div").hide();
			$("#crontabGroupInput").hide();
			$("#mei").hide();
	        $("#maxTimesLable").text("1小时内连续告警最大次数");
		 };
		});
		
		//最大的策略编号
		var max_num = 0;
		var simple_defualt_check = $("#simple_defualt_check").val();
		if(simple_defualt_check !='' ){
			max_num = max_num+1;
		}
		var status=$("#status").val();
		console.log("status = "+status);
		if(status=='off'){
			$("#save").attr("disabled",false)
			console.log("1111 = ");
		}
		if(status==''){
			$("#save").attr("disabled",false);
			console.log("2222 = ");
		}
		try{
			
			//增加策略组
			//$("#addStrategy").click(function(){
				//$("#strategyMainDiv").append();
				
			//});
			
			$("a[op='addSimpleStrategy']").click(function(){
				//console.log("addSimpleStrategy..."+simple);
				$("#strategyError").attr("style","display:none;");
				var _tmp = simple.clone(true);
				var num = ++max_num;
				_tmp.find("input[name='simple_num']").val(num);
				_tmp.find("input[name='simple_m1']").attr("id","simple_m1"+num);
				_tmp.find("input[name='simple_m1']").attr("onmousemove","show_div('simple_m1"+num+"');");
				_tmp.find("input[name='simple_m1']").attr("onmouseout","hid_div('simple_m1"+num+"');");
				_tmp.find("input[name='id_simple_m1']").attr("id","id_simple_m1"+num);
				_tmp.find("button[name='select-monitor']").attr("onclick","popLayer('simple_m1"+num+"');");
				$(this).parent().parent().append(_tmp);
				return false;
			});
			
			$("a[op='addFullStrategy']").click(function(){
				//console.log("addFullStrategy..."+full);
				$("#strategyError").attr("style","display:none;");
				var _tmp = full.clone(true);
				var num = ++max_num;
				_tmp.find("input[name='full_num']").val(num);
				_tmp.find("input[name='full_m1']").attr("id","full_m1"+num);
				_tmp.find("input[name='full_m1']").attr("onmousemove","show_div('full_m1"+num+"');");
				_tmp.find("input[name='full_m1']").attr("onmouseout","hid_div('full_m1"+num+"');");
				_tmp.find("input[name='id_full_m1']").attr("id","id_full_m1"+num);
				_tmp.find("button[name='select-monitor1']").attr("onclick","popLayer('full_m1"+num+"');");

				_tmp.find("input[name='full_m2']").attr("id","full_m2"+num);
				_tmp.find("input[name='full_m2']").attr("onmousemove","show_div('full_m2"+num+"');");
				_tmp.find("input[name='full_m2']").attr("onmouseout","hid_div('full_m2"+num+"');");
				_tmp.find("input[name='id_full_m2']").attr("id","id_full_m2"+num);
				_tmp.find("button[name='select-monitor2']").attr("onclick","popLayer('full_m2"+num+"');");
				$(this).parent().parent().append(_tmp);
				return false;
			});
			
			$("a[op='removeRow']").click(function(){
				//console.log("removeRow...");//$(this).parent().html());
				$(this).parent().remove();
				return false;
			});
			
			//clone 克隆2个html模板
			var simple = $("div[nickname='simple']").clone(true).show();
			var full = $("div[nickname='full']").clone(true).show();
			
			$("div[nickname='simple']").remove();
			$("div[nickname='full']").remove();
			
			
			var _html = $("#strategyMainDiv").clone(true);
			$("#html").val(_html.html());
			
			//回填页面的strategy
			var _strategy = $("#strategy_div").text();
			console.log(_strategy);
			if(_strategy && _strategy!=''){
// 				console.log(_strategy);
				$("#strategy_div").remove();
				//$("#strategy_div").show();
				var __strategyObj = eval('('+_strategy+')');
// 				console.log(__strategyObj);
				var _params = __strategyObj["params"][0]["params"];
				var _op = __strategyObj["params"][0]["op"];
				//console.log(_params);
// 				console.log(_op);
				if(_params && _params.length > 0){
					var _opArr = _op.split(",");
					for(var i=0;i<_params.length;i++){
						//console.log(_params[i]);
						var _item = _params[i];
						max_num++;
						if(_item["type"]=='compare'){
							//console.log("找到compare...");
							var _compare = simple.clone(true);
							_compare.find("input[name='simple_num']").val(i);
							_compare.find("input[name='simple_m1']").val(_item["m1"]);
							_compare.find("input[name='id_simple_m1']").val(_item["m1Id"]);
							_compare.find("select[name='simple_compareOp']").val(_item["compareOp"]);
							_compare.find("select[name='simple_category']").val(_item["category"]);
							_compare.find("select[name='simple_jixian']").val(_item["baseline"]);
							_compare.find("input[name='simple_result']").val(_item["result"]);
							_compare.find("select[name='simple_andOr']").val(_opArr[i]);
							if(_item["category"]=="fixedThreshold"){
								_compare.find("select[id='simple_compareOp']").attr("style","");
								_compare.find("select[name='simple_jixian']").attr("style","display:none;");
// 								_compare.find("select[name='simple_jixian']").removeAttr("data-rule");
								_compare.find("input[name='simple_result']").attr("style","width:50px;");
				 			}else{
								_compare.find("select[id='simple_compareOp']").attr("style","display:none;");
				 				_compare.find("select[name='simple_jixian']").attr("style","");
// 								_compare.find("select[name='simple_jixian']").attr("data-rule","required;");
								_compare.find("input[name='simple_result']").attr("style","width:50px;display:none;");
				 			}

							_compare.find("input[name='simple_m1']").attr("id","simple_m1"+i);
							_compare.find("input[name='simple_m1']").attr("onmousemove","show_div('simple_m1"+i+"');");
							_compare.find("input[name='simple_m1']").attr("onmouseout","hid_div('simple_m1"+i+"');");
							_compare.find("input[name='id_simple_m1']").attr("id","id_simple_m1"+i);
							_compare.find("button[name='select-monitor']").attr("onclick","popLayer('simple_m1"+i+"');");

							$("#strategyItem").append(_compare);
						}else if(_item["type"]=='eval'){
							//console.log("找到eval...");
							var _full = full.clone(true);
							_full.find("input[name='full_num']").val(i);
							_full.find("input[name='full_m1']").val(_item["m1"]);
							_full.find("input[name='id_full_m1']").val(_item["m1Id"]);
							_full.find("input[name='full_m2']").val(_item["m2"]);
							_full.find("input[name='id_full_m2']").val(_item["m2Id"]);
							_full.find("select[name='full_evalOp']").val(_item["evalOp"]);
							_full.find("select[name='full_compareOp']").val(_item["compareOp"]);
							_full.find("select[name='full_category']").val(_item["category"]);
							_full.find("select[name='full_jixian']").val(_item["baseline"]);
							_full.find("input[name='full_result']").val(_item["result"]);
							_full.find("select[name='full_andOr']").val(_opArr[i]);
							if(_item["category"]=="fixedThreshold"){
								_full.find("select[id='full_compareOp']").attr("style","");
								_full.find("select[name='full_jixian']").attr("style","display:none;");
// 								_full.find("select[name='full_jixian']").removeAttr("data-rule");
								_full.find("input[name='full_result']").attr("style","width:50px;");
				 			}else{
				 				_full.find("select[id='full_compareOp']").attr("style","display:none;");
				 				_full.find("select[name='full_jixian']").attr("style","");
// 								_full.find("select[name='full_jixian']").attr("data-rule","required;");
				 				_full.find("input[name='full_result']").attr("style","width:50px;display:none;");
				 			}

							_full.find("input[name='full_m1']").attr("id","full_m1"+i);
							_full.find("input[name='full_m1']").attr("onmousemove","show_div('full_m1"+i+"');");
							_full.find("input[name='full_m1']").attr("onmouseout","hid_div('full_m1"+i+"');");
							_full.find("input[name='id_full_m1']").attr("id","id_full_m1"+i);
							_full.find("button[name='select-monitor1']").attr("onclick","popLayer('full_m1"+i+"');");

							_full.find("input[name='full_m2']").attr("id","full_m2"+i);
							_full.find("input[name='full_m2']").attr("onmousemove","show_div('full_m2"+i+"');");
							_full.find("input[name='full_m2']").attr("onmouseout","hid_div('full_m2"+i+"');");
							_full.find("input[name='id_full_m2']").attr("id","id_full_m2"+i);
							_full.find("button[name='select-monitor2']").attr("onclick","popLayer('full_m2"+i+"');");
							
							$("#strategyItem").append(_full);
						}
					}
				}
			}
			
			
			//addCronSelect();
			
			//var cron = new CronClass();
			//cron.init();
		}catch(err){
			console.log(err);
		}
	});

	//xuanzhe
	function popLayer(name){
		layer.open({
		    type: 2,
	        title: [
	                '监控项列表',
	                'border:none; background:#01B6CB; color:#fff;' //font-size:18px;font-weight:20;
	        ],
		    area: ['500px', '500px'],
		    shadeClose: true,
		    skin: 'layui-layer-molv', //墨绿风格
		    fix: false, //不固定
		    scrollbar:false,
		    content: '/user/monitor?method=popIndex&m1_name='+name
		});
	}
	
	function submitFunc(){
		//console.log("submitFunc...");
		var _html = $("#strategyMainDiv").clone(true);
		$("#html").val(_html.html());
		//$("#form").attr("action",);
		return false;
	}
	
	var oldSelect = $("#moduleList").children('option:selected').val();
	//删除模板按钮的隐藏和显示
	if(oldSelect==''){
		$("#delSelectDsTmpBtn").hide();
		$("#test").attr("class","col-sm-offset-2 col-sm-3");  
	}else{
		$("#delSelectDsTmpBtn").show();
		
	}
	
	//删除选中的模板
	function delSelectDsTmpFunc(){
// 		console.log("delSelectDsTmpFunc...");
		if(confirm("确认删除选中的模板吗？")){
			var dsTmpId = $("#moduleList").children('option:selected').val();
			$.ajax({
				url:"<%=request.getContextPath() %>/datasources?method=delSelectDsTmp",
				type:"post",
				data:{"dsTmpId":dsTmpId},
				dataType:"text",
				success:function(data, textStatus){
// 					console.log(data);
					if(data==0){
						window.location.href=window.location.href;
					}else{
						alert("删除失败！");
					}
				},
				error:function(){
					alert("删除失败！");
				}
			});
		}
	}
	
	//另存为模板
	function saveToDsTemplateFunc(obj){
// 		console.log("saveToDsTemplateFunc...");
		//模板名称不存在则要求输入
		var _dsTemplate = $("#dsTemplateInput").find("input[name='dsTemplateName']");
		if(_dsTemplate.length==0){
// 			console.log("模板名称不存在则要求输入");
			$("#dsTemplateInput").append("<input name='dsTemplateName' style='width:200px;'  class='form-control' placeholder=\"请输入模板名称\"/>");
			$("#dsTemplateInput").find("input[name='dsTemplateName']").focus();
			$(obj).val("保存模版");
			$(obj).attr("class","btn btn-success");
			return;
		}
		
		var _name = $("#dsTemplateInput").find("input[name='dsTemplateName']").val();
		if($.trim(_name).length==0){
			$("#dsTemplateInput").find("input[name='dsTemplateName']").focus();
			return;
		}

		var _triggerConf = {
			"op":"",
			"periodType":$("#periodType").val(),
			"digital":$("#digital").val(),
			"crontabType":$("#crontabType").val(),
			"crontab":$("#crontab").val(),
			"maxTimes":$("#maxTimes").val(),
			"priority":$("#priority").val(),
			"noticeTemplate":document.getElementById('noticeTemplate').value,
			"params":[]
		};
		
		_triggerConf["params"].push({
			"op":"",
			"params":[]
		});
		//var _name = $("#name").val();
		var _op = "";
		$("div[nickname='simple'],div[nickname='full']").each(function(index,value){
			
			if($(this).find("input[name='full_num']").length>0){
				_op += $(this).find("select[name='full_andOr']").val();
				var _row = {
					"num":index+1,
					"type":"eval",
					"m1":$(this).find("input[name='full_m1']").val(),
					"m1Id":$(this).find("input[name='id_full_m1']").val(),
					"m2":$(this).find("input[name='full_m2']").val(),
					"m1Id":$(this).find("input[name='id_full_m1']").val(),
					"evalOp":$(this).find("select[name='full_evalOp']").val(),
					"compareOp":$(this).find("select[name='full_compareOp']").val(),
					"category":$(this).find("select[name='full_category']").val(),
					"baseline":$(this).find("select[name='full_jixian']").val(),
					"result":$(this).find("input[name='full_result']").val()
				};
			}else{
				_op += $(this).find("select[name='simple_andOr']").val();
				var _row = {
					"num":index+1,
					"type":"compare",
					"m1":$(this).find("input[name='simple_m1']").val(),
					"m1Id":$(this).find("input[name='id_simple_m1']").val(),
					"compareOp":$(this).find("select[name='simple_compareOp']").val(),
					"category":$(this).find("select[name='simple_category']").val(),
					"baseline":$(this).find("select[name='simple_jixian']").val(),
					"result":$(this).find("input[name='simple_result']").val()
				};
			}
			_op += ",";
			_triggerConf["params"][0]["params"].push(_row);
		});
		if(_op.substring(_op.length-1)==","){
			_op = _op.substring(0,_op.length-1);
		}
		if($.trim(_op).length==0){
			_op = "";
		}
		_triggerConf["params"][0]["op"]=_op;
		
		//_ruleConf["newLine"] = $("#newLine").val();
		
// 		console.log(_triggerConf);
		
		$.ajax({
			url:"<%=request.getContextPath() %>/datasources?method=saveToDsTemplateFunc",
			type:"post",
			data:{"ruleConf":JSON.stringify(_triggerConf),"tmpName":_name,"type":"trigger"},
			dataType:"text",
			success:function(data, textStatus){
// 				console.log(data);
				if(data==0){
					alert("保存成功！");
					window.location.href=window.location.href;
				}else{
					alert("模版重名！保存失败！");
				}
			},
			error:function(){
				alert("保存模板出错！");
			}
		});
	}
	
	//模板下拉框选择切换事件
	$("#moduleList").change(function(){
		if(true){
			if(confirm("确认切换成新的模板么？")){
				var newSelect = $(this).val();
				var href = window.location.href;
				//解析地址
				var _left = href.substring(0,href.indexOf("?"));
				var _right = href.substring(href.indexOf("?")+1);
// 				console.log(_left+","+_right);
				var _arr = _right.split("&");
				var exist = false;
				for(var i=0;i<_arr.length;i++){
					var _row = _arr[i].split("=");
					if(_row[0]=="tmpId"){
						exist = true;
						_arr[i] = null;
						break;
					}
				}
				_arr.push("tmpId=" + newSelect);
				
				//拼接参数
				var param = "";
				for(var i=0;i<_arr.length;i++){
					if(!_arr[i]){continue;}
					if(_arr[i].split("=")[1]=='')continue;
					param += _arr[i];
					if(i!=_arr.length-1){
						param +="&";
					}
				}
				
				if(param.charAt(param.length-1)=="&"){
					param = param.substring(0,param.length-1);
				}
				
				//console.log(href+"&tmpId="+newSelect);
				href = _left + "?" + param;
// 				console.log(href);
				
				window.location.href=href;
				oldSelect = newSelect;
			}else{
				$(this).val(oldSelect);
			}
			return;
		}
		
		//var dd = $(this).attr("dd");
// 		console.log("moduleList..");
		//var dd = $(this).children('option:selected').attr("dd");
		var _moduleListJson = $("#moduleList_hidden").text();

		var dsTmp = eval('('+_moduleListJson+')');
// 		console.log(ruleConf);
		var ruleConf = dsTmp["ruleConf"];
		var delimited_char = ruleConf["delimited_char"];
		var delimited = ruleConf["delimited"];
		var line = ruleConf["line"];
		var lineReg = ruleConf["lineReg"];
		var newLine = ruleConf["newLine"];
		var notParser = ruleConf["notParser"];
		var columns = ruleConf["columns"];
		
		//填充数据到页面
		$("#delimited_char").text(delimited_char);
		$("#delimited").text(delimited);
		$("#line").text(line);
		$("#lineReg").text(lineReg);
		$("#newLine").text(newLine);
		$("#notParser").text(notParser);
		
		//根据columns自动生成表格
			
		//console.log(dd);
	});
	
	//通用按钮的提交表单事件
	$("form").on("valid.form", function(e, form){
		/*
		if($("#ruleTable tr").size()==1){
			console.log("没有配置解析规则！");
			alert("没有配置解析规则！");
			return false;
		}
		
		var _exist = false;
		$("#ruleTable tr:gt(0)").each(function(index,value){
			var _columnName = $(this).find("input[name='columnName']").val();
			
			if(_columnName!=''){
				_exist = true;
			}
		});
		if(!_exist){
			alert("必须配置至少一项解析规则！");
			return false;
		}
		*/
		createMark();
		
		//return false;
// 		form.submit();
	});
	
	
	</script>
	
	
	
	<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/kindeditor-all.js"></script>
	<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script>
		KindEditor.ready(function(K) {
			var editor = K.editor({
				allowFileManager : true
			});
			K('#insertfile').click(function() {
				editor.loadPlugin('insertfile', function() {
					editor.plugin.fileDialog({
						fileUrl : K('#shellFile').val(),
						clickFn : function(url, title) {
							var shellFile = K('#shellFile').val();
// 							console.log("shellFile="+shellFile);
// 							console.log("url="+url);
							K('#shellFile').val(url);//shellFile?shellFile:"" + url + ";");
							
							//shellFile = K('#shellFile').val();
							//if(shellFile){
								//init(shellFile);
							//}
							editor.hideDialog();
						}
					});
				});
			});
			
			//init($("#shellFile").val());
			
			/*function init(shellFile){
				shellFile = shellFile.split(";");
				for(var i=0;i<shellFile.length;i++){
					$("#selectedList").append("<div>"+shellFile[i]+"</div>");
				}
			}*/
		});
		
		function onsubmitFunc(){
			var shellFile = $("#shellFile").val();
			if(shellFile){
				return true;
			}
			$("#errorTips").html("请先选择文件!");
			return false;
		}
		
		$('form').validator({
		    rules: {
		    	strategyCheck: function(element, param, field) {
		            var len = $("div[nickname='simple'],div[nickname='full'],div[nickname='simple_defualt']").size();
		            $("#strategyError").attr("style","");
		        	return len == 0 ?"需要添加告警策略！":"";
		        },
		    	strategyNameCheck: function(element, param, field) {
			    	var status = false;
		    		$("div[nickname='simple'],div[nickname='full']").each(function(index,value){
		    			if($(this).find("input[name='full_num']").length>0){
		    				var m1 = $(this).find("input[name='full_m1']").val();
		    				var m2 = $(this).find("input[name='full_m2']").val();
		    				if(m1=='' || m2==''){
		    					status = true;
				    		}
		    			}else{
		    				var m1 = $(this).find("input[name='simple_m1']").val();
		    				if(m1==''){
		    					status = true;
				    		}
		    			}
		    		});
		    		$("#strategyNameError").attr("style","");
		        	return status ?"以下所有监控项名称均不能为空！":"";
		        }
		    },
		    fields: {
		    	strategyCheck: 'required; strategyCheck',
		    	strategyNameCheck: 'required; strategyNameCheck'
		    }
		});
		
	</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
