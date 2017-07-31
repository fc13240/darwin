<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>帮助-产品历程</title>
<%@ include file="/resources/common.jsp"%>
<style>
	header h2{font-size:28px;color:#01b6cb;line-height:1.1em;}
	ul.introduction-steps{padding:20px 0 20px;}
	ul.introduction-steps li{display:inline-block;vertical-align:top;padding-right:5%;width:24%;}
	.introduction-step-desc{margin-top:10px;}
	.introduction-step-desc p{color:#666;font-size:16px;line-height:2em;}
</style>
</head>
<body>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					产品历程
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="page-header">
			<ol class="breadcrumb">
				<li><span class='glyphicon glyphicon-download'></span>&nbsp;关于我们</li>
				<li><a>产品历程</a></li>
			</ol>
		</div>
		<div class="page-body">
			<img src="/resources/site/img/milestone.png" style="width:100%;"/>
		</div>
	</div>
<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>