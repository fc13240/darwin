<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.ServerInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>服务列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%request.setAttribute("topId", "121");%>
	<% 
		String esList = NodeServices.selectListToJson(NodeInfo.node_type_elasticsearch);
		String esList01 = NodeServices.selectListToJson01(NodeInfo.node_type_elasticsearch);
		String esList02 = NodeServices.selectListToJson02(NodeInfo.node_type_elasticsearch);
		request.setAttribute("esList", esList);
		request.setAttribute("esList01", esList01);
		request.setAttribute("esList02", esList02);
	%>

	<form class="form-horizontal" role="form" id="addEsserviceform" notBindDefaultEvent="true">
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					节点与采集点管理
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
					<ol class="breadcrumb">
						<li><a href="<%=request.getContextPath() %>/node?method=index">服务管理列表</a></li>
						<li class="active">批量添加【索引服务】到主机</li>
					</ol>
				</div>
				<div>
				<input type="hidden" value="${esList}" name="esShow" id="esShow"/>
				<input type="hidden" value="${esList01}" name="esShow01" id="esShow01"/>
				<input type="hidden" value="${esList02}" name="esShow02" id="esShow02"/>
				<div>
					<table class="table table-bordered table-hover" id="ruleTable" >
						<tr class="success">
							<td width="30%">主机</td>
							<td width="34%">索引服务名称</td>
							<td width="20%">管理端口</td>
							<td width="16%">
								<input code="delete" type='button' class="btn  btn-xs btn-primary" value ='全选 'onclick='check_all01();'>
								<input code="delete" type='button' class="btn  btn-xs btn-primary" value ='取消 'onclick='cancel_all01();'>
								<input code="save" id="addservicesubmit" type="submit" value="保存" class="btn btn-xs btn-primary" />
							</td>
						</tr>
						<% 
							List<ServerInfo> list = ServerServices.selectList(NodeInfo.node_type_elasticsearch);
							request.setAttribute("list", list);
						%>
						<c:forEach var="stu" items="${list}">
							<tr>
								<td>${stu.name}[${stu.host}:${stu.communicatePort}]</td>
								<td><input data-rule="required;esname;length[1~45]" value="索引服务-${stu.name}" class="form-control" id="esname${stu.id}" name="esname${stu.id}" placeholder="索引服务名称"></td>
								<td><input data-rule="required;" value="19200" class="form-control" id="esport${stu.id}" name="esport${stu.id}" placeholder="管理端口,默认19200"></td>
								<td>
									<div class="checkbox" name="esServerID" style="text-align: center;">
									     <input onchange='changeval(${stu.id});' name="esServerID" id="esServerID${stu.id}" type="checkbox" value="${stu.id}" >
									</div>
									<div class="checkbox" name="esServerIDHidden" style="text-align: center;display:none;">
										 <input name="esServerIDHidden" id="esServerIDHidden${stu.id}" type="checkbox" value="${stu.id}" >
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<input value="elasticsearch" id="estype" name="estype" type="hidden">
				</div>
			</div>
		</div>
	</div>	
</form>
<c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
</c:if>
<script type="text/javascript">
function changeval(id){
   	var check = document.getElementById("esServerID"+id);
    if(check.checked == true){
    	$("input[name='esServerIDHidden']").each(function(){
			if($(this).val()==id){
				$(this).prop("checked",true);
			}
		});
    }else{
    	$("input[name='esServerIDHidden']").each(function(){
			if($(this).val()==id){
				$(this).prop("checked",false);
			}
		});
    }
    
}
$(function(){
	
	//查看是否有删除权限
	var deleteFlg = false;
	var privilegeBtns = $("#pagePrivilegeBtns").text();
	console.log("privilegeBtns  tonode ="+privilegeBtns);
	if($.trim(privilegeBtns)!=''){
		var btns = privilegeBtns.split(",");
		for(var b in btns){
			if(btns[b]=="delete"){
				deleteFlg = true;
				break;
			}
		}
	}else{
		deleteFlg = true;
	}
	console.log("deleteFlg   ="+deleteFlg);
	var groupIds = $("#esShow").val();
	var groupIds01 = $("#esShow01").val();
	var groupIds02 = $("#esShow02").val();
	var n=0;
	if(groupIds && groupIds!=''){
		var groupIdsArray = groupIds.split(",");
		var groupIdsArray01 = groupIds01.split(",");
		var groupIdsArray02 = groupIds02.split(",");
		for(var i=0;i<groupIdsArray.length;i++){
			var gid = groupIdsArray[i];
			var gname = groupIdsArray01[i];
			var gport = groupIdsArray02[i];
			$("input[name='esServerID']").each(function(){
				if($(this).val()==gid){
					$(this).prop("checked",true);
					if(!deleteFlg){
						$(this).prop("disabled","disabled");
					}
					$("#esname"+gid).val(gname);
					$("#esport"+gid).val(gport);
					n=parseInt(n)+1;
				}
			});
			$("input[name='esServerIDHidden']").each(function(){
				if($(this).val()==gid){
					$(this).prop("checked",true);
				}
			});
		}
	}
	$("#checkGroups").val(n);
});
</script>
<script>
$(function() {
	$('#addEsservicecancel').click(function(){
		$('#addEsservice').modal('hide');
	});
	$('#addEsserviceform').validator({
		valid: function(form){
    		console.log("Es valid ok");
        	createMark();
			$.ajax({
				url:'/ajaxServer?method=saveServiceToEs',
				data:$('#addEsserviceform').serialize(),
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					console.log(data);
					$.unblockUI();
					var status = data.status;
					if(status){
						if(data.cause!=""){
							alert(data.cause);
						}else{
							$('#addEsservice').modal('hide');
							window.location.href=window.location.href;
						}
					}else{
						alert(data.cause);
					}
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("保存失败！");
				}
			});
    	},
    	invalid:function(form){
			console.log("invalid");
			console.log(form);
    	}
	});
});

</script>
<script>
function check_all01(){
	arr = document.getElementsByName('esServerID');
	for(i=0;i<arr.length;i++){
		arr[i].checked = true;
	}
	arr1 = document.getElementsByName('esServerIDHidden');
	for(i=0;i<arr1.length;i++){
		arr1[i].checked = true;
	}
}
function cancel_all01(){
	arr = document.getElementsByName('esServerID');
	for(i=0;i<arr.length;i++){
		arr[i].checked = false;
	}
	arr1 = document.getElementsByName('esServerIDHidden');
	for(i=0;i<arr1.length;i++){
		arr1[i].checked = false;
	}
}
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>