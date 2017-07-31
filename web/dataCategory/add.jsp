<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="addOrg" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-m">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>新增子分类</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="addOrgform" notBindDefaultEvent="true">
				<div class="form-group">
					<label for="insertName" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>子分类名称</label>
					<div class="col-sm-5">
						<input data-rule="required;checkname;length[1~45];" value="" class="form-control" id="insertName" name="insertName" placeholder="子分类名称">
					</div>
				</div>
				<input value="" id="pid" name="pid" type="hidden">
				<div class="form-group">
					<label for="addOrgsubmit" class="col-sm-4 control-label"></label>
					<div class="col-sm-5">
						<a id="addOrgcancel">取消</a>
						<input code="save" id="addOrgsubmit" type="submit" value="保存" class="btn btn-primary" />
					</div>
				</div>
			</form>
	  </div>
    </div>
  </div>
</div>
<script>
$(function() {
	$('#addOrgcancel').click(function(){
		$('#addOrg').modal('hide');
	});
	$('#addOrgform').validator({
		valid: function(form){
    		console.log("Es valid ok");
    		var editPid = $('#pid').val();
    		var editName = $('#insertName').val();
    		$.ajax({
				url:'/dataCategory?method=exist01&pid='+editPid+'&editName='+editName,
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
					console.log(data);
					if(data =='ok'){
						createMark();
						$.ajax({
							url:'/dataCategory?method=newChild',
							data:$('#addOrgform').serialize(),
							type:"post",
							dataType:"text",
							success:function(data, textStatus){
//			 					console.log(data);
								$('#addOrg').modal('hide');
								window.location.href=window.location.href;
								$.unblockUI();
//			 					alert("添加成功！");
							},error:function(err){
								console.log(err);
								$.unblockUI();
								alert("添加失败！");
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