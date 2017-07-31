<%@page import="java.util.HashMap"%>
<%@page import="com.stonesun.realTime.services.db.bean.KeyValueMainInfo"%>
<%@page import="com.stonesun.realTime.services.db.KeyValueMainServices"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.conf.Column"%>
<%@page import="com.stonesun.realTime.services.db.bean.DsTemplateInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.db.DsTemplateServices"%>
<%@page import="java.util.Map"%>
<%@page import="com.stonesun.realTime.services.db.bean.conf.RuleConf"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
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
<title>数据源配置</title>
<%@ include file="/resources/common.jsp"%>
<style type="text/css">
.delimited_char_css{
	width: 600px;
}
</style>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					添加离线数据源
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/datasources?method=index">数据源管理</a> / <a href="<%=request.getContextPath() %>/datasources/add.jsp">选择数据的添加方式</a> / 添加离线数据源
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<%
					try{
						String id = request.getParameter("id");
						String source = request.getParameter("source");
						String sourceType = request.getParameter("sourceType");
						DatasourceInfo ds = null;
						if(StringUtils.isNotBlank(id)){
							ds = DatasourceServices.selectById(id);

							request.setAttribute("ds", ds);
							source = ds.getSource();
							sourceType = ds.getSourceType();
							
							if(StringUtils.isNotBlank(ds.getRuleConf())){
								ds.setRc(JSON.parseObject(ds.getRuleConf(),RuleConf.class));
								
								if(ds.getRc()!=null){
									ds.getRc().getColumns();
									for(int i=0;i<ds.getRc().getColumns().size();i++){
										Column column = ds.getRc().getColumns().get(i);
										if(StringUtils.isBlank(column.getDateFormat())){
											column.setDateFormat("");
										}
									}
								}
							}
						}else{
							source = request.getParameter("source");
							sourceType = request.getParameter("sourceType");
							ds = new DatasourceInfo();
							request.setAttribute("ds", ds);
						}
						
						//加载数据源模板数据
						List<DsTemplateInfo> list = DsTemplateServices.selectList(((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId(),DsTemplateInfo.DsTemplateInfo_type_ds);
						request.setAttribute("dsTemplateList", list);
						String tmpId = request.getParameter("tmpId");
						request.setAttribute("tmpId", tmpId);
						if(StringUtils.isNotBlank(tmpId)){
							for(int i=0;i<list.size();i++){
								if(list.get(i).getId()==Integer.valueOf(tmpId)){
									ds.setRc(JSON.parseObject(list.get(i).getRuleConf(), RuleConf.class));
									break;
								}
							}
						}
					
						request.setAttribute("source",source);
						request.setAttribute("sourceType",sourceType);
						request.setAttribute("dsConnMap", DataCache.dsConnMap.get(source));
						
						//如果是上传离线文件，则读取数据到样例数据文本框
						if(source.equals("upload") && sourceType.equals("upload")){
// 							ds.getSourceDetailMap().put("files", files);

							String filepath = DatasourceServlet.getRootPath() + DatasourceServlet.getDsBySession(request.getSession()).getSourceDetailMap().get("files").toString();
							
							System.out.println("================filepath=" + filepath);
							String lines = DatasourceServlet.readLines(filepath);
							System.out.println("================lines=" + lines);
							request.setAttribute("test_data", lines);
						}
						
						
						//加载字典列表
						if(ds.getId() > 0){
							id = String.valueOf(ds.getId());
							List<KeyValueMainInfo> keyvalueMainList = KeyValueMainServices.selectList(Integer.valueOf(id));
							request.setAttribute("keyvalueMainList", keyvalueMainList);
							
							JSONObject kvJson = new JSONObject();
							Map<String,String> kvMap = new HashMap<String,String>();
							if(keyvalueMainList!=null){
								for(int i=0;i<keyvalueMainList.size();i++){
									KeyValueMainInfo item = keyvalueMainList.get(i);
									kvMap.put(String.valueOf(item.getId()), item.getField());
								}
							}
							request.setAttribute("kvJson", JSON.toJSONString(kvMap));
							System.out.println(id);
							System.out.println(JSON.toJSONString(kvMap));
						}
						
					}catch(Exception e){
						e.printStackTrace();
					}
				%>
				
				<%!
				String getIdParam(HttpServletRequest request){
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						return "&id="+id;
					}
					return "";
				}
				%>
				<form notBindDefaultEvent="true" action="<%=request.getContextPath() %>/datasources?method=toDesc&source=${source}<%=getIdParam(request) %>" class="form-horizontal" role="form" method="post" id="formId">
					<input name="sourceType" value="${sourceType}" type="hidden"/>
					<input name="id" value="${ds.id}" type="hidden"/>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-10">
							<ul class="darwin-page-op-nav">
<!-- 								<li> -->
<!-- 									<a>数据连接设置</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a class="current">格式设置</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a>信息确定</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a>完成</a> -->
<!-- 								</li> -->
								<li>
									<a href="javascript:history.go(-1);">返回</a> 
								</li>
								<li>
									<input type="submit" value="下一步" class="btn btn-primary"/>
									<input type="button" value="删除模板" class="btn btn-danger" id="delSelectDsTmpBtn" onclick="delSelectDsTmpFunc()"/>
									<input type="button" value="另存为模板" class="btn" onclick="saveToDsTemplateFunc(this)"/>
								</li>
								<li>
									<div style="display: inline;" id="dsTemplateInput"></div>
								</li>
							</ul>
						</div>
					</div>
					<div class="form-group">
						<label for="moduleList" class="col-sm-2 control-label">使用已有模板</label>
						<div class="col-sm-3">
							<select class="form-control" name="moduleList" id="moduleList">
								<option value=""></option>
								<c:forEach items="${dsTemplateList}" var="item">
						        	<option <c:if test='${tmpId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
						        </c:forEach>
							</select>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								可以在已有模版列表中选择，已有模版已经预置了格式行和列的识别规则。
							</p>
						</div>
					</div>
					<div class="form-group" style="display: none;">
						<label for="newLine" class="col-sm-2 control-label">换行符</label>
						<div class="col-sm-3">
<%-- 							${ds.rc.newLine} --%>
							<input data-rule="required;newLine" value="\n" id="newLine" name="newLine" class="form-control"/>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								文本文件的换行符一般为回车换行(\n)，请根据实际情况进行设定。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="delimited" class="col-sm-2 control-label">列分割符</label>
						<div class="col-sm-3">
							<select id="delimited" name="delimited" class="form-control">
								<%
									request.setAttribute("splitMap", DataCache.splitMap);
								%>
								<c:forEach items="${splitMap}" var="item">
						           <option <c:if test='${ds.rc.delimited == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
							<div id="regInput" style="margin: 10px 0 0 0;"></div>
							<input id="delimited_type_hidden" value="${ds.rc.delimited_type}" type="hidden"/>
<%-- 							<input id="delimited_hidden" value="${ds.rc.delimited}" type="hidden"/> --%>
							<div id="delimited_hidden" style="display: none;">${ds.rc.delimited}</div>
							<textarea id="delimited_char" rows="" cols="100" class="form-control delimited_char_css" style="display: none;">${ds.rc.delimited}</textarea>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								一般按照tab键，空格，逗号进行列分割，如需其他的列分割方式，可以选择正则表达式。
							</p>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<div class="checkbox">
								<label>
									<input type="checkbox" id="notParser" name="notParser" <c:if test="${not empty ds.rc.notParser and ds.rc.notParser eq 'y'}"> checked="checked" </c:if>>不解析格式<br>
								</label>
							</div>
							<div class="checkbox">
								<label>
									<c:if test="${not empty ds.rc.line and ds.rc.line}">
										<input type="checkbox" id="line" name="line" checked="checked">换行日志识别
									</c:if>
									<c:if test="${empty ds.rc.line or !ds.rc.line}">
										<input type="checkbox" id="line" name="line">换行日志识别
									</c:if>
								</label>
							</div>
							<input style="display: none;" id="lineCheckedFlg" value="${not empty ds.rc.line and ds.rc.line}"/>
							<c:if test="${not empty ds.rc.line and ds.rc.line}">
									<textarea placeholder="请输入换行日志识别的正则表达式" id="lineReg" name="lineReg" rows="" cols="100" class="form-control">${ds.rc.lineReg}</textarea>
								</c:if>
								<c:if test="${empty ds.rc.line or !ds.rc.line}">
									<textarea placeholder="请输入换行日志识别的正则表达式" id="lineReg" name="lineReg" rows="" cols="100" class="form-control" style="display: none;">${ds.rc.lineReg}</textarea>
								</c:if>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-10">
							<textarea id="exampleData" rows="3" cols="100" class="form-control" placeholder="请粘贴样例数据">${test_data}</textarea>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-8">
							<button class="btn btn-primary" type="button" id="newRow">增加一行</button>
							<button class="btn btn-primary" type="button" id="newDateTimeRow" style="display: none;">增加_datetime</button>
							<button class="btn btn-success" type="button" id="autoCreate">自动生成</button>
							<button class="btn btn-default" type="button" id="clearRadioSelect">清除选中</button>
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-10">
							<table class="table table-bordered table-hover" id="ruleTable" style="margin-bottom: 100px;">
								<tr class="success">
									<td>No</td>
									<td>是否是时间列</td>
									<td>列名</td>
									<td>描述</td>
									<td>类型</td>
									<td>字典</td>
									<td>操作</td>
								</tr>
								<c:forEach var="stu" items="${ds.rc.columns}" varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td><div class="radio"><label>
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
												<c:when test="${stu.type eq 'Datetime' or stu.type eq 'Timestamp'}">
													<input name='columnDateFormat' class='form-control' value="${stu.dateFormat}" placeholder="请输入日期时间格式"/>
												</c:when>
												<c:otherwise>
													<input name='columnDateFormat' class='form-control' value="${stu.dateFormat}" placeholder="请输入日期时间格式" style="display: none;"/>
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
										<td>
											<select name="kvMainId" class="form-control">
												<option></option>
												<c:forEach items="${keyvalueMainList}" var="item">
										           	<option <c:if test='${stu.kvMainId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.field}</option>
										        </c:forEach>
											</select>
										</td>
										<td style="width:280px"> <input type='button' value='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' value='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' value='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' value='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' value='删除' id='del' onclick='delFunc(this)'/></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="kvJson" style="display: none;">
		<select name="kvMainId" class="form-control">
			<option></option>
			<c:forEach items="${keyvalueMainList}" var="item">
	           	<option <c:if test='${stu.kvMainId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.field}</option>
	        </c:forEach>
		</select>
	</div>
	
											
											
	<%@ include file="/resources/common_footer.jsp"%>

	<script>
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
				
				$("#notParser").click(function(){
					if($(this).prop("checked")){
						$("#newRow").addClass("disabled");
						$("#newDateTimeRow").addClass("disabled");
						$("#autoCreate").addClass("disabled");
						$("#clearRadioSelect").addClass("disabled");
					}else{
						$("#newRow").removeClass("disabled");
						$("#newDateTimeRow").removeClass("disabled");
						$("#autoCreate").removeClass("disabled");
						$("#clearRadioSelect").removeClass("disabled");
					}
				});
				
				if($("#notParser").prop("checked")){
					$("#newRow").addClass("disabled");
					$("#newDateTimeRow").addClass("disabled");
					$("#autoCreate").addClass("disabled");
					$("#clearRadioSelect").addClass("disabled");
				}
				
			}
			
			var kvMainId_select;
			$(function(){
				init();
				
				kvMainId_select = $("#kvJson").html();
				$("#kvJson").remove();
				
				//通用按钮的提交表单事件
				$("form").on("valid.form", function(e, form){
					if(!$("#notParser").prop("checked")){
						
						if(!$("#notParser").prop("checked") && $("#ruleTable tr").size()==1){
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
					}
					
					createMark();

					form.submit();
				});
				
				//line切换
				$("#line").click(function(){
					console.log("line.checked="+$(this).is(":checked")+",id="+$(this).attr("id"));
					if($(this).is(":checked")){
						$("#lineReg").show();
					}else{
						$("#lineReg").hide();
					}
				});
				
				$("#newRow").click(function(){
					addRow(null,null);
				});
				
				$("#autoCreate").click(function(){
					if(confirm("确定自动生成吗？")){
						$("#ruleTable tr:gt(0)").each(function(index,value){
							$(this).remove();
						});
						
						var _exampleData = $.trim($("#exampleData").val());
						if($.trim(_exampleData)==''){
							console.log("样例数据不能为空！");
							alert("样例数据不能为空！");
							return;
						}
						
						var _delimited = $("#delimited").val();
						var delimited_char = _delimited;
						var _columns = 0;
							console.log("_delimited！"+_delimited+","+(_delimited=='REGX'));
						if(_delimited=='REGX'){
// 						if(1==1){
							delimited_char = $("#delimited_char").val();
							console.log("正则表达式去匹配！"+delimited_char);
							var arrMactches = _exampleData.match(delimited_char);
							_columns = arrMactches.length;
						}else{
							if(_delimited.indexOf("t")!=-1){
								console.log("\t....");
								_columns = _exampleData.split("\t").length;
							}else{
								_columns = _exampleData.split(_delimited).length;
							}
						}
						console.log("_exampleData="+_exampleData);
						console.log("_delimited="+_delimited);
						console.log("_columns="+_columns);
						//批量创建html
						for (var i=0;i < _columns ; i++){
							if(i==0 && _delimited=='REGX'){
								continue;
							}
							addRow(null,null);
						}
					}
				});
				
				$("#newDateTimeRow").click(function(){
					addDateTimeRow(null,null);
				});
				
				$("#delimited").change(function(){
					var sval = $(this).val();
					if(sval=='REGX'){
						var _input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
						if($("#delimited_hidden").text()!=''){
							_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
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
						var _input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
						$("#regInput").html(_input);
						
					}else if(delimited_type_hidden=='FIELD'){
						$("#delimited").val($("#delimited_hidden").text());
					}
				}
			});
			
			
			/**
			* 添加_datetime的html
			* target插入的目标元素
			* insertBefore:true插入到目标元素前面
			*  
			*  此方法已废弃
			*/
			function addDateTimeRow(target,insertBefore){
				var _s = $("#ruleTable").html();
				if(_s.indexOf("_datetime") > 0){
					console.log("请不要重复添加！");
					alert("请不要重复添加！");
					return;
				}
				
				var ruleTableTr = $("#ruleTable tr").size();
				var _row = "<tr>";
				_row += "<td>"+ruleTableTr+"</td>";
				_row += "<td><div class=\"radio\"><label><input name='columnTime' type='radio' value='"+ruleTableTr+"'/></label></div></td>";
				_row += "<td><input name='columnName' class='form-control' value='_datetime' readonly='readonly'/></td>";
				_row += "<td><input name='columnDesc' class='form-control' value='yyyy-MM-dd HH'/></td>";
				_row += "<td><select name='columnType' class='form-control'><option value='Text'>文本</option><option value='Datetime'>日期</option><option value='Timestamp'>长整型</option></select></td>";
				_row += "<td style=\"width:'280px'\"> <input type='button' value='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' value='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' value='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' value='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' value='删除' id='del' onclick='delFunc(this)'/></td>";
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
			
			/**
			* target插入的目标元素
			* insertBefore:true插入到目标元素前面
			*/
			function addRow(target,insertBefore){
				var ruleTableTr = $("#ruleTable tr").size();
				var _row = "<tr>";
				_row += "<td>"+ruleTableTr+"</td>";
				_row += "<td><div class=\"radio\"><label><input name='columnTime' type='radio' value='"+ruleTableTr+"'/></label></div></td>";
				_row += "<td><input name='columnName' class='form-control' value='c"+ruleTableTr+"'/></td>";
				_row += "<td><input name='columnDesc' placeholder='请输入描述' class='form-control'/><br><input name='columnDateFormat' placeholder='请输入日期时间格式' class='form-control' style='display:none;'/></td>";
				_row += "<td><select name='columnType' onchange='columnTypeChange0($(this))' class='form-control'><option value='Text'>文本</option><option value='String'>字符串</option><option value='Integer'>数值</option><option value='Datetime'>日期</option><option value='Timestamp'>长整型</option><option value='Double'>浮点型</option></select></td>";
				
// 				$("input[name=id]");
				_row += "<td>"+kvMainId_select+"</td>";
// 				for(s in kvJson){
// 					console.log(s);
// 				}
// 				for(var i=0;i<kvJson.length;i++){
// 					console.log(kvJson[i]);
// 				}
// 				$.each(kvJson,function(i,v){
// 					console.log(v.);
// 				});
				
				_row += "<td style=\"width:'280px'\"> <input type='button' value='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' value='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' value='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' value='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' value='删除' id='del' onclick='delFunc(this)'/></td>";
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
			
			function upInsertFunc(obj){
				var target = $(obj).parent().parent();
				//alert(target.find("td").eq(0).html());
				addRow(target,true);
			}
			
			function downInsertFunc(obj){
				var target = $(obj).parent().parent();
				//alert(target.find("td").eq(0).html());
				addRow(target,false);
			}
			
			//移动元素
			function shift(select,target,insertBefore){
				var _no = $(target).find("td").eq(0).html();
				
				//alert(isNaN($(target).find("td").eq(0).html()));
				if(_no=="No"){
					console.log("No……");
					return;
				}
				
				if(insertBefore){
					$(select).insertBefore(target);
				}else{
					console.log("insertAfter");
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
			
			//del
			function delFunc(obj){
				$(obj).parent().parent().remove();
			}
			
			//删除选中的模板
			function delSelectDsTmpFunc(){
				console.log("delSelectDsTmpFunc...");
				if(confirm("确认删除选中的模板吗？")){
					var dsTmpId = $("#moduleList").children('option:selected').val();
					$.ajax({
						url:"<%=request.getContextPath() %>/datasources?method=delSelectDsTmp",
						type:"post",
						data:{"dsTmpId":dsTmpId},
						dataType:"text",
						success:function(data, textStatus){
							console.log(data);
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
				console.log("saveToDsTemplateFunc...");
				
				//模板名称不存在则要求输入
				var _dsTemplate = $("#dsTemplateInput").find("input[name='dsTemplateName']");
				if(_dsTemplate.length==0){
					console.log("模板名称不存在则要求输入");
					$("#dsTemplateInput").append("<input name='dsTemplateName' class='form-control' placeholder=\"请输入模板名称\"/>");
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
				_ruleConf["notParser"] = $("#notParser").val();
				console.log("换行日志识别="+$("#line").is("checked")+","+$("#line").val()+","+$("#line").prop("checked"));
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
					var _columnKvMainId = $(this).find("select[name='kvMainId']").val();
					console.log("_columnTime="+_columnTime);
					var _row = {};
					_row["isTime"] = _columnTime;
					_row["name"] = _columnName;
					_row["desc"] = _columnDesc;
					_row["dateFormat"] = _columnDateFormat;
					_row["type"] = _columnType;
					_row["kvMainId"] = _columnKvMainId;
					
					if(!(_columnName=='' && _columnDesc=='' && _columnType=='')){
						_columns.push(_row);
					}
				});
				_ruleConf["columns"] = _columns;
				console.log(_ruleConf);
				
				$.ajax({
					url:"<%=request.getContextPath() %>/datasources?method=saveToDsTemplateFunc",
					type:"post",
					data:{"ruleConf":JSON.stringify(_ruleConf),"tmpName":_name,"type":"ds"},
					dataType:"text",
					success:function(data, textStatus){
						console.log(data);
						if(data==0){
							alert("保存成功！");
							window.location.href=window.location.href;
						}else{
							alert("保存失败！");
						}
					},
					error:function(){
						alert("保存模板出错！");
					}
				});
			}
			
			var oldSelect = $("#moduleList").children('option:selected').val();
			//删除模板按钮的隐藏和显示
			if(oldSelect==''){
				$("#delSelectDsTmpBtn").hide();
			}else{
				$("#delSelectDsTmpBtn").show();
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
						console.log(_left+","+_right);
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
						console.log(href);
						
						window.location.href=href;
						oldSelect = newSelect;
					}else{
						$(this).val(oldSelect);
					}
					return;
				}
				
				//var dd = $(this).attr("dd");
				console.log("moduleList..");
				//var dd = $(this).children('option:selected').attr("dd");
				var _moduleListJson = $("#moduleList_hidden").text();
				var dsTmp = eval('('+_moduleListJson+')');
				console.log(ruleConf);
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
				console.log("填充数据到页面");
				$("#lineReg").text(lineReg);
				$("#newLine").text(newLine);
				$("#notParser").text(notParser);
				
				//根据columns自动生成表格
			});
			
			$("#clearRadioSelect").click(function(){
				$("input[name='columnTime']").attr("checked",false);				
			});
			
			function columnTypeChange0(t){
				var val = $(t).val();
				console.log("time..."+val);
				if(val=="Datetime" || val=="Timestamp"){
					$(t).parent().parent().find("input[name='columnDateFormat']").show();
				}else{
					$(t).parent().parent().find("input[name='columnDateFormat']").hide();
				}
			}
			
			$("select[name='columnType']").bind("change",function(){
					console.log("time...");
					columnTypeChange0($(this))
			});
		</script>

</body>
</html>