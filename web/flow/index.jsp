<%@page import="com.stonesun.realTime.services.db.sys.UserServices"%>
<%@page import="com.stonesun.realTime.services.servlet.UserServlet"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowTemplateInfo"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
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
<title>配置</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	<%request.setAttribute("topId", "41");%>
	<input id="method" name="method" value="${pager.params.method}" type="hidden"/>
	<%@ include file="/resources/common_menu2.jsp"%>
	<c:choose>
		<c:when test="${pager.params.method eq 'index'}">
			<form action="<%=request.getContextPath() %>/flow?method=index" method="post" class="form-horizontal" role="form">
		</c:when>
		<c:otherwise>
			<form action="<%=request.getContextPath() %>/flow?method=templates" method="post" class="form-horizontal" role="form">
		</c:otherwise>
	</c:choose>
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					处理流程与流程依赖管理
				</div>
				<!-- 
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">配置</a> / 管理配置
				</div>
				 -->
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
		<%-- <%=request.getAttribute("plateform") %> --%>
		
			<%-- <c:if test="${empty plateform}">
					
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-3 col-md-3">
							<c:if test="${pager.params.method eq 'index'}">
								<div class="btn-group" role="group" aria-label="...">
								  <a code="save" type="button" class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/flow/init.jsp">创建流程</a>
								</div>
							</c:if>
						</div>
						<div class="col-xs-9 col-md-9">
							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="流程名称" name="name" value="${pager.params.name}" class="form-control" >
										<span class="input-group-btn">
											<c:choose>
												<c:when test="${pager.params.method eq 'index'}">
													<button class="btn" type="submit" href="<%=request.getContextPath() %>/flow?method=index">
														<span class="fui-search"></span>
													</button>
												</c:when>
												<c:otherwise>
													<button class="btn" type="submit" href="<%=request.getContextPath() %>/flow?method=templates">
														<span class="fui-search"></span>
													</button>
												</c:otherwise>
											</c:choose>
										</span>
									</div>
								</div>
							</div>
							<div class="page-header-op r" style="margin: 0 5px;width: 180px;">
								<select id="projectId" name="projectId" class="form-control">
									<%
										int id = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo)).getId();
										session.setAttribute(Container.session_projectList, ProjectServices.selectList(id));
										UserInfo userInfo=((UserInfo)request.getSession().getAttribute(Container.session_userInfo));
										int roleId=Integer.parseInt(userInfo.getRoleId());
										session.setAttribute("roleId", roleId);
									%>
									<option value="">--选择项目--</option>
									<c:forEach items="${sessionScope.session_projectList}" var="list">
							           <option <c:if test='${pager.params.projectId == list.id}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
							        </c:forEach>
								</select>
							</div>
<!-- 						    <div class="page-header-op r" style="margin: 0 5px;"> -->
<!-- 								<select id="runStatus" name="runStatus" class="form-control"> -->
<%-- 									<% --%>
<!-- // 										request.setAttribute("runStatus", DataCache.runStatus); -->
<%-- 									%> --%>
<%-- 									<c:forEach items="${runStatus}" var="item"> --%>
<%-- 							           <option <c:if test='${pager.params.runStatus == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option> --%>
<%-- 							        </c:forEach> --%>
<!-- 								</select> -->
<!-- 							</div> -->
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->
					<div class="table-result">
						<c:choose>
							<c:when test="${param.method eq 'templates' and pager.total==0}">
								当前找到 ${pager.total} 个模板对象，请先到已有流程内保存成模板，才能使用模板。
							</c:when>
							<c:when test="${param.method eq 'templates'}">
								当前找到 ${pager.total} 个流程模板。
							</c:when>
							<c:otherwise>
				    			当前找到 ${pager.total} 个流程对象。
				    		</c:otherwise>
						</c:choose>
					</div>
					<p>
					</p>
<!-- 				<div class="container mh500"> -->
					<table class="table table-hover table-striped  ">
						<thead>
							<tr>
								<c:if test="${sessionScope.roleId==1}">
									<th>ID</th>
								</c:if>
								<th></th>
								<th>名称</th>
								<c:if test="${sessionScope.roleId==1}">
									<th>用户</th>
								</c:if>
								<th style="width: 100px;">创建日期</th>
								<th>所属项目</th>
								<th style="width: 150px;">执行周期</th>
								<c:choose>
									<c:when test="${param.method eq 'index'}">
										<th>部署状态</th>
									</c:when>
								</c:choose>
<!-- 								<th style="width: 100px;" >执行状态</th> -->
								<th style="width: 130px;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stu" items="${pager.list}">
								<tr>
									<c:if test="${sessionScope.roleId==1}">
										<td>${stu.id}</td>
									</c:if>
									<td>
										<c:choose>
											<c:when test="${stu.type eq '1'}">
												<span title="流程"><img src="<%=request.getContextPath() %>/resources/site/img/flow.png"/></span>
											</c:when>
											<c:otherwise>
												<span title="流程依赖"><img src="<%=request.getContextPath() %>/resources/site/img/flow-depend.png"/></span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<a title="${stu.id}/${stu.name}" style="display: block;overflow: hidden;text-overflow: ellipsis;width: 150px;" href="<%=request.getContextPath() %>/flow/init.jsp?id=${stu.id}">${stu.name}</a>
									</td>
									<c:if test="${sessionScope.roleId==1}">
										<td>${stu.createAccount}</td>
									</c:if>
									<td>${stu.createTime}</td>
									<td><span title="${stu.projectName}" style="display: block;overflow: hidden;text-overflow: ellipsis;width: 100px;">${stu.projectName}</span></td>
									<td>
										<c:choose>
											<c:when test="${empty stu.periodType}">
												调度周期：手动
											</c:when>
											<c:when test="${stu.periodType eq 'second'}">
												调度周期：短周期
											</c:when>
											<c:when test="${stu.periodType eq 'rt'}">
												调度周期：实时
											</c:when>
											<c:when test="${stu.periodType eq 'dict'}">
												调度周期：排期表<br>
<%-- 												${stu.cron} --%>
											</c:when>
											<c:otherwise>
												调度周期：${stu.periodType}<br>(${stu.cron})
											</c:otherwise>
										</c:choose>
									</td>
									<c:choose>
										<c:when test="${param.method eq 'index'}">
											<td>
												<c:choose>
													<c:when test="${stu.status eq 'online' }">
														<span class="label label-success">已部署</span>
														<br>(${stu.nodeInfo})
													</c:when>
													<c:when test="${stu.status eq 'running' }">
														<span class="label label-success">已部署</span>
														<br>(${stu.nodeInfo})
													</c:when>
													<c:otherwise><span class="label label-default">未部署</span></c:otherwise>
												</c:choose>
											</td>
										</c:when>
									</c:choose>
<!-- 									<td> -->
<%-- 										<c:choose> --%>
<%-- 											<c:when test="${stu.status eq 'online'}"> --%>
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${stu.runStatus eq 'running' }"> --%>
<!-- 														<span class="label label-success">运行</span> -->
<%-- 													</c:when> --%>
<%-- 													<c:when test="${stu.runStatus eq 'stoped' }"> --%>
<!-- 														<span class="label label-danger">停止</span> -->
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<!-- 														<span class="label label-warning"></span> -->
<%-- 													</c:otherwise> --%>
<%-- 												</c:choose> --%>
<%-- 											</c:when> --%>
<%-- 											<c:when test="${stu.status eq 'running' }"> --%>
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${stu.runStatus eq 'running' }"> --%>
<!-- 														<span class="label label-success">运行</span> -->
<%-- 													</c:when> --%>
<%-- 													<c:when test="${stu.runStatus eq 'stoped' }"> --%>
<!-- 														<span class="label label-danger">停止</span> -->
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<!-- 														<span class="label label-warning"></span> -->
<%-- 													</c:otherwise> --%>
<%-- 												</c:choose> --%>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise><span class="label label-default"></span></c:otherwise> --%>
<%-- 										</c:choose> --%>
<!-- 									</td> -->
									<td style="width: 130px;">
										<c:if test="${not empty stu.config and 1==2}">
											<c:choose>
												<c:when test="${stu.status eq 'online' }">
													<a href="<%=request.getContextPath() %>/flow?method=sendFlow&id=${stu.id}&status=offline" class="darwin-mask">取消部署</a>
												</c:when>
												<c:otherwise>
													<a href="<%=request.getContextPath() %>/flow?method=sendFlow&id=${stu.id}&status=online" class="darwin-mask">部署</a>
												</c:otherwise>
											</c:choose>
											<a href="<%=request.getContextPath() %>/flow?method=run&id=${stu.id}" class="darwin-mask">执行</a>
										</c:if>
										
										<a code="select" href="<%=request.getContextPath() %>/flow/init.jsp?id=${stu.id}">编辑</a>
										<c:choose>
											<c:when test="${stu.status eq 'online' or stu.status eq 'running'}">
												<a class="disabled" code="delete" onclick="return confirmDel2()">删除</a>
											</c:when>
											<c:otherwise>
												<a class="disabled" code="delete" onclick="return confirmDel()" href="<%=request.getContextPath() %>/flow?method=deleteById&id=${stu.id}&fromPage=${param.method}">删除</a>
											</c:otherwise>
										</c:choose>
										<c:if test="${stu.isTemplate eq 'n'}">
											<br><a  href="<%=request.getContextPath() %>/flowStatus?method=history&flowId=${stu.id}">查看监控历史</a>
										</c:if>
										<c:if test="${stu.isTemplate eq 'n'}">
											<div class="dropdown" style="display: none;">
												<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">
											      请选择<span class="caret"></span>
											    </a>
											    <ul class="dropdown-menu dropdown-menu-right" role="menu">
											    	<li>
											      		<a href="<%=request.getContextPath() %>/flow/init.jsp?id=${stu.id}">查看/编辑</a>
											      		<a>复制到</a>
											      		<a>移动到</a>
											      		<a>创建流程依赖</a>
											      		<a>查看流程依赖引用</a>
											      		<a>部署</a>
											      		<a>取消部署</a>
											      		<a>立即执行</a>
											      	</li>
											    </ul>
											</div>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
<!-- 				</div> -->
				<!-- page content start -->
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
	//流程执行状态下拉框切换时间
	$("#runStatus").change(function(){
				var runStatus=$("#runStatus").val();
// 				console.info("--------"+runStatus);
				href = "flow?method=index&runStatus="+runStatus;
// 				console.info("----"+href);
				window.location.href=href;
				
	});
	//项目的下拉框选择切换事件
	$("#projectId").change(function(){
		if(true){
			var newSelect = $(this).val();
			var method = $("#method").val();
// 			console.log("method="+method);
			if(method == "index"){
				href = "flow?method=index&projectId="+newSelect;
			}else {
				href = "flow?method=templates&projectId="+newSelect;
			}
			
			window.location.href=href;
		}
	});
</script>
<script>
	function confirmDel(){
		if (confirm("你确定要删除吗？")) {  
			return true;
        }  return false;
	}
	function confirmDel2(){
		if (confirm("该流程已部署，请取消部署，再删除！")) {  
			return true;
        }  return false;
	}
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
