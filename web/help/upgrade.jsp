<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>系统升级管理</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" type="text/css" href="/flowStatus/css/css.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditorToUp/themes/default/default.css"/>
</head>
<body>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					系统升级管理
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="page-header">
			<ol class="breadcrumb">
				<li><span class='glyphicon glyphicon-collapse-down'></span>&nbsp;关于系统升级</li>
			</ol>
		</div>
		<div class="page-body">
			<input id="versionFlg" name="versionFlg" value="" type="hidden"/>
			<input id="checkFlg" name="checkFlg" value="" type="hidden"/>
			<table>
				<tr>
					<td>
						<img src="/resources/site/img/bigdatalogo.jpg" width="490px;" height="270px;">
					</td>
					<td>&nbsp;&nbsp;</td>
					<td>
						<table>
							<tr>
								<td colspan="2">
									<div class="col-sm-5" style="margin-left:-15px;">
										<input name="files" id="files" value="" class="form-control " readonly="readonly" data-rule="required;"/> 
									</div>
									<div class="col-sm-7">
										<input code="save" class="btn btn-default input-sm" type="button" id="insertfile" value="上传升级包" />
										<input id="checkSys" class="btn btn-primary btn-sm" type="button" value="检查更新"/>
										<input id="updateRun" class="btn btn-default btn-sm" type="button" value="系统升级"/>
										<input id="restart" class="btn btn-warning btn-sm" type="button" value="重启服务"/>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<p>系统当前版本-<span style="font-weight:bold;">
										<%if(StringUtils.isNotBlank(DataCache.version)){ %>
											V<%=DataCache.version %>
										<%} %></span> &nbsp;
										<span style="color:blue;" id="versionMes"></span>
										<span id="notice"></span>
									</p>
									<br>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p><span style="font-weight:bold;">升级注意事项:</span></p>
									<p>升级过程中系统处于暂时不可用状态，敬请原谅^^。</p>
									<p>升级前，请上传正确的升级包，并点击检查升级包是否可用。
									1，前后台,数据库备份。2，升级web端。3，升级后台，分发到各个主机。4，升级数据库。以上步骤如有失败，均回滚到升级前版本。以上所有步骤执行成功后，则会提示您重启服务。
									</p>
									<p><span style="color:red;">升级警示语：升级过程中不可刷新页面，否则升级停止。<br>
									升级过程中不可停止tomcat服务，否则可能造成不可恢复的结果，最后只能手动恢复系统。</span></p>
									<p>以上步骤如果有问题，请联系系统管理员。^_^</p>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div id="showRemark"></div>
								</td>
							</tr>
							
						</table>
					</td>
				</tr>
			</table>
			<table style="border-top:1px;">
				<tr>
					<td width="39%">
					</td>
					<td width="61%">
						<div id="barboxDiv" style="display:none;">
							<div style="color:blue;" id="barboxMes">&nbsp;系统正在升级中，请耐心等候....</div>
							<div class="votebox" >
								<dl class="barbox">
									<dd class="barline">
										<div id="barboxId" style="width:10%" class="barSuccess"></div>
									</dd>
								</dl>
							</div>
<!-- 							<div class="progress progress-striped active"> -->
<!-- 								  <div id="barboxId" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%;heigth:450px;"> -->
<!-- 								    <span class="sr-only" id="srOnlyDiv">10% Complete</span> -->
<!-- 								  </div> -->
<!-- 							</div> -->
						</div>
						<div id="logs">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
<%@ include file="/resources/common_footer.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/codeeditor/codemirror.css">
<script src="<%=request.getContextPath() %>/resources/codeeditor/codemirror.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.timers-1.1.2.js"></script>
<script src="<%=request.getContextPath() %>/resources/kindeditorToUp/kindeditor-all.js"></script>
<script src="<%=request.getContextPath() %>/resources/kindeditorToUp/lang/zh_CN.js"></script>
<script>
	KindEditor.ready(function(K) {
		var editor = K.editor({
			allowFileManager : true
		});
		K('#insertfile').click(function() {
			editor.loadPlugin('insertfile', function() {
				editor.plugin.fileDialog({
					fileUrl : K('#files').val(),
					clickFn : function(url, title) {
						var files = K('#files').val();
						K('#files').val(url);
						editor.hideDialog();
						var fff=$('#files').val();
						if(fff != '' && fff.indexOf(".sh") != -1){
					 		console.log("fff="+fff);
					 		var fileToMain = fff.split("/");
					 		if(fileToMain.length>1){
					 			console.log("fff="+fileToMain.length);
					 			$("#mainFile").val(fileToMain[fileToMain.length-1]);
						 	}
					 	}else{
						 }
					}
				});
			});
		});
		
	});
	
	function onsubmitFunc(){
		var files = $("#files").val();
		if(files){
			return true;
		}
		$("#errorTips").html("请先选择文件!");
		return false;
	}
</script>
<SCRIPT type="text/javascript">
$(function(){
	setTimeout("random()",100);
});

function random(){
	var vv = $("#checkFlg").val();
	$.ajax({
		url:"<%=request.getContextPath() %>/upgrade?method=showlog&version="+vv,
		type:"post",
		dataType:"json",
		success:function(data, textStatus){
			console.log(data);
// 			if(!data || data==''){
// 				return;
// 			}
			var _progressBar = data._progressBar; 
			var status = data.status; 
			var logValue = data.logs; 
			console.log("_progressBar="+_progressBar+"status="+status+",logValue="+logValue);
			$("#logs").html(logValue);
			
			if(logValue != ''){
				console.log("logValue不为空");
				$("#barboxDiv").attr("style","");
				if(status){
					// width: 10%;heigth:450px;
					$("#barboxId").attr("style","width:"+_progressBar+"%");
					$("#barboxId").attr("class","barSuccess");
					if(_progressBar == '100'){
						$("#barboxMes").text("升级成功！");
					}
// 					$("#srOnlyDiv").text("aria-valuenow",_progressBar);//srOnlyDiv">10% Complete
				}else{
					$("#barboxMes").text("升级失败！");
					$("#barboxId").attr("style","width:"+_progressBar+"%");
					$("#barboxId").attr("class","barfailed");
				}

				if(logValue.indexOf("升级成功") < 0 && logValue.indexOf("Exception") < 0 && logValue.indexOf("失败") < 0){
					var ht = "<img src='<%=request.getContextPath() %>/resources/images/loading.gif'>";
					if(!logValue || logValue==''){
						$("#logs").html("");
					}else{
						$("#logs").html(logValue+ht);
					}
					setTimeout("random()",1000);
				}else{
//	 				$("#checkFlg").val("");
				}
				
			}else{
				$("#barboxDiv").attr("style","display:none;");
				setTimeout("random()",1000);
			}
		
		},
		error:function(err){
			console.log(err);
			console.log("加载数据出错啊啊啊！");
		}
		});
	}
	
$(function(){
	setTimeout("random()",100);
	
	$("#checkSys").click(function(){
		var files = $("#files").val();
		console.log("files="+files);
		if(!files || files == ''){
			alert("请先检查上传升级包。");
		}else{
			createMark();
			$.ajax({
				url:"<%=request.getContextPath() %>/upgrade?method=check",
				type:"post",
				dataType:"text",
				success:function(data){
					console.log("检查="+data);
					$("#barboxDiv").attr("style","display:none;");
					if(data != ''){
						var vv = data.split("|");
						var vvk = vv[0].replace("V","");
						console.log(vvk);
						$("#versionMes").attr("style","color:blue;");
						$("#checkFlg").val(vvk);
						$("#versionFlg").val(vvk);
						$("#updateRun").attr("class","btn btn-success btn-sm");
				       	$("#versionMes").text("检测到最新版本："+data);
				       	$("#notice").html("&nbsp;&nbsp;<a href='/version?method=index' id='remark' target='_blank'>查看升级公告</a>");
				       	$("#logs").html("");
					}else{
						$("#versionMes").text("没有检测到升级包，请确认。");
						$("#versionMes").attr("style","color:blue;");
						$("#checkFlg").val("");
						$("#versionFlg").val("");
						$("#files").val("");
				       	$("#notice").html("");
				       	$("#logs").html("");
					}
					$.unblockUI();
				},
				error:function(){
					console.log("错误啦");
					$("#checkFlg").val("");
					$("#versionFlg").val("");
					$.unblockUI();
				}
			});
		}
	});
	
	$("#updateRun").click(function(){

		var vv = $("#versionFlg").val();
		if(vv == ""){
			alert("请先检查是否有升级补丁包。");
		}else{
			if(!confirm("确定要升级到最新版本吗?")){
				return false;
			}
			createMark02();
			setTimeout("random()",1000);
			$.ajax({
				url:"<%=request.getContextPath() %>/upgrade?method=backupAll",
// 				timeout : 3600000, //超时时间设置，单位毫秒
				type:"post",
				dataType:"text",
				success:function(data){
					setTimeout("random()",100);
					console.log("date="+data);
					if(data=='0'){
						setTimeout("random()",100);
						console.log("备份成功");
						$.ajax({
							url:"<%=request.getContextPath() %>/upgrade?method=upGradeAll",
							type:"post",
							dataType:"text",
							success:function(data){
								setTimeout("random()",100);
// 								console.log("date="+data);
								if(data.indexOf("升级成功")>=0){
									$("#versionFlg").val("");
									$("#versionMes").attr("style","color:blue;");
									$("#updateRun").attr("class","btn btn-default btn-sm");
							       	$("#versionMes").text("升级成功，请重启服务。");
								}else{
									$("#versionFlg").val("");
									$("#versionMes").attr("style","color:red;");
									$("#updateRun").attr("class","btn btn-default btn-sm");
							       	$("#versionMes").text("升级失败，请重新检查升级包。");
								}
								alert(data);
								$.unblockUI();
							},
							error:function(){
								console.log("错误啦");
								$.unblockUI();
							}
						});
					}else{
						console.log("备份失败~");
// 						$("#checkFlg").val("");
						$("#versionMes").attr("style","color:red;");
						$("#updateRun").attr("class","btn btn-default btn-sm");
				       	$("#versionMes").text("备份失败，请检查错误信息。");
						$.unblockUI();
					}
				},
				error:function(){
					console.log("错误啦");
					$.unblockUI();
				}
			});
		}
		
	});
	
	$("#restart").click(function(){

		if(!confirm("您确定要重启服务吗?")){
			return false;
		}
		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/upgrade?method=restart",
			type:"post",
			dataType:"text",
			success:function(data){
				console.log("重启="+data);
				window.location.reload();
			},
			error:function(){
				console.log("错误啦");
				$.unblockUI();
			}
		});
		
	});
	
	$("#remark").click(function(){
		console.log("remark .... ");
		$.ajax({
			url:"<%=request.getContextPath() %>/upgrade?method=showRemark",
			type:"post",
			dataType:"text",
			success:function(data){
				console.log("showRemark="+data);
			},
			error:function(){
				console.log("错误啦");
				$.unblockUI();
			}
		});
		
	});
	
	$("#rollbackSql").click(function(){

		createMark();
		$.ajax({
			url:"<%=request.getContextPath() %>/upgrade?method=rollbackSql",
			type:"post",
			dataType:"text",
			success:function(data){
				console.log("rollbackSql="+data);
				$("#showRemark").text(data);
			},
			error:function(){
				console.log("错误啦");
				$.unblockUI();
			}
		});
		
	});
	
	
});

//创建遮罩效果
function createMark01(){
	//console.log("createMark...");

	if ($.blockUI===undefined) {
		$.blockUI = common.blockUI;
	} 

	$.blockUI({ message: "系统备份中，请等待...",css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
        opacity: .5, 
        color: '#fff' 
    }});
}

//创建遮罩效果
function createMark02(){
	//console.log("createMark...");

	if ($.blockUI===undefined) {
		$.blockUI = common.blockUI;
	} 

	$.blockUI({ message: "系统升级中，请等待...",css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
        opacity: .5, 
        color: '#fff' 
    }});
}
</SCRIPT>
</body>
</html>