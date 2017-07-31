<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.bean.ConnConfInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.ConnConfServices"%>
<%@ page contentType="text/html; charset=UTF-8"%>



<!-- Modal2添加新的链接 -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    	<form id="connForm" novalidate="novalidate" action="<%=request.getContextPath() %>/user/connConf?method=save&ajax=true" method="post" class="form-horizontal" role="form">
    	
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">新增一个连接</h4>
		      </div>
		      <div class="modal-body" id="connBodyDiv">
		      			<!-- 连接配置 -->
		      			<c:choose>
							<c:when test="${sourceType eq 'ftp' or sourceType eq 'scp'}">
									<input id="type" name="type" value="ftp" type="hidden">
					      		  <div class="form-group">
								    <label for="name" class="col-sm-3 control-label">连接名称</label>
								    <div class="col-sm-6">
								      <input class="form-control" data-rule="required;name;remote[/user/connConf?method=exist]" id="name" name="name" placeholder="连接名称">
								    </div>
								  </div>
								  <div class="form-group">
								    <label for="host" class="col-sm-3 control-label">主机名(Host)</label>
								    <div class="col-sm-6">
								      <input  class="form-control" data-rule="required;host" id="host" name="host" placeholder="主机名(Host)">
								    </div>
								  </div>
								  <div class="form-group">
								    <label for="port" class="col-sm-3 control-label">端口号(Port)</label>
								    <div class="col-sm-6">
								      <input  class="form-control" data-rule="required;port" id="port" name="port" placeholder="端口号(Port)">
								    </div>
								  </div>
								  <div class="form-group">
								    <label for="username" class="col-sm-3 control-label">用户名(Username)</label>
								    <div class="col-sm-6">
								      <input  class="form-control" data-rule="required;username" id="username" name="username" placeholder="用户名(Username)">
								    </div>
								  </div>
								  <div class="form-group">
								    <label for="password" class="col-sm-3 control-label">密码(Password)</label>
								    <div class="col-sm-6">
								      <input type="password" data-rule="required;password" class="form-control" id="password" name="password" placeholder="密码(Password)">
								    </div>
								  </div>
							</c:when>
							<c:when test="${sourceType eq 'scp'}">
							
							</c:when>
							<c:when test="${sourceType eq 'flume'}">
							
							</c:when>
						</c:choose>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="submit" class="btn btn-primary" id="ajaxSubmit">确定</button>
		      </div>
		      
    	</form>
    </div>
  </div>
</div>

<script>
var _connBodyDiv;
$(function(){
	_connBodyDiv = $("#connBodyDiv").html();
	$("#connBodyDiv").html("");
	
	$("#selectConnBtn").click(function(){
		console.log("selectConnBtn...");
		//var cc = $("input:radio:checked").size();
		if($("input:radio:checked").size()==0){
		//if($("#selectConnId").val()==''){
			alert("请选择一个连接！");
			return;
		}
		var selectConnId = $("input:radio:checked").attr("_selectConnId");
		var selectConnName = $("input:radio:checked").attr("_selectConnName");
		console.log(selectConnId);
		console.log(selectConnName);
		$("#selectConnId").val(selectConnId);
		$("#selectConnName").val(selectConnName);
		$("#showSelectConnInfo").html("");
// 		console.log(selectConnName + '<span><a href=\"/user/connConf?method=edit&id=\"'+selectConnId+'>【查看】</a></span>');
		$("#showSelectConnInfo").html(selectConnName);
		$("#connEditId").html('<a target=\"_blank\" href=\"/user/connConf?method=edit&id='+selectConnId+'\">【查看】</a>');
		
		$('#myModal').modal('hide');
	});
	
	$('#connForm').validator({
		valid: function(form){
			console.log("valid...");
			$.ajax({
				url:"<%=request.getContextPath() %>/user/connConf?method=save&ajax=true",
				type:"post",
				data:{
					type:$("#sourceType").val(),
					name:$("#name").val(),
					host:$("#host").val(),
					port:$("#port").val(),
					username:$("#username").val(),
					password:$("#password").val()
				},
				dataType:"text",
				success:function(data, textStatus){
					console.log("data="+data);
					if(data=="0"){
						$('#myModal2').modal('hide');
					}
				},
				error:function(){
					alert("保存连接失败！");
				}
			});
		}
	});
	
});

function check(){
	/*if($.trim($("#showSelectConnInfo").html()).length == 0){
		alert("请先选择一个连接!");
		return false;
	}*/
	if($("#selectConnId").val()==''){
		alert("请选择一个连接！");
		return false;
	}
	return true;
}

function addConnFunc(){
	$("#connBodyDiv").html("");
	$("#connBodyDiv").html(_connBodyDiv);
}

function showConnFunc(){
	$("#connListDiv").html("");
	
	$.ajax({
		url:"<%=request.getContextPath() %>/user/connConf?method=showConnFunc&ajax=true&sourceType="+$("#sourceType").val(),
		type:"post",
		data:{
			
		},
		dataType:"json",
		success:function(data, textStatus){
// 			console.log("data="+data);
			
			$.each(data,function(index,value){
// 				console.log(value);
				var row = "<div class=\"radio\">";
				row+="<label>";
				row+="<input type='radio' id='increment' name='getDataMethod' _selectConnId='"+value["id"]+"' _selectConnName='"+value["name"]+"'>"+value["name"];
				var tips = "连接名称："+value["confMap"]["name"]+";&#10;";
				tips+= "主机名："+value["confMap"]["host"]+";&#10;";
				tips+="端口号："+value["confMap"]["port"]+";&#10;";
				tips+="用户名："+value["confMap"]["username"];
				row+="<a href=\"javascript:void();\" data-toggle=\"tooltip\" title=\""+tips+"\" data-placement=\"right\" data-original-title=\""+tips+"\"></a>";
				row+="</label>";
				row+="<a  href='<%=request.getContextPath() %>/user/connConf?method=edit&id="+value["id"]+"'><span class=\"glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
				row+="</div>";
				
				$("#connListDiv").append(row);
			});
			$('[data-toggle="tooltip"]').tooltip();
		},
		error:function(){
			alert("加载连接失败！");
		}
	});
}
</script>
