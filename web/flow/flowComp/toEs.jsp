<%@page import="java.util.*"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.EsIndexServices"%>
<%@page import="com.alibaba.fastjson.*"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<form id="rightForm" action="<%=request.getContextPath() %>/flowComp?method=save" method="post" class="form-horizontal" role="form" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" >
<input name="type" value="${param.type}" type="hidden"/>
<input name="compId" value="${param.compId}" type="hidden"/>
<%request.setAttribute("topId", "41");%>
<%
	try{
		ComJspCode.getJspCode(request.getParameter("type"),request.getParameter("compId"),request);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script src="<%=request.getContextPath() %>/resources/js/common-util.js"></script>
<input id="flowId" name="flowId" value="${flowId}" type="hidden"/>
<input id="status" name="status" value="${status}" type="hidden"/>
<input id="isTimeHidden" name="isTimeHidden" type="hidden"/>
<input id="delimited_char_hidden" name="delimited_char_hidden" value="" type="hidden"/>
<div id="hdfsColumns" style="display: none;" >${hdfsColumns}</div>
<div id="tableNameJson" style="display: none;">${tableNameJson}</div>
<div id="status" style="display: none;">${status}</div>
<!-- 组件通用信息设置 -->
<div class="panel panel-default">
	<ol class="breadcrumb">
		<li><a href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">所属的流程名称：${flowName}</a></li>
		<li class="active">入es组件配置</li>
	</ol>
	<div id="result_15" class="alert alert-danger alert-dismissible" role="alert" style="margin-top: -20px;display:none;">
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
		<div class="col-sm-5">
			<input <c:if test='${empty name}'>value="组件名称"</c:if>value="${name}" class="form-control input-inline" placeholder="组件名称" id="name" name="name" data-rule="required;length[1~45];"/>
		</div>
		<div class="col-sm-1">
			<input class="btn btn-primary" type="submit" onclick="return testSet();"  value="保存"/>
		</div>
		<div class="col-sm-1">
			<a class="btn btn-primary"  href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">返回流程</a>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 这里是获取设置 -->
			<div class="col-md-4">
				<div class="panel panel-darwin">
					<div class="panel-heading">输入数据</div>
					<div class="panel-body">
						<div class="box box-default">
							<div class="box-heading">
								hdfs配置
							</div>
							<div>
								<button  id="saveHdfsConfigBtn"  type="button" class="btn btn-xs btn-default" data-toggle="modal" data-target="#myModal">
									<span class="glyphicon glyphicon-cog"></span>设置
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 这里是处理过程 -->
			<div class="col-md-4">
				<div class="panel panel-darwin">
					<div class="panel-heading">处理过程 &nbsp;&nbsp;<a onclick="openAdvancedSet();">高级设置</a></div>
					<div class="panel-body">
						<div id="advancedSet" style="display:none">
							<div >
								<label for="queueSize" class="control-label"><span class="redStar">*&nbsp;</span>队列大小</label>
								<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='0为不限制'></div>
								<div>
									<input <c:if test='${empty config.config.queueSize}'>value="0"</c:if>value="${config.config.queueSize}" class="form-control input-inline" id="queueSize" name="queueSize" data-rule="required;integer;length[1~45];"/>
								</div>
							</div>
							<div >
								<label for="number_of_replicas" class="control-label"><span class="redStar">*&nbsp;</span>索引副本数量</label>
								<div>
									<input <c:if test='${empty config.config.number_of_replicas}'>value="0"</c:if>value="${config.config.number_of_replicas}" class="form-control input-inline" id="number_of_replicas" name="number_of_replicas" data-rule="required;integer;length[1~45];"/>
								</div>
							</div>
							<div >
								<label for="number_of_shards" class="control-label"><span class="redStar">*&nbsp;</span>索引分片数量</label>
								<div>
									<input <c:if test='${empty config.config.number_of_shards}'>value="10"</c:if>value="${config.config.number_of_shards}" class="form-control input-inline" id="number_of_shards" name="number_of_shards" data-rule="required;integer;length[1~45];"/>
								</div>
							</div>
							<div class="">
								<label for="bulkSize" class="control-label"><span class="redStar">*&nbsp;</span>批量大小</label>
								<div>
									<input <c:if test='${empty config.config.bulkSize}'>value="2000"</c:if>value="${config.config.bulkSize}" class="form-control input-inline" id="bulkSize" name="bulkSize" data-rule="required;integer;length[1~45];"/>
								</div>
							</div>
							<div class="">
								<label for="threads" class="control-label"><span class="redStar">*&nbsp;</span>并发线程数量</label>
								<div>
									<input <c:if test='${empty config.config.threads}'>value="30"</c:if>value="${config.config.threads}" class="form-control input-inline" id="threads" name="threads" data-rule="required;integer;length[1~45];"/>
								</div>
							</div>
							<div class="">
								<label for="multilineMergeSplitStr" class="control-label"><span class="redStar">*&nbsp;</span>额外字段提取的分隔符</label>
								<div>
									<input <c:if test='${empty config.config.multilineMergeSplitStr}'>value=";"</c:if>value="${config.config.multilineMergeSplitStr}" class="form-control input-inline" id="multilineMergeSplitStr" name="multilineMergeSplitStr" data-rule="required;length[1~45];"/>
								</div>
							</div>
							&nbsp;
						</div>
						<div class="form-group">
							<input type="checkbox" <c:if test='${bulkLoad == true}'>checked="checked"</c:if> value="bulkLoad" name="type_bulkLoad" id="type_bulkLoad"/>批量导入
							<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='将导入的源数据的整批导入，出现错误数据时停止导入' ></span>
							<input value="${proces }"  id="proces" name="proces" data-rule="required;" type="hidden"/>
							<div id="hdfs_hbase_conf_div" <c:if test='${bulkLoad == true}'>style="display: none;"</c:if>>
								<div class="row">
									<div class="col-sm-12">
										<div class="text-right">
											<button class="btn btn-primary" type="button" id="newRow2">添加字段映射</button>
										</div>
										<label >已添加的映射：</label>
										<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='映射导入数据，出现错误跳过本条数据，继续导入下一条数据。映射字段的最大数量是源数据的列数。数据列为hdfs配置中的源字段，ES字段为表中的字段' ></span>
									</div>
									
									<div class="col-sm-12" style="margin-bottom: 100px;">
										<table class="table table-bordered table-hover" id="confTable" >
											<tr class="success">
												<td width="10%">No</td>
												<td width="35%"><span class="redStar">*&nbsp;</span>数据列</td>
												<td width="35%"><span class="redStar">*&nbsp;</span>Es字段</td>
												<td width="20%">操作</td>
											</tr>
											<c:forEach var="stu1" items="${confrules}" varStatus="status">
												<tr>
													<td>${status.index + 1}</td>
													<td>
														<select class="form-control" name="column">
															<c:forEach items="${hdfsColumns1}" var="item">
													           <option <c:if test='${item == stu1.column}'>selected="selected"</c:if>value="${item}">${item}</option>
													        </c:forEach>
														</select>
													</td>
													<td>
														<select class="form-control" name="field">
															<c:forEach items="${esTableNameJson1}" var="item">
													    		<option <c:if test='${item == stu1.field}'>selected="selected"</c:if> value="${item}">${item}</option>
													        </c:forEach>
														</select>
													</td>
													<td style="width:280px">
														<input type="button" title="删除" class="btn-del" onclick='delFunc02(this)'/>
													</td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 这里是输出设置 -->
			<div class="col-md-4">
				<div class="panel panel-darwin">
					<div class="panel-heading">入ES索引设置</div>
					<div class="panel-body">
						<div class="form-group">
							<label for="indexName" class="control-label"><span class="redStar">*&nbsp;</span>选择索引</label>
							<div class="">
								<%
									String username = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getUsername();
									List<String> IndexList = EsIndexServices.selectIndexByUser02(username);
									session.setAttribute(Container.session_esIndexList, IndexList);
								%>
								<select id="indexName" name="indexName" class="form-control" data-rule="required;">
									<option value="">--选择索引--</option>
									<c:forEach items="${sessionScope.session_esIndexList}" var="list">
										<option <c:if test='${list == storeinfo.index}'>selected="selected"</c:if> value="${list}">${list}</option>
							        </c:forEach>
								</select>
							</div>
							<label class="help-block">*如果没有索引，请先<a href="<%=request.getContextPath() %>/es/edit.jsp?compId=${param.compId}&type=es">创建索引</a></label>
						</div>
						<div class="form-group">
							<label for="table" class=" control-label"><span class="redStar">*&nbsp;</span>选择表</label>
							<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='索引下的表' ></div>
							<div class="">
								<select id="esTablesSelect" id="table" name="table" class="form-control" data-rule="required;table">
									<option value="">--选择表--</option>
									<c:forEach items="${tableList}" var="list">
										<option  <c:if test='${list == storeinfo.table}'>selected="selected"</c:if> value="${list}">${list}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="dir" class=" control-label"></label>
							<div class="">
								<table class="table table-bordered" id="phoenixTables">
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content content">
      <div class="modal-header header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        	<span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Hdfs配置</h4>
      </div>
      <div class="modal-body">
			<div class="row">
				<!-- <h6>to ES组件</h6> -->
				<div class="col-md-12">
					<div class="form-group">
						<label for="hdfsPath" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>hdfs目录</label>
						<div class="col-sm-5">
							<input value="${config.inputinfo.hdfsPath}" class="form-control input-inline" placeholder="hdfs目录" id="hdfsPath" name="hdfsPath" data-rule="required;length[1~245];" readonly="readonly"/>
						</div>
						<div class="col-sm-1">
							<input value="选择" class="btn input-inline" name="select" type="button"/>
						</div>
						<div class="col-sm-2 checkbox">
							<label><input class="btn input-inline" name="ignoreRowFirst" type="checkbox" <c:if test='${config.inputinfo.ignoreRowFirst}'>checked="checked"</c:if> />忽略行首</label>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-3 control-label"></label>
						<div class="col-sm-5">
							<input type="button" value="删除模板" class="btn btn-danger" id="delSelectDsTmpBtn" onclick="delSelectDsTmpFunc()"/>
							<input type="button" value="另存为模板" class="btn" onclick="saveToDsTemplateFunc(this)"/>
							<div style="display: inline;" id="dsTemplateInput"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="moduleList" class="col-sm-3 control-label">使用已有模板</label>
						<div class="col-sm-5">
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
						<div class="col-sm-4">
							<p class="help-block">
								可以在已有模版列表中选择，已有模版已经预置了格式行和列的识别规则。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="delimited" class="col-sm-3 control-label">列分割符</label>
						<div class="col-sm-5" id="delimited_div">
							<select id="delimited" name="delimited" class="form-control">
								<%
									request.setAttribute("splitMap", DataCache.splitMap);
								%>
								<c:forEach items="${splitMap}" var="item">
								   <option <c:if test='${delimited == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								</c:forEach>
							</select>
							<div id="regInput" style="margin: 10px 0 0 0;" >
								<input id="delimited_type_hidden" value="${config.inputinfo.delimited_type}" type="hidden"/>
								<div id="delimited_hidden" style="display: none;">${delimited}</div>
								<textarea id="delimited_char" name="delimited_char" rows="" cols="100" class="form-control delimited_char_css" style="display: none;" <c:if test="${status eq 'online'}">readonly="readonly"</c:if>>${delimited}</textarea>
							</div>
						</div>
						<div class="col-sm-4">
							<p class="help-block">
								一般按照tab键，空格，逗号进行列分割，如需其他的列分割方式，可以选择正则表达式。
							</p>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<div class="checkbox">
								<label>
								<c:choose>
									<c:when test="${not empty config.inputinfo.notParser and config.inputinfo.notParser eq 'y'}">
										<input type="checkbox" id="notParser" name="notParser" checked="checked">不解析格式
										<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='暂时不解析数据的格式，将内容变成一列' ></span>
										<br>
									</c:when>
									<c:otherwise>
										<input type="checkbox" id="notParser" name="notParser" >不解析格式
										<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='暂时不解析数据的格式，将内容变成一列' ></span>
										<br>
									</c:otherwise>
								</c:choose>
								</label>
							</div>
							<div class="checkbox">
								<label>
									<c:if test="${not empty config.inputinfo.line and config.inputinfo.line}">
										<input type="checkbox" id="line" name="line" checked="checked">换行日志识别
										<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='处理一条数据显示了多行的情况，在遇到输入的识别符后开始下一条数据' ></span>
									</c:if>
									<c:if test="${empty config.inputinfo.line or !config.inputinfo.line}">
										<input type="checkbox" id="line" name="line">换行日志识别
										<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='处理一条数据显示了多行的情况，在遇到输入的识别符后开始下一条数据' ></span>
									</c:if>
								</label>
							</div>
							<input style="display: none;" id="lineCheckedFlg" value="${not empty config.inputinfo.line and config.inputinfo.line}"/>
							<c:if test="${not empty config.inputinfo.line and config.inputinfo.line}">
								<textarea placeholder="请输入换行日志识别的正则表达式" id="lineReg" name="lineReg" rows="" cols="100" class="form-control" <c:if test="${status eq 'online'}">readonly="readonly"</c:if>>${lineReg}</textarea>
							</c:if>
							<c:if test="${empty config.inputinfo.line or !config.inputinfo.line}">
								<textarea placeholder="请输入换行日志识别的正则表达式" id="lineReg" name="lineReg" rows="" cols="100" class="form-control" style="display: none;">${lineReg}</textarea>
							</c:if>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<textarea id="tmp_mulit_column" rows="" cols="120"  class="form-control" placeholder="以逗号分隔，可以输入多列，点击自动分隔，系统自动为您生成对应的列。如：col1,col2,col3"></textarea>
						</div>
					</div>
					<div class="form-group" >
						<div class="col-sm-12" style="text-align: right;">
							<input type="button" value="自动生成列" class="btn btn-success" onClick="autoCreateColumns()"/>
						</div>
					</div>
					<div class="text-left mtb10">
					<c:if test="${status eq 'online'}">
						<button class="btn btn-xs btn-default" type="button">
							<span class="glyphicon glyphicon-plus"></span>添加一行源字段
						</button>
						<button class="btn btn-xs btn-default" type="button">取消时间列</button>
					</c:if>
					<c:if test="${status eq 'offline'}">
						<button class="btn btn-xs btn-primary" type="button" id="newRow">
							<span class="glyphicon glyphicon-plus"></span>添加一行源字段
						</button>
						<button class="btn btn-xs btn-default" type="button" id="clearRadioSelect">取消时间列</button>
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='源数据含有的列数，可以将日期类型的列设置为时间列，在仪表盘中入ES的时间将是时间列的时间' ></div>
					</c:if>
					</div>
					<div id="table_div">
						<table class="table table-bordered table-hover" id="ruleTable" style="margin-bottom: 100px;">
							<tr class="success">
								<td>No</td>
								<td style="width:100px">是否是时间列</td>
								<td>列名</td>
								<td>描述</td>
								<td>类型</td>
								<td style="width:180px">操作</td>
							</tr>
						<c:forEach var="stu" items="${columnNames}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td ><div class="radio"><label>
									<c:choose>
										<c:when test="${stu.isTime}">
											<input name='columnTime' type="radio" value="${status.index + 1}" checked="${stu.isTime}"/>
										</c:when>
										<c:otherwise>
											<input name='columnTime' type="radio" value="${status.index + 1}" />
										</c:otherwise>
									</c:choose>
									
									</label></div>
								</td>
								<td><input name='columnName' class='form-control' value="${stu.name}" placeholder='请输入字段名称'/></td>
								<td>
									<input name='columnDesc' class='form-control' value="${stu.desc}" placeholder='请输入描述'/>
									<br>
									<c:choose>
										<c:when test="${stu.type eq 'Datetime'}">
											<input name='columnDateFormat' class='form-control' value="${stu.dateFormat}" placeholder="请输入时间格式"/>
										</c:when>
										<c:otherwise>
											<input name='columnDateFormat' class='form-control' value="${stu.dateFormat}" placeholder="请输入时间格式" style="display: none;"/>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<select name="columnType" class="form-control">
										<%
											request.setAttribute("fieldSettingMap", DataCache.fieldSettingMap);
										%>
										<c:forEach items="${fieldSettingMap}" var="item">
										   <option <c:if test='${stu.type == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
										</c:forEach>
									</select>
								</td>
								<td style="width:180px"> 
									<input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> 
									<input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> 
									<input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> 
									<input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> 
									<input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/>
								</td>
							</tr>
						</c:forEach>
						</table>
					</div>
					<div id="table_div_template"></div>
				</div>
			</div>
      </div>
      <div class="modal-footer">
        <button id="myModal_closeBtn" type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <c:if test="${status eq 'offline'}">
        	<button type="button" class="btn btn-primary" id="conn-save" >保存</button>
        </c:if>
      </div>
    </div>
  </div>
</div>

<script>
//输入框说明
$(".propmt").popover({
     trigger:'hover',
     placement:'bottom',
     html: true
     });

var hdfsColumns = [];//hdfs配置的列集合
var phoenixColumns = [];//phoenix选择的表的列集合

	$(function(){
		init();
		
		$('#conn-save').click(function(){
			//检测表单是否所有字段都验证通过
			$('#myModal').isValid(function(v){
// 			    console.log(v ? '表单验证通过' : '表单验证不通过');
			    	setHdfsColumns();
			    if(v)
				    $('#myModal').modal('hide');
			    return;
			});
			
	    	$('#conn-count').html($('.tr-setting').length);

			$("form").on("valid.form", function(e, form){
			});
			
		});
		
	       
		$("#type_bulkLoad").click(function(){
			if($(this).prop("checked")){
				$("#proces").attr("value","ok");
				$("#hdfs_hbase_conf_div").hide();
			}else{
				$("#proces").attr("value","");
				$("#hdfs_hbase_conf_div").show();
			}
		});
		
		//表单验证失败的函数
		function invalidFormFunc(){
			if(true)return;
		}

		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
		
		function init(){
			if($("#lineCheckedFlg").val()==true){
				$("#line").prop("checked",true);
			}else{
				$("#line").prop("disabled",false);
			}
			$("#lineCheckedFlg").remove();
			
		}
		
		if($("#hdfsColumns").text()!=''){
			var hdfsColumnsObj = eval("(" + $("#hdfsColumns").text() + ")");
			for(var s in hdfsColumnsObj){
				hdfsColumns.push(hdfsColumnsObj[s]["name"]);
			}
		}
		if($("#tableNameJson").text()!=''){
			var phoenixColumnsObj = eval("(" + $("#tableNameJson").text() + ")");
			phoenixColumns = [];
			for(var s in phoenixColumnsObj){
				phoenixColumns.push(phoenixColumnsObj[s]);//["COLUMN_NAME"]);
			}
		}
		init();
		
		//通用按钮的提交表单事件
		$("form").on("valid.form", function(e, form){
		});
		
		$("#newRow2").click(function(){
			$("#proces").attr("value","ok");
			addRow2(null,null);
		});
			
		//验证，hdfs弹出层区域，如果验证通过则隐藏，能提交则提交，不能则
		$('form').validator({
			valid: function(form){
			},
			invalid: function(form){
				$("#myModal").isValid(function(v){
// 					console.log(v ? 'myModal表单验证通过' : 'myModal表单验证不通过');
					
					if(v){$("#myModal_closeBtn").click();
						$('#result_15').hide();}
					else{
						var _html="<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>提交失败！【输入数据】没有设置完整，请检查hdfs配置。";
						$('#result_15').html(_html);
						$('#result_15').show();
					}
// 					if(!v){
						setHdfsColumns();
// 					}
					if(v)
	 				    $('#myModal').modal('hide');
	 			    return;
				});
				
				var _exist = false;
				if(!$("#type_bulkLoad").prop("checked")){
					
					var confTableTr = $("#confTable tr").size();
					if(confTableTr>1){
						$("#confTable tr:gt(0)").each(function(index,value){
							var _columnRule = $(this).find("select[name='column']").val();
							var _fieldRule = $(this).find("select[name='field']").val();
							if(_columnRule==null || _fieldRule==null){
								_exist = true;
							}
						});
					}else{
						_exist = true;
					}
					if(_exist){
						var _html="<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>提交失败！【处理过程】没有设置，必须勾选批量导入或者添加映射关系。";
						$('#result_15').html(_html);
						$('#result_15').show();
					}else{
// 						$('#result_15').hide();
					}
				}else{
// 					$('#result_15').hide();
				}
			}
		});
		
		function setHdfsColumns(){
			hdfsColumns = [];
// 			hdfsColumns.push("");
			$("#ruleTable tr:gt(0)").each(function(index,value){
// 				console.log(value);
				var columnName = $(value).find("td:eq(2)").find("input").val(); 
// 				console.log("columnName>>>>"+columnName);
				hdfsColumns.push(columnName);
			});
			
// 			console.log(hdfsColumns);
		}
		
		//line切换
		$("#line").click(function(){
// 			console.log("line.checked="+$(this).is(":checked")+",id="+$(this).attr("id"));
			if($(this).is(":checked")){
				$("#lineReg").show();
			}else{
				$("#lineReg").hide();
			}
		});
		
		$("#saveHdfsConfigBtn").click(function(){
			
		});
		
		
		$("#esTablesSelect").change(function(){
			var indexName = $("#indexName").val();
// 			console.log("phoenixTables..."+$(this).val());
// 			console.log("indexName..."+indexName);
			$("#phoenixTables").html("");
			
			if($(this).val() == ""){return;}
			
			$.ajax({
				url:"<%=request.getContextPath() %>/es?method=esColumnsByTableName",
				type:"post",
				data:{indexName:indexName,tableName:$(this).val()},
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					initPhoenixTableHtml(data);
				},
				error:function(){
					console.log("加载数据出错！");
				}
			});
			
		});
		
		$("#indexName").change(function(){
			
			if($(this).val() == ""){return;}
			
			$.ajax({
				url:"<%=request.getContextPath() %>/es?method=esTableByIndex&index="+$(this).val(),
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					$("#phoenixTables").html("");
					var _html="";
					_html += "<option value=''>--选择表--</option>";
					$.each(data,function(index,item){
						_html += "<option value='"+item.tableName+"'>"+item.tableName+"</option>";
					});
					$("#esTablesSelect").html(_html);
					
				},
				error:function(){
					console.log("加载数据出错！");
				}
			});
			
		});
		
		function initPhoenixTableHtml(data){
			if(!data){return;}
// 			console.log(data);
			var tr = "<tr><td>序列号</td><td>字段名</td><td>字段类型</td><tr>";
			phoenixColumns = [];
			$.each(data,function(index,value){
				tr += "<tr>";
				tr += "<td>" + (index+1) + "</td>";
				tr += "<td>" + value["COLUMN_NAME"] + "</td>";
				
				
// 				if(value["COLUMN_SIZE"]){
// 					tr += "<td>" + value["TYPE_NAME"] + "(" + value["COLUMN_SIZE"] + ")" + "</td>";
// 				}else{
				tr += "<td>" + value["TYPE_NAME"] + "</td>";
// 				}
				
				tr += "</tr>";
				
				phoenixColumns.push(value);//["COLUMN_NAME"]);
			});
			$("#phoenixTables").append("").append(tr);
		}
		
		initPhoenixTableHtml(phoenixColumnsObj);
		
		$("#myModal_closeBtn").click(function(){
// 			console.log("myModal_closeBtn.click...");
			
			setHdfsColumns();
		});
				
	});
	
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow2(target,insertBefore){
		$("#proces").attr("value","ok");
		var confTableTr = $("#confTable tr").size();
		var _row = "<tr>";
		_row += "<td>"+confTableTr+"</td>";

		var _selectComp = "<select data-rule='required;' name='column' class=\"form-control\">";
		for(var s in hdfsColumns){
			_selectComp += "<option>"+hdfsColumns[s]+"</option>";
		}
		_selectComp += "</select>";
		_row += "<td>"+_selectComp+"</td>";
		
		var _phoenixColumns = "<select data-rule='required;' name='field' class=\"form-control\">";
		for(var s in phoenixColumns){
			_phoenixColumns += "<option>"+phoenixColumns[s]["COLUMN_NAME"]+"("+phoenixColumns[s]["TYPE_NAME"]+")</option>";
		}
		_phoenixColumns += "</select>";
		_row += "<td>"+_phoenixColumns+"</td>";
		
		_row += "<td> <input type='button' title='删除' class='btn-del' id='del' onclick='delFunc02(this)'/></td>";
		_row += "</tr>";
		
		$("#confTable").append(_row);
		
	}
	
	//del
	function delFunc02(obj){
		$(obj).parent().parent().remove();
		var confTableTr = $("#confTable tr").size();
		if(confTableTr<=1){
			$("#proces").attr("value","");
		}
	}
	
</script>


<script>

	function init01(){
		if($("#lineCheckedFlg").val()==true){
			$("#line").prop("checked",true);
		}else{
			$("#line").prop("disabled",false);
		}
		$("#lineCheckedFlg").remove();
		
		$("#notParser").click(function(){
			if($(this).prop("checked")){
				$("#newRow").addClass("disabled");
				$("#newDateTimeRow").addClass("disabled");
				$("#clearRadioSelect").addClass("disabled");
			}else{
				$("#newRow").removeClass("disabled");
				$("#newDateTimeRow").removeClass("disabled");
				$("#clearRadioSelect").removeClass("disabled");
			}
		});
		
		if($("#notParser").prop("checked")){
			$("#newRow").addClass("disabled");
			$("#newDateTimeRow").addClass("disabled");
			$("#clearRadioSelect").addClass("disabled");
		}
		
	}
	
	$(function(){
		init01();
		
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
		
		$("#newDateTimeRow").click(function(){
			addDateTimeRow(null,null);
		});
		
		$("#delimited").change(function(){
			var sval = $(this).val();
			var status = $("#status").val();
			if(sval=='REGX'){
				var _input = "";
				if(status =='online'){
					$("#delimited_char").attr("style","");
// 					_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" readonly=\"readonly\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
				}else{
					$("#delimited_char").attr("style","");
// 					_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
				}
				
				if($("#delimited_hidden").text()!=''){
					if(status =='online'){
						$("#delimited_char").attr("style","");
// 						_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" readonly=\"readonly\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
					}else{
						$("#delimited_char").attr("style","");
// 						_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
					}
				}
// 				$("#regInput").html(_input);
			}else{
// 				$("#regInput").html("");
				$("#delimited_char").attr("style","display:none;");
			}
		});
		
		//选中列分隔符
		var delimited_type_hidden = $("#delimited_type_hidden").val();
		if(delimited_type_hidden!=''){
			if(delimited_type_hidden=='REGX'){
				$("#delimited").val(delimited_type_hidden);
				var status = $("#status").val();
				var _input ="";
				if(status =='online'){
// 					_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" readonly=\"readonly\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
				}else{
// 					_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
				}
				$("#delimited_char").attr("style","");
// 				$("#regInput").html(_input);
				
			}else if(delimited_type_hidden=='FIELD'){
				$("#delimited").val($("#delimited_hidden").text());
			}
		}
		
		$("#clearRadioSelect").click(function(){
			$("input[name='columnTime']").attr("checked",false);				
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
		_row += "<td style=\"width:'100px'\"><div class=\"radio\"><label><input name='columnTime' type='radio' value='"+ruleTableTr+"'/></label></div></td>";
		_row += "<td><input name='columnName' class='form-control' value='"+defaultValue+"'/></td>";
		_row += "<td><input name='columnDesc' placeholder='请输入描述' class='form-control'/><br><input name='columnDateFormat' placeholder='请输入时间格式' class='form-control' style='display:none;'/></td>";
		_row += "<td><select name='columnType' onchange='columnTypeChange0($(this))' class='form-control'><option value='Text'>文本</option><option value='String'>字符串</option><option value='Integer'>数值</option><option value='Datetime'>日期</option><option value='Timestamp'>长整型</option><option value='Double'>浮点型</option></select></td>";
		_row += "<td style=\"width:'180px'\"> <input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/></td>";
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
	
	function upInsertFunc(obj){
		var target = $(obj).parent().parent();
		addRow(target,true);
	}
	
	function downInsertFunc(obj){
		var target = $(obj).parent().parent();
		addRow(target,false);
	}
	
	//del
	function delFunc(obj){
		$(obj).parent().parent().remove();
	}
	
	//移动元素
	function shift(select,target,insertBefore){
		var _no = $(target).find("td").eq(0).html();
		
		//alert(isNaN($(target).find("td").eq(0).html()));
		if(_no=="No"){
			return;
		}
		
		if(insertBefore){
			$(select).insertBefore(target);
		}else{
			$(select).insertAfter(target);
		}
	}
	
	//上移
	function upShiftFunc(obj){
		var select = $(obj).parent().parent();
		var target = $(select).prev();
		shift(select,target,true);
	}
	
	//下移
	function downShiftFunc(obj){
		var select = $(obj).parent().parent();
		var target = $(select).next();
		shift(select,target,false);
	}
	$("#clearRadioSelect").click(function(){
				$("input[name='columnTime']").attr("checked",false);				
			});
			
	function columnTypeChange0(t){
		var val = $(t).val();
		if(val=="Datetime"){
			$(t).parent().parent().find("input[name='columnDateFormat']").show();
		}else{
			$(t).parent().parent().find("input[name='columnDateFormat']").hide();
		}
	}
	
	$("select[name='columnType']").bind("change",function(){
			columnTypeChange0($(this))
	});
	
	//另存为模板
	function saveToDsTemplateFunc(obj){
		
		//模板名称不存在则要求输入
		var _dsTemplate = $("#dsTemplateInput").find("input[name='dsTemplateName']");
		if(_dsTemplate.length==0){
// 			console.log("模板名称不存在则要求输入");
			$("#dsTemplateInput").append("<input id='dsTemplateName' name='dsTemplateName' class='form-control' placeholder=\"请输入模板名称\"/>");
			$("#dsTemplateInput").find("input[name='dsTemplateName']").focus();
			$(obj).val("保存");
			return;
		}
		
		var _ruleConf = {};
		_ruleConf["newLine"] = $("#newLine").val();
		//_ruleConf["delimited_type"] = $("#delimited_type").val();
		//_ruleConf["delimited"] = $("#delimited_char").val();
		//_ruleConf["delimited_type"] = $("#delimited").val()=="REGX"?"REGX":"FIELD";
		if($("#delimited").val()=="REGX"){
			_ruleConf["delimited_type"] = "REGX";
			_ruleConf["delimited"] = $("#delimited_char").val();
		}else{
			_ruleConf["delimited_type"] = "FIELD";
			_ruleConf["delimited"] = $("#delimited").val();
		}
		if($("#notParser").prop("checked")){
			_ruleConf["notParser"] = "y";
		}else{
			_ruleConf["notParser"] = "n";
		}
		if($("#line").prop("checked")){
			_ruleConf["line"] = "true";
		}else{
			_ruleConf["line"] = "false";
		}
		_ruleConf["lineReg"] = $("#lineReg").val();
		var _name = $("#dsTemplateInput").find("input[name='dsTemplateName']").val();
		if($.trim(_name)==''){
			$("#dsTemplateInput").find("input[name='dsTemplateName']").focus();
			return;
		}
		//获取columns
		var _columns = [];
		$("#ruleTable tr:gt(0)").each(function(index,value){
			//console.log(index+","+value+",html="+$(this).html());
// 					var _columnTime = $(this).find("input[name=columnTime]").attr("value");
			var _columnTime = $(this).find("input[name=columnTime]").prop("checked");
			var _columnName = $(this).find("input[name='columnName']").val();
			var _columnDesc = $(this).find("input[name='columnDesc']").val();
			var _columnDateFormat = $(this).find("input[name='columnDateFormat']").val();
			var _columnType = $(this).find("select[name='columnType']").val();
//			var _columnKvMainId = $(this).find("select[name='kvMainId']").val();
			var _row = {};
			_row["isTime"] = _columnTime;
			_row["name"] = _columnName;
			_row["desc"] = _columnDesc;
			_row["dateFormat"] = _columnDateFormat;
			_row["type"] = _columnType;
//			_row["kvMainId"] = _columnKvMainId;
			
			if(!(_columnName=='' && _columnDesc=='' && _columnType=='')){
				_columns.push(_row);
			}
		});
		_ruleConf["columns"] = _columns;
		
		$.ajax({
			url:"<%=request.getContextPath() %>/es?method=saveToDsTemplateFunc",
			type:"post",
			data:{"ruleConf":JSON.stringify(_ruleConf),"tmpName":_name,"type":"es"},
			dataType:"text",
			success:function(data, textStatus){
				if(data==0){
					alert("保存成功！");
					$.ajax({
						url:"<%=request.getContextPath() %>/es?method=esTemplateList",
						type:"post",
						dataType:"json",
						success:function(data, textStatus){
							var _html="";
							_html += "<option value=''></option>";
							$.each(data,function(index,item){
								if(_name==item.name){
									_html += "<option selected='selected' value='"+item.id+"'>"+item.name+"</option>";
								}else{
									_html += "<option value='"+item.id+"'>"+item.name+"</option>";
								}
							});
							$("#delSelectDsTmpBtn").show();
							$("#moduleList").html(_html);
							
							$("#dsTemplateName").remove();
							$(obj).val("另存为模板");
						},
						error:function(){
							alert("删除失败！");
						}
					});
				}else if(data==2){
					alert("模板已存在，保存失败！");
				}else{
					alert("保存失败！");
				}
			},
			error:function(){
				alert("保存模板出错！");
			}
		});
	}
	
	//删除选中的模板
	function delSelectDsTmpFunc(){
		if(confirm("确认删除选中的模板吗？")){
			var dsTmpId = $("#moduleList").children('option:selected').val();
			$.ajax({
				url:"<%=request.getContextPath() %>/datasources?method=delSelectDsTmp",
				type:"post",
				data:{"dsTmpId":dsTmpId},
				dataType:"text",
				success:function(data, textStatus){
					if(data==0){
						initBlankDiv();
						$.ajax({
							url:"<%=request.getContextPath() %>/es?method=esTemplateList",
							type:"post",
							dataType:"json",
							success:function(data, textStatus){
								
								var _html="";
								if(data!=""){
									_html += "<option selected='selected' value=''></option>";
									$.each(data,function(index,item){
										_html += "<option value='"+item.id+"'>"+item.name+"</option>";
									});
								}else{
									_html += "<option selected='selected' value=''>无</option>";
								}
								$("#moduleList").html(_html);
							},
							error:function(){
								alert("删除失败！");
							}
						});
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
	
	var oldSelect = $("#moduleList").children('option:selected').val();
	//删除模板按钮的隐藏和显示
	if(oldSelect==''){
		$("#delSelectDsTmpBtn").hide();
	}else{
		$("#delSelectDsTmpBtn").show();
	}
	
	$("#moduleList").change(function(){
		if(true){
			if(confirm("确认切换成新的模板么？")){
				//if($(this).val() == ""){return;}
				var newSelect = $(this).val();
				if(newSelect==""){
					initBlankDiv();
					
				}else{
					$("#delSelectDsTmpBtn").show();
					$.ajax({
						url:"<%=request.getContextPath() %>/es?method=esTemplateChange&tmpId="+$(this).val(),
						type:"post",
						dataType:"json",
						async:true,
						success:function(data, textStatus){
							initTemplateHtml(data);
						},
						error:function(){
							console.log("加载数据出错！");
						}
					});
				}
		
			}else{
				$(this).val(oldSelect);
			}
		return;
		}
	});
	
	function initBlankDiv(){
		$("#delSelectDsTmpBtn").hide();
		var _html="";
		_html += "<option selected='selected' value='\\t'>tab键</option>";
		_html += "<option value=' '>空格</option>";
		_html += "<option value=','>逗号</option>";
		_html += "<option value='REGX'>正则表达式</option>";
		$("#delimited_char").attr("style","display: none;");
		$("#delimited_char").text("");
		$("#delimited").html(_html);
		$("#notParser").attr("checked",false);
		$("#line").attr("checked",false);
		$("#lineReg").attr("style","display: none;");
		$("#lineReg").text("");
		
		var _row="";
		_row += "<table class='table table-bordered table-hover' id='ruleTable' style='margin-bottom: 100px;'>";
		_row += "<tr class='success'><td>No</td><td style='width:100px'>是否是时间列</td><td>列名</td><td>描述</td><td>类型</td><td style='width:180px'>操作</td></tr>";
		//$("#table_div").remove();
		$("#table_div_template").html(_row);
	}
	
	
	function initTemplateHtml(data){
		if(!data){return;}
		//填充数据到页面
// 		console.log("填充数据到页面");
		var _html="";
		
		$("#delimited_type_hidden").text(data.delimited_type);
		
		if(data.delimited_type=="REGX"){
			_html += "<option value='\\t'>tab键</option>";
			_html += "<option value=' '>空格</option>";
			_html += "<option value=','>逗号</option>";
			_html += "<option selected='selected' value='REGX'>正则表达式</option>";
			$("#delimited_char").attr("style","");
			$("#delimited_char").attr("disable",true);
			$("#delimited_char").text(data.delimited);
			$("#delimited_char_hidden").val(data.delimited);
			
		}else if(data.delimited_type=="FIELD"){
			if(data.delimited==" "){
				_html += "<option value='\\t'>tab键</option>";
				_html += "<option selected='selected' value=' '>空格</option>";
				_html += "<option value=','>逗号</option>";
				_html += "<option value='REGX'>正则表达式</option>";
				$("#delimited_char").attr("style","display: none;");
				$("#delimited_char").text(data.delimited);
			}else if(data.delimited==","){
				_html += "<option value='\\t'>tab键</option>";
				_html += "<option value=' '>空格</option>";
				_html += "<option selected='selected' value=','>逗号</option>";
				_html += "<option value='REGX'>正则表达式</option>";
				$("#delimited_char").attr("style","display: none;");
				$("#delimited_char").text(data.delimited);
			}else{
				_html += "<option selected='selected' value='\\t'>tab键</option>";
				_html += "<option value=' '>空格</option>";
				_html += "<option value=','>逗号</option>";
				_html += "<option value='REGX'>正则表达式</option>";
				$("#delimited_char").attr("style","display: none;");
				$("#delimited_char").text(data.delimited);
			}
		}
		$("#delimited").html(_html);
		if(data.notParser=="y"){
			$("#notParser").prop("checked",true);
		}else{
			$("#notParser").attr("checked",false);
		}
		if(data.line=="true"){
			$("#line").prop("checked","checked");
			$("#lineReg").attr("style","");
			$("#lineReg").text(data.lineReg);
		}else{
			$("#line").attr("checked",false);
			$("#lineReg").attr("style","display: none;");
			$("#lineReg").text("");
		}
		
		//根据columns自动生成表格
		$("#table_div_template").html("");
		var _row="";
		_row += "<table class='table table-bordered table-hover' id='ruleTable' style='margin-bottom: 100px;'>";
		_row += "<tr class='success'><td>No</td><td style='width:100px'>是否是时间列</td><td>列名</td><td>描述</td><td>类型</td><td style='width:180px'>操作</td></tr>";
 		if(data.columns != ""){
			var _d = data.columns;
			var n=0;
			$.each(_d,function(index,item){
				n=n+1;
				_row += "<tr>";
				_row += "<td>"+n+"</td>";
				_row += "<td style=\"width:'100px'\"><div class=\"radio\"><label>";
				if(item.isTime){
					_row += "<input name='columnTime' type='radio' value='"+n+"' checked='checked'/>";
				}else{
					_row += "<input name='columnTime' type='radio' value='"+n+"'/>";
				}
				_row += "</label></div></td>";
				_row += "<td><input name='columnName' class='form-control' value='"+item.name+"'/></td>";
				_row += "<td><input name='columnDesc' placeholder='请输入描述' value='"+item.desc+"' class='form-control'/><br>";
				if(item.type=="Datetime"){
					_row += "<input name='columnDateFormat' value='"+item.dateFormat+"' placeholder='请输入时间格式' class='form-control'/>";
				}else{
					_row += "<input name='columnDateFormat' placeholder='请输入时间格式' class='form-control' style='display:none;'/>";
				}
				_row += "</td>";
				_row += "<td>";
				_row += "<select name='columnType' onchange='columnTypeChange0($(this))' class='form-control'>";
				if(item.type=="Text"){
					_row += "<option selected='selected' value='Text'>文本</option><option value='String'>字符串</option>";
					_row += "<option value='Integer'>数值</option><option value='Datetime'>日期</option>";
					_row += "<option value='Timestamp'>长整型</option><option value='Double'>浮点型</option>";
				}else if(item.type=="String"){
					_row += "<option value='Text'>文本</option><option selected='selected' value='String'>字符串</option>";
					_row += "<option value='Integer'>数值</option><option value='Datetime'>日期</option>";
					_row += "<option value='Timestamp'>长整型</option><option value='Double'>浮点型</option>";
				}else if(item.type=="Integer"){
					_row += "<option value='Text'>文本</option><option value='String'>字符串</option>";
					_row += "<option selected='selected' value='Integer'>数值</option><option value='Datetime'>日期</option>";
					_row += "<option value='Timestamp'>长整型</option><option value='Double'>浮点型</option>";
				}else if(item.type=="Datetime"){
					_row += "<option value='Text'>文本</option><option value='String'>字符串</option>";
					_row += "<option value='Integer'>数值</option><option selected='selected' value='Datetime'>日期</option>";
					_row += "<option value='Timestamp'>长整型</option><option value='Double'>浮点型</option>";
				}else if(item.type=="Timestamp"){
					_row += "<option value='Text'>文本</option><option value='String'>字符串</option>";
					_row += "<option value='Integer'>数值</option><option value='Datetime'>日期</option>";
					_row += "<option selected='selected' value='Timestamp'>长整型</option><option value='Double'>浮点型</option>";
				}else if(item.type=="Double"){
					_row += "<option value='Text'>文本</option><option value='String'>字符串</option>";
					_row += "<option value='Integer'>数值</option><option value='Datetime'>日期</option>";
					_row += "<option value='Timestamp'>长整型</option><option selected='selected' value='Double'>浮点型</option>";
				}
				_row += "</select></td>";
				_row += "<td style=\"width:'180px'\"> <input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/></td>";
				_row += "</tr>";
			});
 		}
		$("#table_div").remove();
		$("#table_div_template").html(_row);
		
	}

	function autoCreateColumns(){
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

<SCRIPT type="text/javascript">
function showLayer(_id,_value){
	layer.open({
	    type: 2,
// 	    border: [0,1,'#61BA7A'], //不显示边框
	    area: ['600px', '600px'],
// 	    shade: 0.8,
	    closeBtn: true,
	    shadeClose: true,
	    skin: 'layui-layer-molv', //墨绿风格
	    fix: false, //不固定
// 	    maxmin: true,
	    content: 'hdfsTree.jsp?compId='+_id+'&pathValue='+_value
	});
}

$("input[name=select]").click(function(){
	var _id = $(this).parent().parent().find("input:eq(0)").attr("id");
	var _value = $(this).parent().parent().find("input:eq(0)").val();
	showLayer(_id,_value);
});

function openAdvancedSet(){
    if($("#advancedSet").is(":hidden")){
       $("#advancedSet").show();
    }else{
       $("#advancedSet").hide();
       $(".msg-wrap").remove();
    }
}
function testSet(){
	$("#ruleTable tr:gt(0)").each(function(index,value){
		var _columnTime = $(this).find("input[name=columnTime]").prop("checked");
		var _columnName = $(this).find("input[name='columnName']").val();
		if(_columnTime){
			$("#isTimeHidden").val(_columnName);
		}
	});
}

</SCRIPT>

</form>