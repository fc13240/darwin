<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.core.PagerModel"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%

String offset = request.getParameter("offset");
int offsetValue = 0;
if(StringUtils.isNotBlank(offset)){
	offsetValue = Integer.valueOf(offset);
	if(offsetValue<=0){
		offsetValue = 0;
	}
}
PagerModel pm = new PagerModel();
pm.setOffset(offsetValue);
pm.setPageSize(100);

DatasourceInfo ds = new DatasourceInfo();
//ds.setNotInIds(notInIds);
pm = DatasourceServices.selectListNotUsered(ds,pm);
request.setAttribute("pager", pm);
%>
<table class="table table-bordered" id="dsTableList">
	<thead>
		<tr>
			<td>ID</td>
			<td width="300">数据名称</td>
			<td width="200">信息</td>
			<td width="100">来源方式</td>
			<td width="150">所属项目</td>
			<td width="100">状态</td>
			<td width="100px">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="stu" items="${pager.list}">
			<tr>
				<td>${stu.id}</td>
				<td>${stu.name}</td>
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
				<td>${stu.source}</td>
				<td>${stu.projectName}</td>
				<td>${stu.statusValue}</td>
				<td>
					<input type="radio" name="selectDsId" value="${stu.id}" dsName="${stu.name}"/>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div>
	<%@ include file="/resources/pager.jsp"%>
</div>