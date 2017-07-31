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
		String nodeList = NodeServices.selectListToJson(NodeInfo.node_type_node);
		String nodeList01 = NodeServices.selectListToJson01(NodeInfo.node_type_node);
		String nodeList02 = NodeServices.selectListToJson02(NodeInfo.node_type_node);
		request.setAttribute("nodeList", nodeList);
		request.setAttribute("nodeList01", nodeList01);
		request.setAttribute("nodeList02", nodeList02);
	%>
	
	<form class="form-horizontal" role="form" id="addserviceform" notBindDefaultEvent="true">
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
						<li class="active">批量添加【资源池服务】到主机</li>
					</ol>
				</div>
				<div>
					<input type="hidden" data-rule="required;resourcesCheck;" value="ok" class="form-control" name="resourcesCheck">
					<span class="msg-box n-left" style="position:static;" for="resourcesCheck"></span>

					<input type="hidden" value="${nodeList}" name="serverIDShow" id="serverIDShow"/>
					<input type="hidden" value="${nodeList01}" name="serverIDShow01" id="serverIDShow01"/>
					<input type="hidden" value="${nodeList02}" name="serverIDShow02" id="serverIDShow02"/>
					<div>
						<table class="table table-bordered table-hover" id="ruleTable" >
							<tr class="success">
								<td width="20%">主机</td>
								<td width="20%">资源池服务名称</td>
								<td width="10%">管理端口</td>
								<td width="15%">计算资源</td>
								<td width="15%">内存资源</td>
								<td width="20%">
									<input code="delete" type='button' class="btn  btn-xs btn-primary" value ='全选 'onclick='check_all();'>
									<input code="delete" type='button' class="btn  btn-xs btn-primary" value ='取消 'onclick='cancel_all();'>
									<input code="save" id="addservicesubmit" type="submit" value="保存" class="btn btn-xs btn-primary" />
								</td>
							</tr>
							<% 
								String hdfsRoot = (String)session.getAttribute(Container.session_defaultHdfsRoot);
								List<ServerInfo> list = ServerServices.getNodeList(NodeInfo.node_type_node,hdfsRoot);
								request.setAttribute("list", list);
							%>
							<c:forEach var="stu" items="${list}">
								<tr>
									<td>${stu.name}[${stu.host}:${stu.communicatePort}]</td>
									<td><input data-rule="required;name;length[1~45]" value="资源池${stu.name}" class="form-control" id="name${stu.id}" name="name${stu.id}" placeholder="服务名称"></td>
									<td><input data-rule="required;port;integer;range[1~65535]" value="18012" class="form-control" id="port${stu.id}" name="port${stu.id}" placeholder="管理端口,默认18012"></td>
									<td>
										<select data-rule="select" id="cpuResources${stu.id}" name="cpuResources${stu.id}" class="form-control">
											<%
												request.setAttribute("cpuResources", DataCache.cpuResources);
											%>
											<c:forEach items="${cpuResources}" var="list">
									           <option <c:if test='${stu.node.cpuResources == list.key}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
									        </c:forEach>
										</select>
									</td>
									<td>
										<div class="input-group">
											<input data-rule="memoryResources;integer;range[1~1048576];" value="${stu.node.memoryResources}" class="form-control" id="memoryResources${stu.id}" name="memoryResources${stu.id}" placeholder="内存资源，单位M">
										  	<span class="input-group-addon" id="basic-addon2">M</span>
										</div>
									</td>
									<td>
										<div class="checkbox" name="serverID" style="text-align: center;">
										     <input name="serverID" onchange='changeval(${stu.id});' id="serverID${stu.id}" type="checkbox" value="${stu.id}" >
										</div>
										<div class="checkbox" name="serverIDHidden" style="text-align: center;display:none;">
										     <input name="serverIDHidden" id="serverIDHidden${stu.id}" type="checkbox" value="${stu.id}" >
										</div>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div id="maxResources"></div>
					<input value="node" id="type" name="type" type="hidden" >
				</div>
			</div>
		</div>
	</div>	
</form>
<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script type="text/javascript">
function changeval(id){
   	var check = document.getElementById("serverID"+id);
    if(check.checked == true){
    	$("input[name='serverIDHidden']").each(function(){
			if($(this).val()==id){
				$(this).prop("checked",true);
			}
		});
    }else{
    	$("input[name='serverIDHidden']").each(function(){
			if($(this).val()==id){
				$(this).prop("checked",false);
			}
		});
    }
    
}
$(function(){
	getMaxResources();
	//查看是否有删除权限
	var deleteFlg = false;
	var privilegeBtns = $("#pagePrivilegeBtns").text();
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
	var groupIds = $("#serverIDShow").val();
	var groupIds01 = $("#serverIDShow01").val();
	var groupIds02 = $("#serverIDShow02").val();
	var n=0;
	if(groupIds && groupIds!=''){
		var groupIdsArray = groupIds.split(",");
		var groupIdsArray01 = groupIds01.split(",");
		var groupIdsArray02 = groupIds02.split(",");
		for(var i=0;i<groupIdsArray.length;i++){
			var gid = groupIdsArray[i];
			var gname = groupIdsArray01[i];
			var gport = groupIdsArray02[i];
			$("input[name='serverID']").each(function(){
				if($(this).val()==gid){
					$(this).prop("checked",true);
					if(!deleteFlg){
						$(this).prop("disabled","disabled");
					}
					$("#serverIDHidden"+gid).prop("checked",true);
					$("#name"+gid).val(gname);
					$("#port"+gid).val(gport);
					n=parseInt(n)+1;
				}
			});
			$("input[name='serverIDHidden']").each(function(){
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
	$('#addservicecancel').click(function(){
		$('#addservice').modal('hide');
	});
	$('#addserviceform').validator({
		rules:{
			resourcesCheck:function(element){
				var allMem = 0,allCpu = 0;
				$("#ruleTable tr:gt(0)").each(function(index,value){
					var cpu = $($(this).find("td").get(3)).find("select").val();
					var mem = $($(this).find("td").get(4)).find("input").val();
					console.log("index="+index+",mem=" + mem+",cpu="+cpu);

					if(!mem){
						allMem = 0;
						return false;
					}
					allCpu += parseInt(cpu);
					allMem += parseInt(mem);
				});

				console.log("allMem="+allMem+",allCpu="+allCpu);

				var ss = false;

				$.ajax({
					url:'/ajaxServer?method=getMaxResources',
					//data:$('#addserviceform').serialize(),
					type:"get",
					dataType:"json",
					async:false,
					success:function(data, textStatus){
						console.log(data);
						//$.unblockUI();
						var status = data.status;
						var allocatedMB = data.allocatedMB;
						var allocatedVCores = data.allocatedVCores;
						console.log(">>>"+parseInt(allMem) < parseInt(allocatedMB));

						ss = "";

						if(parseInt(allMem) > parseInt(allocatedMB)){
							ss += "超出最大内存资源！最大:"+allocatedMB+"M!";
						}

						if(allCpu > parseInt(allocatedVCores)){
							ss += "超出最大CPU资源！最大:"+allocatedVCores+"核!";
						}

						if($.trim(ss)==''){
							ss = true;
							return true;
						}
						return ss;
					},error:function(err){
						console.log(err);
						//$.unblockUI();
						alert("内存资源检查失败！");
					}
				});

				console.log("ss="+ss);
				return ss;
			}
		},
		fields:{
			"resourcesCheck":"resourcesCheck"
		},
		valid: function(form){
    		console.log("valid ok");
        	createMark();
			$.ajax({
				url:'/ajaxServer?method=saveServiceToNode',
				data:$('#addserviceform').serialize(),
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
							$('#addservice').modal('hide');
							window.location.href=window.location.href;
							alert("全部保存成功！");
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
function check_all(){
	arr = document.getElementsByName('serverID');
	for(i=0;i<arr.length;i++){
		arr[i].checked = true;
	}
	arr1 = document.getElementsByName('serverIDHidden');
	for(i=0;i<arr1.length;i++){
		arr1[i].checked = true;
	}
}
function cancel_all(){
	arr = document.getElementsByName('serverID');
	for(i=0;i<arr.length;i++){
		arr[i].checked = false;
	}
	arr1 = document.getElementsByName('serverIDHidden');
	for(i=0;i<arr1.length;i++){
		arr1[i].checked = false;
	}
}
function getMaxResources() {
	$.ajax({
		url:'/ajaxServer?method=getMaxResources',
		type:"get",
		dataType:"json",
		async:false,
		success:function(data, textStatus){
// 			console.log(data);
			var status = data.status;
			var allocatedMB = data.allocatedMB;
			var allocatedVCores = data.allocatedVCores;

			var maxResources = "<div>当前集群可用CPU资源为"+allocatedVCores+"核，可用内存资源为"+allocatedMB+"M</div>";

			$("#maxResources").html(maxResources);
		},error:function(err){
			console.log(err);
		}
	});

}
</script> 
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>