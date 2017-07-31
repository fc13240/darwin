<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="editOrg" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-m">
    <div class="modal-content">
		<div style="text-align:center;padding:10px 0;">
			<h4>编辑组织机构</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" role="form" id="editOrgform" notBindDefaultEvent="true">
				<div class="form-group">
					<label for="editName" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>机构名称</label>
					<div class="col-sm-5">
						<input data-rule="required;checkname;length[1~45];remote[/ajaxServer?method=existName&id=${id}]" value="" class="form-control" id="editName" name="editName" placeholder="机构名称">
					</div>
				</div>
				<div class="form-group">
					<label for="editNodeId" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>分配资源池</label>
					<div class="col-sm-5">
						<select id="editNodeId" name="editNodeId" class="form-control">
							<c:forEach items="${nodes}" var="item">
					           <option <c:if test='${item.id == database}'>selected="selected"</c:if>value="${item.id}">${item.name}(${item.ip}:${item.port})</option>
					        </c:forEach>
							<option value="0">暂无资源池</option>
						</select>
					</div>
					<label class="help-block">*点击进入<a target="_blank" href="<%=request.getContextPath() %>/node?method=index">资源池管理界面</a></label>
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
	var nodeId = $("#nodeId").val();
	console.log("nodeid="+nodeId);
	$('#editOrgcancel').click(function(){
		$('#editOrg').modal('hide');
	});
	$('#editOrgform').validator({
		valid: function(form){
    		console.log("Es valid ok");
    		var editId = $('#editId').val();
        	createMark();
			$.ajax({
				url:'/org?method=editOrg&id='+editId,
				data:$('#editOrgform').serialize(),
				type:"post",
				dataType:"text",
				success:function(data, textStatus){
// 					console.log(data);
					$('#editOrg').modal('hide');
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