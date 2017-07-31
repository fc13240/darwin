<%@ page contentType="text/html; charset=UTF-8"%>
<style>
.node-item{padding-right:15px;}
.node-item-status.failed{color:#e27500;}
.status-ok{color:#3bb6cb;}
.status-error{color:#e27500;}
.node-item, .node-item-status{min-width:120px;border:1px solid #ccc;border-radius: 8px;color:#aaa;display: block;float: left;margin:0 14px 10px 0;padding: 2px 2px 2px 4px;}
.node-item b{float:right;margin-top:4px;width:14px;background:url('/resources/site/css/img/p-close.png') no-repeat;height:14px;margin-left:8px;}
.node-item-status b{float:right;margin-top:4px;width:16px;height:16px;margin-left:8px;}
.node-item-status.success b{background:url('/resources/site/css/img/p-stop.png') no-repeat;}
.node-item-status.failed b{background:url('/resources/site/css/img/p-start.png') no-repeat;}
</style>
<!-- <div class="container" id="noServerAndNodeTips" style="margin-top:50px;"> -->
<div class="container" id="noServerAndNodeTips">
	<!--
	<div class="header" style="margin:20px 0;font-size:20px;text-align:center;">
		平台依赖环境检查
	</div>
	<table class="table">
		<tbody>
			<tr>
				<td>
				  HDFS
			    </td>
				<td>
			    </td>
				<td>
				  <a href="/user/properties/edit.jsp">点击修改HDFS配置</a>
			  </td>
			</tr>
			<tr>
				<td>
				  Spark
			  </td>
				<td>
				  检测失败
			  </td>
				<td>
				  <a href="/user/properties/edit.jsp">点击修改</a>
			  </td>
			</tr>
		</tbody>
	</table>
  -->
<!-- 	<div class="header" style="margin:20px 0;font-size:18px;"> -->
<!-- 		平台环境检查 -->
<!-- 	</div> -->
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
						<a code="save" data-toggle="modal" data-target="#addhost" class="btn btn-xs btn-primary">添加主机</a>
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
									<a code="save" id="addNodeList" class="service-add" data-type="node" title="添加"><span class="glyphicon glyphicon-plus"></span></a>
								</td>
							</tr>
							<tr>
								<td style="width: 20%;">
									索引服务
								</td>
								<td id="search-list">
								</td>
								<td>
									<a code="save" id="addEsList" class="service-add" data-type="elasticsearch" title="添加"><span class="glyphicon glyphicon-plus"></span></a>
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
						<a code="save" id="startall" class="btn  btn-xs btn-primary">全部启动</a>
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
									<a code="save" class="node-start">启动</a>
								</td>
							</tr>
							<tr>
								<td>
									索引服务
								</td>
								<td id="search-status">
								</td>
								<td>
									<a code="save" class="node-start">启动</a>
								</td>
							</tr>
						</tbody>
					</table>
			  	</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="addhost.jsp"></jsp:include>
<jsp:include page="addserviceToNode.jsp"></jsp:include>
<jsp:include page="addserviceToEs.jsp"></jsp:include>
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
							$('#serverList').append('<tr><td><a href="/server?method=edit&id='+v.id+'">'+v.name+'</a></td><td>'+v.status+'</td><td><a code="delete" data-id="'+v.id+'" class="del-host" title="删除"><span class="glyphicon glyphicon-trash"></span></a></td></tr>');
						}else{
							$('#serverList').append('<tr><td><a href="/server?method=edit&id='+v.id+'">'+v.name+'</a></td><td><span style="color:#e27500;">'+v.status+'</span></td><td><a code="delete" data-id="'+v.id+'" class="del-host" title="删除"><span class="glyphicon glyphicon-trash"></span></a></td></tr>');
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
					bindEventForHost();
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
			cache:false,
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
						var esCheck = services.esCheck; // 是否检查es状态，true则检查
						console.log("esCheck = "+esCheck); 
						if(esCheck=='true'){
							runstatus.es = false;
							status = false;
							$('#search-list').html('未部署');
							$('#search-status').html('未部署');
						}else{
							// false则不检查
							runstatus.es = true;
							$('#search-list').html('es不在web管辖范围内，不检查');
							$('#search-status').html('es不在web管辖范围内，不检查');
						}
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
				bindEventForService();
				checkAllStatus();
				ajustHeight();
			},
			error:function(){
				console.log("加载数据出错！");
			}
	});
};
function bindEventForHost() {
	$('.del-host').click(function(){
		if (!confirm('您确定要删除这个主机吗？如果删除，可能会导致服务异常')) {
			return false;
		}
		var hostid = $(this).data('id');

		createMark();
		$.ajax({
			url:'/ajaxServer?method=deleteServerById&id='+hostid,
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				console.log(data);
				$.unblockUI();
				var status = data.status;
				if(status){
					console.log("success");
					getHostInfo();
					getServiceInfo();
				}else{
					alert(data.cause);
				}
			},error:function(err){
				console.log("error")
				console.log(err);
				$.unblockUI();
				alert("删除失败！");
			}
		});
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
function bindEventForService() {
	$('.node-start').click(function(){
		var startnode = $(this);
		var nodelist = $(this).parent().prev().find('.node-item-status');
		if (nodelist && nodelist.length>0) {
			var nodeid = 0;
			$.each(nodelist, function(i, v){
				nodeid = $(v).data('id');
				startnode.html('启动中...');
				$.ajax({
					url:'/node?method=startNode&nodeId='+nodeid,
					type:"get",
					dataType:"json",
					async:true,
					success:function(data, textStatus){
						startnode.html('启动');
						if(data){
							if (data.status) {
								$(v).removeClass('failed').addClass('success');
								$(v).attr('title','');
							} else {
								$(v).removeClass('success').addClass('failed');
								$(v).attr('title',data.msg);
							}
						}
					},
					error:function(){
						console.log("加载数据出错！");
					}
				});
			});
		} else {
			console.log('没有可启动服务的资源池');
		}
	});
	$('.node-item b').click(function(){
		if (confirm('您确定要删除这个服务吗？删除后系统可能会运行异常！')) {
			var id = $(this).parent().data('id');
			var type = $(this).parent().data('type');
			createMark();
			var _url = "/node?method=deleteById&id="+id+"&ajaxReq="+true;
			$.ajax({
				url:_url,
				type:"get",
				dataType:"text",
				async:true,
				success:function(data, textStatus){
					console.log("data==="+data);
					if(data=="-1"){
						alert("删除服务失败！请先取消部署在此服务上的流程！");
					}else if(data=="-2"){
						alert("删除服务失败！该节点上部署有监控告警！");
					}else{
						getServiceInfo();
						var n=0;
						if(type=="node"){
							$("input[name='serverID']").each(function(){
								if($(this).val()==data){
									$(this).prop("checked",false);
									n=parseInt(n)+1;
								}
							});
						}else{
							$("input[name='esServerID']").each(function(){
								if($(this).val()==data){
									$(this).prop("checked",false);
									n=parseInt(n)+1;
								}
							});
						}
					}
					$.unblockUI();
				},
				error:function(err){
					console.log(err);
					$("#errDiv .err").html("请求失败！请联系管理员！");
					$.unblockUI();
				}
			});
		}
		return false;
	});
	$('.node-item-status b').click(function(){
		var obj = $(this);
		var id = $(this).parent().data('id');
		var opText = $(this).parent().hasClass('success')?'停止':'启动';
		if (!confirm('您确定要'+opText+'这个服务吗？')) {
			return false;
		}
		var url = '';
		if (opText=='启动') {
			url = '/node?method=startNode&nodeId='+id;
		} else {
			url = '/node?method=stopNode&nodeId='+id;
		}
		$.ajax({
			url:url,
			type:"get",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
				if(data){
					if (data.status) {
						$(obj).removeClass('failed').addClass('success');
						$(obj).attr('title','');
					} else {
						$(obj).removeClass('success').addClass('failed');
						$(obj).attr('title',data.msg);
					}
				}
				getServiceInfo();
			},
			error:function(){
				console.log("加载数据出错！");
			}
		});
	});
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
// 	$('.service-add').click(function(){
// 		var type = $(this).data('type');
// // 		console.log("type===="+type);
// 		if(type=="node"){
// 			$('#addservice').modal('show');
// 			$('#type').val(type);
// 			$('#addservice').find('input').empty();
// 		}else{
// 			getEsCheckList();
// 			$('#addEsservice').modal('show');
// 			$('#estype').val(type);
// 			$('#addEsservice').find('input').empty();
// 		}
		
// 	});
	
	$('#startall').click(function(){
		$('.node-start').click();
	});
});
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
