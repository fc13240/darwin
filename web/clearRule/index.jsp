<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>数据清理规则</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%request.setAttribute("isAdmin", DatasourceServlet.getUid(request));%>
	<%request.setAttribute("topId", "36");%>
	
	
<form action="<%=request.getContextPath() %>/clearRule?method=index" method="post">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					数据清理规则
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
								数据清理规则管理
							</div>
						</div>
 						<div class="col-xs-6 col-md-6">
 							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="请输入搜索内容" name="name" value="${pager.params.name}" class="form-control" >
										<span class="input-group-btn">
											<button class="btn" type="submit" href="<%=request.getContextPath() %>/clearRule?method=index">
												<span class="fui-search"></span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="page-header-op r" style="margin: 0 5px;width: 180px;">
								<select id="searchType" name="searchType" class="form-control">
									<option value="">--请选择类型--</option>
									<option <c:if test='${pager.params.searchType == "hdfs"}'>selected="selected"</c:if>value="hdfs">HDFS数据</option>
									<option <c:if test='${pager.params.searchType == "es"}'>selected="selected"</c:if>value="es">索引数据</option>
								</select>
							</div>
							<div class="page-header-op r">
							</div>
							<div class="page-header-op r">
								&nbsp;&nbsp;
							</div>
							<div class="page-header-op r">
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->	
				<!-- page content start -->
				<div>数据清理规则列表，当前找到 ${pager.total} 个文件</div><p></p>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>资源类型</th>
							<th>资源名称</th>
							<th>清理规则</th>
<!-- 							<th>状态</th> -->
							<th>创建日期</th>
							<th style="width: 120px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td>${stu.id}</td>
								<td>
									<input type="hidden" id="type${stu.id}" value="${stu.type}">
									<c:choose>
										<c:when test="${stu.type eq 'hdfs'}">
											HDFS数据
										</c:when>
										<c:when test="${stu.type eq 'es'}">
											索引数据
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</td>
								<td id="dir${stu.id}">${stu.dir}</td>
								<td id="days${stu.id}">清理【${stu.days}】天前的数据
								</td>
<!-- 								<td> -->
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${stu.status eq 'y'}"> --%>
<!-- 											<span class="label label-success">已生效</span> -->
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<span class="label label-default">未生效</span> -->
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
<!-- 								</td> -->
								<td>${stu.createtime}</td>
								<td>
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${stu.status eq 'y'}"> --%>
<%-- 											<a code="save" href="/clearRule?method=cancel&id=${stu.id}&status=n">失效</a> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
											<a type="button" code="save" name="common_clearRule_buttonOne" onclick="return updateBtnFunc(this);">编辑</a>
<%-- 											<a code="save" href="/clearRule?method=cancel&id=${stu.id}&status=y">生效</a> --%>
											<a code="delete" onclick="return confirmDel()" href="/clearRule?method=deleteById&id=${stu.id}">删除</a>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
								</td>
							</tr>
							<input type="hidden" id="dayshidden${stu.id}" value="${stu.days}">
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

<div id="clearRuleModal" class="modal fade bs-example-modal-m" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-m">
    <div class="modal-content">
		<div class="modal-header">
			<h4>清理规则设置</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="clearRuleform" notBindDefaultEvent="true">
				<div class="form-group">
				    <label for="clearDir" class="col-sm-3 control-label">设置清理目录</label>
				    <div class="col-sm-8">
				   		<input type="text" class="form-control" readonly="readonly" id="clearDir" ng-model="clearDir" placeholder="清理目录">
					</div>
				</div>
				<div class="form-group">
				    <label for="days" class="col-sm-3 control-label">清理天数</label>
				    <div class="col-sm-5">
				    <input type="text" class="form-control" data-rule="required;integer[+];range[1~4000];" id="days" ng-model="days" placeholder="清理N天前数据">
					</div>
					<label class="help-block">*清理N天前的数据，请输入天数。</label>
				</div>
				<div class="form-group">
					<label for="saveClearRule" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="clearRuleCancel">取消</a>
						<input code="save" type="button" value="保存" class="btn btn-success"  onclick="saveClearRule()"/>
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<input name="clearId" type="hidden"/>
<input name="cleardays" type="hidden"/>
<%-- <c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script>
function confirmDel(){
	if (confirm("确定要删除此清理任务吗？")) {  
		return true;
    }  return false;
}

$(function(){
// 	$("a[code='cancel']").click(function(){
// 		var status = $(this).attr("status");
// 		if(status=='y'){
// 			status = 'n';
// 		}else{
// 			status = 'y';
// 		}
// 		$.ajax({
// 			method:"get",
// 			url:"/clearRule?method=cancel&id="+$(this).attr("value")+"&status="+status,
// 			type:"json",
// 			success:function(data){
// 				console.log(data);
// 				if(data.status=='y'){
// 					$(this).text("规则失效");
// 				}else{
// 					$(this).text("生效");
// 				}
// 			},error:function(err){
// 				console.log(err);

// 			}
// 		});

// 	});
	
	//下拉框选择切换事件
	$("#searchType").change(function(){
		if(true){
			var newSelect = $(this).val();
			href = "clearRule?method=index&searchType="+newSelect;
			
			window.location.href=href;
		}
	});

});

$('#clearRuleCancel').click(function(){
	$('#clearRuleModal').modal('hide');
});

function updateBtnFunc(thisObj){
// 	console.log("updateBtnFunc...");
// 	$(thisObj).attr("data-toggle","modal");
	var p = $(thisObj).parent().parent().find("td");
	var id = $(p.get(0)).text();
	var type = $('#type'+id).val();
	var dir = $('#dir'+id).text();
	var dayshidden = $('#dayshidden'+id).val();
	
	console.log("id="+id+",type="+type+",dir="+dir+",dayshidden="+dayshidden);
// 	console.log($('#clearDir').val());
	$("input[name='clearId']").val(id);
	if($("input[name='cleardays']").val()==''){
		$("input[name='cleardays']").val(dayshidden);
	}
	
	$('#clearDir').val(dir);
	$('#days').val(dayshidden);
	$('#clearRuleModal').modal('show');

}

function saveClearRule(){
// 	console.log("saveClearRule...");
	var id = $("input[name='clearId']").val();
	var days = $('#days').val();
	if(days<=0 || days=='' || days>3999 || days===undefined){
		$("#days").focus();
	}else{
		createMark();
	
		$.ajax({
			type:"get",
			url:"/clearRule?method=update",
			dataType:"text",
			data:{
				"id":id,
	// 			"type":$("input[name='clearType']").val(),
	// 			"dir":$('#clearDir').val(),
				"days":days
			},
			success:function(data){
				console.log(data);
				$.unblockUI();
				if(data==="0"){
					alert("编辑成功！");
					$('#days'+id).text("清理【"+days+"】天前的数据");
					$('#dayshidden'+id).val(days);
					$("input[name='cleardays']").val(days);
					$('#clearRuleModal').modal('hide');
				}else{
					alert("编辑失败！");
				}
			},error:function(err){
				alert("编辑失败！");
				$.unblockUI();
			}
		});
	}
}

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>