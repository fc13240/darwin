<%@page import="com.stonesun.realTime.services.db.ServerServices"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.ServerInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="addEsservice" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content content">
   		<div class="modal-header header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">添加索引服务到主机</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="addEsserviceform" notBindDefaultEvent="true">
				<div id="esListDiv">
				</div>
				<input value="elasticsearch" id="estype" name="estype" type="hidden">
				<div class="form-group">
					<label for="addEsservicesubmit" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="addEsservicecancel">取消</a>
						<input code="save" id="addEsservicesubmit" type="submit" value="保存" class="btn btn-primary" />
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<script type="text/javascript">

$(function(){
	//添加es
	$('#addEsList').click(function(){
		$('#addEsservice').modal('show');
		$.ajax({
			url:"<%=request.getContextPath() %>/ajaxServer?method=esCheckList",
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log("data------------"+data);
				var _html="<table class='table table-bordered table-hover' id='ruleTable' >";
				_html += "<tr class='success'>";
				_html += "<td width='14%'>";
				_html += "<input code='save' type='button' class='btn  btn-xs btn-primary' value='全选 'onclick='check_all01();'>&nbsp;";
				_html += "<input code='save' type='button' class='btn  btn-xs btn-primary' value='取消 'onclick='cancel_all01();'>";
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
						_html += "<input name='esServerID' checked='checked' id='esServerID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}else{
					_html += "<input name='esServerID' id='esServerID"+item.id+"' type='checkbox' value='"+item.id+"' >";
					}
					_html += "</div>";
					_html += "</td>";
					_html += "<td>"+item.serverInfo+"</td>";
					_html += "<td><input data-rule='required;esname;length[1~45]' value='"+item.nodeName+"' class='form-control' id='esname"+item.id+"' name='esname"+item.id+"' placeholder='索引服务名称'></td>";
					_html += "<td><input data-rule='required;esport;integer;range[1~65535]' value='"+item.nodePort+"' class='form-control' id='esport"+item.id+"' name='esport"+item.id+"' placeholder='管理端口,默认9200'></td>";
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
						getServiceInfo();
						if(data.cause!=""){
							alert(data.cause);
						}else{
							$('#addEsservice').modal('hide');
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
}
function cancel_all01(){
	arr = document.getElementsByName('esServerID');
	for(i=0;i<arr.length;i++){
		arr[i].checked = false;
	}
}
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>