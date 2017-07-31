<%@page import="com.stonesun.realTime.services.db.UdcHistoryServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.UdcHistoryInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.UdcInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.UdcServices"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>自定义</title>
<%@ include file="/resources/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/kindeditor-4.1.10/themes/default/default.css"/>


</head>
<body>
	<%request.setAttribute("selectPage", Container.module_udc);%>
	<%session.setAttribute("files", "yyyyyyy");%>
	<%session.setAttribute("versionHistory", "");%>
	<%request.setAttribute("topId", "1");%>

	<!-- page header start -->
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					自定义组件管理
				</div>
			</div>
		</div>
	</div>
	<!-- page header end -->
	
	<div class="container mh500">
		<div class="row">
		<c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if>
			<div class="col-md-9">
				<div class="page-header">
					<ol class="breadcrumb">
						<li><a href="<%=request.getContextPath() %>/udc?method=index">自定义组件管理列表</a></li>
						<li class="active">自定义组件新增编辑</li>
						<li class="active">&nbsp;帮助文档<a target="_blank" href="<%=request.getContextPath() %>/udc/example.jsp" >【点击查看示例代码】</a></li>
					</ol>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<%
// 								try{
								String id = request.getParameter("id");
								String versionHistory = "";
								UdcHistoryInfo udcHistoryInfo = new UdcHistoryInfo();
								UdcInfo udcInfo = new UdcInfo();
								if(StringUtils.isNotBlank(id)){
									udcInfo = UdcServices.selectById(id);
									if(StringUtils.isNotBlank(udcInfo.getParams())){
										JSONArray params=JSON.parseArray(udcInfo.getParams());
										request.setAttribute("params", params);
									}
									udcHistoryInfo = UdcHistoryServices.selectVersionById(id);
									if(udcHistoryInfo != null){
										versionHistory=udcHistoryInfo.getVersion();
									}
								}else{
									udcInfo = new UdcInfo();
								}
								request.setAttribute("versionHistory", versionHistory);
								request.setAttribute("udc", udcInfo);
								request.setAttribute("id",id);
// 								}catch(Exception e){
// 									e.printStackTrace();
// 								}
							%>
							<form 
								action="<%=request.getContextPath() %>/udc?method=testError"
								class="form-horizontal" role="form" method="post">
								<input value="${udc.id}" name="id" id="id" type="hidden"/>
								<div class="form-group">
									<label for="" class="col-sm-2 control-label"></label>
									<div class="col-sm-4">
										<ul class="darwin-page-op-nav">
											
											<li>
												<a href="javascript:history.go(-1);">返回</a> 
											</li>
											<li>
												<input type="submit" value="保存" class="btn btn-primary"/>
											</li>
										</ul>
									</div>
								</div>
								<div class="form-group">
									<label for="version" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>版本</label>
									<div class="col-sm-4">
										<input data-rule="required;length[1~45]" id="version" name="version" <c:if test='${empty udc.version}'>value="V.1.0.0"</c:if>value="${udc.version}" class="form-control" placeholder="版本号"/>
										<input id="versionOld" name="versionOld" value="${udc.versionOld}" type="hidden"/>
									</div>
									<c:if test="${!empty versionHistory}" >
										<p class="help-block">
											上一个版本为:${versionHistory }
										</p>
									</c:if>
								</div>
								<div class="form-group">
									<label for="remark" class="col-sm-2 control-label">描述</label>
									<div class="col-sm-6">
										<input  id="remark" name="remark" value="${udc.remark}" class="form-control" placeholder="描述"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-2">
										<button class="btn btn-primary" type="button" id="newRow">添加输入参数</button>
									</div>
									<p class="help-block">
										注：不填则无输入，或无输出
									</p>
								</div>
								<div class="form-group">
									<table class="table table-bordered table-hover" id="ruleTable" style="margin-bottom: 100px;">
										<tr class="success">
											<td style="width:5%">序号</td>
											<td>参数样式</td>
											<td style="width:300px；"><span class="redStar">*&nbsp;</span>参数名称</td>
											<td>参数中文描述</td>
											<td style="width:10%">操作</td>
										</tr>
										<c:forEach var="stu" items="${params}" varStatus="status">
											<tr>
												<td>${status.index + 1}</td>
												<td>
													<select class="form-control" name="pamType" id="pamType" onchange="columnTypeChange0(this)">
														<%
															session.setAttribute("types", DataCache.pamTypeList);
														%>
<!-- 														<option value="">--选择类型--</option> -->
														<c:forEach items="${types}" var="list">
												           <option <c:if test='${list.key == stu.type}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
												        </c:forEach>
													</select>
												</td>
												<td style="width:300px；">
													<input name='pamName' class='form-control' value="${stu.name}"/>
													<br>
													<c:choose>
														<c:when test="${stu.type eq 'select'}">
															<div id="selectType" >
																<button class="btn btn-xs btn-primary" type="button" onclick="addRow2(this,${status.index + 1});">添加下拉菜单内容</button>
																<table class="table table-bordered table-hover" id="selectTable">
																	<tr class="success">
																		<td>key</td>
																		<td>value</td>
																		<td style="width:20%">操作</td>
																	</tr>
																	<c:forEach var="stu001" items="${stu.select}" varStatus="status01">
																		<tr>
																			<td>
																				<input name='selectKey${status.index + 1}' class='form-control' value="${stu001.key}" />
																			</td>
																			<td>
																				<input name='selectValue${status.index + 1}' class='form-control' value="${stu001.value}" />
																			</td>
																			<td style="width:20%">
																				<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
																			</td>
																		</tr>
																	</c:forEach>
																</table>
															</div>
														</c:when>
														<c:otherwise>
															<div id="selectType" style="display:none;">
																<button class="btn btn-xs btn-primary" type="button" onclick="addRow2(this,${status.index + 1});">添加下拉菜单内容</button>
																<table class="table table-bordered table-hover" id="selectTable">
																	<tr class="success">
																		<td>key</td>
																		<td>value</td>
																		<td>操作</td>
																	</tr>
																</table>
															</div>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<input name='pamRemark' class='form-control' value="${stu.remark}" />

												</td>
												<td style="width:100px">
													<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>