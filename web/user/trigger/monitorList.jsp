<%@ page contentType="text/html; charset=UTF-8"%>
<div id="addhost" class="modal fade bs-example-modal-ms" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-ms">
    <div class="modal-content content">
			<div class="modal-header header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				<h4 class="modal-title" id="myModalLabel">监控项列表</h4>
 			</div>
			<div class="modal-body">
				<form action="<%=request.getContextPath() %>/user/monitor?method=index" method="post" class="" role="form">
					<div class="container mh500">
						<div class="row">
							<div class="col-xs-5 col-md-5">
								<span>系统共有200个监控项</span>
							</div>
							<div class="col-xs-7 col-md-7">
								<div class="page-search r">
									<div class="input-group">
									  <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
									  <span class="input-group-addon" id="basic-addon1" style="height:5px;"><span class=" glyphicon glyphicon-search"></span></span>
									</div>
<!-- 									<div class="input-group"> -->
<%-- 										<input type="search" placeholder="流程名称" name="name" value="${pager.params.name}" class="form-control" > --%>
<!-- 										<span class="input-group-btn"> -->
<%-- 											<button class="btn" type="submit" href="<%=request.getContextPath() %>/flow?method=index"> --%>
<!-- 												<span class="fui-search"></span> -->
<!-- 											</button> -->
<!-- 										</span> -->
<!-- 									</div> -->
								</div>
							</div>
						</div>
						<div class="row">
							<table class="table table-hover table-striped" border="0" style="border-collapse:   separate;   border-spacing:   10px; ">
								<tr>
									<td>监控项目1</td>
									<td>监控项目2</td>
								</tr>
								<tr>
									<td>监控项目1</td>
									<td>监控项目2</td>
								</tr>
								<tr>
									<td>监控项目1</td>
									<td>监控项目2</td>
								</tr>
								<tr>
									<td>监控项目1</td>
									<td>监控项目2</td>
								</tr>
							</table>
							<div>
								<%@ include file="/resources/popPager.jsp"%>
							</div>
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
		$('#addhost').modal('show');
		$.ajax({
			url:"<%=request.getContextPath() %>/ajaxServer?method=esCheckList",
			type:"post",
			dataType:"json",
			success:function(data, textStatus){
// 				console.log("data------------"+data);
				
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
});

</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
