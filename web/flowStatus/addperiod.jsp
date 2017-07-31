<%@ page contentType="text/html; charset=UTF-8"%>
<script src="<%=request.getContextPath() %>/resources/My97DatePicker/WdatePicker.js"></script>
<script src="<%=request.getContextPath() %>/resources/ss/ss.time.js"></script>
<div id="myModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
			<div style="text-align:center;padding:10px 0;">
				<h4>补充周期</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form" id="addhostform" notBindDefaultEvent="true">
					<div class="form-group">
						<label for="startTime" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>补充周期开始时间</label>
						<div class="col-sm-5">
							<input placeholder="开始时间" class="Wdate form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'stopTime\')||\'2020-10-01\'}'})"/>
						</div>
					</div>
					<div class="form-group">
						<label for="stopTime" class="col-sm-4 control-label"><span class="redStar">*&nbsp;</span>补充周期结束时间</label>
						<div class="col-sm-5">
							<input placeholder="结束时间" class="Wdate form-control" id="stopTime" name="stopTime" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'2020-10-01'})"/>
						</div>
					</div>
					<input value="${pager.params.flowId}" id="flowId" name="flowId" type="hidden">
					<div class="form-group">
						<label for="addperiodsubmit" class="col-sm-4 control-label"></label>
						<div class="col-sm-5">
							<a id="addperiodcancel">取消</a>
							<input id="addperiodsubmit" onclick="abc();" type="button" value="保存" class="btn btn-primary" />
						</div>
					</div>
				</form>
		  </div>
    </div>
  </div>
</div>
<script>
$(function() {
	$('#addperiodcancel').click(function(){
		$('#myModal').modal('hide');
	});
});

</script>
<script>
function abc(){
  var starttime = strtotime($('#startTime').val());
  var endtime = strtotime($('#stopTime').val());
  var nowtime = (new Date()).valueOf()/1000;
  if (starttime>endtime) {
    if(!confirm('开始时间晚于结束时间,您确定要继续吗？')) {
      return false;
    }
  }
  if (starttime>nowtime) {
    if (!confirm('开始时间晚于当前时间,您确定要继续吗？')) {
      return false;
    }
  }
	createMark();
	var flowId=000;
	$.ajax({
		url:'/flowStatus?method=addPeriod',
		data:$('#addhostform').serialize(),
		type:"post",
		dataType:"json",
		success:function(data, textStatus){
			var key = data["key"];
			var value = data["value"];
			var qqq="";
			if(key == "0"){
				qqq = value;
				alert(qqq);
				$('#myModal').modal('hide');
        window.location.reload();
			}else{
				qqq = value;
				alert(qqq);
			}
			$.unblockUI();

		},error:function(err){
			console.log(err);
			$.unblockUI();
			alert("发送请求失败！");
		}
	});
}

</script>
