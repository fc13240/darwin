<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>添加数据源</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					选择数据添加方式
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/datasources?method=index">数据源管理</a> / 选择数据的添加方式
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-4 text-center darwin-thumb">
				<a href="<%=request.getContextPath() %>/datasources/upload/files.jsp">
					<img class="img-circle" src="<%=request.getContextPath() %>/resources/site/img/upload-bg.png">
					<h4>数据上传</h4>
					<p>本机数据的上传，一般用于一次性数据。</p>
				</a>
			</div>
			<div class="col-md-4 text-center darwin-thumb">
				<a href="<%=request.getContextPath() %>/datasources/conn.jsp?source=offLine&sourceType=ftp">
					<img class="img-circle" src="<%=request.getContextPath() %>/resources/site/img/offline-bg.png">
					<h4>离线获取</h4>
					<p>远程周期性获取数据，一般用于线上按周期产生的数据的汇集。支持远程目录、文件数据获取，支持脚本。</p>
				</a>
			</div>
			<div class="col-md-4 text-center darwin-thumb">
				<a href="<%=request.getContextPath() %>/datasources/conn.jsp?source=realTime&sourceType=logstash">
<!-- 				<a href="#"> -->
					<img class="img-circle" src="<%=request.getContextPath() %>/resources/site/img/realtime-bg.png">
					<h4>实时数据</h4>
					<p>用于实时监控服务器上的本机文件/目录、TCP/UDP、Flume、Logstash数据流等。</p>
				</a>
			</div>
		</div>
		<div class="well">
			<label>温馨提示：</label>
			<p>
				如果您是初次使用平台的用户，建议您先使用“数据上传”的方式。
			</p>
			<p>
				如果您的数据需要实时获取并被处理，如syslog，实时交易数据等，建议您选择“实时数据”的方式。
			</p>
			<p>
				如果您的数据周期性的产生，并且对实时处理要求不是很高，如每天产生的apache日志，数据库日志等，建议您选择“离线获取”的方式。
			</p>
		</div>
	</div>
	<%@ include file="/resources/common_footer.jsp"%>	
</body>
</html>