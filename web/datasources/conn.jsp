<%@page import="java.util.Set"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>添加离线数据源</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<%
// 		try{
			String id = request.getParameter("id");
			String source = request.getParameter("source");
			String sourceType = request.getParameter("sourceType");
			DatasourceInfo ds = null;
			//String ipPort = null,
			String tableName = null , dir = null;
			JSONObject _sourceDetail = null;
			if(StringUtils.isNotBlank(id)){
				ds = DatasourceServices.selectById(id);
//	 			request.setAttribute("sourceDetail",ds.getSourceDetail());
				source = ds.getSource();
				sourceType = ds.getSourceType();
				
				if(StringUtils.isNotBlank(ds.getSourceDetail())){
					_sourceDetail = JSON.parseObject(ds.getSourceDetail());
					Object _connId = JSON.parseObject(ds.getSourceDetail()).get("connId");
					if(_connId!=null){
						//查询conn info
						ConnConfInfo connInfo = ConnConfServices.selectById(Integer.valueOf(_connId.toString()));
						request.setAttribute("connInfo", connInfo);
					}
					
//	 				ipPort = _sourceDetail.getString("ipPort");
//	 				request.setAttribute("ipPort",ipPort);

					String windowSplit = "\\";
					String linuxSplit = "/";
					request.setAttribute("_sourceDetail",_sourceDetail);
					dir = _sourceDetail.getString("localScript");
					if(StringUtils.isNotBlank(dir)){
						
						String dir2 = dir.substring(0,dir.lastIndexOf(linuxSplit) + 1);
						request.setAttribute("dir",dir2);
						String file = dir.substring(dir.lastIndexOf(linuxSplit) + 1);
						request.setAttribute("file",file);
						System.out.println("=====file="+file);
					}
				}
				tableName = ds.getTableName();
				request.setAttribute("tableName",tableName);
				
				//update的情况下，如果source和sourceType同时存在，则说明是切换
				if(StringUtils.isNotBlank(request.getParameter("source")) && StringUtils.isNotBlank(request.getParameter("sourceType"))){
					source = request.getParameter("source");
					sourceType = request.getParameter("sourceType");
				}
				
			}else{
				source = request.getParameter("source");
				sourceType = request.getParameter("sourceType");
			}
		
			request.setAttribute("id",id);
			request.setAttribute("source",source);
			request.setAttribute("sourceType",sourceType);
			request.setAttribute("dsConnMap", DataCache.dsConnMap.get(source));
// 		}catch(Exception e){
// 			e.printStackTrace();
// 		}
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
	<div class="container mh500">
		<div class="row">
			<div class="col-md-12">
				<c:choose>
					<c:when test="${source eq 'offLine'}">
						<c:choose>
							<c:when test="${sourceType eq 'ftp' or sourceType eq 'scp' or sourceType eq 'hdfs'}">
								<form id="defaultForm" action="<%=request.getContextPath() %>/datasources/offLine/files.jsp?source=${source}<%=getIdParam(request) %>" class="form-horizontal" role="form" method="post" onsubmit="return check()">
							</c:when>
							<c:when test="${sourceType eq 'db'}">
								<form id="defaultForm" action="<%=request.getContextPath() %>/datasources/offLine/sql/sql.jsp?source=${source}&sourceType=${sourceType}<%=getIdParam(request) %>" class="form-horizontal" role="form" method="post" onsubmit="return check()">
							</c:when>
						</c:choose>
					</c:when>
					<c:when test="${source eq 'realTime'}">
						<form action="<%=request.getContextPath() %>/datasources?method=toFmt&source=${source}<%=getIdParam(request) %>" class="form-horizontal" role="form" method="post">
						
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${sourceType eq 'flume' or sourceType eq 'logstash' or sourceType eq 'tcp' or sourceType eq 'syslog'}"> --%>
<%-- 								<form id="defaultForm" action="<%=request.getContextPath() %>/datasources?method=toFmt&source=${source}<%=getIdParam(request) %>" class="form-horizontal" role="form" method="post" onsubmit="return check()"> --%>
<%-- 							</c:when> --%>
<%-- 						</c:choose> --%>
					</c:when>
				</c:choose>
				
				<input id="id" name="id" value="${id}" type="hidden"/>
				
				<div class="form-group">
					<label for="" class="col-sm-2 control-label"></label>
					<div class="col-sm-5">
						<ul class="darwin-page-op-nav">
							
							<li>
								<a href="javascript:history.go(-1);">返回</a> 
							</li>
							<li>
								<input type="submit" value="下一步" class="btn btn-primary"/>
							</li>
						</ul>
					</div>
				</div>
				<div class="form-group">
					<label for="sourceType" class="col-sm-2 control-label">请选择数据源类型</label>
					<div class="col-sm-5">
						<select id="sourceType" name="sourceType" class="form-control ">
							<c:forEach items="${dsConnMap}" var="item">
					           <option <c:if test='${sourceType == item.type}'>selected="selected"</c:if>value="${item.type}">${item.name}</option>
					        </c:forEach>
						</select>
					</div>
					<!-- 
					<div class="col-sm-5">
						<p class="help-block">
							FTP数据获取需要您的FTP服务是平台可以访问的。SCP数据获取需要您有SSH登录到数据所在服务器的权限。
						</p>
					</div>
					 -->
				</div>
				<div class="form-group" id="sourceTypeDetail">
					<c:choose>
						<c:when test="${source eq 'offLine'}">
						</c:when>
						<c:when test="${source eq 'realTime'}">
							<c:choose>
								<c:when test="${sourceType eq 'logstash'}">
								</c:when>
								<c:when test="${sourceType eq 'flume'}">
										<label for="ipPort" class="col-sm-2 control-label">ip:port</label>
										<div class="col-sm-5">
											<input id="ipPort" name="ipPort" value="${_sourceDetail.ipPort}" class="form-control" placeholder="请输入采集端ip:port" data-rule="required;ipPort">
										</div>
										<div class="col-sm-5">
											<p class="help-block">
												指定接收实时数据的ip和端口
											</p>
										</div>
								</c:when>
								<c:when test="${sourceType eq 'tcp' or sourceType eq 'udp'}">
										<label for="port" class="col-sm-2 control-label">port</label>
										<div class="col-sm-5">
											<input id="port" name="port" value="${_sourceDetail.port}" class="form-control" placeholder="请输入端口" data-rule="required;port;integer;range[1025~65534]">
										</div>
										<div class="col-sm-5">
											<p class="help-block">
												指定监听的端口号，前提是该端口号未被其他应用占用。可以通过命令netstat -lanp | grep 端口号 查看是否被占用。
											</p>
										</div>
								</c:when>
								<c:when test="${sourceType eq 'syslog' or sourceType eq 'rsyslog'}">
								
								</c:when>
								<c:when test="${sourceType eq 'localMonitor'}">
										<label for="monitorPath" class="col-sm-2 control-label">监控路径</label>
										<div class="col-sm-5">
											<input id="monitorPath" name="monitorPath" value="${_sourceDetail.monitorPath}" class="form-control" placeholder="请输入监测路径" data-rule="required;monitorPath;remote[/datasources?method=pathExists]">
											<br>
											<address>
											  <strong>格式说明</strong>
											    <p>
											    	监控指定的文件：/home/files/a.txt<br>
											    	监控指定的目录：/home/files/<br>
											    </p>
											</address>
										</div>
								</c:when>
								<c:when test="${sourceType eq 'remoteMonitor'}">
										<label for="monitorPath" class="col-sm-2 control-label">监控路径</label>
										<div class="col-sm-5">
											<input id="monitorPath" name="monitorPath" value="${_sourceDetail.monitorPath}" class="form-control" placeholder="请输入监测路径" data-rule="required;monitorPath">
											<br>
											<address>
											  <strong>格式说明</strong>
											    <p>
<!-- 											    	ftp://用户名@远程IP:PORT/home/.../@@{yyyyMMdd HH:mm:ss}.log --ftp-password=密码<br> -->
													ftp://用户名:密码@远程IP:PORT/home/.../@@{yyyyMMdd HH:mm:ss}.log<br>
													ftp://用户名:密码@远程IP:PORT/home/.../@@{yyMMdd}.@@{hh}.log<br>
											    </p>
											</address>
										</div>
								</c:when>
								<c:when test="${sourceType eq 'localScript'}">
										<label for="localScript" class="col-sm-2 control-label">选择脚本</label>
										<div class="col-sm-3">
<%-- 											<input style="display: none;" id="localScript" name="localScript" value="${_sourceDetail.localScript}" class="form-control" placeholder="请输入本机脚本路径" data-rule="required;localScript"> --%>
											<%
												Set<String> dirList = DatasourceServlet.fileList().keySet();
												request.setAttribute("dirList", dirList);
											%>
											<select id="dir" name="dir" class="form-control" data-rule="required;dir">
												<option></option>
												<c:forEach items="${dirList}" var="item">
													<option <c:if test='${item == dir}'>selected="selected"</c:if>value="${item}">${item}</option>
										      	</c:forEach>
											</select>
										</div>
										<div class="col-sm-2">
											<select id="files" name="files" class="form-control" data-rule="required;files">
												<option></option>
											</select>
										</div>
										<div class="col-sm-5">
											<p class="help-block">
												Darwin所在服务器上有专门用于存放脚本的目录，如需脚本获取数据，请先将脚本上传于该目录下，支持在脚本目录下创建子目录。
											</p>
										</div>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
				</div>
				
				<c:choose>
					<c:when test="${source eq 'offLine'}">
						<div class="form-group">
							<label for="" class="col-sm-2 control-label"></label>
							<div class="col-sm-3">
								<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal2" onclick="return addConnFunc()">
								  添加新的连接
								</button>
								<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal" onclick="return showConnFunc()">
								  使用已有连接
								</button>
							</div>
							<div class="col-sm-3" style="margin-left: -80px;">
								<%
									ConnConfInfo _connInfo = (ConnConfInfo)request.getAttribute("connInfo");
									if(_connInfo!=null){
										request.setAttribute("_connInfo_name", _connInfo.getName());
										request.setAttribute("_connInfo_id", _connInfo.getId());
									}else{
										request.setAttribute("_connInfo_name", "请选择一个连接！");
									}
								%>
								<input name="selectConnId" id="selectConnId" type="hidden" value="<%=_connInfo!=null?_connInfo.getId():"" %>"/>
								<input name="selectConnName" id="selectConnName" type="hidden" value="<%=_connInfo!=null?_connInfo.getName():"" %>"/>
							
							</div>
						</div>
						<div class="form-group">
							<label for="" class="col-sm-2 control-label"></label>
							<div class="col-sm-5">
									<div class="alert alert-danger alert-dismissible fade in">
										<button type="button" class="close" data-dismiss="alert" ></button>
										<span id="showSelectConnInfo" style=";padding: 10px;">${_connInfo_name}</span>
										<span id="connEditId">
											<c:if test="${not empty _connInfo_id}">
												<a target="_blank"  href="<%=request.getContextPath() %>/user/connConf?method=edit&id=${_connInfo_id}">【查看】</a>
											</c:if>
										</span>
									</div>
							</div>
						</div>
											
						<!-- Modal -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						        <h4 class="modal-title" id="myModalLabel">请选择一个连接</h4>
						      </div>
						      <div class="modal-body" id="connListDiv">
						       		
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						        <button type="button" class="btn btn-primary" id="selectConnBtn">确定</button>
						      </div>
						    </div>
						  </div>
						</div>
						</form>
						
						<br>
						<%@ include file="/datasources/connImpl.jsp"%>
					</c:when>
					<c:when test="${source eq 'realTime'}">
						
					</c:when>
				</c:choose>
				
			</div>
		</div>
	</div>
	<input id="source" value="${source}" type="hidden"/>
	<input id="file" value="${file}" type="hidden"/>
	<%@ include file="/resources/common_footer.jsp"%>
	
	<script type="text/javascript">
	$(function(){
		
		var _url = "<%=request.getContextPath() %>/datasources/conn.jsp?source=realTime&sourceType=logstash";
		console.log(_url);
		$("#sourceType").change(function(){
			var id = $("#id").val();
			if(id && parseInt(id) > 0){
				_url = location.href;
				//update
				var _left = _url.substring(0,_url.indexOf("?"));
				var _right = _url.substring(_url.indexOf("?") + 1);
				console.log(_right);
				var params = {};
				var _arr = _right.split("&");
				if(_arr.length > 0){
					for(var i=0;i<_arr.length;i++){
						var _arr_item = _arr[i].split("=");
						params[_arr_item[0]] = _arr_item[1];
					}
				}
				console.log(params);
				params["source"] = $("#source").val();
				params["sourceType"] = $("#sourceType").val();
				
				var p = "?";
				for(var s in params){
					p += s + "=" + params[s] + "&";
				}
				if(p.length > 0 && p.substring(p.length - 1) == "&"){
					p = p.substring(0,p.length - 1);
				}
				console.log("p = " + p);
				console.log("p = " + (_left + p));
				
				location.href = _left + p;
				
// 				console.log(_left+"?source="+$("#source").val()+"&sourceType="+$("#sourceType").val());
// 				location.href = _left+"?source="+$("#source").val()+"&sourceType="+$("#sourceType").val();
			}else{
				//insert
				var _left = _url.substring(0,_url.indexOf("?"));
				console.log(_left+"?source="+$("#source").val()+"&sourceType="+$("#sourceType").val());
				location.href = _left+"?source="+$("#source").val()+"&sourceType="+$("#sourceType").val();
			}
			
		});
		
		$("#dir").change(function(){
			var dir = $(this).val();
			autoSelected(dir,null);
		});
		
		function autoSelected(selectVal,selectFile){
			if(selectVal==''){
				$("#files").empty();
				return;
			}
			$.ajax({
				url:"<%=request.getContextPath() %>/datasources?method=getFilesByDir&dir="+selectVal,
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					console.log(data);
					$("#files").empty();
					$.each(data,function(index,value){
						if(selectFile && selectFile!='' && selectFile==value){
							$("#files").append("<option selected='selected' value='"+value+"'>"+value+"</option>");	
						}else{
							$("#files").append("<option value='"+value+"'>"+value+"</option>");	
						}
					});
				},
				error:function(){
					console.log("加载数据出错！");
				}
			});
		}
		
		var dir = $("#dir").val();
		autoSelected(dir,$("#file").val());
		
	});
	</script>
</body>
</html>