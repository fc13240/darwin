<%@page import="com.stonesun.realTime.services.db.bean.ScriptInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.ScriptServices"%>
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
<title>脚本编辑</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%session.setAttribute("files", "yyyyyyy");%>
	<%request.setAttribute("topId", "1");%>
	<%
		try{
			String id = request.getParameter("id");
			UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
			ScriptInfo info = new ScriptInfo();
			if(StringUtils.isNotBlank(id)){
				info = ScriptServices.selectById0(id,user1.getId());
				if(info==null){
					response.sendRedirect("/resources/403.jsp");
					return;
				}else{
					if(StringUtils.isNotBlank(info.getParams())){
						JSONObject pms = JSON.parseObject(info.getParams());
						request.setAttribute("params", pms);
						request.setAttribute("inputinfo", pms.getJSONArray("inputinfo"));
					}
				}
			}else{
				info = new ScriptInfo();
			}
			request.setAttribute("info", info);
			request.setAttribute("id",id);
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<!-- page header start -->
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					数据获取脚本管理
				</div>
			</div>
		</div>
	</div>
	<!-- page header end -->
	
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%-- <%@ include file="/configure/leftMenu.jsp"%> --%>
			</div>
			<div class="col-md-9">
				<div class="page-header">
					<ol class="breadcrumb">
						<li><a href="<%=request.getContextPath() %>/script?method=index">数据获取脚本列表</a></li>
						<li class="active">脚本新增编辑</li>
					</ol>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<form 
								action="<%=request.getContextPath() %>/script?method=save"
								class="form-horizontal" role="form" method="post" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}">
								<input value="${info.id}" name="id" id="id" type="hidden"/>
								<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"></label>
									<div class="col-sm-4">
										<ul class="darwin-page-op-nav">
											
											<li>
												<a href="javascript:history.go(-1);">返回</a> 
											</li>
											<li>
												<input code="save" type="submit" value="保存" class="btn btn-primary"/>
											</li>
										</ul>
									</div>
								</div>
								<div class="form-group">
									
									<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>名称</label>
									<div class="col-sm-4">
										<input data-rule="required;name;length[1~45];remote[/script?method=exist&id=${id}]" id="name" name="name" <c:if test='${empty info.name}'>value="脚本名称"</c:if>value="${info.name}" class="form-control" placeholder="名称"/>
									</div>
								</div>
								<div class="form-group">
									<label for="type" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>类型</label>
									<div class="col-sm-4">
										<select id="type" name="type" class="form-control">
												<%
													request.setAttribute("udcTypeList", DataCache.udcTypeList);
												%>
												<c:forEach items="${udcTypeList}" var="item">
										           <option <c:if test='${info.type == item.value}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
										        </c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
								
									<label for="version" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>版本</label>
									<div class="col-sm-4">
										<input data-rule="required;length[1~45]" id="version" name="version" <c:if test='${empty info.version}'>value="V.1.0.0"</c:if>value="${info.version}" class="form-control" placeholder="版本号"/>
									</div>
								</div>
								<div class="form-group">
									<label for="remark" class="col-sm-2 control-label">描述</label>
									<div class="col-sm-6">
										<input  id="remark" name="remark" value="${info.remark}" class="form-control" placeholder="描述"/>
									</div>
								</div>
								
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>zip文件</label>
									<div class="col-sm-6">
										<div id="errorTips" style="color: red;"></div>
										<input name="files" id="files" value="${info.filePath}" class="form-control " readonly="readonly" data-rule="required;"/> 
									</div>
									<div class="col-sm-2">
										<input code="save" class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" />
									</div>
								</div>
								
								<div id="udcClassName_div" class="form-group" <c:if test="${info.type eq '单机shell' or empty id}">style="display:none"</c:if>>
									<label for="scriptClassName" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>类名</label>
									<div class="col-sm-6">	
										<c:choose>
											<c:when test="${info.type eq '单机shell' or empty id}">
												<input id="scriptClassName" name="scriptClassName" value="${info.scriptClassName}" class="form-control" placeholder="例：com.darwin.huizi.test.HadoopCountTest"/>
											</c:when>
											<c:otherwise>
												<input id="scriptClassName" name="scriptClassName" value="${info.scriptClassName}"  data-rule="required;" class="form-control" placeholder="例：com.darwin.huizi.test.HadoopCountTest"/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div id="mainFile_div" class="form-group" <c:if test="${info.type eq '单机jar' or info.type eq 'sparkJar'}">style="display:none"</c:if>>
									<label for="mainFile" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>入口文件</label>
									<div class="col-sm-4">
										<c:choose>
											<c:when test="${info.type eq '单机jar' or info.type eq 'sparkJar'}">
												<input id="mainFile" name="mainFile" value="${info.mainFile}" class="form-control" placeholder="例：in.sh"/>
											</c:when>
											<c:otherwise>
												<input id="mainFile" name="mainFile" value="${info.mainFile}" class="form-control" data-rule="required;" placeholder="例：in.sh"/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<div class="form-group">
									<label for="status" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>状态</label>
									<div class="col-sm-4">
										<select id="status" name="status" class="form-control">
											<%
												request.setAttribute("udcStatusList", DataCache.udcStatusList);
											%>
											<c:forEach items="${udcStatusList}" var="item1">
									           <option <c:if test='${info.status == item1.value}'>selected="selected"</c:if>value="${item1.key}">${item1.value}</option>
									        </c:forEach>
										</select>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%-- 	<%@ include file="/resources/common_footer.jsp"%> --%>
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
						K('#files').val(url);
						editor.hideDialog();
						var fff=$('#files').val();
						if(fff != '' && fff.indexOf(".sh") != -1){
					 		console.log("fff="+fff);
					 		var fileToMain = fff.split("/");
					 		if(fileToMain.length>1){
					 			console.log("fff="+fileToMain.length);
					 			$("#mainFile").val(fileToMain[fileToMain.length-1]);
						 	}
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

	$(function(){
		//通用按钮的提交表单事件
		$("form").on("valid.form", function(e, form){
			createMark();
			form.submit();
		});
		
	//类型切换
	$("#type").change(function(){
		var newSelect = $(this).val();
		if(newSelect=="sparkJar" || newSelect=="singleJar"){
			//
			$("#udcClassName_div").show();
			$("#scriptClassName").attr("data-rule","required;");
			//
			$("#mainFile_div").hide();
// 			$("#mainFile").val("0");
			$("#mainFile").attr("data-rule","");
			
		}else if(newSelect==""){
			//
			$("#udcClassName_div").hide();
// 			$("#scriptClassName").val("");
			$("#scriptClassName").attr("data-rule","");
			//
			$("#mainFile_div").hide();
// 			$("#mainFile").val("");
			$("#mainFile").attr("data-rule","");
		}else{
			//
			$("#udcClassName_div").hide();
// 			$("#scriptClassName").val("0");
			$("#scriptClassName").attr("data-rule","");
			//
			$("#mainFile_div").show();
// 			$("#mainFile").val("");
			$("#mainFile").attr("data-rule","required;");
		}
	});
});
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
