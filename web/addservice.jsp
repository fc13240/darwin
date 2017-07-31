<%@ page contentType="text/html; charset=UTF-8"%>
<div id="addservice" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
			<div style="text-align:center;padding:10px 0;">
				<h4>添加服务</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form" id="addserviceform" notBindDefaultEvent="true">
					<div class="form-group">
						<label for="serverID" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>主机</label>
						<div class="col-sm-5">
							<select id="serverID" name="serverID" class="form-control">
						 	</select>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>服务名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;length[1~45]" value="" class="form-control" id="name" name="name" placeholder="服务名称">
						</div>
					</div>
					<div class="form-group">
						<label for="port" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>管理端口</label>
						<div class="col-sm-5">
							<input data-rule="required;port;integer;range[1~65535]" value="" class="form-control" id="port" name="port" placeholder="管理端口,默认18012">
						</div>
					</div>
					<div class="form-group">
						<label for="type" class="col-sm-4 control-label">服务类型</label>
						<div class="col-sm-5">
							<select id="type" name="type" class="form-control">
				                <option value="node">节点服务</option>
				                <option value="elasticsearch">索引服务</option>
				              </select>
						</div>
					</div>
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
<script>
$(function() {
	$('#addservicecancel').click(function(){
		$('#addservice').modal('hide');
	});
	$('#addserviceform').validator({
		valid: function(form){
    		console.log("valid ok");
        	createMark();
			$.ajax({
				url:'/ajaxServer?method=saveService',
				data:$('#addserviceform').serialize(),
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					console.log(data);
					$.unblockUI();
					var status = data.status;
					if(status){
						getServiceInfo();
            $('#addservice').modal('hide');
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
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
