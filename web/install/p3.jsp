<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Darwin Install(配置服务器)</title>
<%@ include file="/resources/common.jsp"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/style.css">

</head>
<body>
	<%-- 	<%@ include file="/resources/common_menu.jsp"%> --%>

	<div class="container" style="margin-top: 21px;min-height: 500px;">
		<div class="row">
			<form id="form1" action="<%=request.getContextPath()%>/install/success.jsp" autocomplete="off" 
				class="form-horizontal" role="form" method="post" notBindDefaultEvent="true" >

				<div class="form-group">
					<label for="total" class="col-sm-2 control-label"></label>
					<div class="col-sm-8" style="text-align: center;">
						<h5>服务器配置</h5>
					</div>
					<div class="col-sm-2"></div>
				</div>

				<div class="form-group">
					<div class="col-sm-2"></div>
					<div class="col-sm-8" style="text-align: left;">
						<input class="btn btn-info btn-sm" type="button" id="addServer"
							value="添加服务器" />
					</div>
					<div class="col-sm-2"></div>
				</div>

				<div class="form-group">
					<div class="col-sm-2"></div>
					<div class="col-sm-8" style="text-align: left;">
						<div id="errorDiv" style="background-color: white;"></div>
					</div>
					<div class="col-sm-2"></div>
				</div>

				

				<div class="form-group">
					<label for="total" class="col-sm-0 control-label"></label>
					<div class="col-sm-12" style="text-align: center;">

						<table id="serverTable" class="table table-bordered"
							style="background-color: white;">
							<tr>
								<td width="10%">ID</td>
								<td width="10%">服务器名称</td>
								<td width="30%">服务器配置</td>
								<!--<td width="10%">总线服务</td>-->
								<td width="10%">流程处理节点</td>
								<td width="10%">Elasticsearch</td>
								<td width="10%">状态</td>
								<td width="10%">操作</td>
							</tr>
						</table>
					</div>
					<div class="col-sm-0">&nbsp;</div>
				</div>

				<div class="form-group">
					<label for="total" class="col-sm-2 control-label"></label>
					<div class="col-sm-8" style="text-align: center;">
						<input class="btn btn-default" type="button" value="上一步"
							onclick="javascript:history.back()" /> <button
							class="btn btn-success" type="submit" value="下一步" id="nextBtn"
							style="width: 200px;">下一步</button>
					</div>
					<div class="col-sm-2">&nbsp;</div>
				</div>

			</form>
		</div>
	</div>


	<table id="serverTable2222" style="display: none;">
		<tr>
			<td>
				<div class="form-group">
					<div class="col-sm-12">
						<lable name="ID">
					</div>
				</div>
			</td>
			<td>
				<div class="form-group">
					<div class="col-sm-12">
						<input data-rule="required;" class="form-control input-sm" id="hostname"
							name="hostname" placeholder="服务器名称">
					</div>
				</div>
			</td>
			<td>
				<div class="form-group">
					<label for="host" class="col-sm-3 control-label">host</label>
					<div class="col-sm-9">
						<input data-rule="required;" class="form-control input-sm" id="host"
							name="host" placeholder="服务器IP或host">
					</div>
				</div>
				<div class="form-group">
					<label for="rootPwd" class="col-sm-3 control-label">rootPwd</label>
					<div class="col-sm-9">
						<input data-rule="required;" class="form-control input-sm" id="rootPwd"
							name="rootPwd" type="password" placeholder="服务器root密码">
					</div>
				</div>
				<div class="form-group">
					<label for="sshdPort" class="col-sm-3 control-label">sshdPort</label>
					<div class="col-sm-9">
						<input type="sshdPort" data-rule="required;integer[+0];range[~65535]" class="form-control input-sm" id="sshdPort" value="22"
							name="sshdPort" placeholder="sshd port">
					</div>
				</div>
			</td>
			<td>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<div class="checkbox">
							<label> <input type="checkbox" title="安装" alt="安装" checked="checked" name="darwinNode" value="y">
							</label>
						</div>
					</div>
				</div>
			</td>
			<td>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<div class="checkbox">
							<label> <input type="checkbox" title="安装" alt="安装" checked="checked" name="elasticsearch" value="y">
							</label>
						</div>
					</div>
				</div>
			</td>
			<td><div class="nodeStatus">新增</div></td>
			<td><input class="btn btn-default" type="button" value="删除" onclick="delServer(this)"/></td>
</tr>
	</table>

	<script type="text/javascript">
		$(function() {
			var ss = $("#serverTable2222").clone(true);
			$("#serverTable2222").remove();

			$("#addServer").click(function() {
				console.log("addServer");
				var s = ss.clone(true);
				var max = $("#serverTable tr:gt(0)").size()+1;
				s.find("lable[name='ID']").text(max);

				s.find("lable[name='ID']").attr("id","server_id"+max);
				s.find("input[name='hostname']").attr("id","server_hostname"+max);
				//s.find("input[name='nodeId']").attr("id","server_nodeId"+max);
				s.find("input[name='host']").attr("id","server_host"+max);
				s.find("input[name='communicatePort']").attr("communicatePort","server_id"+max);
				s.find("input[name='rootPwd']").attr("id","server_rootPwd"+max);
				s.find("input[name='sshdPort']").attr("id","server_sshdPort"+max);

				if(max == 1){

				}
				
				var rowTmp = "<tr>" + s.html() + "</tr>";
				$("#serverTable").append(rowTmp);

				$("#errorDiv").html("");

				//$("#nextBtn").attr("type","submit");
				//$("form").removeAttr("onsubmit");
			});

			$('#form1').validator({
				valid: function(form){
					$("#errorDiv").html("");
					console.log($("#serverTable tr:gt(0)").size());
					if($("#serverTable tr:gt(0)").size() == 0){
						$("#errorDiv").html("请至少添加一台服务器节点！");
						return false;
					}
					return true;
				}
			});

			$("#form1").on("valid.form", function(e, form){

				$("#errorDiv").html("");

				if($("#serverTable tr:gt(0)").size() == 0){
					$("#errorDiv").html("请至少添加一台服务器节点！");
					return false;
				}

				createMark();

				ajaxSubmitForm(form);
			});

			//表单验证失败
			$('form').on('invalid.form', function(e, form, errors){
				console.log("表单验证失败...");
				console.log(e);
				console.log(form);
				console.log(errors);
				$("#errorDiv").html("");
			    //do something...
				if(window.invalidFormFunc){
					invalidFormFunc();
				}
			});

			function ajaxSubmitForm(form){
				var _url = "<%=request.getContextPath() %>/install?method=addDarwinNode";
				var serverList = [];
				$("#serverTable tr:gt(0)").each(function(index,value){
					//console.log(value);
					var ID = $(value).find("lable[name='ID']").text();
					var hostname = $(value).find("input[name='hostname']").val();
					//var nodeId = $(value).find("input[name='nodeId']").val();
					var host = $(value).find("input[name='host']").val();
					var communicatePort = $(value).find("input[name='communicatePort']").val();
					var rootPwd = $(value).find("input[name='rootPwd']").val();
					var sshdPort = $(value).find("input[name='sshdPort']").val();

					var darwinNode = $(value).find("input[name='darwinNode']").prop("checked");
					var elasticsearch = $(value).find("input[name='elasticsearch']").prop("checked");

					var serverItem = {
						"ID":ID,
						"hostname":hostname,
						//"nodeId":nodeId,
						"host":host,
						"communicatePort":communicatePort,
						"rootPwd":rootPwd,
						"sshdPort":sshdPort,
						"darwinNode":darwinNode,
						"elasticsearch":elasticsearch
					};
					serverList.push(serverItem);
				});

				//console.log(serverList);

				$.ajax({
					url:_url,
					data:{
						"serverList":JSON.stringify(serverList)
					},
					type:"post",
					dataType:"json",
					async:true,
					success:function(data, textStatus){
						console.log(data);
						
						var saveDbStatus = data["saveDbStatus"];
						if(!saveDbStatus){
							$("#errorDiv").html(data["saveDbStatusMsg"] + "");
							$.unblockUI();
							return;
						}

						var serverResult = data["serverResult"];
						var allSuccess = true;
						$("#errorDiv").html("");
						for(var s in serverResult){
							var _id = serverResult[s]["ID"];

							$("#serverTable tr:gt(0)").each(function(index,value){
								var ID = $(value).find("lable[name='ID']").text();
								var _status = "成功";
								if(ID==_id){
									_status = serverResult[s]["status"];
									if(_status){
										$(value).find("div[class='nodeStatus']").html("成功");
									}else{
										allSuccess = false;
										$(value).find("div[class='nodeStatus']").html("<font color='red'>失败</font>");
										var errorRow = "";
										errorRow += "ID:"+ID+",失败原因:"+serverResult[s]["msg"]+"</br>";
										$("#errorDiv").append(errorRow);
									}
								}								
							});
						}

						console.log("allSuccess="+allSuccess);

						if(allSuccess){
							form.submit();
						}

						$.unblockUI();
					},error:function(err){
						console.log(err);
						$("#errDiv .err").html("配置验证失败！请联系管理员！");
						$.unblockUI();
					}
				});
			}

			$("input[name='darwinNode']").click(function(){
				if($(this).prop("checked")){$(this).attr("value","y");}
				else{$(this).attr("value","n");}
			});

			$("input[name='elasticsearch']").click(function(){
				if($(this).prop("checked")){$(this).attr("value","y");}
				else{$(this).attr("value","n");}
			});


		});

		function delServer(o){
			var tr = $(o).parent().parent();
			
			if(tr.find("div[class='nodeStatus']").text()=='新增'){
				tr.remove();
				return;
			}

			var _url = "<%=request.getContextPath() %>/install?method=deleteDarwinNode";

			$.ajax({
				url:_url,
				data:{
					"hostname":tr.find("input[name='hostname']").val(),
					"sshdPort":tr.find("input[name='sshdPort']").val()
				},
				type:"post",
				dataType:"json",
				async:true,
				success:function(data, textStatus){
					console.log(data);
					if(data["status"]){
						tr.remove();	
					}else{
						alert("删除服务器失败！原因"+data["msg"]);
					}

					$.unblockUI();
				},error:function(err){
					console.log(err);
					$.unblockUI();
					alert("删除服务器异常！原因"+err["statusText"]);
				}
			});

		}
	</script>
	<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>