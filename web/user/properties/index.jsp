<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.UserServices"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>系统设置</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
<%-- 	<%request.setAttribute("selectPage", Container.module_configure);%> --%>
<%-- 	<%request.setAttribute("topId", "1");%> --%>
	<%
		UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
		if(user1 != null){
			if(!"1".equals(user1.getRoleId())){
				response.sendRedirect("/resources/403.jsp");
				return;
			}
		}
		JSONArray array= new JSONArray();
		array = SystemProperties.getInstance().readProperties();
		request.setAttribute("array", array);
	%>
	
	<form action="<%=request.getContextPath() %>/user/group?method=index" method="post">
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					系统设置
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
				<!-- page header start -->
				<div class="page-header">
					<div class="row">
						<div class="col-xs-2 col-md-2">
							<div class="page-header-desc">
								系统设置
							</div>
						</div>
						<div class="col-xs-10 col-md-10">
							<div class="page-header-op r">
<!-- 								<a class="btn btn-primary btn-xs" onclick="showFile();">查看配置文件</a> -->
<%-- 								<a class="btn btn-primary btn-xs" href="<%=request.getContextPath() %>/manage/user?method=saveSystemFile">保存</a> --%>
<!-- 								<a class="btn btn-primary btn-xs" id="reloadFile" onclick="reloadFile();">重新加载</a> -->
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<c:forEach var="stu" items="${array}" varStatus="status">
					<div id="edit${stu.key}" >
						<a onclick="editFile('${stu.key}');"><span class="glyphicon glyphicon-pencil" ></span></a>${stu.key}=${stu.Property}<br>
					</div>
					<div id="save${stu.key}" style="display:none;">
						<a onclick="closeFile('${stu.key}');"><span class="glyphicon glyphicon-pencil" ></span></a>${stu.key}=<input id="input${stu.key}" value="${stu.Property}"> 
						<a class="btn btn-primary btn-xs" onclick="saveFile('${stu.key}');">保存</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</form>
	<%@ include file="/resources/common_footer.jsp"%>

<script type="text/javascript">
function editFile(_key){
// 	console.log("editFile..."+_key);
	$("#edit"+_key).attr("style","display:none;");
	$("#save"+_key).attr("style","");
}
function closeFile(_key){
// 	console.log("closeFile..."+_key);
	$("#edit"+_key).attr("style","");
	$("#save"+_key).attr("style","display:none;");
}

function saveFile(_key){
	
	var _url = '<%=request.getContextPath() %>/manage/user?method=saveSystemFile';
	$.ajax({
		url:_url,
		type:"post",
		dataType:"text",
		data:{key:_key,value:$("#input"+_key).val()},
		success:function(data, textStatus){
			console.log("data=================="+data);
			if(data == "0"){
				alert("修改成功,立即生效！");
				window.location.href=window.location.href;
			}else{
				alert("修改失败");
			}
		},
		error:function(err){
			alert("请求修改失败！");
		}
	});
}

function reloadFile(){
	
	var _url = '<%=request.getContextPath() %>/manage/user?method=reloadSystemFile';
	$.ajax({
		url:_url,
		type:"post",
		dataType:"text",
		success:function(data, textStatus){
			layer.tips("ok", '#reloadFile', {
				tips: [3, '#3595CC'],
				time: 3000
			});
		},
		error:function(err){
		}
	});
}
</script>
</body>
</html>