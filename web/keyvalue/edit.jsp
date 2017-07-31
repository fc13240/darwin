<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.KeyValueMainServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.KeyValueMainInfo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.stonesun.realTime.services.db.bean.KeyValueItemInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.KeyValueItemServices"%>
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
<title>编辑字典</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%
		request.setAttribute("selectPage", Container.module_keyvalue);
	%>
	<%@ include file="/resources/common_menu.jsp"%>

	<%
		String id = request.getParameter("id");
		String dsId = request.getParameter("dsId");
		List<KeyValueItemInfo> keyvalueList = null;
		KeyValueMainInfo kvMainInfo = null;
		if(StringUtils.isNotBlank(id)){
			keyvalueList = KeyValueItemServices.selectList(Integer.valueOf(id));
			
			kvMainInfo = KeyValueMainServices.selectById(Integer.valueOf(id));
			
			dsId = String.valueOf(kvMainInfo.getDsId());
		}
			
		if(keyvalueList==null || keyvalueList.size()==0){
			keyvalueList = new LinkedList<KeyValueItemInfo>();
			for(int i=0;i<2;i++){
				keyvalueList.add(new KeyValueItemInfo());
			}
		}
		if(kvMainInfo == null){
			kvMainInfo = new KeyValueMainInfo();
		}
		request.setAttribute("keyvalueList", keyvalueList);
		request.setAttribute("kvMainInfo", kvMainInfo);
		request.setAttribute("kvMainId", id);
		request.setAttribute("dsId", dsId);
		
		//加载数据源字段列表
		DatasourceInfo dsInfo = DatasourceServices.selectById(dsId);
		JSONArray columns = JSON.parseObject(dsInfo.getRuleConf()).getJSONArray("columns");
		request.setAttribute("columns", columns);
	%>
	
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					添加字典字段
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/keyvalue?method=index&dsId=${dsId}">字典列表</a> / 添加字典字段
				</div>
			</div>
		</div>
	</div>

	<form action="<%=request.getContextPath()%>/keyvalue?method=save"
		method="post" class="form-horizontal" role="form">

		<input type="hidden" value="${kvMainId}" name="kvMainId" />
		<input type="hidden" value="${dsId}" name="dsId" />

		<!-- page content start -->
		<div class="container mh500">
			<div class="row">
				<div class="col-md-12">
					<input type="button" value="添加一行" id="addRow"
						class="btn btn-success" /> <input type="submit" value="保存"
						class="btn btn-primary" />
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<label for="" class="col-sm-2 control-label">字段名称</label>
						<div class="col-sm-4">
<%-- 							<input data-rule="required;field;length[1~45]" value="${kvMainInfo.field}" class="form-control" id="field" name="field" placeholder="字段名称"> --%>
							
							<select data-rule="required;field" id="field" name="field" class="form-control ">
								<option></option>
								<c:forEach items="${columns}" var="item">
						           <option <c:if test='${kvMainInfo.field == item.name}'>selected="selected"</c:if>value="${item.name}">${item.name}</option>
						        </c:forEach>
							</select>
							
						</div>
					</div>
				</div>
			</div>

			<table id="keyvalueTable" class="table table-hover table-striped">
				<thead>
					<tr>
						<th style="display: none;">ID</th>
						<th>No</th>
						<th>key</th>
						<th>value</th>
						<th width="150px">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="stu" items="${keyvalueList}" varStatus="status">
						<tr>
							<td style="display: none;"><input value="${stu.id}"
								name="id"  class="form-control" /></td>
							<td>${status.index + 1}</td>
							<td><input value="${stu.key}" name="key"
								class="form-control" /></td>
							<td><input value="${stu.value}" name="value"
								class="form-control" /></td>
							<td><a onclick="$(this).parent().parent().remove();">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
	<%@ include file="/resources/common_footer.jsp"%>
	<script>
		function confirmDel() {
			if (confirm("你确定要删除吗？")) {
				return true;
			}
			return false;
		}
		$(function() {

			console.log("addRow..");
			var _firstTr = $("#keyvalueTable tr:eq(1)").clone();
			_firstTr.find("input[name='id']").val("0");
			_firstTr.find("input[name='key']").val("");
			_firstTr.find("input[name='value']").val("");
			console.log("addRow.." + _firstTr);
			$("#addRow").click(function() {
				console.log("addRow..");
				_firstTr.find("td:eq(1)").text($("#keyvalueTable tr").size());
				$("#keyvalueTable").append(_firstTr.clone());
			});

		});
	</script>
</body>
</html>