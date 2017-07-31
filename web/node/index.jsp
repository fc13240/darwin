<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>服务列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "121");%>
	
	<form action="<%=request.getContextPath() %>/node?method=index" method="post" class="form-horizontal" role="form">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
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
		<%-- <c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-3 col-md-3">
							<div class="page-header-desc">
								<a type="button" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/node/addNode.jsp">资源池服务</a>
								<a type="button" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/node/addEs.jsp">索引服务</a>
							</div>
						</div>
						<div class="col-xs-9 col-md-9">
							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="名称" name="name" value="${pager.params.name}" class="form-control" >
										<span class="input-group-btn">
											<button class="btn" type="submit" href="node?method=index">
												<span class="fui-search"></span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="page-header-op r" style="margin: 0 5px;">
								<select id="nodetype" name="nodetype" class="form-control">
									<%
										session.setAttribute("nodeTypes",DataCache.nodeTypeList);
									%>
									<option value="">--请选择类型--</option>
									<c:forEach items="${nodeTypes}" var="item">
							           <option <c:if test='${pager.params.type == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
							        </c:forEach>
								</select>
							</div>
							<div class="page-header-op r" style="margin: 0 5px;">
								
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<div class="table-result">
					当前找到 ${pager.total} 个对象
				</div>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th style="display: none;">ID</th>
							<th>主机名</th>
							<th>服务名称</th>
							<th>类型</th>
							<th>IP端口</th>
							<th>创建日期</th>
							<th>流程数</th>
							<th>监控告警数</th>
							<th>连接状态</th>
							<th>启停状态</th>
							<th width="80px">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td style="display: none;">${stu.id}</td>
								<td>${stu.serverName}</td>
								<td><span title="${stu.name}" style="display: block;overflow: hidden;text-overflow: ellipsis;width: 120px;">${stu.name}</span></td>
								<td>
									<%
										session.setAttribute("nodeTypes",DataCache.nodeTypeList);
									%>
									<c:forEach items="${nodeTypes}" var="item">
							           <c:if test="${stu.type eq item.key}">${item.value}</c:if>
							        </c:forEach>
								</td>
								<td>${stu.ip}:${stu.port}</td>
								<td>${stu.createtime}</td>
								<td class="text-center">${stu.flowNum}</td>
								<td class="text-center">${stu.triggerNum}</td>
								<td>${stu.status}</td>
								<td>
									<c:choose>
										<c:when test="${empty stu.startStopStatus  or stu.startStopStatus eq 'stoped'}">
											已停止
										</c:when>
										<c:otherwise>
											已启动
										</c:otherwise>
									</c:choose>
								</td>
								
								<td>
									<c:choose>
										<c:when test="${empty stu.startStopStatus  or stu.startStopStatus eq 'stoped'}">
											<a code="save" href="#" onclick="return startStopFunc('startNode',${stu.id})">启动</a>
										</c:when>
										<c:otherwise>
											<a code="save" href="#" onclick="return startStopFunc('stopNode',${stu.id})">停止</a>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${empty stu.startStopStatus  or stu.startStopStatus eq 'stoped'}">
											<a code="delete" onclick="return confirmDel(this,${stu.id})" href="#">删除</a>
										</c:when>
										<c:otherwise>
											<a code="delete" onclick="return confirmDel(this,${stu.id})" href="#">删除</a>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
				<div>
					<%@ include file="/resources/pager.jsp"%>
				</div>
			</div>
		</div>
	</div>	
</form>
<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script>
	var d2 = false;
	function confirmDel(thisObj,id){
		if (confirm("确定要删除选中的服务么？")) {
			checkDel(thisObj,id);
			return true;
		}
		return false;
	}
	
	function checkDel(thisObj,id){
		createMark();
		var _url = "<%=request.getContextPath() %>/node";
		$.ajax({
			url:_url,
			data:{
				"method":"checkNodeStartStopStatus",
				"id":id
			},
			type:"post",
			dataType:"text",
			async:true,
			success:function(data, textStatus){
				console.log("checkNodeStartStopStatus=="+data);
				$.unblockUI();
				if(data=='started'){
					alert("请先停止服务再进行删除操作！");
					return;
				}

				del(thisObj,id);
			}
			,error:function(err){
				console.log(err);
				$("#errDiv .err").html("请求失败！请联系管理员！");
				$.unblockUI();
			}
		});
	}

	function del(thisObj,id){
		createMark();
		var _url = "<%=request.getContextPath() %>/node";
		$.ajax({
			url:_url,
			data:{
				"method":"deleteById",
				"id":id,
				"ajaxReq":true,
			},
			type:"post",
			dataType:"text",
			async:true,
			success:function(data, textStatus){
				console.log("deleteById+"+data);
				if(data=="-1"){
					alert("删除服务失败！请先取消部署在此服务上的流程！");
				}else if(data=="-2"){
					alert("删除服务失败！该节点上部署有监控告警！");
				}else{
					if(data!=''){
						location.reload();
						return;
					}
				}
				$.unblockUI();
			}
			,error:function(err){
				console.log(err);
				$.unblockUI();
				alert("删除失败！"+err.responseText);
			}
		});
	}

	//项目的下拉框选择切换事件
	$("#nodetype").change(function() {
		if (true) {
			var newSelect = $(this).val();
			if(newSelect==""){
				href = "node?method=index";
// 					console.log(href);
			}else{
				href = "node?method=index&type=" + newSelect;
			}
			window.location.href = href;
		}
	});

	$(function(){


	});

	function startStopFunc(flg,nodeId){
		createMark();
		var _url = "<%=request.getContextPath() %>/node";
		$.ajax({
			url:_url,
			data:{
				"method":flg,
				"nodeId":nodeId
			},
			type:"get",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
				console.log(data);
				var status = data.status;
				if(status){
					location.reload();
					return;
				}

				var statusCode = data.statusCode;
				if(statusCode=='node_running_success'){
					location.reload();
				}else if(statusCode=='node_send_fail'){
					alert("发送请求失败！");
				}else if(statusCode=='node_closed'){
					alert("与服务器失联！");
				}else if(statusCode=='node_resp_timeout'){
					alert("服务器响应超时！");
				}else if(statusCode=='node_running_faild'){
					// alert("服务器响应失败消息！");
					alert(data.msg);
				}else if(statusCode=='unknown_exception'){
					alert("操作失败！未知异常！");
				}

				$.unblockUI();
			}
			,error:function(err){
				console.log(err);

				//$("#errDiv .err").html("请求失败！请联系管理员！");
				$.unblockUI();
				alert("请求失败！请联系管理员！");
			}
		});

	}
	</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>