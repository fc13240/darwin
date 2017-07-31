<%@page import="com.stonesun.realTime.services.db.UdcHistoryServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.UdcHistoryInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.UdcInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.UdcServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>自定义</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>

</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%session.setAttribute("files", "yyyyyyy");%>
	<%session.setAttribute("versionHistory", "");%>
	<%request.setAttribute("topId", "1");%>
	<%
		String id = request.getParameter("id");
		UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
		String versionHistory = "";
		UdcHistoryInfo udcHistoryInfo = new UdcHistoryInfo();
		UdcInfo udcInfo = new UdcInfo();
		JSONArray params=new JSONArray();
		if(StringUtils.isNotBlank(id)){
			udcInfo = UdcServices.selectById0(id,user1.getId());
			if(udcInfo==null){
				response.sendRedirect("/resources/403.jsp");
				return;
			}else{
				if(StringUtils.isNotBlank(udcInfo.getParams())){
					params=JSON.parseArray(udcInfo.getParams());
					
				}
				udcHistoryInfo = UdcHistoryServices.selectVersionById(id);
				if(udcHistoryInfo != null){
					versionHistory=udcHistoryInfo.getVersion();
				}
			}
		}else{
			udcInfo = new UdcInfo();
		}
		request.setAttribute("params", params);
		request.setAttribute("versionHistory", versionHistory);
		request.setAttribute("udc", udcInfo);
		request.setAttribute("id",id);
	%>
	
	<%@ include file="/resources/common_menu2.jsp"%>
	
	<!-- page header start -->
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					自定义组件管理
				</div>
			</div>
		</div>
	</div>
	<!-- page header end -->
	
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
						<li><a href="<%=request.getContextPath() %>/udc?method=index">自定义组件管理列表</a></li>
						<li class="active">自定义组件新增编辑</li>
						<li class="active">&nbsp;帮助文档<a target="_blank" href="<%=request.getContextPath() %>/udc/example.jsp" >【点击查看示例代码】</a></li>
					</ol>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<form  notBindDefaultEvent=true
								action="<%=request.getContextPath() %>/udc?method=save"
								class="form-horizontal" role="form" method="post" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}">
								
								<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
								<input value="${udc.id}" name="id" id="id" type="hidden"/>
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"></label>
									<div class="col-sm-5">
										<a href="javascript:history.go(-1);">返回</a>
										<input code="save" type="submit" value="保存" class="btn btn-primary"/>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>名称</label>
									<div class="col-sm-4">
										<input data-rule="required;name;length[1~45];remote[/udc?method=exist&id=${id}]" id="name" name="name" <c:if test='${empty udc.name}'>value="自定义名称"</c:if>value="${udc.name}" class="form-control" placeholder="名称"/>
									</div>
								</div>
								<div class="form-group">
									<label for="type" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>类型</label>
									<div class="col-sm-4">
										<select id="type" name="type" class="form-control">
												<%
													request.setAttribute("udcTypeList", DataCache.udcTypeList);
												%>
<!-- 												<option value="">---选择类型---</option> -->
												<c:forEach items="${udcTypeList}" var="item">
										           <option <c:if test='${udc.type == item.value}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
										        </c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="version" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>版本</label>
									<div class="col-sm-4">
										<input data-rule="required;length[1~45]" id="version" name="version" <c:if test='${empty udc.version}'>value="V.1.0.0"</c:if>value="${udc.version}" class="form-control" placeholder="版本号"/>
										<input id="versionOld" name="versionOld" value="${udc.versionOld}" type="hidden"/>
									</div>
									<c:if test="${!empty versionHistory}" >
										<p class="help-block">
											上一个版本为:${versionHistory }
										</p>
									</c:if>
								</div>
								<div class="form-group">
									<label for="remark" class="col-sm-2 control-label">描述</label>
									<div class="col-sm-6">
										<input  id="remark" name="remark" value="${udc.remark}" class="form-control" placeholder="描述"/>
									</div>
								</div>
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>上传文件</label>
									<div class="col-sm-6">
										<div></div>
										<input name="files" id="files" value="${udc.filePath}" class="form-control " readonly="readonly" data-rule="required;"/> 
									</div>
									<div class="col-sm-2">
										<input code="save" class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" />
									</div>
								</div>
								<div id="udcClassName_div" class="form-group" <c:if test="${udc.type eq '单机shell' or empty id}">style="display:none"</c:if>>
									<label for="udcClassName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>类名</label>
									<div class="col-sm-6">
										<c:choose>
											<c:when test="${udc.type eq '单机shell' or empty id}">
												<input id="udcClassName" name="udcClassName" value="${udc.udcClassName}" class="form-control" placeholder="例：com.darwin.huizi.test.HadoopCountTest"/>
											</c:when>
											<c:otherwise>
												<input id="udcClassName" name="udcClassName" value="${udc.udcClassName}"  data-rule="required;" class="form-control" placeholder="例：com.darwin.huizi.test.HadoopCountTest"/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div id="mainFile_div" class="form-group" <c:if test="${udc.type eq '单机jar' or udc.type eq 'sparkJar'}">style="display:none"</c:if>>
									<label for="mainFile" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>入口文件</label>
									<div class="col-sm-4">
										<c:choose>
											<c:when test="${udc.type eq '单机jar' or udc.type eq 'sparkJar'}">
												<input id="mainFile" name="mainFile" value="${udc.mainFile}" class="form-control" placeholder="例：in.sh"/>
											</c:when>
											<c:otherwise>
												<input id="mainFile" name="mainFile" value="${udc.mainFile}" class="form-control" data-rule="required;" placeholder="例：in.sh"/>
											</c:otherwise>
										</c:choose>
									</div>
									<p class="help-block">
										注：如果是.sh文件，请注意填写上传文件的文件名。
									</p>
								</div>
								
								<div class="form-group">
									<label for="status" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>状态</label>
									<div class="col-sm-4">
										<select id="status" name="status" class="form-control">
											<%
												request.setAttribute("udcStatusList", DataCache.udcStatusList);
											%>
											<c:forEach items="${udcStatusList}" var="item1">
									           <option <c:if test='${udc.status == item1.value}'>selected="selected"</c:if>value="${item1.key}">${item1.value}</option>
									        </c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-2">
										<button code="save" class="btn btn-primary" type="button" id="newRow">添加输入参数</button>
									</div>
									<p class="help-block">
										注：不填则无输入，或无输出
									</p>
								</div>
								<div class="form-group">
									<table class="table table-bordered table-hover" id="ruleTable" style="margin-bottom: 100px;">
										<tr class="success">
											<td style="width:5%">序号</td>
											<td>参数样式</td>
											<td style="width:300px；"><span class="redStar">*&nbsp;</span>参数名称</td>
											<td>参数中文描述</td>
											<td style="width:10%">操作</td>
										</tr>
										<c:forEach var="stu" items="${params}" varStatus="status">
											<tr>
												<td>${status.index + 1}</td>
												<td>
													<select class="form-control" name="pamType" id="pamType" onchange="columnTypeChange0(this)">
														<%
															session.setAttribute("types", DataCache.pamTypeList);
														%>
<!-- 														<option value="">--选择类型--</option> -->
														<c:forEach items="${types}" var="list">
												           <option <c:if test='${list.key == stu.type}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
												        </c:forEach>
													</select>
												</td>
												<td style="width:300px；">
													<input name='pamName' class='form-control' value="${stu.name}"/>
													<br>
													<c:choose>
														<c:when test="${stu.type eq 'select'}">
															<div id="selectType" >
																<button code="save"  class="btn btn-xs btn-primary" type="button" onclick="addRow2(this,${status.index + 1});">添加下拉菜单内容</button>
																<table class="table table-bordered table-hover" id="selectTable">
																	<tr class="success">
																		<td>key</td>
																		<td>value</td>
																		<td style="width:20%">操作</td>
																	</tr>
																	<c:forEach var="stu001" items="${stu.select}" varStatus="status01">
																		<tr>
																			<td>
																				<input name='selectKey${status.index + 1}' class='form-control' value="${stu001.key}" />
																			</td>
																			<td>
																				<input name='selectValue${status.index + 1}' class='form-control' value="${stu001.value}" />
																			</td>
																			<td style="width:20%">
																				<input code="save" type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
																			</td>
																		</tr>
																	</c:forEach>
																</table>
															</div>
														</c:when>
														<c:otherwise>
															<div id="selectType" style="display:none;">
																<button class="btn btn-xs btn-primary" type="button" onclick="addRow2(this,${status.index + 1});">添加下拉菜单内容</button>
																<table class="table table-bordered table-hover" id="selectTable">
																	<tr class="success">
																		<td>key</td>
																		<td>value</td>
																		<td>操作</td>
																	</tr>
																</table>
															</div>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<input name='pamRemark' class='form-control' value="${stu.remark}" />

												</td>
												<td style="width:100px">
													<input code="save"  type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
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
					fileUrl : K('#files').val(),
					clickFn : function(url, title) {
						var files = K('#files').val();
						//K('#files').val(files?files:"" + url + ";");
						//K('#files').val(files?files:"" + url);
						K('#files').val(url);
						//files = K('#files').val();
						//if(files){
							//init(files);
						//}
						editor.hideDialog();
						var fff=$('#files').val();
						if(fff != '' && fff.indexOf(".sh") != -1){
					 		console.log("fff="+fff);
					 		var fileToMain = fff.split("/");
					 		if(fileToMain.length>1){
					 			console.log("fff="+fileToMain.length);
					 			$("#mainFile").val(fileToMain[fileToMain.length-1]);
// 					 			$("#mainFile").attr("readonly","readonly");
						 	}
					 	}else{
// 					 		$("#mainFile").val("");
// 					 		$("#mainFile").attr("readonly",false);
						 }
					}
				});
			});
		});
		
	});
	
	function onsubmitFunc(){
		var files = $("#files").val();
		if(files){
			return true;
		}
		$("#errorTips").html("请先选择文件!");
		return false;
	}
</script>

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
		
	}
	
// 	var typelist_select;
	$(function(){
		init();

// 		typelist_select = $("#typeJson").html();
// 		$("#typeJson").remove();
		//通用按钮的提交表单事件
		

		$("form").on("valid.form", function(e, form){
					console.log("valid...");
					createMark();
					form.submit();
				});
				
				//表单验证失败
				$('form').on('invalid.form', function(e, form, errors){
					console.log("表单验证失败222...");
					console.log(e);
					console.log(form);
					console.log(errors);
				    //do something...
					if(window.invalidFormFunc){
						invalidFormFunc();
					}
				});


		$("#newRow").click(function(){
			addRow(null,null);
		});
		
	});

	function columnTypeChange0(t){
		console.log(t);
		var val = $(t).val();
		if(val=="select"){
			$(t).parent().parent().find("div[id='selectType']").show();
		}else{
			$(t).parent().parent().find("div[id='selectType']").hide();
		}
	}
	
// 	$("#pamType").change(function(){
// 		var val = $(this).val();
// 		console.log("time..."+val);
// 		if(val=="select"){
// 			$(this).parent().parent().find("div[id='selectType']").show();
// 		}else{
// 			$(this).parent().parent().find("div[id='selectType']").hide();
// 		}
// 	});
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow(target,insertBefore){
		var ruleTableTr = $("#ruleTable tr").size();
		var selectTableTr = $("#selectTable tr").size();
		var id = ruleTableTr-selectTableTr;
		var _row = "<tr>";
		_row += "<td>"+id+"</td>";
		_row += "<td><select id='pamType' name='pamType' onchange='columnTypeChange0($(this))' class='form-control'><option value='String'>输入框(input)</option><option value='hdfspath'>路径(hdfspath)</option><option value='textarea'>文本框(textarea)</option><option value='select'>下拉框(select)</option><option value='password'>密码框(password)</option></select></td>";
		_row += "<td style=\"width:'300px'\"><input name='pamName' placeholder='参数名称' class='form-control' data-rule='required;'/><br>";
		_row += "<div id='selectType' style='display:none;'>";
		_row += "<button class='btn btn-xs btn-primary' type='button' onclick='addRow2($(this),"+id+");'>添加下拉菜单内容</button>";
		_row += "<table class='table table-bordered' id='selectTable'><tr class='success'><td>key</td><td>value</td><td>操作</td></tr></table>";
		_row += "</div>";
		_row += "</td>";
		_row += "<td><input name='pamRemark' placeholder='中文描述' class='form-control'/></td>";
		_row += "<td style=\"width:'10%'\"> <input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";
		$("#ruleTable").append(_row);
	}
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow2(t,id){
// 		console.log("addRow2.t.."+t);
// 		console.log("addRow2.id.."+id);
		var ttt = $(t).parent().parent().find($("#selectTable tr")).size();
		var _row2 = "<tr>";
		_row2 += "<td><input name='selectKey"+id+"' id='selectKey"+id+"' class='form-control' data-rule='required;'/><br>";
		_row2 += "<td><input name='selectValue"+id+"' id='selectValue"+id+"' class='form-control' data-rule='required;'/></td>";
		_row2 += "<td style=\"width:10%\"><input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row2 += "</tr>";
		$(t).parent().parent().find("table[id='selectTable']").append(_row2);
	}
	
	//del
	function delFunc(obj){
		$(obj).parent().parent().remove();
	}
	
	//类型切换
	$("#type").change(function(){
		var newSelect = $(this).val();
		if(newSelect=="sparkJar" || newSelect=="singleJar"){
			$('form').validator( "destroy" );
			$("#files").attr("data-rule","required;");
			//
			$("#udcClassName_div").show();
			$("#udcClassName").attr("data-rule","required;");
			//
			$("#mainFile").removeAttr("data-rule");
			$('form').validator('hideMsg', '#mainFile');
			$("#mainFile").val("0");
			$("#mainFile_div").hide();
			
		}else if(newSelect==""){
			$('form').validator( "destroy" );
			$("#files").attr("data-rule","required;");
			//
			$("#udcClassName_div").hide();
			$("#udcClassName").val("");
			$("#udcClassName").removeAttr("data-rule");
			//
			$("#mainFile_div").hide();
			$("#mainFile").val("");
			$("#mainFile").removeAttr("data-rule");
			$('form').validator('hideMsg', '#udcClassName');
			$('form').validator('hideMsg', '#mainFile');

		}else{
			$('form').validator( "destroy" );
			$("#files").attr("data-rule","required;");
			//
			$("#udcClassName").removeAttr("data-rule");
			$('form').validator('hideMsg', '#udcClassName');
			
			$("#udcClassName_div").hide();
			$("#udcClassName").val("0");
			//
			$("#mainFile_div").show();
			$("#mainFile").val("");
			$("#mainFile").attr("data-rule","required;");
		}
	});
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
