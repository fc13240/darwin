<%@page import="com.stonesun.realTime.services.db.bean.ConnConfInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.ConnConfServices"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<div class="form-group">
	<label for="ipPort" class="col-sm-2 control-label">ip:port</label>
	<div class="col-sm-5">
		<input id="ipPort" name="ipPort" value="${ipPort}" class="form-control" placeholder="请输入flume.sink的ip:port" data-rule="required;ipPort">
	</div>
</div>


<script>
$(function(){
	$("#selectConnBtn").click(function(){
		
		//var cc = $("input:radio:checked").size();
		if($("input:radio:checked").size()==0){
			alert("请选择一个连接！");
			return;
		}
		var selectConnId = $("input:radio:checked").attr("_selectConnId");
		var selectConnName = $("input:radio:checked").attr("_selectConnName");
		$("#selectConnId").val(selectConnId);
		$("#selectConnName").val(selectConnName);
		$("#showSelectConnInfo").html(selectConnName);
		
		$('#myModal').modal('hide');
	});
});

function check(){
	if($("#showSelectConnInfo").html()==''){
		alert("请先选择一个连接!");
		return false;
	}
	var _action = $("form").action();
	console.log(_action);
	return false;
	//return true;
}
</script>
