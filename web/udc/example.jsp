<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>下载区</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_udc);%>
	<%request.setAttribute("topId", "1");%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					自定义组件下载专区
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
		<%-- <c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
<!-- 				<div class="page-header-desc"> -->
<!-- 						<span class='glyphicon glyphicon-download'></span>&nbsp;自定义组件（下载列表） -->
<!-- 				</div> -->
				<div class="page-header">
					<ol class="breadcrumb">
						<li><span class='glyphicon glyphicon-download'></span>&nbsp;自定义组件帮助列表</li>
						<li><a target="_blank" href="<%=request.getContextPath() %>/udc?method=index">自定义组件管理列表</a></li>
						<li><a target="_blank" href="<%=request.getContextPath() %>/udc?method=edit">新增自定义组件</a></li>
					</ol>
				</div>
				<div>【帮助文档下载】</div>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th style="width: 30%;">&nbsp;文档</th>
							<th style="width: 10%;">版本</th>
							<th style="width: 15%;">格式/大小</th>
							<th style="width: 10%;">更新日期</th>
							<th style="width: 40%;">详情</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><a  href="<%=request.getContextPath() %>/resources/udc/自定义组件.docx">自定义实现帮助文档.docx</a></td>
							<td>1.0.0</td>
							<td>
								<a href="<%=request.getContextPath() %>/resources/udc/自定义组件.docx">
<!-- 									<span class='glyphicon glyphicon-download-alt'></span> -->
									<img src='<%=request.getContextPath() %>/resources/images/word.png'>
								</a>253 KB &nbsp;
							</td>
							<td>2015-07-07</td>
							<td>详细介绍三种自定义组件的实现。</td>
						</tr>
					</tbody>
				</table>
				<br>
				<div>【示例依赖包下载】</div>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th style="width: 30%;">&nbsp;文件</th>
							<th style="width: 10%;">版本</th>
							<th style="width: 15%;">格式/大小</th>
							<th style="width: 10%;">更新日期</th>
							<th style="width: 40%;">详情</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><a href="<%=request.getContextPath() %>/resources/udc/示例代码.zip">示例代码.zip</a></td>
							<td>1.0.0</td>
							<td>zip 3 KB</td>
							<td>2015-07-07</td>
							<td>java代码例子。</td>
						</tr>
						<tr>
							<td><a href="<%=request.getContextPath() %>/resources/udc/自定义组件依赖Jar包（不包含Spark）.zip">自定义组件依赖Jar包（不包含Spark）.zip</a></td>
							<td>1.0.0</td>
							<td>zip 3,683 KB</td>
							<td>2015-07-07</td>
							<td>创建自定义组件所需要的所有依赖包,每个文件都比较小,统一放在压缩包里。</td>
						</tr>
						<tr>
							<td><a target="_blank" href="http://archive.apache.org/dist/spark/spark-1.2.0/spark-1.2.0-bin-hadoop2.4.tgz">spark组件依赖的jar包(官网下载)</a></td>
							<td>1.0.0</td>
							<td>tgz 209 MB</td>
							<td>2015-07-07</td>
							<td>spark的jar包,这里给出官网连接，请自行下载。<br>下载后找到我们需要的以下2个即可：<br>spark-assembly-1.2.0-hadoop2.4.0.jar,<br>spark-examples-1.2.0-hadoop2.4.0.jar</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
<%-- 	<c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
</body>
</html>
