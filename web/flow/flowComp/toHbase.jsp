<%@page import="java.util.*"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.alibaba.fastjson.*"%>
<%@page import="com.stonesun.realTime.services.db.FlowCompServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<form id="rightForm" action="<%=request.getContextPath() %>/flowComp?method=save" method="post" class="form-horizontal" role="form"  notBindDefaultEvent="true" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" >
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
<input id="flowId" name="flowId" value="${flowId}" type="hidden"/>
<input id="delimited_char_hidden" name="delimited_char_hidden" value="" type="hidden"/>
<div id="hdfsColumns" style="display: none;">${hdfsColumns}</div>
<div id="confrules" style="display: none;">${confrules}</div>
<div id="phoenixTableNameJson" style="display: none;">${phoenixTableNameJson}</div>
<!-- 组件通用信息设置 -->
<div class="panel panel-default">
	<ol class="breadcrumb">
		<li><a href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">所属的流程名称：${flowName}</a></li>
		<li class="active">入Hbase组件配置</li>
	</ol>
	<div id="result_15" class="alert alert-danger alert-dismissible" role="alert" style="margin-top: -20px;display:none;">
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
		<div class="col-sm-5">
			<input <c:if test='${empty name}'>value="组件名称"</c:if>value="${name}" class="form-control input-inline" placeholder="组件名称" id="name" name="name" data-rule="required;length[1~45];"/>
		</div>
		<div class="col-sm-1">
			<input class="btn btn-primary" type="submit" value="保存"/>
		</div>
		<div class="col-sm-1">
			<a class="btn btn-primary"  href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">返回流程</a>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- 这里是获取设置 -->
			<div class="col-md-3">
				<div class="panel panel-darwin">
					<div class="panel-heading">输入数据</div>
<!-- 					<button id="saveHdfsConfigBtn" type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" > -->
<!-- 				  hdfs配置 -->
<!-- 				</button> -->
					<div class="panel-body">
						<div class="box box-default">
							<div class="box-heading">
								hdfs配置
							</div>
<!-- 							<div class="box-body"> -->
<%-- 								<span id="conn-count">${rulesize}</span>个远程文件 --%>
<!-- 							</div> -->
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
			<div class="col-md-5">
				<div class="panel panel-darwin">
					<div class="panel-heading">处理过程</div>
					<div class="panel-body">
						<input type="checkbox" <c:if test='${bulkLoad}'>checked="checked"</c:if> value="bulkLoad" name="type_bulkLoad" id="type_bulkLoad"/>批量导入
						<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='将导入的源数据的整批导入，出现错误数据时停止导入' ></span>
<!---->
						<span class="msg-box n-right" style="position:static;" for="hbaseNotNullFiledCheck"></span>
	
						<input name="hbaseNotNullFiledCheck" value="ok" style="display:none;"/>
						<div id="hdfs_hbase_conf_BlukDiv" <c:if test='${bulkLoad}'>style="display: block;"</c:if>>
								<table class="table table-bordered table-hover" id="confTableBluk">
									<tr>
										<td width="40%">数据列</td>
										<td width="45%">HBase字段</td>
									</tr>

								</table>

						</div>

						<span id="_dateInfoMess" style="color:blue;"></span>
						<input value="${proces }"  id="proces" name="proces" data-rule="required;" type="hidden"/>
						<span id="procesError" style="" class="msg-box" for="proces"></span>
						<div id="hdfs_hbase_conf_div" <c:if test='${bulkLoad}'>style="display: none;"</c:if>>
							<div class="row">
								<div class="col-sm-12">
									<div class="text-right">
										<button class="btn btn-primary" type="button" id="newRow2">添加字段映射</button>
									</div>
									<label >已添加的映射字段：</label>
									<span  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='映射导入数据，出现错误跳过本条数据，继续导入下一条数据。映射字段的最大数量是源数据的列数。数据列为hdfs配置中的源字段，Hbase字段为表中的字段' ></span>
								</div>
								
								<div class="col-sm-12" style="margin-bottom: 100px;">
									<table class="table table-bordered table-hover" id="confTable" >
										<tr>
<!-- 											<td width="10%" style="display: none;">No</td> -->
											<td width="40%">数据列</td>
											<td width="45%">HBase字段</td>
											<td width="15%">操作</td>
										</tr>
										<c:forEach var="stu1" items="${confrules}" varStatus="status">
											<tr>
												<td style="display: none;">${status.index + 1}</td>
												<td>
													<select class="form-control" name="column">
														<c:forEach items="${hdfsColumns1}" var="item">
												           <option <c:if test='${item == stu1.column}'>selected="selected"</c:if>value="${item}">${item}</option>
												        </c:forEach>
													</select>
												</td>
												<td>
													<select class="form-control" name="field" onchange="phoenixSelectChangefunc(this)">
														<c:forEach items="${phoenixTableNameJson1}" var="item">
												    		<option <c:if test='${item == stu1.field}'>selected="selected"</c:if> value="${item}">${item}</option>
												        </c:forEach>
													</select>
													
													<c:choose>
														<c:when test="${empty stu1.dateFormat or stu1.dateFormat eq '-'}">
															<input class="form-control" name="dateFormat" style="display: none;" value="-"/>
														</c:when>
														<c:otherwise>
															<input class="form-control" name="dateFormat" value="${stu1.dateFormat}"/>
														</c:otherwise>
													</c:choose>
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
			<!-- 这里是输出设置 -->
			<div class="col-md-4">
				<div class="panel panel-darwin">
					<div class="panel-heading">Hbase表设置</div>
					<div class="panel-body">
						<div class="form-group" style="display: none;">
							<label for="dir" class="control-label">HBase连接</label>
							<div class="">
								<select id="hbaseConnId" name="hbaseConnId" class="form-control">
									<option value=""></option>
									<c:forEach items="${sessionScope.session_hbaseList}" var="list">
							           <option  <c:if test='${list.id == storeinfo.hbaseConnId}'>selected="selected"</c:if> value="${list.id}">${list.name}</option>
							        </c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="dir" class=" control-label"><span class="redStar">*&nbsp;</span>选择表</label>
							<div class="">
								<div id="storeinfo_table">${storeinfo.table}</div>
								<%
								request.setAttribute("hbaseTables", null);//AnalyticsServices.selectHBaseTables(request));
								%>
								<select id="phoenixTablesSelect" name="table" class="form-control" data-rule="required;table">
									<option></option>
								</select>
								
								<c:if test="${1==2}">
									<select id="phoenixTablesSelect" name="table" class="form-control" data-rule="required;table">
										<option></option>
										<c:forEach items="${hbaseTables}" var="list">
											<option  <c:if test='${list == storeinfo.table}'>selected="selected"</c:if> value="${list}">${list}</option>
										</c:forEach>
									</select>
								</c:if>
								
							</div>
							<label class="help-block">*如果没有Hbase表，请先<a href="<%=request.getContextPath() %>/analytics/edit.jsp?linktype=Hbase&compId=${param.compId}">创建表</a></label>
						</div>
						<div class="form-group">
							<label for="dir" class=" control-label"></label>
							<div class="">
								<table class="table table-bordered" id="phoenixTables">
<!-- 									<tr> -->
<!-- 										<td>序列号</td> -->
<!-- 										<td>字段名</td> -->
<!-- 										<td>属性</td> -->
<!-- 									</tr> -->
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="dataJson" style="display: none;">
	<select class="form-control" name="column">
		<%
			session.setAttribute("dataList", FlowCompServices.selectDataList());
		%>
		<c:forEach items="${dataList}" var="list">
           <option <c:if test='${list.name == stu1.column}'>selected="selected"</c:if>value="${list.name}">${list.name}</option>
        </c:forEach>
	</select>
</div>

<div id="hbaseJson" style="display: none;">
	<select class="form-control" name="field">
		<%
			session.setAttribute("hbaseList", FlowCompServices.selectHbaseList());
		%>
		<c:forEach items="${hbaseList}" var="list">
           <option <c:if test='${list.name == stu1.field}'>selected="selected"</c:if>value="${list.name}">${list.name}</option>
        </c:forEach>
	</select>
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
						<label for="dataType" class="col-sm-3 control-label">数据类型</label>
						<div class="col-sm-5">
							<select class="form-control" name="dataType" id="dataType">
								<option value="text" <c:if test='${config.inputinfo.dataType eq "text"}'>selected</c:if>>文本</option>
								<option value="binary" <c:if test='${config.inputinfo.dataType eq "binary"}'>selected</c:if>>二进制</option>
								<option value="compress" <c:if test='${config.inputinfo.dataType eq "compress"}'>selected</c:if>>gz压缩的文本</option>
							</select>
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
								   <option <c:if test='${config.inputinfo.splitOrReg == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								</c:forEach>
							</select>
							<div id="regInput" style="margin: 10px 0 0 0;" ></div>
							<input id="delimited_type_hidden" value="${config.inputinfo.split}" type="hidden"/>
							<div id="delimited_hidden" style="display: none;">${config.inputinfo.splitOrReg}</div>
							<textarea id="delimited_char" rows="" cols="100" class="form-control delimited_char_css" style="display: none;" <c:if test="${status eq 'online'}">readonly="readonly"</c:if>>${config.inputinfo.splitOrReg}</textarea>
						</div>
						<div class="col-sm-4">
							<p class="help-block">
								一般按照tab键，空格，逗号进行列分割，如需其他的列分割方式，可以选择正则表达式。
							</p>
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label for="split" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>数据分隔符</label> -->
<!-- 						<div class="col-sm-2"> -->
<!-- 							<select id="split" name="split" class="form-control" > -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-5"> -->
<%-- 							<textarea rows="4" cols="100" class="form-control input-inline" placeholder="分隔符或正则表达式" id="splitOrReg" name="splitOrReg" data-rule="required;length[1~200];">${config.inputinfo.splitOrReg}</textarea> --%>
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="form-group">
						<label for="columnNumber" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>分隔列数</label>
						<div class="col-sm-5">
							<input class="form-control input-inline" placeholder="分隔列数" id="columnNumber" name="columnNumber" value="${config.inputinfo.columnNumber}" data-rule="required;length[1~45];"/>
						</div>
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='将数据分隔成的列数，在此输入列数后会在下方显示与输入内容相对应的列数'  ></div>
					</div>
					<div class="form-group">
						<label for="fileRuleType" class="col-sm-3 control-label">数据范围</label>
						<div class="col-sm-5">
							<select class="form-control" id="fileRuleType" name="fileRuleType">
								<option value="dir-time" <c:if test='${config.inputinfo.fileRuleType eq "dir-time"}'>selected</c:if>>目录下目录名符合【时间】规则的文件</option>
								<option value="file-time" <c:if test='${config.inputinfo.fileRuleType eq "file-time"}'>selected</c:if>>目录下文件名符合【时间】规则的文件</option>
								<option value="file-all" <c:if test='${config.inputinfo.fileRuleType eq "file-all"}'>selected</c:if>>选定的文件/目录下所有文件</option>
								<option value="file-rule" <c:if test='${config.inputinfo.fileRuleType eq "file-rule"}'>selected</c:if>>选定目录下所有符合规则的文件</option>
								<option value="period" <c:if test='${config.inputinfo.fileRuleType eq "period"}'>selected</c:if>>指定周期</option>
							</select>
						</div>
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='此选择项针对文件路径&lt;/br&gt;1、目录下目录名符合时间规则的文件：选择下方符合时间规则的文件夹&lt;/br&gt;2、目录下文件名符合时间规则的文件：：选择下方符合时间规则的文件&lt;/br&gt;3、指定周期则选择对应周期的文件'  ></div>
					</div>
					<div class="form-group" id="fileRuleDiv">
						<label for="fileRule" class="col-sm-3 control-label" id="fileRuleLabel">
							<c:choose>
								<c:when test="${config.inputinfo.fileRuleType eq 'dir-time'}">
								   <span class="redStar">*&nbsp;</span>目录名时间规则
								</c:when>
								<c:when test="${config.inputinfo.fileRuleType eq 'file-time'}">
								   <span class="redStar">*&nbsp;</span>	
									文件名时间规则
								</c:when>
								<c:when test="${config.inputinfo.fileRuleType eq 'file-all'}">
								    <span class="redStar">*&nbsp;</span>所有文件
								</c:when>
								<c:otherwise>
									<span class="redStar">*&nbsp;</span>文件规则
								</c:otherwise>
							</c:choose>
						</label>
						<div class="col-sm-5">
							<input value="${config.inputinfo.fileRule}" class="form-control input-inline" placeholder="yyyymmdd" id="fileRule" name="fileRule" data-rule="required;length[1~45];"/>
						</div>
					</div>
					<div class="form-group">
						<label for="charset" class="col-sm-3 control-label">字符集</label>
						<div class="col-sm-5">
							<select class="form-control" id="charset" name="charset">
								<%
									session.setAttribute("charsetList", DataCache.charsetList);
								%>
								<c:forEach items="${charsetList}" var="list">
						           <option <c:if test='${list.key == config.inputinfo.charset}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
						        </c:forEach>
							</select>
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
					<div class="text-right mtb10">
						<button class="btn btn-xs btn-primary" type="button" id="newRow">
							<span class="glyphicon glyphicon-plus"></span>添加一行源字段
						</button>
					</div>
					<div id="table_div">
						<table class="table table-bordered table-hover" id="ruleTable" style="margin-bottom: 100px;">
							<tr class="success">
								<td width="60">列序号</td>
								<td>列名</td>
								<td>操作</td>
							</tr>
							<c:forEach var="colm" items="${columnNames}" varStatus="status">
								<tr>
									<td>${status.index + 1}</td>
									<td><input name='columnName' class='form-control' value="${colm.columnName}" placeholder='请输入列名'/></td>
									<td>
										<input type='button' class="btn-insertabove" title='上插' id='upInsert' onclick='upInsertFunc(this)'/>
										<input type='button' class="btn-insertbelow" title='下插' id='downInsert' onclick='downInsertFunc(this)'/> 
										<input type='button' class="btn-moveup" title='上移' id='upShift' onclick='upShiftFunc(this)'/> 
										<input class="btn-movedown" type='button' title='下移' id='downShift' onclick='downShiftFunc(this)'/> 
										<input type='button' class="btn-del" title='删除' id='del' onclick='delFunc(this)'/>
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
        <button type="button" class="btn btn-primary" id="conn-save" >保存</button>
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
var blukNotInit = true;

	$(function(){

		function createMark_loadingHbaseTables(){
			if ($.blockUI===undefined) {
				$.blockUI = common.blockUI;
			} 

			$.blockUI({ message: "正在加载phoenix表，请等待...",css: { 
		        border: 'none', 
		        padding: '15px', 
		        backgroundColor: '#000', 
		        '-webkit-border-radius': '10px', 
		        '-moz-border-radius': '10px', 
		        opacity: .5, 
		        color: '#fff' 
		    }});
		}

		//localing hbase tables
		function loadingHbaseTables(){
			createMark_loadingHbaseTables();
			$.ajax({
				url:"<%=request.getContextPath() %>/flowComp?method=loadingHbaseTables",
				type:"post",
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					//console.log("loadingHbaseTables..");
					//console.log(data);

					$.each(data,function(index,value){
						$("#phoenixTablesSelect").append("<option value='"+value+"'>" + value + "</option>");
					});

					$("#phoenixTablesSelect").val($("#storeinfo_table").text());

					$("#phoenixTablesSelect").trigger("change");

					$.unblockUI();
				},
				error:function(){
					console.log("加载Hbase.tables出错！");
				}
			});
		}

		loadingHbaseTables();


		init();
		
		$('#conn-save').click(function(){
			$('#myModal').isValid(function(v){
				console.log("myModal.isValid..");
			    setHdfsColumns();
			    blukNotInit = true;
			    if(v)
				    $('#myModal').modal('hide');
			    return;
			});
			
	    	$('#conn-count').html($('.tr-setting').length);

			$("form").on("valid.form", function(e, form){
 				console.log("valid...");
			});
			
		});

		$('#fileRuleType').change(function(){
			$("#fileRule").val("");
			$("#fileRuleDiv").show();
			var v = $(this).val();
			if (v=='dir-time') {
				$('#fileRuleLabel').html('<span class="redStar">*&nbsp;</span>目录名时间规则');
			} else if (v=='file-time') {
				$('#fileRuleLabel').html('<span class="redStar">*&nbsp;</span>文件名时间规则');
			} else if (v=='file-all') {
				$('#fileRuleLabel').html('<span class="redStar">*&nbsp;</span>所有文件');
				$('#fileRule').val('*');
			} else if (v=='period') {
				//$('#fileRuleLabel').html('文件规则');
				$("#fileRuleDiv").hide();
				$("#fileRule").val("*");
			} else {
				$('#fileRuleLabel').html('<span class="redStar">*&nbsp;</span>文件规则');
			}
		});

		function init3(){
			var v = $('#fileRuleType').val();
			if (v=='period') {
				$("#fileRuleDiv").hide();
				$("#fileRule").val("*");
			}
		}

		init3();

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
		
		var datalist_select;
		var hbaselist_select;
		if($("#hdfsColumns").text()!=''){
			var hdfsColumnsObj = eval("(" + $("#hdfsColumns").text() + ")");
			for(var s in hdfsColumnsObj){
				hdfsColumns.push(hdfsColumnsObj[s]["columnName"]);
			}
		}
		if($("#phoenixTableNameJson").text()!=''){
			var phoenixColumnsObj = eval("(" + $("#phoenixTableNameJson").text() + ")");
			phoenixColumns = [];
			for(var s in phoenixColumnsObj){
				phoenixColumns.push(phoenixColumnsObj[s]);//["COLUMN_NAME"]);
			}
		}

		init();
		
		datalist_select = $("#dataJson").html();
		$("#dataJson").remove();
		
		hbaselist_select = $("#hbaseJson").html();
		$("#dataJson").remove();
		
		
		$("#newRow2").click(function(){
			$("#proces").attr("value","ok");
			$("#procesError").attr("style","display:none;");
			addRow2(null,null);
		});
		
		$('form').validator({
			rules:{
				hbaseNotNullFiledCheck:function(element){
					console.log("hbaseNotNullFiledCheck...");
					var _html = $('#result_15').html();

					//if($("#type_bulkLoad").prop("checked")){
					if(true){

						var notNullError = "字段【";
						var nullableArray = [],selectedFiledArray = [];

						$("#phoenixTables tr:gt(0)").each(function(){
							var v = $($(this).find("td").get(1)).text();
							var is_nullable = $($(this).find("td").get(1)).attr("is_nullable");
							
							if(is_nullable && is_nullable=='false'){
								nullableArray.push(v);
							}
						});

						if($("#type_bulkLoad").prop("checked")){
							$("#confTableBluk tr:gt(0)").each(function(){
								var vv = $($(this).find("td").get(1)).find("select").val();
								if($.trim(vv)!=''){
									selectedFiledArray.push(vv);
								}
							});
						}else{
							$("#confTable tr:gt(0)").each(function(){
								var vv = $($(this).find("td").get(2)).find("select").val();

								if($.trim(vv)!=''){
									console.log(vv+",indexOf="+vv.indexOf("("));
									vv = vv.substring(0,vv.indexOf("("));
									console.log("vv="+vv);
									selectedFiledArray.push(vv);
								}
							});
						}

						var errArray = [];
						for(var i=0;i<nullableArray.length;i++){
							var exist = false;
							for(var j=0;j<selectedFiledArray.length;j++){
								if(selectedFiledArray[j]==nullableArray[i]){
									exist = true;
								}
							}

							if(!exist){
								notNullError += nullableArray[i]+",";
								errArray.push(nullableArray[i]);
							}
							
						}

						console.log("nullableArray="+nullableArray+",selectedFiledArray="+selectedFiledArray);

						notNullError+="】不能为空！";

						_html+="<br>"+notNullError;

						if(errArray.length==0){return true;}

						return notNullError;
					}
					//console.log("_html="+_html);
					//$('#result_15').html(_html);
					//$('#result_15').show();
					return true;//"Hbase不能为空字段必须配置！";
				}
			},
			fields:{
				"hbaseNotNullFiledCheck":"hbaseNotNullFiledCheck"
			},
			valid: function(form){
				console.log("valid...");
				createMark();
					
				form.submit();
			},
			invalid: function(form){
				console.log("invalid...");
				$("#myModal").isValid(function(v){
					if(v){
						$("#myModal_closeBtn").click();
						$('#result_15').hide();
					}else{
						var _html="<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>提交失败！【输入数据】没有设置完整，请检查hdfs配置。";

						$('#result_15').html(_html);
						$('#result_15').show();
					}
				});
				/*
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
				}*/
			}
		});

		
		
		//line切换
		$("#line").click(function(){
// 			console.log("line.checked="+$(this).is(":checked")+",id="+$(this).attr("id"));
			if($(this).is(":checked")){
				$("#lineReg").show();
			}else{
				$("#lineReg").hide();
			}
		});
		
		$("#newRow").click(function(){
			addRow(null,null);
		});
		
		$("#saveHdfsConfigBtn").click(function(){
			
		});
		
		$("#phoenixTablesSelect").change(function(){
			phoenixTablesSelectFunc($(this).val());
			blukNotInit = true;
		});
		
		function phoenixTablesSelectFunc(v){
			$("#phoenixTables").html("");
			
			$("#type_bulkLoad").attr("disabled",false);
			$("#_dateInfoMess").html("");
			if(v == ""){
				return;
			}
			
			$.ajax({
				url:"<%=request.getContextPath() %>/flowComp?method=phoenixColumnsByTableName&tableName="+v,
				type:"post",
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					initPhoenixTableHtml(data);
				},
				error:function(){
					console.log("加载数据出错！");
				}
			});
		}

		function setHdfsColumns(){
			console.log("setHdfsColumns...");
			hdfsColumns = [];
			$("#ruleTable tr:gt(0)").each(function(index,value){
				var columnName = $(value).find("td:eq(1)").find("input").val();
				hdfsColumns.push(columnName);
			});
			pageInit();
		}
		
		phoenixTablesSelectFunc($("#phoenixTablesSelect").val());
		
		function initPhoenixTableHtml(data){
			if(!data){
// 				console.log("initPhoenixTableHtml data is undefind!");	
				return;
			}
// 			console.log("initPhoenixTableHtml...");
// 			console.log(data);
			var tr = "<tr><td>序列号</td><td>字段名</td><td>字段类型</td><td>不能为空</td><tr>";
			phoenixColumns = [];
			var findDateColumn = false;
			$.each(data,function(index,value){
// 				console.log(value);
				
				
				tr += "<tr>";
				tr += "<td>" + (index+1) + "</td>";
				tr += "<td IS_NULLABLE='"+value["IS_NULLABLE"]+"'>" + value["COLUMN_NAME"] + "</td>";
				
				
				if(value["COLUMN_SIZE"]){
					tr += "<td>" + value["TYPE_NAME"] + "(" + value["COLUMN_SIZE"] + ")" + "</td>";
				}else{
					tr += "<td>" + value["TYPE_NAME"] + "</td>";
				}
				
				if(value["TYPE_NAME"]=="DATE"){
					findDateColumn = true;
// 					console.log(">>>"+value["TYPE_NAME"]);
					$("#type_bulkLoad").attr("disabled",true);
					var _html = "(*Hbase表带时间列，不支持批量导入。)";
					$("#_dateInfoMess").html(_html);
				}
				
				//var nullable = "";
				if(value["IS_NULLABLE"]=="false"){
					tr += "<td>是</td>";
				}else{
					tr += "<td>&nbsp;</td>";
				}

				tr += "</tr>";
				
				phoenixColumns.push(value);//["COLUMN_NAME"]);
			});

			console.log("findDateColumn = " + findDateColumn);

			
			if(findDateColumn){
				$("#type_bulkLoad").attr("disabled",false);
				$("#type_bulkLoad").prop("checked",true);
				$("#type_bulkLoad").trigger("click");
			}
			$("#type_bulkLoad").attr("disabled",findDateColumn);
			console.log("findDateColumn..1");
			$("#phoenixTables").append("").append(tr);
			console.log("findDateColumn..2");
			setHbaseColumns();

			pageInit();
		}
		
		initPhoenixTableHtml(phoenixColumnsObj);
		
		function setHbaseColumns(){
			console.log("setHbaseColumns...");
			var confrules = $("#confrules").text();
			if(confrules && $.trim(confrules)!=''){
				var obj = eval("(" + confrules + ")");

				$("#confTable tr:gt(0)").each(function(index,value){
					var s2 = $(this).find("select").get(1);
					$(s2).empty();
					$(s2).append("<option></option>");
					for(var s in phoenixColumns){
						var columnStr = phoenixColumns[s]["COLUMN_NAME"]+"("+phoenixColumns[s]["TYPE_NAME"]+")";
						
						$(s2).append("<option value='"+columnStr+"'>"+columnStr+"</option>");
					}
					
					var rowObj = obj[index];
					$(s2).val(rowObj["field"]);
				});
			}
			
		}
		
		/*$("#myModal_closeBtn").click(function(){
			console.log("myModal_closeBtn..");
			setHdfsColumns();
		});*/
				
	});
	
	$("#columnNumber").blur(function(){
		var columnNum = $.trim($(this).val());
		var tableTrSize = $("#ruleTable tr:gt(0)").size();
		if(columnNum){
			$("#ruleTable tr:gt(0)").remove();
			for(var i=0;i<columnNum;i++){
				addRow(null,null);	
			}
		}
	});
	
	$("#delimited").change(function(){
		var sval = $(this).val();
		var status = $("#status").val();
// 		console.log("status……"+status);
		if(sval=='REGX'){
			var _input = "";
			if(status =='online'){
				_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" readonly=\"readonly\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
			}else{
				_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
			}
			
			if($("#delimited_hidden").text()!=''){
				if(status =='online'){
					_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" readonly=\"readonly\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
				}else{
					_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
				}
			}
			$("#regInput").html(_input);
		}else{
			$("#regInput").html("");
		}
	});
	
	//选中列分隔符
	var delimited_type_hidden = $("#delimited_type_hidden").val();
	if(delimited_type_hidden!=''){
		if(delimited_type_hidden=='REGX'){
			$("#delimited").val(delimited_type_hidden);
			var status = $("#status").val();
// 			console.log("status……"+status);
			var _input ="";
			if(status =='online'){
				_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" readonly=\"readonly\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
			}else{
				_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
			}
			
			$("#regInput").html(_input);
			
		}else if(delimited_type_hidden=='FIELD'){
			$("#delimited").val($("#delimited_hidden").text());
		}
	}
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow2(target,insertBefore){
		
		var confTableTr = $("#confTable tr").size();
		var _row = "<tr>";
		_row += "<td style=\"display: none;\">"+confTableTr+"</td>";

		var _selectComp = "<select name='column' class=\"form-control\">";
		for(var s in hdfsColumns){
			_selectComp += "<option>"+hdfsColumns[s]+"</option>";
		}
		_selectComp += "</select>";
		_row += "<td>"+_selectComp+"</td>";
		
		var i = 0,tmp = "";
		var _phoenixColumns = "<select name='field' class=\"form-control\" onchange=\"phoenixSelectChangefunc(this)\">";
		for(var s in phoenixColumns){
			if(i==0){
				tmp = phoenixColumns[s];
// 				console.log(phoenixColumns[s]);
			}
			i++;
			
			_phoenixColumns += "<option>"+phoenixColumns[s]["COLUMN_NAME"]+"("+phoenixColumns[s]["TYPE_NAME"]+")</option>";
		}
		_phoenixColumns += "</select>";

		if(tmp["TYPE_NAME"]=="DATE"){
			_phoenixColumns += '<input class="form-control"  name="dateFormat" value="" data-rule=\"required;\"/>';
		}else{
			_phoenixColumns += '<input class="form-control" style="display: none;" name="dateFormat" value="-"/>';
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
	
	function phoenixSelectChangefunc(thisObj){
// 		console.log("phoenixSelectChangefunc.."+$(thisObj).val());
		if($(thisObj).val().indexOf("(DATE)") != -1){
			$(thisObj).parent().find("input[name='dateFormat']").val("");
			$(thisObj).parent().find("input[name='dateFormat']").attr("data-rule","required;length[1~45];").show();
			$(thisObj).parent().find("input[name='dateFormat']").show();//.html("<input />");
		}else{
// 			$(thisObj).parent().find("input[name='dateFormat']").remove();
			$(thisObj).parent().find("input[name='dateFormat']").removeAttr("data-rule");
			$(thisObj).parent().find("input[name='dateFormat']").hide();
			$(thisObj).parent().find("input[name='dateFormat']").val("-");
		}
	}
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	* inputValue:如果不指定则为默认的c1,c2
	*/
	function addRow(target,insertBefore,inputValue){
		
		var ruleTableTr = $("#ruleTable tr").size();
		$("#columnNumber").val(ruleTableTr);

		if(!inputValue){
			inputValue = "c"+ruleTableTr;
		}
		var _row = "<tr>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td><input name='columnName' class='form-control' value='"+inputValue+"'/></td>";
		_row += "<td style=\"width:'280px'\"> <input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/></td>";
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
		var ruleTableTr = $("#ruleTable tr").size();
		if(ruleTableTr > 0){
			ruleTableTr--;
		}
		$("#columnNumber").val(ruleTableTr);
	}
	function upInsertFunc(obj){
		var target = $(obj).parent().parent();
		addRow(target,true);
	}
	
	function downInsertFunc(obj){
		var target = $(obj).parent().parent();
		addRow(target,false);
	}
	
	//移动元素
	function shift(select,target,insertBefore){
		var _no = $(target).find("td").eq(0).html();
		
		//alert(isNaN($(target).find("td").eq(0).html()));
		if(_no=="列序号"){
			return;
		}
		
		if(insertBefore){
			$(select).insertBefore(target);
		}else{
// 			console.log("insertAfter");
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

	function pageInit(){
		console.log("pageInit...");
		$("#hdfs_hbase_conf_BlukDiv").hide();

		if($("#type_bulkLoad").prop("checked")){
			$("#hdfs_hbase_conf_BlukDiv").show();
			initBlukConfig();
		}else{
			$("#hdfs_hbase_conf_BlukDiv").hide();
		}

		var confrules = $("#confrules").text();
		if(confrules && $.trim(confrules)!=''){
			var obj = eval("(" + confrules + ")");
			console.log(obj);

			for(var i in obj){
				var sss = ""+$.trim(obj[i]["field"])+"";
				console.log(sss);
				//sss = "R1";
				$("#confTableBluk tr:gt(0)").each(function(index,value){
					if(index == i){
						$(value).find("select[name='blukPhoenixColumn']").val(sss);
					}
				});
			}
		}
	}

	if($("#type_bulkLoad").prop("checked")){
		$("#hdfs_hbase_conf_BlukDiv").show();
	}else{
		$("#hdfs_hbase_conf_BlukDiv").hide();
	}

	function initBlukConfig(){
		if(blukNotInit){
			blukNotInit = false;
			$("#confTableBluk tr:gt(0)").remove();

			var __hdfsColumns = [],__phoenixColumns = [],__phoenixColumnsSelectComp="";
			__phoenixColumnsSelectComp = "<select class='form-control' name='blukPhoenixColumn'>";

			__phoenixColumnsSelectComp += "<option></option>";

			console.log("phoenixTables.size="+$("#phoenixTables tr:gt(0)").size());
			
			$("#phoenixTables tr:gt(0)").each(function(){
				var v = $($(this).find("td").get(1)).text();
				if(!v || $.trim(v)==''){return;}
				__phoenixColumnsSelectComp += "<option>";
				__phoenixColumnsSelectComp += v;
				__phoenixColumnsSelectComp += "</option>";
			});
			__phoenixColumnsSelectComp += "</select>";

			$("#ruleTable tr:gt(0)").each(function(){
				var hdfsColumnName = $(this).find("input[name='columnName']").val();
				var _row = "<tr>";
				_row += "<td>";
				_row += "<input class='form-control disabled' value='" + hdfsColumnName + "' name='blukHdfsColumn' readonly='true'/>";
				_row += "</td>";
				_row += "<td>";
				_row += __phoenixColumnsSelectComp;
				_row += "</td>";
				_row += "</tr>";
				$("#confTableBluk").append(_row);
			});
		}
	}

	$("#type_bulkLoad").click(function(){
		if($(this).prop("checked")){
			$("#proces").attr("value","ok");
			$("#procesError").attr("style","display:none;");
			$("#hdfs_hbase_conf_div").hide();
			$("#hdfs_hbase_conf_BlukDiv").show();

			initBlukConfig();

		}else{
			$("#proces").attr("value","ok");
			$("#hdfs_hbase_conf_div").show();
			$("#hdfs_hbase_conf_BlukDiv").hide();
		}
	});
	
	
	//另存为模板
	function saveToDsTemplateFunc(obj){
// 		console.log("saveToDsTemplateFunc...");
		
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
		_ruleConf["dataType"] = $("#dataType").val();
// 		_ruleConf["split"] = $("#split").val();
// 		_ruleConf["splitOrReg"] = $("#splitOrReg").val();
		if($("#delimited").val()=="REGX"){
			_ruleConf["split"] = "REGX";
			_ruleConf["splitOrReg"] = $("#delimited_char").val();
		}else{
			_ruleConf["split"] = "FIELD";
			_ruleConf["splitOrReg"] = $("#delimited").val();
		}
		_ruleConf["columnNumber"] = $("#columnNumber").val();
		_ruleConf["fileRuleType"] = $("#fileRuleType").val();
		_ruleConf["fileRule"] = $("#fileRule").val();
		_ruleConf["charset"] = $("#charset").val();
		var _name = $("#dsTemplateInput").find("input[name='dsTemplateName']").val();
		if($.trim(_name)==''){
			$("#dsTemplateInput").find("input[name='dsTemplateName']").focus();
			return;
		}
		
		//获取columns
		var _columns = [];
		$("#ruleTable tr:gt(0)").each(function(index,value){
			var _columnName = $(this).find("input[name='columnName']").val();
			var _row = {};
			_row["name"] = _columnName;
			
			if(!(_columnName=='')){
				_columns.push(_row);
			}
		});
		_ruleConf["columns"] = _columns;
// 		console.log(_ruleConf);
		
		$.ajax({
			url:"<%=request.getContextPath() %>/datasources?method=saveToDsTemplateFunc",
			type:"post",
			data:{"ruleConf":JSON.stringify(_ruleConf),"tmpName":_name,"type":"hbase"},
			dataType:"text",
			success:function(data, textStatus){
// 				console.log(data);
				if(data==0){
					alert("保存成功！");
					$.ajax({
						url:"<%=request.getContextPath() %>/datasources?method=hbaseTemplateList",
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
							alert("保存失败！");
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
						initBlankDiv();
						$.ajax({
							url:"<%=request.getContextPath() %>/datasources?method=hbaseTemplateList",
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
						url:"<%=request.getContextPath() %>/datasources?method=hbaseTemplateChange&tmpId="+$(this).val(),
						type:"post",
						dataType:"json",
						async:true,
						success:function(data, textStatus){
// 							console.log("=========ajax.data===========");
// 							console.log(data);
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
		
		var _htmlDataType="";
		_htmlDataType += "<option selected='selected' value='text'>文本</option>";
		_htmlDataType += "<option value='binary'>二进制</option>";
		_htmlDataType += "<option value='compress'>gz压缩的文本</option>";
		$("#dataType").html(_htmlDataType);
		
		var _htmlSplit="";
		_htmlSplit += "<option selected='selected' value='\\t'>tab键</option>";
		_htmlSplit += "<option value=' '>空格</option>";
		_htmlSplit += "<option value=','>逗号</option>";
		_htmlSplit += "<option value='REGX'>正则表达式</option>";
		$("#delimited_char").attr("style","display: none;");
		$("#delimited_char").text("");
		$("#delimited").html(_htmlSplit);
		
		$("#columnNumber").val("");
		
		var _htmlFileRuleType="";
		_htmlFileRuleType += "<option selected='selected' value='dir-time'>目录下目录名符合【时间】规则的文件</option>";
		_htmlFileRuleType += "<option value='file-time'>目录下文件名符合【时间】规则的文件</option>";
		_htmlFileRuleType += "<option value='file-all'>选定的文件/目录下所有文件</option>";
		_htmlFileRuleType += "<option value='file-rule'>选定目录下所有符合规则的文件</option>";
		_htmlFileRuleType += "<option value='period'>指定周期</option>";
		$("#fileRuleType").html(_htmlFileRuleType);
		
		$("#fileRuleLabel").text("目录名时间规则");
		$("#fileRule").val("");
		
		var _htmlCharset="";
		_htmlCharset += "<option selected='selected' value='UTF-8'>UTF-8</option>";
		_htmlCharset += "<option value='GBK'>GBK</option>";
		_htmlCharset += "<option value='ISO-8859-1'>ISO-8859-1</option>";
		_htmlCharset += "<option value='GB2312'>GB2312</option>";
		_htmlCharset += "<option value='Unicode'>Unicode</option>";
		$("#charset").html(_htmlCharset);
		
		var _row="";
		_row += "<table class='table table-bordered table-hover' id='ruleTable' style='margin-bottom: 100px;'>";
		_row += "<tr class='success'><td width='60'>列序号</td><td>列名</td><td>操作</td></tr>";
		$("#table_div_template").html(_row);
	}
	
	
	function initTemplateHtml(data){
		if(!data){return;}
// 		console.log("initTemplateHtml...");
// 		console.log(data);
		//填充数据到页面
// 		console.log("填充数据到页面");
		var _htmlDataType="";
		if(data.dataType=="text"){
			_htmlDataType += "<option selected='selected' value='text'>文本</option>";
			_htmlDataType += "<option value='binary'>二进制</option>";
			_htmlDataType += "<option value='compress'>gz压缩的文本</option>";
		}else if(data.dataType=="binary"){
			_htmlDataType += "<option value='text'>文本</option>";
			_htmlDataType += "<option selected='selected' value='binary'>二进制</option>";
			_htmlDataType += "<option value='compress'>gz压缩的文本</option>";
		}else if(data.dataType=="compress"){
			_htmlDataType += "<option value='text'>文本</option>";
			_htmlDataType += "<option value='binary'>二进制</option>";
			_htmlDataType += "<option selected='selected' value='compress'>gz压缩的文本</option>";
		}
		$("#dataType").html(_htmlDataType);

		var _htmlSplit="";
		if(data.split=="REGX"){
			_htmlSplit += "<option value='\\t'>tab键</option>";
			_htmlSplit += "<option value=' '>空格</option>";
			_htmlSplit += "<option value=','>逗号</option>";
			_htmlSplit += "<option selected='selected' value='REGX'>正则表达式</option>";
			$("#delimited_char").attr("style","");
			$("#delimited_char").attr("disable",true);
			$("#delimited_char").text(data.splitOrReg);
			$("#delimited_char").val(data.splitOrReg);
			$("#delimited_hidden").text(data.splitOrReg);
			$("#delimited_char_hidden").val(data.splitOrReg);
			
		}else if(data.split=="FIELD"){
			if(data.splitOrReg==" "){
				_htmlSplit += "<option value='\\t'>tab键</option>";
				_htmlSplit += "<option selected='selected' value=' '>空格</option>";
				_htmlSplit += "<option value=','>逗号</option>";
				_htmlSplit += "<option value='REGX'>正则表达式</option>";
				$("#delimited_char").attr("style","display: none;");
				$("#delimited_char").text(data.splitOrReg);
				$("#delimited_char").val(data.splitOrReg);
				$("#delimited_hidden").text(data.splitOrReg);
			}else if(data.splitOrReg==","){
				_htmlSplit += "<option value='\\t'>tab键</option>";
				_htmlSplit += "<option value=' '>空格</option>";
				_htmlSplit += "<option selected='selected' value=','>逗号</option>";
				_htmlSplit += "<option value='REGX'>正则表达式</option>";
				$("#delimited_char").attr("style","display: none;");
				$("#delimited_char").text(data.splitOrReg);
				$("#delimited_char").val(data.splitOrReg);
				$("#delimited_hidden").text(data.splitOrReg);
			}else{
				_htmlSplit += "<option selected='selected' value='\\t'>tab键</option>";
				_htmlSplit += "<option value=' '>空格</option>";
				_htmlSplit += "<option value=','>逗号</option>";
				_htmlSplit += "<option value='REGX'>正则表达式</option>";
				$("#delimited_char").attr("style","display: none;");
				$("#delimited_char").text(data.splitOrReg);
				$("#delimited_char").val(data.splitOrReg);
				$("#delimited_hidden").text(data.splitOrReg);
			}
		}
		$("#delimited").html(_htmlSplit);
		
		$("#columnNumber").val(data.columnNumber);
		
		var _htmlFileRuleType="";
		if(data.fileRuleType=="dir-time"){
			_htmlFileRuleType += "<option selected='selected' value='dir-time'>目录下目录名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-time'>目录下文件名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-all'>选定的文件/目录下所有文件</option>";
			_htmlFileRuleType += "<option value='file-rule'>选定目录下所有符合规则的文件</option>";
			_htmlFileRuleType += "<option value='period'>指定周期</option>";
			$("#fileRuleLabel").text("目录名时间规则");
			$("#fileRule").val(data.fileRule);
		}else if(data.fileRuleType=="file-time"){
			_htmlFileRuleType += "<option value='dir-time'>目录下目录名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option selected='selected' value='file-time'>目录下文件名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-all'>选定的文件/目录下所有文件</option>";
			_htmlFileRuleType += "<option value='file-rule'>选定目录下所有符合规则的文件</option>";
			_htmlFileRuleType += "<option value='period'>指定周期</option>";
			$("#fileRuleLabel").text("文件名时间规则");
			$("#fileRule").val(data.fileRule);
		}else if(data.fileRuleType=="file-all"){
			_htmlFileRuleType += "<option value='dir-time'>目录下目录名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-time'>目录下文件名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option selected='selected' value='file-all'>选定的文件/目录下所有文件</option>";
			_htmlFileRuleType += "<option value='file-rule'>选定目录下所有符合规则的文件</option>";
			_htmlFileRuleType += "<option value='period'>指定周期</option>";
			$("#fileRuleLabel").text("所有文件");
			$("#fileRule").val(data.fileRule);
		}else if(data.fileRuleType=="file-rule"){
			_htmlFileRuleType += "<option value='dir-time'>目录下目录名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-time'>目录下文件名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-all'>选定的文件/目录下所有文件</option>";
			_htmlFileRuleType += "<option selected='selected' value='file-rule'>选定目录下所有符合规则的文件</option>";
			_htmlFileRuleType += "<option value='period'>指定周期</option>";
			$("#fileRuleLabel").text("文件规则");
			$("#fileRule").val(data.fileRule);
		}else{
			_htmlFileRuleType += "<option value='dir-time'>目录下目录名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-time'>目录下文件名符合【时间】规则的文件</option>";
			_htmlFileRuleType += "<option value='file-all'>选定的文件/目录下所有文件</option>";
			_htmlFileRuleType += "<option value='file-rule'>选定目录下所有符合规则的文件</option>";
			_htmlFileRuleType += "<option selected='selected' value='period'>指定周期</option>";
// 			$("#fileRuleLabel").text("文件规则");
// 			$("#fileRule").val(data.fileRule);
			$("#fileRuleDiv").hide();
			$("#fileRule").val("*");
		}
		$("#fileRuleType").html(_htmlFileRuleType);
		
		var _htmlCharset="";
		if(data.charset=="UTF-8"){
			_htmlCharset += "<option selected='selected' value='UTF-8'>UTF-8</option>";
			_htmlCharset += "<option value='GBK'>GBK</option>";
			_htmlCharset += "<option value='ISO-8859-1'>ISO-8859-1</option>";
			_htmlCharset += "<option value='GB2312'>GB2312</option>";
			_htmlCharset += "<option value='Unicode'>Unicode</option>";
		}else if(data.charset=="GBK"){
			_htmlCharset += "<option value='UTF-8'>UTF-8</option>";
			_htmlCharset += "<option selected='selected' value='GBK'>GBK</option>";
			_htmlCharset += "<option value='ISO-8859-1'>ISO-8859-1</option>";
			_htmlCharset += "<option value='GB2312'>GB2312</option>";
			_htmlCharset += "<option value='Unicode'>Unicode</option>";
		}else if(data.charset=="ISO-8859-1"){
			_htmlCharset += "<option value='UTF-8'>UTF-8</option>";
			_htmlCharset += "<option value='GBK'>GBK</option>";
			_htmlCharset += "<option selected='selected' value='ISO-8859-1'>ISO-8859-1</option>";
			_htmlCharset += "<option value='GB2312'>GB2312</option>";
			_htmlCharset += "<option value='Unicode'>Unicode</option>";
		}else if(data.charset=="GB2312"){
			_htmlCharset += "<option value='UTF-8'>UTF-8</option>";
			_htmlCharset += "<option value='GBK'>GBK</option>";
			_htmlCharset += "<option value='ISO-8859-1'>ISO-8859-1</option>";
			_htmlCharset += "<option selected='selected' value='GB2312'>GB2312</option>";
			_htmlCharset += "<option value='Unicode'>Unicode</option>";
		}else{
			_htmlCharset += "<option value='UTF-8'>UTF-8</option>";
			_htmlCharset += "<option value='GBK'>GBK</option>";
			_htmlCharset += "<option value='ISO-8859-1'>ISO-8859-1</option>";
			_htmlCharset += "<option value='GB2312'>GB2312</option>";
			_htmlCharset += "<option selected='selected' value='Unicode'>Unicode</option>";
		}
		$("#charset").html(_htmlCharset);
		
		//根据columns自动生成表格
		$("#table_div_template").html("");
		var _row="";
		_row += "<table class='table table-bordered table-hover' id='ruleTable' style='margin-bottom: 100px;'>";
		_row += "<tr class='success'><td width='60'>列序号</td><td>列名</td><td>操作</td></tr>";
 		if(data.columns != ""){
			var _d = data.columns;
			var n=0;
			$.each(_d,function(index,item){
				n=n+1;
				_row += "<tr>";
				_row += "<td>"+n+"</td>";
				_row += "<td><input name='columnName' class='form-control' value='"+item.name+"'/></td>";
				_row += "<td style=\"width:'180px'\"> <input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/></td>";
				_row += "</tr>";
			});
 		}
		$("#table_div").remove();
		$("#table_div_template").html(_row);
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
</SCRIPT>
</form>