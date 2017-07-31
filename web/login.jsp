<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.servlet.UserServlet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Darwin是基于Spark,无需代码开发的大数据业务支撑平台。">
<meta name="keywords" content="Hadoop,Spark,Big data">
<meta name="author" content="idataworks">
<meta name="application-name" content="idataworks.com">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>用户登录</title>
<%@ include file="/resources/common.jsp"%>
<link href="<%=request.getContextPath() %>/resources/site/css/login.css" rel="stylesheet">
</head>
<body>
	<%request.setAttribute("currentTime", UserServlet.getCurrentTime());%>
    <div class="row" style="margin-top:2px;">
		<div class="col-xs-9 col-md-9">
			<img  width="350px;" height="100px;" src="<%=request.getContextPath() %>/resources/site/img/logo-union1.png"/>
		</div>
		<div class="col-xs-3 col-md-3" style="text-align:center;line-height:89px;">
			<span style="font-size:18px;color:#617276;text-align:center;">${currentTime }</span>
		</div>
		
	</div>
	<div id="header" style="margin-top:5px;">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-6 text-center" style="margin-top:100px;">
<%-- 					<img src="<%=request.getContextPath() %>/resources/site/img/login-desc.png"/> --%>
				</div>
				<div class="col-xs-12 col-md-5">
					<div id="form-wrapper">
						<form action="<%=request.getContextPath()%>/manage/user?method=doLogin" class="form-horizontal" role="form" method="post">
							<div class="form-group login-from-group">
								<b class="form-account"></b>
								<input type="text" id="username" name="username" class="form-control" placeholder="请输入账号" required autofocus>
							</div>
							<div class="form-group login-from-group">
								<b class="form-passwd"></b>
								<input type="password" id="password" name="password" class="form-control" placeholder="请输入密码" required>
							</div>
<!-- 							<div class="form-group" style="text-align:left;color:#999;font: 900;"> -->
<!-- 							只读账号：demo/demo123 -->
<!-- 							</div> -->
							<div class="form-group">
								<button class="btn btn-primary  btn-block" type="submit">登录</button>
							</div>
							<%
								if(request.getSession().getAttribute("loginErrMsg")!=null){
									String loginErrMsg = request.getSession().getAttribute("loginErrMsg").toString();
									request.setAttribute("loginErrMsg", loginErrMsg);
									request.getSession().removeAttribute("loginErrMsg");
								}
							%>
							<c:if test="${not empty loginErrMsg}">
								<div class="error text-center">${loginErrMsg}</div>
							</c:if>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="login-slogan" id="how" name="how">
		<h1>系统功能介绍</h1>
	</div>
	<div class="function-wrapper">
		<div class="function-item">
			<div class="function-img">
				<img src="/resources/site/img/function-1.png"/>
			</div>
			<div class="function-desc">
				<h2>数据汇集</h2>
				<p>
					支持实时、非实时模式，通过界面配置方式将远程数据汇集入平台。实时包括Tcp/Udp,Syslog,SNMP,Flume,SparkStreaming等数据源的接入；非实时包括FTP,FTP增量获取,RDB数据,SCP,Spider互联网数据爬取等方式。对于特殊的数据源，系统支持采用自定义脚本方式将数据接入。
				</p>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="function-wrapper even">
		<div class="function-item">
			<div class="function-img">
				<img src="/resources/site/img/function-2.png"/>
			</div>
			<div class="function-desc">
				<h2>清洗转换</h2>
				<p>
					采用Spark内存计算技术，通过界面配置方式，将数据进行数据切分、多条件组合的行列筛选、列函数转换、字典映射、多份数据的数据关联(类似DB的JOIN连表)和数据合并,编码转换等操作，并支持结果的输出路由。列转换函数集合，包括字符串处理类、表达式运算类、时间处理类、URL处理类、GEO类和自定义类。对于系统尚未支持的列处理，可以通过自定义函数实现。
				</p>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="function-wrapper">
		<div class="function-item">
			<div class="function-img">
				<img src="/resources/site/img/function-3.png"/>
			</div>
			<div class="function-desc">
				<h2>分析挖掘</h2>
				<p>组件化Spark分析：通过界面配置方式对数据多维统计分析，采用Spark技术实现了RDB中的行列过滤,Distinct,GroupBy,
Count/SUM/MAX/MIN/AVG等聚合函数,Having过滤等BigDB交互式分析：支持标准SQL对数据的增删改查操作，底层采用Hbase存储,支持水平无限扩展，可以作为交互式分析工具和传统BI的底层高性能分析型DB组件化ML分析：组件化方式支持常用的分类、聚类、分词、文本挖掘、推荐算法等机器学习算法
				</p>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="function-wrapper even">
		<div class="function-item">
			<div class="function-img">
				<img src="/resources/site/img/function-6.png"/>
			</div>
			<div class="function-desc">
				<h2>可视化</h2>
				<p>
					支持对平台上的文件、大数据库、检索数据，进行实时按需的展示。目前提供趋势图、饼图、柱状体、分页表、地图、词云图等多种动态展现方式，且支持根据条件的数据展示可视化支持多个图表、面板之间的条件触发；支持实时数据的自动刷新展示。
				</p>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div id="docs" name="docs">
	<%@ include file="/resources/common_footer.jsp"%>
	</div>
	<script>
	$('.navbar-nav a').click(function(){
	  var id = $(this).attr('href');
	  $("html,body").animate({scrollTop: $(id).offset().top}, 1000);
	});
	function readonlyLogin(){
		console.log("readonlyLogin...");
		$("#username").val("readonly");
		$("#password").val("readonly");
		//$("input[type='submit']").trigger("submit");
		$("form:first").submit();
	}
	</script>
</body>
</html>
