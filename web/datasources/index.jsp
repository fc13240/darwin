<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
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
<title>数据源列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<form action="<%=request.getContextPath() %>/datasources?method=index" method="post" class="form-horizontal" role="form">
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						数据源管理
					</div>
				</div>
				<div class="col-xs-6 col-md-6">
					<div class="page-header-op r">
						<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/datasources/add.jsp">新增数据源</a>
					</div>
					<div class="page-search r">
						<div class="form-group">
							<div class="input-group">
								<input type="search" placeholder="数据源名称、标签" name="keyword" value="${pager.params.keyword}" class="form-control" >
								<span class="input-group-btn">
									<button class="btn" type="submit">
										<span class="fui-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!-- page header end -->
		<!-- page content start -->
		<div class="container mh500">
			<div class="page-search-advance">
				<div class="page-search-advance-op">
					<a class="fui-triangle-up" id="seniorQueryId" onclick="toggleSeniorQuery()">
						高级筛选
					</a>
				</div>
				<div class="page-search-advance-body">
					<div class="form-group">
						<label for="source" class="col-sm-3 control-label">来源方式</label>
						<div class="col-sm-6">
							<select id="source" name="source" class="form-control ">
								<%
									request.setAttribute("sourceMap", DataCache.sourceMap);
								%>
								<option></option>
								<c:forEach items="${sourceMap}" var="list">
						           <option <c:if test='${pager.params.source == list.key}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="projectId" class="col-sm-3 control-label">所属项目</label>
						<div class="col-sm-6">
							<select id="projectId" name="projectId" class="form-control">
								<%
									//加载用户的项目列表
									session.setAttribute(Container.session_projectList, ProjectServices.selectList());
								%>
								<option></option>
								<c:forEach items="${sessionScope.session_projectList}" var="list">
						           <option <c:if test='${pager.params.projectId == list.id}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group" style="display: none;">
						<label for="status" class="col-sm-3 control-label">获取状态</label>
						<div class="col-sm-6">
							<select id="status" name="status" class="form-control">
								<%
									request.setAttribute("statusMap", DataCache.statusMap);
								%>
								<option></option>
								<c:forEach items="${statusMap}" var="list">
						           <option <c:if test='${pager.params.status == list.key}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-9">
							<div class="checkbox">
								<label class="checkbox-inline">
									<input name="addLuceneIndex" type="checkbox" <c:if test='${pager.params.addLuceneIndex eq "y"}'>checked="checked"</c:if>/>是否索引
								</label>
								<label class="checkbox-inline" style="display: none;">
									<input type="checkbox"/>是否中间数据
								</label>
								<label class="checkbox-inline">
									<input name="accelerate" type="checkbox" <c:if test='${pager.params.accelerate eq "y"}'>checked="checked"</c:if>/>是否加速查询
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-9">
							<input style="display: none;" id="seniorQuery" name="seniorQuery" value="${pager.params.seniorQuery}"/>
							<button class="btn btn-primary" type="submit" onclick="func()">查询</button>
						</div>
					</div>
				</div>
			</div>
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th>数据名称</th>
						<th>信息</th>
						<th>来源方式</th>
						<th>所属项目</th>
<!-- 						<th>状态</th> -->
						<th>操作</th>
					</tr>
				</thead>
				<c:forEach var="stu" items="${pager.list}">
					<tr>
						<td>${stu.id}</td>
						<td>${stu.name}<br>
						<c:choose>
								<c:when test="${stu.tableName eq ''}"></c:when>
								<c:otherwise>注册为表：${stu.tableName}</c:otherwise>
						</c:choose>
						</td>
						<td>
							标签：${stu.tags}<br>
							是否索引：
							<c:choose>
								<c:when test="${stu.addLuceneIndex eq 'y'}">是</c:when>
								<c:otherwise>否</c:otherwise>
							</c:choose><br>
							是否加速查询：<c:choose>
								<c:when test="${stu.accelerate eq 'y'}">是</c:when>
								<c:otherwise>否</c:otherwise>
							</c:choose><br>
							<!-- 是否中间数据：_<br> -->
						</td>
						<td>${stu.sourceText}</td>
						<td>${stu.projectName}</td>
<%-- 						<td>${stu.statusValue}</td> --%>
						<td>
							<a href="#" class="disable">分析</a>
							<a href="#" class="disable">图表</a>
							<!--a href="<%=request.getContextPath() %>/search/index.jsp?id=${stu.id}&keyword=select * from es_index where dsId=${stu.id} limit 10">检索</a -->
							<c:choose>
								<c:when test="${stu.tableName eq ''}"></c:when>
								<c:otherwise>
								<a href="<%=request.getContextPath() %>/search/dashboard.jsp?dsId=${stu.id}&from=ds&name=${stu.name}&index=es_index*/${stu.tableName}">检索</a>
								</c:otherwise>
							</c:choose>
							<br>
							<a href="datasources?method=edit&id=${stu.id}">编辑</a>
							<c:choose>
								<c:when test="${stu.taskId!=0}">
									<a href="task?method=edit&id=${stu.taskId}">任务</a>
								</c:when>
								<c:otherwise>
									<a href="#" class="disable">任务</a>
								</c:otherwise>
							</c:choose>
							<a href="#" class="disable">权限</a>
							<a href="<%=request.getContextPath() %>/keyvalue?method=index&dsId=${stu.id}">字典</a>
							<br>
							
							<a href="#" class="disable">数谱</a>
							<a href="#" class="disable">导出</a>
							<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/datasources?method=deleteById&id=${stu.id}">删除</a>
							<br>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div>
				<%@ include file="/resources/pager.jsp"%>
			</div>
		</div>
	</form>
	<!-- page content end -->
	<%@ include file="/resources/common_footer.jsp"%>		
	<!-- script start -->
	<script>
		function confirmDel(){
			if (confirm("你确定要删除吗？")) {  
				return true;
	        }  return false;
		}
		$(function(){
			var seniorQuery = $("#seniorQuery").val();
			//seniorQuery = 'y'
			if(seniorQuery=='y'){
				$("#seniorQueryId").removeClass('fui-triangle-up').addClass('fui-triangle-down');
				$('.page-search-advance-body').show();
			}
			
		});
		function toggleSeniorQuery(){
			if($("#seniorQueryId").hasClass('fui-triangle-up')){
				$("#seniorQueryId").removeClass('fui-triangle-up').addClass('fui-triangle-down');
				$('.page-search-advance-body').show();
				$("#seniorQuery").val('y');
			}else{
				$("#seniorQueryId").removeClass('fui-triangle-down').addClass('fui-triangle-up');
				$('.page-search-advance-body').hide();
				$("#seniorQuery").val('n');
			}
		}
		function func(){
			$("#seniorQuery").val('y');
		}
	</script>
	<!-- script end -->
</body>
</html>