<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.ServerInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="addservice" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content content">
   		<div class="modal-header header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">添加资源池到主机</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="addserviceform" notBindDefaultEvent="true">
				<input type="hidden" data-rule="required;resourcesCheck;" value="ok" class="form-control" name="resourcesCheck">
<!-- 				<span class="msg-box n-left" style="position:static;" for="resourcesCheck"></span> -->
<!-- 				<br><br> -->
				<div id="nodeListDiv">
				</div>
<!-- 				<div id="maxResources">当前集群可用CPU资源为20核，可用内存资源为20G</div> -->
				<div id="maxResources"></div>
				<input value="node" id="type" name="type" type="hidden" >
				<div class="form-group">
					<label for="addservicesubmit" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="addservicecancel">取消</a>
						<input code="save" id="addservicesubmit" type="submit" value="保存" class="btn btn-primary" />
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<!-- <div id="cpuJson" style="display: none;"> -->
<!-- 	<select data-rule="select" id="cpuResources" name="cpuResources" class="form-control"> -->
		<%
			request.setAttribute("cpuResources", DataCache.cpuResources);
		%>
		<div id="cpuJson" style="display: none;">
			<c:forEach items="${cpuResources}" var="list">
	           <option value="${list.key}">${list.value}</option>
<%-- 	           <option <c:if test='${stu.node.cpuResources == list.key}'>selected="selected"</c:if>value="${list.key}">${list.value}</option> --%>
	        </c:forEach>
        </div>
<!-- 	</select> -->
<!-- </div> -->
<script type="text/javascript">
function changeval(id){
   	var check = document.getElementById("serverID"+id);
//    	console.log("check.checked = "+check.checked);
    if(check.checked == true){
         $("#name"+id).attr("data-rule","required;name;length[1~45]");
         $("#port"+id).attr("data-rule","required;port;integer;range[1~65535]");
         $("#memoryResources"+id).attr("data-rule","required;memoryResources;integer;range[1~1048576]");
    }else{
        $("#name"+id).attr("data-rule","");
        $("#port"+id).attr("data-rule","");
        $("#memoryResources"+id).attr("data-rule","");
    }
    
}

$(function(){
	//添加node
	$('#addNodeList').click(function(){
		getMaxResources();
		$('#addservice').modal('show');
		$.ajax({
			url:"<%=request.getContextPath() %>/ajaxServer?method=nodeCheckdeList",
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log("data------------"+data);
				var cpuJson_select = $("#cpuJson").html();
// 				$("#cpuJson").remove();
				var _html="<table class='table table-bordered table-hover' id='ruleTable' >";
				_html += "<tr class='success'>";
				_html += "<td width='15%'>";
				_html += "<input code='save' type='button' class='btn  btn-xs btn-primary' value='全选 'onclick='check_all();'>&nbsp;";
				_html += "<input code='save' type='button' class='btn  btn-xs btn-primary' value='取消 'onclick='cancel_all();'>";
				_html += "</td>";
				_html += "<td width='20%'>主机</td>";
				_html += "<td width='20%'>资源池名称</td>";
				_html += "<td width='13%'>管理端口</td>";
				_html += "<td width='15%'>计算资源</td>";
				_html += "<td width='17%'>内存资源</td>";
				_html += "</tr>";
				$.each(data,function(index,item){
					_html += "<tr>";
					_html += "<td>";
					_html += "<div class='checkbox' name='serverID' style='text-align: center;'>";
					if(item.isCheck){
						_html += "<input onchange='changeval(${stu.id});' name='serverID' checked='checked' id='serverID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}else{
					_html += "<input onchange='changeval(${stu.id});' name='serverID' id='serverID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}
					_html += "</div>";
					_html += "</td>";
					_html += "<td>"+item.serverInfo+"</td>";
					_html += "<td><input data-rule='required;name;length[1~45]' value='"+item.nodeName+"' class='form-control' id='name"+item.id+"' name='name"+item.id+"' placeholder='资源池名称'></td>";
					_html += "<td><input data-rule='required;port;integer;range[1~65535]' value='"+item.nodePort+"' class='form-control' id='port"+item.id+"' name='port"+item.id+"' placeholder='管理端口,默认18012'></td>";
					_html += "<td>";
					_html += "<select data-rule='select' id='cpuResources"+item.id+"' name='cpuResources"+item.id+"' class='form-control'>";
					_html += cpuJson_select;
					_html += "</select>";
					_html += "</td>";
					_html += "<td>";
					_html += "<div class='input-group'>";
					_html += "<input data-rule='memoryResources;integer;range[1~1048576]' value='"+item.memoryResources+"' class='form-control' id='memoryResources"+item.id+"' name='memoryResources"+item.id+"' placeholder='内存资源，单位M'>";
					_html += "<span class='input-group-addon' id='basic-addon2'>M</span>";
					_html += "</div>";
					_html += "</td>";
					_html +="</tr>";
				});
				_html += "</table>";
				$("#nodeListDiv").html(_html);

				$.each(data,function(index,item){
					if(item.cpuResources!=''){
						$("#cpuResources"+item.id).val(item.cpuResources);
					}
				});
			},
			error:function(err){
				console.log("加载数据失败！"+err);
			}
		});
	});
});

</script>
<script>
$(function() {
	$('#addservicecancel').click(function(){
		$('#addservice').modal('hide');
// 		window.location.href=window.location.href;
	});
	$('#addserviceform').validator({
		rules:{
			resourcesCheck:function(element){
				var allMem = 0,allCpu = 0;
				$("#ruleTable tr:gt(0)").each(function(index,value){
					var cpu = $($(this).find("td").get(4)).find("select").val();
					var mem = $($(this).find("td").get(5)).find("input").val();
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
						getServiceInfo();
						if(data.cause!=""){
							alert(data.cause);
						}else{
							$('#addservice').modal('hide');
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
}
function cancel_all(){
	arr = document.getElementsByName('serverID');
	for(i=0;i<arr.length;i++){
		arr[i].checked = false;
	}
}
function getMaxResources() {
	$.ajax({
		url:'/ajaxServer?method=getMaxResources',
		type:"get",
		timeout : 1000,
		dataType:"json",
		async:false,
		success:function(data, textStatus){
			console.log(data);
			var status = data.status;
			var allocatedMB = data.allocatedMB;
			var allocatedVCores = data.allocatedVCores;

			if(status){
				var maxResources = "<div>当前集群可用CPU资源为"+allocatedVCores+"核，可用内存资源为"+allocatedMB+"M</div>";
			}else{
				var maxResources = "<div><span style='color:red' class='glyphicon glyphicon-exclamation-sign'></span>警告：集群资源情况获取失败！请联系管理员查看集群状态。</div>";
			}
			

			$("#maxResources").html(maxResources);
		},error:function(err){
			var maxResources = "<div><span style='color:red' class='glyphicon glyphicon-exclamation-sign'></span>警告：集群资源情况获取失败！请联系管理员查看集群状态。</div>";
			$("#maxResources").html(maxResources);
			console.log(err);
		}
	});

}
</script> 
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
