<%@ page contentType="text/html; charset=UTF-8"%>
<div id="addhost" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content content">
			<div class="modal-header header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				<h4 class="modal-title" id="myModalLabel">添加主机</h4>
 			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form" id="addhostform" notBindDefaultEvent="true">
					<div class="form-group">
						<label for="name" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>服务器名称</label>
						<div class="col-sm-5">
							<input data-rule="required;name;length[1~45];remote[/ajaxServer?method=existName&id=${id}]" value="" class="form-control" id="name" name="name" placeholder="服务器名称">
						</div>
					</div>
					<div class="form-group">
						<label for="host" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>主机地址</label>
						<div class="col-sm-5">
							<input data-rule="required;host;remote[/ajaxServer?method=existHost&id=${id}]" value="" class="form-control" id="host" name="host" placeholder="host">
						</div>
					</div>
					<div class="form-group">
						<label for="rootPwd" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>root密码</label>
						<div class="col-sm-5">
							<input data-rule="required;" type="password" value="" class="form-control" id="rootPwd" name="rootPwd" placeholder="root的密码">
						</div>
					</div>
					<div class="form-group">
						<label for="sshdPort" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>SSH端口</label>
						<div class="col-sm-5">
							<input data-rule="required;integer;range[1~65535]" value="" class="form-control" id="sshdPort" name="sshdPort" placeholder="ssh的端口,默认22">
						</div>
					</div>
					<div class="form-group">
						<label for="communicatePort" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>Agent端口</label>
						<div class="col-sm-5">
							<input data-rule="required;integer;range[1~65535]" value="" class="form-control" id="communicatePort" name="communicatePort" placeholder="Agent端口,默认18099">
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-sm-4 control-label"></label>
						<div class="col-sm-5">
							<a id="addhostcancel">取消</a>
							<input code="save" id="addhostsubmit" type="submit" value="保存" class="btn btn-primary" />
						</div>
					</div>
				</form>
		  </div>
    </div>
  </div>
</div>
<script>
$(function() {
	
	$('#addhostcancel').click(function(){	
		$('#addhost').modal('hide');
	});
	$('#addhostform').validator({

    	valid: function(form){
    		console.log("valid ok");
        	createMark();
			$.ajax({
				url:'/ajaxServer?method=saveServer',
				data:$('#addhostform').serialize(),
				type:"post",
				dataType:"json",
				success:function(data, textStatus){
					console.log(data);
					$.unblockUI();
					var status = data.status;
					if(status){
						getHostInfo();
						$('#addhost').modal('hide');
// 						window.location.href=window.location.href;
						$('#myTab a[href="#profile"]').tab('show');
					}else{
						console.log("valid NGNGNG");
// 						layer.open({
// 						    type: 1,
// 						    skin: 'layui-layer-rim', //加上边框
// 						    area: ['420px', '240px'], //宽高
// 						    content: 'html内容'
// 						});
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
    	}
	});

	function del(){
		createMark();
		var id = 1;
		$.ajax({
			url:'/ajaxServer?method=deleteById&id='+id,
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
				console.log(data);
				//window.location.reload();
				$.unblockUI();
				var status = data.status;

				if(status){
					
					alert("成功");
					
				}else{
					alert(data.cause);
				}
			},error:function(err){
				console.log(err);
				$.unblockUI();
			}
		});
	}
});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
