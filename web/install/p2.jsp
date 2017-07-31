<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.stonesun.realTime.services.servlet.ConfigureServlet"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Darwin Install(配置数据库)</title>
<%@ include file="/resources/common.jsp"%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">

</head>
<body>
<%-- 	<%@ include file="/resources/common_menu.jsp"%> --%>
	
	<%request.setAttribute("hdfsRoot", ConfigureServlet.getHdfsRoot());%>
	<div class="container" style="margin-top: 21px;min-height: 500px;">
    	<div class="row">
    		<form action="<%=request.getContextPath()%>/install/success.jsp" class="form-horizontal" role="form" method="post" notBindDefaultEvent="true">
				<div class="form-group">
					<label class="col-sm-2 control-label"></label>
					<div class="col-sm-8" style="text-align: center;">
			    		<h5>安装配置</h5>
					</div>
					<div class="col-sm-2"></div>
				</div>

				<div class="form-group">
					<label class="col-sm-2 control-label"></label>
					<div class="col-sm-8" style="text-align: left;" id="errDiv">
			    		
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="form-group">
					<label for="total" class="col-sm-2 control-label"></label>
					<div class="col-sm-8" style="text-align: center;">

						<div class="well" style="text-align: center;background-color: white;">
			    			<div class="form-group">
								<label for="licenceUrl" class="col-sm-5 control-label">licence文件</label>
								<div class="col-sm-5">
									<input data-rule="required;" id="licenceUrl" class="form-control" placeholder="请选择licence文件路径" readonly="readonly">
									
								</div>
								<div class="col-sm-2" align="left">
									<input type="button" id="uploadButton" value="上传" />
								</div>
							</div>
			    		</div>

						<div class="well" style="text-align: center;background-color: white;">
							<div class="form-group">
								<label for="dbName" class="col-sm-5 control-label">数据库名称</label>
								<div class="col-sm-3">
									<input data-rule="required;" class="form-control" id="dbName" name="dbName" placeholder="数据库名称">
								</div>
							</div>
			    			<div class="form-group">
								<label for="hostname" class="col-sm-5 control-label">数据库地址</label>
								<div class="col-sm-3">
									<input value="localhost" data-rule="required;" class="form-control" id="hostname" name="hostname" placeholder="数据库地址">
								</div>
							</div>
			    			<div class="form-group">
								<label for="port" class="col-sm-5 control-label">数据库端口</label>
								<div class="col-sm-3">
									<input value="20001" data-rule="required;integer" class="form-control" id="port" name="port" placeholder="数据库端口">
								</div>
							</div>
			    			<div class="form-group">
								<label for="username" class="col-sm-5 control-label">数据库用户名</label>
								<div class="col-sm-3">
									<input value="darwin" data-rule="required;" class="form-control" id="username" name="username" placeholder="数据库用户名">
								</div>
							</div>
			    			<div class="form-group">
								<label for="passowrd" class="col-sm-5 control-label">数据库密码</label>
								<div class="col-sm-3">
									<input value="darwin" data-rule="required;" type="password" class="form-control" id="passowrd" name="passowrd" placeholder="数据库密码">
								</div>
							</div>
			    		</div>
			    		<c:if test="${true}">
			    		<div class="well" style="text-align: center;background-color: white;">
			    			<div class="form-group">
								<label for="hdfsUserName" class="col-sm-5 control-label">HDFS用户</label>
								<div class="col-sm-3">
									<input data-rule="required;length[2~200];hdfsUserName;" class="form-control" id="hdfsUserName" name="hdfsUserName" placeholder="HDFS用户名" value="yimr" disabled="disabled">
								</div>
							</div>
			    			<div class="form-group">
								<label for="hdfsPath" class="col-sm-5 control-label">HDFS集群地址</label>
								<div class="col-sm-5">
									<input data-rule="required;length[2~200];hdfsPath;remote[/install?method=checkHdfs]" class="form-control" value="${hdfsRoot }" id="hdfsPath" name="hdfsPath" placeholder="HDFS集群地址">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-sm-5 control-label"></label>
								<div class="col-sm-7" style="text-align: left;">
									格式：hdfs://namenode:8020。多个用逗号分割。
								</div>
							</div>
			    		</div>

			    		<div class="well" style="text-align: center;background-color: white;">
			    			<div class="form-group">
								<label for="sparkUrl" class="col-sm-5 control-label">spark集群地址</label>
								<div class="col-sm-5">
									<input data-rule="required;length[2~200];sparkUrl;remote[/install?method=checkSpark]" class="form-control" id="sparkUrl" name="sparkUrl" value="yarn-client" placeholder="spark集群地址">
								</div>
							</div>
			    			<div class="form-group">
								<label for="sparkUrl" class="col-sm-5 control-label"></label>
								<div class="col-sm-7" style="text-align: left;">
									格式：yarn-client,yarn-cluster,local,spark://XXXX:7077四种格式。
								</div>
							</div>
			    		</div>
			    		
			    		<div class="well" style="text-align: center;background-color: white;">
			    			<div class="form-group">
								<label for="cdhIp" class="col-sm-5 control-label">ip地址端口</label>
								<div class="col-sm-5">
									<input data-rule="required;cdhIp;remote[/install?method=checkCdh]" class="form-control" id="cdhIp" name="cdhIp" value="192.168.xxx.xxx:8088" placeholder="192.168.xxx.xxx:8088">
								</div>
							</div>
			    			<div class="form-group">
			    				<label for="isYarn" class="col-sm-5 control-label">资源管理器</label>
				    			<div class="col-sm-2">
					    			<select class="form-control" id="isYarn" name="isYarn">
								    	<option value="true">yarn</option>
								    	<option value="false">standlone</option>
									</select>
								</div>
							</div>
			    			<div class="form-group">
								<label for="" class="col-sm-5 control-label"></label>
								<div class="col-sm-7" style="text-align: left;">
									说明：yarn模式的端口号一般为8088,standlone模式的端口号为18080。
								</div>
							</div>
			    		</div>
			    		</c:if>
			    		
<!-- 			    		<div class="well" style="text-align: center;background-color: white;"> -->
<!-- 			    			<div class="form-group"> -->
<!-- 								<label for="phoenix" class="col-sm-5 control-label">phoenix地址</label> -->
<!-- 								<div class="col-sm-7"> -->
<!-- 									<input data-rule="required;length[2~200];phoenix;remote[/install?method=checkPhoenix]" class="form-control" id="phoenix" name="phoenix" placeholder="jdbc:phoenix:darwin01,darwin02,darwin03:2181"> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 			    		</div> -->
						
					</div>
					<div class="col-sm-2">&nbsp;</div>
				</div>
				
				<div class="form-group">
					<label for="total" class="col-sm-2 control-label"></label>
					<div class="col-sm-8" style="text-align: center;">
			    		<input class="btn btn-default" type="button" value="上一步" onclick="javascript:history.back()"/>
			    		<input class="btn btn-success" type="submit" value="下一步" style="width: 200px;"/>
					</div>
					<div class="col-sm-2">&nbsp;</div>
				</div>
	    		
	    	</form>
    	</div>
	</div>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>
<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/kindeditor-all.js"></script>
<script src="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/lang/zh_CN.js"></script>

<script type="text/javascript">
$(function(){

	KindEditor.ready(function(K) {
		var uploadbutton = K.uploadbutton({
			button : K('#uploadButton')[0],
			fieldName : 'imgFile',
			url : '/resources/kindeditor-4.1.10/jsp/upload_json_licence.jsp?dir=file',
			afterUpload : function(data) {
				console.log("data:");
				console.log(data);
				if (data.error === 0) {
					var url = K.formatUrl(data.url, 'absolute');
					K('#licenceUrl').val(url);
				} else {
					alert(data.message);
					K('#licenceUrl').val("");
				}
				$('#licenceUrl').trigger("validate");
			},
			afterError : function(str) {
				alert('自定义错误信息: ' + str);
				K('#licenceUrl').val("");
				$('#licenceUrl').trigger("validate");
			}
		});
		uploadbutton.fileBox.change(function(e) {
			uploadbutton.submit();
		});
	});


	$("form").on("valid.form", function(e, form){
		console.log("valid...");
		createMark();

		$("#errDiv").html("");
		
		ajaxSubmitForm(form);
	});
	
	//表单验证失败
	$('form').on('invalid.form', function(e, form, errors){
		console.log("表单验证失败...");
		console.log(e);
		console.log(form);
		console.log(errors);
	    //do something...
		if(window.invalidFormFunc){
			invalidFormFunc();
		}
	});

	function ajaxSubmitForm(form){
		
		var dbName = $("#dbName").val();
		var hostname = $("#hostname").val();
		var port = $("#port").val();
		var username = $("#username").val();
		var passowrd = $("#passowrd").val();
		var hdfsPath = $("#hdfsPath").val();
		var hdfsUserName = $("#hdfsUserName").val();
		var sparkUrl = $("#sparkUrl").val();
		var _url = "<%=request.getContextPath() %>/install?method=checkDb";
		
		$.ajax({
			url:_url,
			data:{
				dbName:dbName,
				hostname:hostname,
				port:port,
				username:username,
				passowrd:passowrd,
				hdfsPath:hdfsPath,
				hdfsUserName:hdfsUserName,
				sparkUrl:sparkUrl
			},
			type:"post",
			dataType:"json",
			async:true,
			timeout:10*60000,
			success:function(data, textStatus){
				console.log(data);
				var _status = data["status"];
				if(_status){
					form.submit();
				}else{
					$("#errDiv").html("数据库配置验证失败！请检查验证是否正确！"+data["msg"]);
				}
				$.unblockUI();
			},error:function(err){
				console.log("ajax.error");
				console.log(err);
				var _e = err["statusText"];
				console.log(_e);
				
				$("#errDiv").html("数据库配置验证失败！请联系管理员！"+_e);
				$.unblockUI();
			}
		});
	}

});
</script>
	<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>