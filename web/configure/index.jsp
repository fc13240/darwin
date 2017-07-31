<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>配置</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
<%request.setAttribute("selectPage", Container.module_configure);%>
<%
	UserInfo userInfo1 = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo));
	String flag="0";
	if(userInfo1!=null){
		if(!"admin".equals(userInfo1.getUsername())){
			flag="1";
		}
	}
	request.setAttribute("flag", flag);
%>

	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					配置
				</div>
				<!-- 
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">配置</a> / 管理配置
				</div>
				 -->
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%-- <%@ include file="/configure/leftMenu.jsp"%> --%>
			</div>
			<div class="col-md-9">
				<div class="col-md-12">
					<div class="page-header-desc">
						配置向导
					</div>
					<div class="row">
						<div class="col-md-4 text-center darwin-thumb">
							<div class="darwin-thumb-wrapper">
								<a href="<%=request.getContextPath()%>/flow/init.jsp"">
									<img class="img-circle" src="<%=request.getContextPath() %>/resources/site/img/create-flow.png" />
									<h4>创建流程(代码编译测试)</h4>
									<p>
										您可以通过创建流程，完成数据的获取，分析，导出。
										
									</p>
								</a>
								<ul>
									<li>
										<a href="/flow/init.jsp?id=1">我要从FTP远程获取数据</a>
									</li>
									<li>
										<a href="/flow/init.jsp?id=2">我要实时监控远程文件</a>
									</li>
									<li>
										<a href="/flow/init.jsp?id=3">我要从数据库导入导出数据</a>
									</li>
									<li>
										<a href="/flow/init.jsp?id=4">我要清洗HDFS上的数据</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 text-center darwin-thumb">
							<div class="darwin-thumb-wrapper">
								<a href="<%=request.getContextPath()%>/configure/hdfsManage.jsp">
									<img class="img-circle" src="<%=request.getContextPath() %>/resources/site/img/data-manage.png"/>
									<h4>管理数据</h4>
									<p>
										您可以方便的管理hdfs，hbase，索引中的数据
									</p>
								</a>
								<ul>
									<li>
										<a href="/configure/hdfsManage.jsp">我要管理HDFS上的数据</a>
									</li>
									<li>
										<a href="/analytics/edit.jsp?linktype=Hbase">我要管理BigDB的数据</a>
									</li>
									<li>
										<a href="/es?method=index">我要管理BigSearch的数据</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 text-center darwin-thumb">
							<div class="darwin-thumb-wrapper">
								<a href="<%=request.getContextPath()%>/search/dashboard.jsp">
									<img class="img-circle" src="<%=request.getContextPath() %>/resources/site/img/data-view.png"/>
									<h4>图表查看</h4>
									<p>
										您可以通过检索或仪表盘，使用适合的方式展现您的数据。
									</p>
								</a>
								<ul>
									<li>
										<a href="/search/dashboard.jsp">我要检索数据</a>
									</li>
<!-- 									<li> -->
<!-- 										<a href="http://192.168.2.50:8000/search/dashboard.jsp?isAna=true">我要查看不同数据源的数据</a> -->
<!-- 									</li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if>
</body>
</html>