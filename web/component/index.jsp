<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsHistoryInfo"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsHistoryServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.stonesun.realTime.services.db.ProjectServices"%>
<%@page import="java.sql.SQLException"%>
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
	<%request.setAttribute("selectPage", Container.module_analytics);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					配置
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">配置</a> / 管理配置
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
			<!-- page header start -->
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								数据源管理
							</div>
						</div>
						<div class="col-xs-6 col-md-6">
							<div class="page-header-op r">
								<a class="btn btn-primary btn-new" href="<%=request.getContextPath() %>/datasources/add.jsp">新增数据源</a>
							</div>
							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="数据源名称、标签" name="keyword" value="${pager.params.keyword}" class="form-control" >
										<span class="input-group-btn">
											<button class="btn" type="submit">
												<span class="fui-search"></span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->
				
				<!-- page content start -->
			</div>
		</div>

	</div>
<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>