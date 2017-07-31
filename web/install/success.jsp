<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Darwin Install(安装成功)</title>
<%@ include file="/resources/common.jsp"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/style.css">

</head>
<body>
	<%-- 	<%@ include file="/resources/common_menu.jsp"%> --%>

	<div class="container"
		style="margin-top: 51px; min-height: 500px; text-align: center;">
		<div class="row">


			<form action="#" class="form-horizontal" role="form" method="post">

				<div class="form-group">
					<div class="col-sm-2">&nbsp;</div>
					<div class="col-sm-8" style="text-align: center;">
						<h5>安装成功</h5>
					</div>
					<div class="col-sm-2"></div>
				</div>

				<div class="form-group" style="text-align: center;">
					<div class="col-sm-2">&nbsp;</div>
					<div class="col-sm-8" style="text-align: center;">
						<table class="table table-bordered"
							style="background-color: white;">
							<tr>
								<td>Darwin系统地址</td>
								<td><a id="darwinWeb" href="#"></a>
								</td>
							</tr>
							<tr>
								<td>账号密码</td>
								<td>admin/admin</td>
							</tr>
							<tr>
								<td>相关文档</td>
								<td >
									
									<a id="doc1" href=""></a><br>

									<a id="doc2" href=""></a><br>

									<a id="doc3" href=""></a><br>

								</td>
							</tr>
							<tr style="display:none;">
								<td>开发人员</td>
								<td>
									名单不分先后...xxx，xxxxx
								</td>
							</tr>
						</table>
					</div>
					<div class="col-sm-2">&nbsp;</div>
				</div>
			</form>
		</div>
	</div>
	
	<div style="display: none;" id="rootPath">http://<%=request.getServerName() %>:<%=request.getServerPort()%></div>
	
	<script type="text/javascript">
	$(function(){
 		var addr = $("#rootPath").text();//window.location.origin;
 		console.log("addr = " +addr);
 		$("#darwinWeb").attr("href",addr);
		$("#darwinWeb").text(addr);

		var doc1_addr = addr + "/doc/Darwin产品手册.pdf";
		$("#doc1").attr("href",doc1_addr);
		$("#doc1").text(doc1_addr);

		var doc2_addr = addr + "/doc/Darwin白皮书.pdf";
		$("#doc2").attr("href",doc2_addr);
		$("#doc2").text(doc2_addr);

		var doc3_addr = addr + "/doc/Darwin操作手册.pdf";
		$("#doc3").attr("href",doc3_addr);
		$("#doc3").text(doc3_addr);
	});
	</script>
	<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>