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

<title>图表列表</title>
<%@ include file="/resources/common.jsp"%>

<body>
	<%request.setAttribute("selectPage", Container.module_chart);%>
	<%@ include file="/resources/common_menu.jsp"%>

	<form action="<%=request.getContextPath() %>/chart?method=index2" method="post" class="form-horizontal" role="form">
		<!-- page header start -->
		<div class="page-header">
			<div class="row">
				<div class="col-xs-3 col-md-3">
					<div class="page-header-desc">
						图表
					</div>
				</div>
				<div class="col-xs-9 col-md-9">
					<div class="page-header-op r">
						<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/chart/edit.jsp">新增分析</a>
					</div>
					<div class="page-search r">
						<div class="form-group">
							<div class="input-group">
								<input type="search" id="name" name="name" value="${pager.params.name}" class="form-control" placeholder="任务名称"/>
								<span class="input-group-btn">
									<button class="btn" type="submit" href="chart?method=index2">
										<span class="fui-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="page-header-op r" style="margin: 0 0 5px;">
						<select id="status" name="status" class="form-control">
								<%
									request.setAttribute("taskStatus", DataCache.taskStatus);
								%>
								<option></option>
								<c:forEach items="${taskStatus}" var="item">
						           <option <c:if test='${pager.params.status == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
						</select>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!-- page header end -->
			
		<div class="container mh500">
			<table class="table table-hover table-striped">
				<tr class="success">
					<td>ID</td>
					<td>名称</td>
					<td>分析表名</td>
					<td>图表类型</td>
					<td width="100px">操作</td>
				</tr>
				<c:forEach var="stu" items="${pager.list}">
					<tr>
						<td>${stu.id}</td>
						<td>${stu.name}</td>
						<td>${stu.dsId}</td>
						<td>${stu.chartType}</td>
						<td>
							<a href="chart/edit.jsp?id=${stu.id}">编辑</a>
							<a onclick="return confirmDel()" href="<%=request.getContextPath() %>/chart?method=deleteById&id=${stu.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div>
				<%@ include file="/resources/pager.jsp"%>
			</div>
		</div>
	</form>
<script>
	function confirmDel(){
		if (confirm("你确定要删除吗？")) {  
			return true;
        }  return false;
	}
</script>

</body>
</html>