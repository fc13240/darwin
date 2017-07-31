<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>帮助-版本更新</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					版本更新
				</div>
			</div>
		</div>
	</div>
	<form action="<%=request.getContextPath() %>/version?method=index" method="post">
	<div class="container mh500">
		<div class="page-header">
			<ol class="breadcrumb">
				<li><span class='glyphicon glyphicon-download'></span>&nbsp;支持</li>
				<li><a>版本更新</a></li>
			</ol>
		</div>
		<div>当前找到 ${pager.total} 个更新历史</div><p></p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width:15%;">更新日期</th>
					<th style="width:15%;">版本</th>
					<th style="width:10%;">升级状态</th>
					<th style="width:60%;">更新内容</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="stu" items="${pager.list}">
					<tr>
						<td>${stu.updatetime}</td>
						<td id="dir${stu.id}">${stu.version}</td>
						<td>
							<c:if test="${stu.status eq 'upload'}">上传未升级</c:if>
							<c:if test="${stu.status eq 'upsuccess'}">升级成功</c:if>
						</td>
						<td id="days${stu.id}">${stu.remark}</td>
<!-- 						<td> -->
<!-- 							<a type="button" code="save" name="common_clearRule_buttonOne" onclick="return updateBtnFunc(this);">编辑</a> -->
<%-- 							<a code="delete" onclick="return confirmDel()" href="/clearRule?method=deleteById&id=${stu.id}">删除</a> --%>
<!-- 						</td> -->
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
		<div>
				<%@ include file="/resources/pager.jsp"%>
		</div>
	</div>
	</form>
<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>