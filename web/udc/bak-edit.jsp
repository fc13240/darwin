<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.UdcInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.UdcServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>编辑自定义脚本</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_udc);%>
	<%session.setAttribute("files", "yyyyyyy");%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					自定义组件管理 / 编辑
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
<%-- 		<c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<div class="container mh500">
					<div class="row">
						<div class="col-md-8">
							<%
								try{
									String id = request.getParameter("id");
									UdcInfo udcInfo = null;
									
									if(StringUtils.isNotBlank(id)){
										udcInfo = UdcServices.selectById(id);
									}else{
										udcInfo = new UdcInfo();
									}
									
									request.setAttribute("udc", udcInfo);
								}catch(Exception e){
									e.printStackTrace();
								}
								
							%>
							
							<%
								String id = request.getParameter("id");
								String source = request.getParameter("source");
								String sourceType = request.getParameter("sourceType");
								DatasourceInfo ds = null;
								String files = "";
								if(StringUtils.isNotBlank(id)){
									ds = DatasourceServices.selectById(id);
									
									source = ds.getSource();
									sourceType = ds.getSourceType();
									if(StringUtils.isNotBlank(ds.getSourceDetail())){
										files = JSON.parseObject(ds.getSourceDetail()).getString("files");
									}
									if(StringUtils.isBlank(files)){
										files = "";
									}
								}else{
									source = request.getParameter("source");
									sourceType = request.getParameter("sourceType");
								}
							
								request.setAttribute("source",source);
								request.setAttribute("sourceType",sourceType);
								request.setAttribute("dsConnMap", DataCache.dsConnMap.get(source));
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
							<form action="<%=request.getContextPath() %>/udc?method=save" method="post" 
								class="form-horizontal" role="form" onclick="return func();">
								
								<input value="${udc.id}" name="id" id="id" type="hidden"/>
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"></label>
									<div class="col-sm-5">
										<ul class="darwin-page-op-nav">
											
											<li>
												<a href="javascript:history.go(-1);">返回</a> 
											</li>
											<li>
												<input type="submit" value="保存" class="btn btn-primary"/>
											</li>
										</ul>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">名称</label>
									<div class="col-sm-5">
										<input data-rule="required;name;length[1~45]" id="name" name="name" value="${udc.name}" class="form-control" placeholder="名称"/>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">版本</label>
									<div class="col-sm-5">
										<input id="version" name="version" value="${udc.version}" class="form-control" placeholder="版本号"/>
									</div>
									<p class="help-block">
										修改后版本为v1.0.1
									</p>
								</div>
								<div class="form-group">
									<label for="type" class="col-sm-2 control-label">类型</label>
									<div class="col-sm-5">
										<select id="type" name="type" class="form-control">
												<%
													request.setAttribute("udcTypeList", DataCache.udcTypeList);
												%>
												<c:forEach items="${udcTypeList}" var="item">
										           <option <c:if test='${udc.type == item.value}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
										        </c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">描述</label>
									<div class="col-sm-10">
										<input  id="remark" name="remark" value="${udc.remark}" class="form-control" placeholder="描述"/>
<%-- 										<textarea data-rule="required;sql" id="sql" name="sql" class="form-control input-sm" placeholder="分析名称">${ana.sql}</textarea> --%>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">文件zip</label>
									<div class="col-sm-10">
<!-- 										<div id="errorTips" style="color: red;"></div> -->
<%-- 										<input name="files" id="files" value="<%=files %>" type="hidden"/>  --%>
<!-- 										<input class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" /> -->
<!-- 										<div id="selectedList" style="margin-top: 20px;"></div> -->
									</div>
								</div>
<!-- 								<div class="from-group"> -->
<!-- 									<label for="filePath" class="col-sm-2 control-label">文件zip</label> -->
<!-- 									<div class="col-sm-10"> -->
<!-- 										<p> -->
<!-- 										</p> -->
<!--										<input class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" /> -->
<!-- 									</div> -->
<!--  									<div id="errorTips" style="color: red;"></div> -->
<%-- 									<input name="files" id="files" value="<%= %>" type="hidden"/>  --%>
									
<!-- 								</div> -->
<!-- 								<div class="from-group"> -->
<!-- 									<div class="well well-lg" id="selectedList" style="margin-top: 5px;"></div> -->
<!-- 								</div> -->
								<div class="form-group" >
								&nbsp;
								</div>
								<div class="form-group" >
									<label for="name" class="col-sm-2 control-label">入口文件</label>
									<div class="col-sm-5">
										<input id="mainFile" name="mainFile" value="${udc.mainFile}" class="form-control" placeholder=""/>
									</div>
								</div>
								<div class="form-group">
									<label for="status" class="col-sm-2 control-label">状态</label>
									<div class="col-sm-5">
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
									<label for="output" class="col-sm-2 control-label">输出参数</label>
									<div class="col-sm-5">
										<p class="help-block">
											输入参数类型可以为：<br>
											      本地文件：localfilename<br>
											  HDFS文件：hdfsfilename<br>
											      整数:int<br>
											      字符串:string<br>
										</p>
									</div>
								</div>
								<div class="form-group">
									<label for="input" class="col-sm-2 control-label">输入参数</label>
									<div class="col-sm-5">
										<p class="help-block">
											输出参数类型可以为：<br>
											       本地文件：localfilename<br>
											   HDFS文件：hdfsfilename<br>
										</p>
									</div>
								</div>
								<div id="errorTips" style="color: red;"></div>
								<input name="files" id="files" value="<%=files %>" type="hidden"/> 
								<input class="btn btn-default input-sm" type="button" id="insertfile" value="选择文件" />
								<div id="selectedList" style="margin-top: 20px;"></div>
								<div class="well well-lg" id="selectedList" style="margin-top: 20px;"></div>
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
						K('#files').val(files?files:"" + url);
						
						files = K('#files').val();
						if(files){
							init(files);
						}
						editor.hideDialog();
					}
				});
			});
		});
		
		init($("#files").val());
		
		function init(files){
			files = files.split(";");
			for(var i=0;i<files.length;i++){
				$("#selectedList").html("<div>"+files[i]+"</div>");
			}
		}
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
</body>
</html>
