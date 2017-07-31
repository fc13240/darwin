<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="addOrg" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-m">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>新增组织机构</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="addOrgform" notBindDefaultEvent="true">
				<div class="form-group">
					<label for="name" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>机构名称</label>
					<div class="col-sm-5">
						<input data-rule="required;checkname;length[1~45];remote[/RealTimeWeb/ajaxServer?method=existName&id=${id}]" value="" class="form-control" id="name" name="name" placeholder="机构名称">
					</div>
				</div>
				<div class="form-group">
					<label for="addNodeId" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>分配资源池</label>
					<div class="col-sm-5">
						<select id="addNodeId" name="addNodeId" class="form-control">
							<c:forEach items="${nodes}" var="item">
					           <option value="${item.id}">${item.name}(${item.ip}:${item.port})</option>
					        </c:forEach>
							<option value="0">暂无资源池</option>
						</select>
					</div>
					<label class="help-block">*点击进入<a target="_blank" href="<%=request.getContextPath() %>/node?method=index">资源池管理界面</a></label>
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
        	createMark();
			$.ajax({
				url:'/RealTimeWeb/org?method=newOrg',
				data:$('#addOrgform').serialize(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
// 					console.log(data);
					$('#addOrg').modal('hide');
					window.location.href=window.location.href;
					$.unblockUI();
// 					alert("添加成功！");
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("添加失败！");
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