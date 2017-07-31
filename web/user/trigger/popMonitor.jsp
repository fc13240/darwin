<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/resources/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn" style="width:500px;" scrolling="no">
<head>
</head>
<body style="width:500px;" scrolling="no">
<div style="width:500px;margin:10px;" scrolling="no">
	<form scrolling="no" action="<%=request.getContextPath() %>/user/monitor?method=popIndex&m1_name=${param.m1_name}" method="post" class="" role="form">
		<input id="inputNameHidden" value="${param.m1_name}" type="hidden"/>
		<div class="container" style="width:500px;height:400px;overflow-y:visible;overflow-x:visible;" >
			<div class="row">
				<div class="col-xs-5 col-md-5">&nbsp;<br><span>系统共有${pager.total} 个监控项</span></div>
				<div class="col-xs-6 col-md-6">
					<div class="input-group">
						<input type="search" placeholder="监控名称" name="name" value="${pager.params.name}" class="form-control" >
						<span class="input-group-btn">
							<button class="btn" type="submit" href="<%=request.getContextPath() %>/user/monitor?method=popIndex&m1_name=${param.m1_name}">
								<span class="fui-search"></span>
							</button>
						</span>
					</div>
				</div>
			</div>
			<table style="width:420px;" class="table table-hover table-striped">
				<tr>
					<th style="font-size:13px;width:50px;">ID</th>
					<th style="font-size:13px;width:260px;">监控名称</th>
					<th style="font-size:13px;width:60px;">操作</th>
				</tr>
				<c:forEach var="stu" items="${pager.list}">
					<tr>
						<td style="font-size:13px;width:60px;">${stu.id}</td>
						<td style="font-size:13px;width:260px;">${stu.name}</td>
						<td style="font-size:13px;width:60px;">
							<input type="button" value="选择" onclick="returnMonitor('${stu.id}','${stu.name}');"/>
						</td>
					</tr>
				</c:forEach>
			</table>
			<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
			<div scrolling="no" style="overflow-y:visible;overflow-x:visible;" >
				<%@ include file="/resources/popPager.jsp"%>
			</div>
		</div>
	</form>
</div>
<SCRIPT type="text/javascript">
$(function(){
	console.log("jkjk");
	$("#layui-layer-iframe1").attr("scrolling","no");
});
function returnMonitor(id,name) {
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	var ss = $("#inputNameHidden").val();
	console.log("ss="+ss);
	var hdfsPath = "";
	parent.$('#id_'+ss).val(id);
	parent.$('#'+ss).val(name);
	parent.$('#'+ss).blur();
	if (typeof(parent.setPath) == 'function') {
		console.log("here...");
		parent.setPath(hdfsPath,ss);
	}
    parent.layer.close(index);
}

</SCRIPT>

</body>
</html>