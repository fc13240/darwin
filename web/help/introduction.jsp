<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>帮助-使用说明</title>
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
					使用说明
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="page-header">
			<ol class="breadcrumb">
				<li><span class='glyphicon glyphicon-download'></span>&nbsp;支持</li>
				<li><a>使用说明</a></li>
			</ol>
		</div>
		<div class="page-body">
			<header>
				<h2>您需要的4个步骤</h2>
			</header>
			<ul class="introduction-steps">
				<li>
					<div class="introduction-step-img">
						<img src="/resources/site/img/intro-step1.png"/>
					</div>
					<div class="introduction-step-desc">
						<p>
							您需要有Hadoop集群环境，我们支持开源社区的Hadoop和CDH版本。
						</p>
					</div>
				</li>
				<li>
					<div class="introduction-step-img">
						<img src="/resources/site/img/intro-step2.png"/>
					</div>
					<div class="introduction-step-desc">
						<p>
							下载darwin安装包。
						</p>
					</div>
				</li>
				<li>
					<div class="introduction-step-img">
						<img src="/resources/site/img/intro-step3.png"/>
					</div>
					<div class="introduction-step-desc">
						<p>
							安装并配置darwin。
						</p>
					</div>
				</li>
				<li>
					<div class="introduction-step-img">
						<img src="/resources/site/img/intro-step4.png"/>
					</div>
					<div class="introduction-step-desc">
						<p>
							开始数据探索之旅。
						</p>
					</div>
				</li>
			</ul>
		</div>
	</div>
<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>