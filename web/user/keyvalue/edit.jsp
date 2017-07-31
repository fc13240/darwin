<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.*"%>
<%@page import="com.stonesun.realTime.services.db.*"%>
<%@page import="com.stonesun.realTime.services.db.bean.*"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" cfontent="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>字典表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "1");%>

	<form action="<%=request.getContextPath()%>/user/keyvalue?method=save"
						method="post" class="form-horizontal" role="form">
		<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
		<div class="page-header" >
			<div class="row">
				<div class="col-xs-6 col-md-6">
					<div class="page-header-desc">
						字典管理
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
							<div class="col-xs-6 col-md-6">
								<div class="page-header-desc">
									字典管理
								</div>
							</div>
							<div class="col-xs-6 col-md-6">
								<div class="page-header-op r">
								</div>
								<div class="clear"></div>
							</div>
						</div>
					</div>
					<!-- body -->
					
					<%
						String id = request.getParameter("id");
						//String dsId = request.getParameter("dsId");
						List<KeyValueItemInfo> keyvalueList = null;
						KeyValueMainInfo kvMainInfo = null;
						if(StringUtils.isNotBlank(id)){
							keyvalueList = KeyValueItemServices.selectList(Integer.valueOf(id));
							
							kvMainInfo = KeyValueMainServices.selectById(Integer.valueOf(id));
							
							//dsId = String.valueOf(kvMainInfo.getDsId());
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
						request.setAttribute("dsId", 100);
						request.setAttribute("id", id);
						
						//加载数据源字段列表
						//DatasourceInfo dsInfo = DatasourceServices.selectById(dsId);
						//JSONArray columns = JSON.parseObject(dsInfo.getRuleConf()).getJSONArray("columns");
						//request.setAttribute("columns", columns);
					%>
					
					
				
						<input type="hidden" value="${kvMainId}" name="kvMainId" />
						<input type="hidden" value="${dsId}" name="dsId" />
				
						<!-- page content start -->
						<div class="container mh500">
							<div class="row">
								<div class="col-md-12">
									<input type="button" value="添加一行" id="addRow" class="btn btn-success" /> 
									<input type="submit" value="保存" class="btn btn-primary" />
									<a href="javascript:history.go(-1);">返回</a> 
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label for="" class="col-sm-2 control-label">字典名称</label>
										<div class="col-sm-4">
											<input data-rule="required;field;length[1~45];dictionaryName;remote[/user/keyvalue?method=exist&id=${id}]" value="${kvMainInfo.field}" class="form-control" id="field" name="field" placeholder="字典名称">
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
				</div>
			</div>
		</div>
	</form>
	<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>	
	</c:if> --%>
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
	
<script type="text/javascript">
	$("#priority").change(function(){
		var priority=$("#priority").val();
		href = "/user/trigger?method=index&priority="+priority;
		window.location.href=href;
		
	});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>