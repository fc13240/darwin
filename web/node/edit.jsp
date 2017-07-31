<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>服务编辑</title>
<%@ include file="/resources/common.jsp"%>
<script src="<%=request.getContextPath() %>/resources/js/CronClass.js"></script>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_task);%>
	<%request.setAttribute("topId", "121");%>
	<%
// 		UserInfo user1 = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
// 		if(user1 != null){
// 			if(!"1".equals(user1.getRoleId())){
// 				response.sendRedirect("/resources/403.jsp");
// 				return;
// 			}
// 		}
	%>
	
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					节点与采集点管理
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
	<%-- 	<c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<%
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						NodeInfo node = NodeServices.selectById(Integer.valueOf(id));
						
						request.setAttribute("node", node);
					}
					request.setAttribute("id",id);
				%>
				<form action="<%=request.getContextPath()%>/node?method=save" class="form-horizontal" role="form" method="post">
					<div class="page-header">
						<ol class="breadcrumb">
							<li><a href="<%=request.getContextPath() %>/node?method=index">服务管理列表</a></li>
							<li class="active">服务新增编辑</li>
						</ol>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<a href="javascript:history.go(-1);">返回</a> 
							<c:choose>
								<c:when test="${task.onLine eq 'on'}">
									<input code="save" type="submit" value="保存" class="btn btn-primary disabled"/>
								</c:when>
								<c:otherwise>
									<input code="save" type="submit" value="保存" class="btn btn-primary" />
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<input type="hidden" value="${id }" name="id"/>
					<div class="form-group">
						<label for="serverID" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>主机</label>
						<div class="col-sm-5">
							<select id="serverID" name="serverID" class="form-control" disabled='disabled'>
								<%
									session.setAttribute("serverList",ServerServices.selectList());
								%>
								<c:forEach items="${serverList}" var="item">
						           <option <c:if test='${node.serverID == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
						        </c:forEach>
						 	</select>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>服务名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;length[1~45];remote[/node?method=exist&id=${id}]" value="${node.name}" class="form-control" id="name" name="name" placeholder="服务名称">
						</div>
					</div>
					<div class="form-group" style="display: none;">
						<label for="ip" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>服务host</label>
						<div class="col-sm-5">
							<input data-rule="required;ip;length[1~45];" <c:if test='${node.ip == item.value}'>value="192.168.0.1"</c:if>value="${node.ip}" class="form-control" id="ip" name="ip" placeholder="服务host">
						</div>
					</div>
					<div class="form-group">
						<label for="port" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>管理端口</label>
						<div class="col-sm-5">
							<input data-rule="required;port;integer;range[1-65535]" <c:if test='${node.ip == item.value}'>value="18012"</c:if>value="${node.port}" class="form-control" id="port" name="port" placeholder="服务端口,默认18012">
						</div>
					</div>
					<div class="form-group">
						<label for="type" class="col-sm-2 control-label">类型</label>
						<div class="col-sm-5">
							<select id="type" name="type" class="form-control" disabled='disabled'>
								<%
									session.setAttribute("nodeTypes",DataCache.nodeTypeList);
								%>
						    	<option value="${node.type}">${node.type}</option>
						 	</select>
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label for="key" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>通信秘钥</label> -->
<!-- 						<div class="col-sm-5"> -->
<%-- 							<input data-rule="required;key;length[1~45];" value="${node.key}" class="form-control" id="key" name="key" type="password" placeholder="通信秘钥"> --%>
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="form-group"> -->
<!-- 						<label for="rootPwd" class="col-sm-2 control-label">root密码</label> -->
<!-- 						<div class="col-sm-5"> -->
<%-- 							<input data-rule="required;password;length[5~16]"  value="${node.rootPwd}" class="form-control" id="rootPwd" type="password" name="rootPwd" placeholder="rootPwd"> --%>
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label for="sshPort" class="col-sm-2 control-label">ssh端口</label> -->
<!-- 						<div class="col-sm-5"> -->
<%-- 							<input data-rule="length[1~45];integer[*];" value="${node.sshPort}" class="form-control" id="sshPort" name="sshPort" placeholder=""> --%>
<!-- 						</div> -->
<!-- 					</div> -->
				</form>
			</div>
		</div>

	</div>
<%-- 	<c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script type="text/javascript">
$(function(){
	
	$("#clearPid").click(function(){
		var $options = $('#pid option');//获取当前选中的项
		$options.each(function(){
			$(this).attr("selected",null);//删除下拉列表中选中的项
		});
		//var $remove = $options.attr("selected","");//删除下拉列表中选中的项
		return false;
	});
	
	$("#showModelBtn").click(function(){
		var _type = $("#type").val();
		if(_type=="dataSource"){
			$(this).attr("data-target","#dsModal");
		}else if(_type=="analysis"){
			$(this).attr("data-target","#anaModal");
		}else{
			alert("请选择节点类型！");
			return false;
		}
	});
	
	$("#dsModalOk").click(function(){
		var _dsId = $("#dsTableList input:radio:checked").val();
		var _dsName = $("#dsTableList input:radio:checked").attr("dsName");
		if(!_dsId){
			alert("请选择数据源！");
			return;
		}
		
		$("#selectDsId").val(_dsId);
		$("#selectDsText").html("【数据源】"+_dsName + "<a target='_blank' href='<%=request.getContextPath() %>/datasources/conn.jsp?method=edit&id="+_dsId+"'>查看</a>");
		
		$("#dsModal").modal('hide');
	});
	
	$("#anaModalOk").click(function(){
		var _radio = $("#selectDsId").val();
// 		console.log(_radio);
		if(!_radio){
			alert("请选择分析！");
			return;
		}
		$("#anaModal").modal('hide');
	});
	
	//var cron = new CronClass();
	//cron.init();
});
</script>


<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>