<%@page import="com.stonesun.realTime.services.core.PagerModel"%>
<%@page import="com.stonesun.realTime.services.db.TaskRunHistoryServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.TaskHistoryInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
<title>任务执行历史列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_task);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<!-- page header start -->
	<div class="page-header">
		<div class="row">
			<div class="col-xs-3 col-md-3">
				<div class="page-header-desc">
					执行历史
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath()%>/task?method=index">任务管理</a> / 执行历史
				</div>
			</div>
			<div class="col-xs-9 col-md-9">
				<div class="page-header-op r">
				</div>
			</div>
		</div>
	</div>
	<!-- page header end -->
	<div class="container mh500">
		<div class="row">
			<div class="col-md-12">
			
			<%
			String id = request.getParameter("id");
			String offset = request.getParameter("pager.offset");
			if(StringUtils.isBlank(id)){
				throw new ServletException("历史id不能为空！");
			}
			int offsetInt = 0;
			if(StringUtils.isNotBlank(offset)){
				offsetInt = Integer.valueOf(offset);
			}
			
			PagerModel pm = new PagerModel();
			pm.setOffset(offsetInt);
			TaskHistoryInfo pp = new TaskHistoryInfo();
			pp.setTask_id(Integer.valueOf(id));

			pm = TaskRunHistoryServices.selectPagerList(pp, pm);
			pm.getParams().put("id", id);
			request.setAttribute("pager", pm);
			
			%>
			<form action="<%=request.getContextPath() %>/task/history.jsp?id=${pager.params.id}" method="post" class="form-horizontal" role="form">
				
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>运行周期</th>
							<th width="50">状态</th>
							<th width="100">开始时间</th>
							<th width="100">结束时间</th>
							<th width="200">输出路径和对应的文件字节范围</th>
							<th>部分-日志信息</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td>${stu.period}</td>
								<td>${stu.status}</td>
								<td>${stu.starttime}</td>
								<td>${stu.stoptime}</td>
								<td>${stu.outputPathPos}</td>
								<td>${stu.logInfo}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div>
					<%@ include file="/resources/pager.jsp"%>
				</div>
			</form>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$(function(){
	
	//弹出分析层
	function showLayer(jobId){
		//var ccc = $("#myTab li:eq(0)").clone();
		//$("#myTab li:eq(0)").append(ccc);
		
		$.layer({
	        type: 2,
	        title: [
	                '实时任务日志',
	                'border:none; background:#61BA7A; color:#fff;' 
	        ],
	        zIndex: 19891014,
	        //fix: true,
	        maxmin: true,
	        move: false,
	        shade: [0], //不显示遮罩
	        border: [0,1,'#61BA7A'], //不显示边框
	        area: [$("body").width()+'px', '300px'],
	        //page: {url: 'http://localhost/analytics/anaResult.jsp'},
	        iframe:{src:'result.jsp?q=123',scrolling: 'auto'},
			shift: 'bottom' //从上动画弹出
		});
		
		//$("#myTab li li").remove();
	}
	
	//showLayer("");
});
</script>

</body>
</html>