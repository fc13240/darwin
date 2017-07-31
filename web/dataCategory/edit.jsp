<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="editOrg" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-m">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>编辑子分类</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="editOrgform" notBindDefaultEvent="true">
				<div class="form-group">
					<label for="editName" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>子分类名称</label>
					<div class="col-sm-5">
						<input data-rule="required;checkname;length[1~45];" value="" class="form-control" id="editName" name="editName" placeholder="子分类名称">
					</div>
				</div>
				<input value="" id="editId" name="editId" type="hidden">
				<input value="" id="editPid" name="editPid" type="hidden">
				<div class="form-group">
					<label for="editOrgsubmit" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="editOrgcancel">取消</a>
						<input code="save" id="editOrgsubmit" type="submit" value="保存" class="btn btn-primary" />
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<script>
$(function() {
	$('#editOrgcancel').click(function(){
		$('#editOrg').modal('hide');
	});
	$('#editOrgform').validator({
		valid: function(form){
    		console.log("Es valid ok");
    		var editId = $('#editId').val();
    		var editPid = $('#editPid').val();
    		var editName = $('#editName').val();
    		$.ajax({
				url:'/dataCategory?method=exist01&id='+editId+'&pid='+editPid+'&editName='+editName,
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					console.log(data);
					if(data =='ok'){
						createMark();
						$.ajax({
							url:'/dataCategory?method=editChild&id='+editId,
							data:$('#editOrgform').serialize(),
							type:"post",
							dataType:"text",
							success:function(data, textStatus){
//			 					console.log(data);
								$('#editOrg').modal('hide');
								window.location.href=window.location.href;
								$.unblockUI();
//			 					alert("添加成功！");
							},error:function(err){
								console.log(err);
								$.unblockUI();
								alert("编辑失败！");
							}
						});
					}else{
						alert("分类名称已存在！请重新输入。");
					}
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("编辑失败！");
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