<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.ServerInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<style>
.node-item{padding-right:15px;}
.node-item-status.failed{color:#e27500;}
.status-ok{color:#3bb6cb;}
.status-error{color:#e27500;}
.node-item, .node-item-status{min-width:120px;border:1px solid #ccc;border-radius: 8px;color:#aaa;display: block;float: left;margin:0 14px 10px 0;padding: 2px 2px 2px 4px;}
.node-item b{float:right;margin-top:4px;width:14px;background:url('/resources/site/css/img/p-close-readonly.png') no-repeat;height:14px;margin-left:8px;}
.node-item-status b{float:right;margin-top:4px;width:16px;height:16px;margin-left:8px;}
.node-item-status.success b{background:url('/resources/site/css/img/p-stop-readonly.png') no-repeat;}
.node-item-status.failed b{background:url('/resources/site/css/img/p-start-readonly.png') no-repeat;}
</style>
<div class="container" id="noServerAndNodeTips">
	<div class="panel panel-default" id="systemTipWrapper">
	  	<div class="panel-heading text-center">完成以下步骤即可使用Darwin</div>
  	</div>
	<div class="row system-status-wrapper">
		<div class="col-xs-4 col-md-4">
			<div class="panel panel-default">
			  <div class="panel-heading">
			  	<div class="pull-left">
						添加主机----<span class="" id="serverStatus">检查通过</span>
					</div>
					<div class="pull-right">
						<a onclick='refreshHost();' class="btn btn-xs btn-primary"><span class="glyphicon glyphicon-refresh"></span></a>
					</div>
					<div class="pull-right">
						&nbsp;
					</div>
					<div class="pull-right">
						<a href="/server?method=index" class="btn btn-xs btn-primary">主机管理</a>
					</div>
					<div class="clear"></div>
			  </div>
			  <div class="panel-body">
				<dl>
					<dt>概况：</dt>
					<dd style="margin-left: 20px;">
						当前有<span id="serverCount_2">0</span>台主机被管理
					</dd>
					<dd style="margin-left: 20px;">
						<a code="save" data-toggle="modal" disabled="disabled" data-target="#addhost" class="btn btn-xs btn-default">添加主机</a>
					</dd>
				</dl>
				<dl id="serverStatusDetail" class="error">
					<dt>问题提示：</dt>
					<dd style="margin-left: 20px;" id="serverStatusDetailText">
					</dd>
				</dl>
				<table class="table table-hover">
						<thead>
							<tr>
								<th>
										名称
								</th>
								<th>
										状态
								</th>
								<th>
										操作
								</th>
							</tr>
						</thead>
						<tbody id="serverList">
						</tbody>
				</table>
			  </div>
			</div>
		</div>
		<div class="col-xs-4 col-md-4">
			<div class="panel panel-default">
			  <div class="panel-heading">
					<div class="pull-left">
						添加服务----<span class="" id="serviceStatus">检查通过</span>
					</div>
					<div class="pull-right">
						<a onclick='refreshService();' class="btn btn-xs btn-primary"><span class="glyphicon glyphicon-refresh"></span></a>
					</div>
					<div class="pull-right">
						&nbsp;
					</div>
					<div class="pull-right">
						<a href="/node?method=index" class="btn  btn-xs btn-primary">服务管理</a>
					</div>
					<div class="clear"></div>
				</div>
			  <div class="panel-body">
				<dl>
					<dt>概况：</dt>
					<dd style="margin-left: 20px;">
						必须对Darwin的以下服务进行部署
					</dd>
				</dl>
				<dl id="serviceStatusDetail" class="error">
					<dt>问题提示：</dt>
					<dd style="margin-left: 20px;">
						需要为任务调度服务，索引服务选择工作资源池
					</dd>
				</dl>
				<table class="table table-hover">
						<thead>
							<tr>
								<th style="width:120px;">
										服务
								</th>
								<th>
										所在主机
								</th>
								<th style="width:60px;">
										操作
								</th>
							</tr>
						</thead>
						<tbody id="serviceList">
							<tr>
								<td style="width: 20%;">
									资源池
								</td>
								<td id="node-list">
								</td>
								<td>
									<a style="color:#a0a0a0" code="save" id="addNodeList" class="service-add" data-type="node" title="添加"><span class="glyphicon glyphicon-plus"></span></a>
								</td>
							</tr>
							<tr>
								<td style="width: 20%;">
									索引服务
								</td>
								<td id="search-list">
								</td>
								<td>
									<a code="save" style="color:#a0a0a0" id="addEsList" class="service-add" data-type="elasticsearch" title="添加"><span class="glyphicon glyphicon-plus"></span></a>
								</td>
							</tr>
						</tbody>
				</table>
			  </div>
			</div>
		</div>
		<div class="col-xs-4 col-md-4">
			<div class="panel panel-default">
			  <div class="panel-heading">
					<div class="pull-left">
						启动服务----<span class="" id="runStatus">检查通过</span>
					</div>
					<div class="pull-right">
						<a onclick='refreshStartStop();' class="btn btn-xs btn-primary"><span class="glyphicon glyphicon-refresh"></span></a>
					</div>
					<div class="pull-right">
						&nbsp;
					</div>
					<div class="pull-right">
						<a code="save" disabled="disabled" id="startall" class="btn  btn-xs btn-default">全部启动</a>
					</div>
					<div class="clear"></div>
				</div>
			  <div class="panel-body">
			  <dl>
					<dt>概况：</dt>
					<dd style="margin-left: 20px;">
						必须启动资源池，系统才可以工作。
						<br>
						必须启动索引服务，系统索引和检索功能才能正常工作。
					</dd>
				</dl>
				<dl id="runStatusDetail" class="error">
					<dt>问题提示：</dt>
					<dd style="margin-left: 20px;">
						服务需正常启动，系统才可以正常工作。
					</dd>
				</dl>
				<table class="table">
						<thead>
							<tr>
								<th style="width: 20%;">
										服务
								</th>
								<th>
										所在主机
								</th>
								<th style="width: 20%;">
										操作
								</th>
							</tr>
						</thead>
						<tbody id="serviceStatusList">
							<tr>
								<td>
									资源池
								</td>
								<td id="node-status">
								</td>
								<td>
									启动
								</td>
							</tr>
							<tr>
								<td>
									索引服务
								</td>
								<td id="search-status">
								</td>
								<td>
									启动
								</td>
							</tr>
						</tbody>
					</table>
			  	</div>
			</div>
		</div>
	</div>
</div>
<div id="addservice" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>添加资源池到主机</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" notBindDefaultEvent="true">
				<input type="hidden" data-rule="required;resourcesCheck;" value="ok" class="form-control" name="resourcesCheck">
				<div id="nodeListDiv">
				</div>
				<div id="maxResources"></div>
				<input value="node" id="type" name="type" type="hidden" >
				<div class="form-group">
					<label for="addservicesubmit" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="addservicecancel">取消</a>
						<input type="button" disabled='disabled' value="保存" class="btn btn-default" />
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<%
	request.setAttribute("cpuResources", DataCache.cpuResources);
%>
<div id="cpuJson" style="display: none;">
	<c:forEach items="${cpuResources}" var="list">
       <option value="${list.key}">${list.value}</option>
    </c:forEach>
</div>
<div id="addEsservice" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>添加索引服务到主机</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" notBindDefaultEvent="true">
				<div id="esListDiv">
				</div>
				<input value="elasticsearch" id="estype" name="estype" type="hidden">
				<div class="form-group">
					<label for="addEsservicesubmit" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="addEsservicecancel">取消</a>
						<input type="button" disabled='disabled' value="保存" class="btn btn-default" />
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<script>
var okStatus='<span class="status-ok">检查通过<span class="glyphicon glyphicon-ok"></span></span>';
var errorStatus='<span class="status-error">检查失败<span class="glyphicon glyphicon-remove"></span></span>';
function refreshHost(){
	getHostInfo();
}
function refreshService(){
	getServiceInfo();
}
function refreshStartStop(){
	getHostInfo();
	getServiceInfo();
}

function getHostInfo() {

	$.ajax({
			url:'/ajaxServer?method=serverList',
			type:"get",
			dataType:"json",
			cache:false,
			async:true,
			success:function(data, textStatus){
				var hosts = data;
				if (hosts) {
					if (hosts.status==true) {
						$('#serverStatus').html(okStatus);
					} else {
						$('#serverStatus').html(errorStatus);
						$('#myTab a[href="#profile"]').tab('show');
					}
					$('#serverCount_2').html(hosts.total);
					$('#serverList').empty();
					$('#serverID').empty();
					$.each(hosts.hits, function(i,v){
						var hostLinkStatus = v.status;
						if(hostLinkStatus == "已连接"){
							$('#serverList').append('<tr><td><a href="/server?method=edit&id='+v.id+'">'+v.name+'</a></td><td>'+v.status+'</td><td><span class="glyphicon glyphicon-trash"></span></td></tr>');
						}else{
							$('#serverList').append('<tr><td><a href="/server?method=edit&id='+v.id+'">'+v.name+'</a></td><td><span style="color:#e27500;">'+v.status+'</span></td><td><span class="glyphicon glyphicon-trash"></span></td></tr>');
						}
						$('#serverID').append('<option value="'+v.id+'">'+v.name+'</option>');
					});
					if (hosts.total==0 ||  hosts.status!=true) {
						$('#serverStatusDetail').show();
						if(hosts.total==0){
							$('#serverStatusDetailText').text("至少需要一台被管理的主机。");
						}else{
							$('#serverStatusDetailText').text("已添加的主机状态为已连接，系统才可以正常工作。");
							}
						
					} else {
						$('#serverStatusDetail').hide();
					}
					if (hosts.hasMore) {
						$('#serverList').append('<tr><td colspan="3" style="text-align:left;"><a target="_blank" href="/server?method=index">查看更多...</a></td></tr>');
					}
				}
				checkAllStatus();
				ajustHeight();
			},
			error:function(){
				console.log("加载数据出错！");
			}
	});

};
function getServiceInfo() {
	$.ajax({
			url:'/ajaxServer?method=serviceList',
			type:"get",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
				var status = true;
				var runstatus = {node:true, es:true}
				var services = data;
				if (services) {
					$('#node-list').empty();
					$('#node-status').empty();
					if (services.node && services.node.length>0) {
						$.each(services.node, function(i,v){
							$('#node-list').append('<a class="node-item" data-type="node" data-id="'+v.id+'">'+v.name+'<b></b></a>');
							if (v.status=='started') {
								$('#node-status').append('<a class="node-item-status success" data-toggle="tooltip" data-id="'+v.id+'">'+v.name+'<b></b></a>');
							} else {
								runstatus.node = false;
								$('#node-status').append('<a class="node-item-status failed" data-toggle="tooltip" data-id="'+v.id+'">'+v.name+'<b></b></a>');
							}
						});
					} else {
						$('#node-list').html('未部署');
						$('#node-status').html('未部署');
						status = false;
						runstatus.node = false;
					}
					$('#search-list').empty();
					$('#search-status').empty();
					if (services.es && services.es.length>0) {
						$.each(services.es, function(i,v){
							$('#search-list').append('<a class="node-item" data-id="'+v.id+'" data-type="elasticsearch">'+v.name+'<b></b></a>');
							if (v.status=='started') {
								$('#search-status').append('<a class="node-item-status success" data-toggle="tooltip" data-id="'+v.id+'">'+v.name+'<b></b></a>');
							} else {
								runstatus.es = false;
								$('#search-status').append('<a class="node-item-status failed" data-toggle="tooltip" data-id="'+v.id+'">'+v.name+'<b></b></a>');
							}
						});
					} else {
						runstatus.es = false;
						status = false;
						$('#search-list').html('未部署');
						$('#search-status').html('未部署');
					}
					if (status) {
						$('#serviceStatus').html(okStatus);
						$('#serviceStatusDetail').hide();
					} else {
						$('#serviceStatus').html(errorStatus);
						$('#serviceStatusDetail').show();
						$('#myTab a[href="#profile"]').tab('show');
					}
					if (runstatus.node && runstatus.es) {
						$('#runStatus').html(okStatus);
						$('#runStatusDetail').hide();
					} else {
						$('#runStatus').html(errorStatus);
						$('#runStatusDetail').show();
						$('#myTab a[href="#profile"]').tab('show');
					}
				}
				checkAllStatus();
				ajustHeight();
			},
			error:function(){
				console.log("加载数据出错！");
			}
	});
};
function checkAllStatus() {
	if ($('.status-error').length>0) {
		$('#systemTipWrapper').show();
		return false;
	} else {
		$('#systemTipWrapper').hide();
		return true;
	}
};
function ajustHeight() {
	if(true){
		return;
	}
	var maxheight = 100;
	$.each($('.system-status-wrapper .panel'), function(i,v){
		if ($(v).height()>maxheight) {
			maxheight = $(v).height();
		}
	});
	$('.system-status-wrapper .panel').height(maxheight+20);
};
function getEsCheckList() {
	$.ajax({
			url:'/ajaxServer?method=esCheckList',
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				console.log("000----"+data);
			},
			error:function(err){
				console.log("加载数据出错！");
				console.log(err);
				console.log("234567890-=");
			}
	});

};
$(function() {
	getHostInfo();
	getServiceInfo();
});
</script>
<script type="text/javascript">
$('#addEsservicecancel').click(function(){
	$('#addEsservice').modal('hide');
});
$('#addservicecancel').click(function(){
	$('#addservice').modal('hide');
});
$(function(){
	//添加es
	$('#addEsList').click(function(){
		$('#addEsservice').modal('show');
		$.ajax({
			url:"<%=request.getContextPath() %>/ajaxServer?method=esCheckList",
			type:"post",
			cache:false,
			dataType:"json",
			success:function(data, textStatus){
				var _html="<table class='table table-bordered table-hover' id='ruleTable' >";
				_html += "<tr class='success'>";
				_html += "<td width='14%'>";
				_html += "<input type='button' class='btn  btn-xs btn-default' value='全选 ' disabled='disabled'>&nbsp;";
				_html += "<input type='button' class='btn  btn-xs btn-default' value='取消 ' disabled='disabled'>";
				_html += "</td>";
				_html += "<td width='30%'>主机</td>";
				_html += "<td width='36%'>索引服务名称</td>";
				_html += "<td width='20%'>管理端口</td>";
				_html += "</tr>";
				$.each(data,function(index,item){
					_html += "<tr>";
					_html += "<td>";
					_html += "<div class='checkbox' name='esServerID' style='text-align: center;'>";
					if(item.isCheck){
						_html += "<input disabled='disabled' name='esServerID' checked='checked' id='esServerID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}else{
					_html += "<input disabled='disabled' name='esServerID' id='esServerID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}
					_html += "</div>";
					_html += "</td>";
					_html += "<td>"+item.serverInfo+"</td>";
					_html += "<td><input data-rule='required;esname;length[1~45]' value='"+item.nodeName+"' class='form-control' id='esname"+item.id+"' name='esname"+item.id+"' placeholder='索引服务名称'></td>";
					_html += "<td><input data-rule='required;esport;integer;range[1~65535]' value='"+item.nodePort+"' class='form-control' id='esport"+item.id+"' name='esport"+item.id+"' placeholder='管理端口,默认19200'></td>";
					_html +="</tr>";
				});
				_html += "</table>";
				$("#esListDiv").html(_html);
			},
			error:function(err){
				console.log("加载数据失败！"+err);
			}
		});
	});
});

</script>
<script type="text/javascript">
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
				var cpuJson_select = $("#cpuJson").html();
				var _html="<table class='table table-bordered table-hover' id='ruleTable' >";
				_html += "<tr class='success'>";
				_html += "<td width='15%'>";
				_html += "<input type='button' class='btn  btn-xs btn-default' value='全选 ' disabled='disabled'>&nbsp;";
				_html += "<input type='button' class='btn  btn-xs btn-default' value='取消 ' disabled='disabled'>";
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
						_html += "<input disabled='disabled' name='serverID' checked='checked' id='serverID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}else{
					_html += "<input disabled='disabled' name='serverID' id='serverID"+item.id+"' type='checkbox' value='"+item.id+"' >";
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
function getMaxResources() {
	$.ajax({
		url:'/ajaxServer?method=getMaxResources',
		type:"get",
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
				var maxResources = "<div>警告：集群资源情况获取失败！请联系管理员查看集群状态。</div>";
			}
			

			$("#maxResources").html(maxResources);
		},error:function(err){
			console.log(err);
		}
	});

}
</script>