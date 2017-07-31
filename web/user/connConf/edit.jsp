<%@page import="com.stonesun.realTime.utils.DesUtil"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="java.util.Map"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.bean.ConnConfInfo"%>
<%@page import="com.stonesun.realTime.services.db.ConnConfServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>连接编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("compId", request.getParameter("compId"));%>
	<%request.setAttribute("compType", request.getParameter("compType"));%>
	<%
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
			ConnConfInfo info = ConnConfServices.selectById0(Integer.valueOf(id),user1.getId());
			if(info==null){
				response.sendRedirect("/resources/403.jsp");
				return;
			}else{
				request.setAttribute("linktype",info.getType());
				request.setAttribute("connConfMap", info.getConfMap());
			}
			request.setAttribute("sourceType", "ftp");
			request.setAttribute("id",id);
			request.setAttribute("connConf", (Map<String,String>)JSON.parse(info.getConf()));
			
		}
	%>
	<%request.setAttribute("type", session.getAttribute("type"));%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<%request.setAttribute("topId", "1");%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					连接管理
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-9">
				<form action="<%=request.getContextPath() %>/user/connConf?method=save&compType=${compType}&compId=${compId}" method="post" class="form-horizontal" role="form" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}">
				      <input name="id" type="hidden" value="${id}"/>
					  <div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
					  <div class="page-header">
						  <ol class="breadcrumb">
							  <li><a href="<%=request.getContextPath() %>/user/connConf?method=index&type=${type}">连接管理列表</a></li>
							  <li class="active">新增编辑</li>
						  </ol>
					  </div>
	      			  <c:choose>
						<c:when test="${sourceType eq 'ftp' or 1==1}">
				      		  <div class="form-group">
							    <label for="type" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>连接类型</label>
							    <div class="col-sm-5">
							      <select data-rule="required;type" id="type" name="type" class="form-control ">
										<%
											request.setAttribute("checkType", request.getAttribute("type"));
											request.setAttribute("connTypeMap", DataCache.conn_ftp.get(request.getAttribute("type")));
										%>
										<c:forEach items="${connTypeMap}" var="list">
								           <option <c:if test='${linktype == list.type}'>selected="selected"</c:if>value="${list.type}">${list.name}</option>
								        </c:forEach>
									</select>
							    </div>
							  </div>
							  <div class="form-group" id="oracleMode" <c:if test='${linktype != "Oracle"}'>style="display:none;"</c:if>>
								  <label for="mode" class="col-sm-3 control-label"></label>
								  <div class="col-sm-5">
								  	<span id="dbchange">
										<input type="radio" id="mode1" name="mode" <c:if test='${connConf.mode == "sid" or empty dbStatus}'>checked="checked"</c:if>value="sid" />  SID方式
										<input type="radio" id="mode2" name="mode" <c:if test='${connConf.mode == "sn"}'>checked="checked"</c:if>value="sn" />  ServiceName方式
									</span>
								  </div>
							  </div>
				      		  <div class="form-group">
							    <label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>连接名称</label>
							    <div class="col-sm-5">
							      <input data-rule="required;name;length[1~45];remote[/user/connConf?method=exist&id=${id}&checkType=${checkType }]" class="form-control" id="name" name="name" <c:if test='${empty connConf.name}'>value="连接名称"</c:if>value="${connConf.name }" placeholder="连接名称">
							    </div>
							  </div>
							  <c:if test="${type eq 'database'}">
								  <div class="form-group">
									<label for="database" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>数据库</label>
									<div class="col-sm-5">
									  <input data-rule="required;" class="form-control" id="database" name="database" value="${connConf.database }" placeholder="ora11">
									</div>
								  </div>
							  </c:if>
							  <c:if test="${type eq 'ftp'}">
								  <div class="form-group">
									<label for="platform" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>平台设置</label>
									<div class="col-sm-5">
									    <select data-rule="required;" id="platform" name="platform" class="form-control ">
							           		<option <c:if test='${connConf.platform == "linux"}'>selected="selected"</c:if>value="linux">linux</option>
							           		<option <c:if test='${connConf.platform == "windows"}'>selected="selected"</c:if>value="windows">windows</option>
										</select>
									</div>
								  </div>
							  </c:if>
							  <div class="form-group">
							    <label for="host" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>主机名(Host)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;host;length[1~45]" class="form-control" id="host" name="host" <c:if test='${empty connConf.host}'>value="127.0.0.0"</c:if>value="${connConf.host }">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="port" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>端口号(Port)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;port;integer;" class="form-control" id="port" name="port" <c:if test='${empty connConf.port}'>value="21"</c:if>value="${connConf.port }">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="username" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>用户名(Username)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;length[1~25]" class="form-control" id="username" name="username" value="${connConf.username }" placeholder="用户名(Username)">
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="password" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>密码(Password)</label>
							    <div class="col-sm-5">
							      <input data-rule="required;length[3~32];" type="password" class="form-control" id="password2" name="password" value="${connConfMap.password }" placeholder="密码(Password)">
							    </div>
							    <div class="col-sm-3">
									<button class="btn btn-xs btn-primary" type="button" id="testLink">
										测试连接&nbsp;<span class="glyphicon glyphicon-signal"></span>
									</button>
							    </div>
							    <div id="testLinkStatus" class="col-sm-2">
							    </div>
							  </div>
						</c:when>
						<c:when test="${sourceType eq 'scp'}">
						
						</c:when>
						<c:when test="${sourceType eq 'flume'}">
						
						</c:when>
					</c:choose>
					<div class="form-group">
					    <label for="name" class="col-sm-3 control-label"></label>
					    <div class="col-sm-5">
					    	<a href="javascript:history.go(-1);">返回</a> 
				           	<button code="save" type="submit" class="btn btn-primary" id="ajaxSubmit">保存</button>
					    </div>
					</div>		
		    	</form>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<%-- <%@ include file="/resources/common_footer.jsp"%>	 --%>
</body>

<script>
$("#testLink").click(function(){
	
// 	console.log("testLink...");
	//createMark();
	var _type = $("#type").val();
	var _linkConf = {};
	_linkConf["host"] = $("#host").val();
	_linkConf["port"] = $("#port").val();
	_linkConf["username"] = $("#username").val();
	_linkConf["password"] = $("#password2").val();
	_linkConf["database"] = $("#database").val();
	var check = document.getElementById("mode1");
    if(check.checked == true){
        console.log("sid");
    	_linkConf["mode"] = "sid";
    }else{
    	console.log("sn");
    	_linkConf["mode"] = "sn";
    }
	var _url = '<%=request.getContextPath() %>/user/connConf?method=testLink';
	
	var _html = "<img src='<%=request.getContextPath() %>/resources/images/loading.gif'>";
	_html += "<span style='color:red;'>测试连接中.....</span>";
	$("#testLinkStatus").html(_html);
	
	$.ajax({
		url:_url,
		type:"post",
		data:{"linkConf":JSON.stringify(_linkConf),"type":_type},
		dataType:"text",
		async:true,
		success:function(data, textStatus){
// 			console.log(">>>data = "+data);
			common['$'].unblockUI();
			var _text = "";
			var dataArr = data.split("_");
			var r = dataArr[0];
			if(r == "0"){
				_text = "连接成功！";
				var _htmlOk="<span style='color:green;'>测试连接成功！</span>";
				$("#testLinkStatus").html(_htmlOk);
			}else if(r == "1"){
				
				_text = "连接失败！";
				var _htmlNg="<span style='color:red;'>连接失败！请确认</span>";
				$("#testLinkStatus").html(_htmlNg);
			}
			
		},
		error:function(err){
			console.log("加载数据出错！");
		}
	});
	return false;
	
});
//类型切换
$("#type").change(function(){
	var newSelect = $(this).val();
// 	console.log("port..."+newSelect);
	if(newSelect=="scp"){
		$("#port").attr("value","22");
		
	}else{
		$("#port").attr("value","21");
	}

	if(newSelect=="Oracle"){
		$("#oracleMode").attr("style","");
	}else{
		$("#oracleMode").attr("style","display:none;");
	}
});
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</html>
