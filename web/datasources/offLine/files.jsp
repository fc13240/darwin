<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.Map"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page import="com.stonesun.realTime.services.db.bean.DatasourceInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.ProjectInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>数据源文件规则设置</title>
<%@ include file="/resources/common.jsp"%>

<script src="<%=request.getContextPath() %>/resources/My97DatePicker/WdatePicker.js"></script>

</head>
<body>
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					添加离线数据源
				</div>
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/datasources?method=index">数据源管理</a> / <a href="<%=request.getContextPath() %>/datasources/add.jsp">选择数据的添加方式</a> / 添加离线数据源
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<%
					String id = request.getParameter("id");
					String source = request.getParameter("source");
					String sourceType = request.getParameter("sourceType");
					DatasourceInfo ds = null;
					JSONObject obj = null;
					Map<String,String> mapp = null;
					if(StringUtils.isNotBlank(id)){
						//保存上一步的配置写入DB。
						String selectConnId = request.getParameter("selectConnId");
						System.out.println("selectConnId="+selectConnId);
						ds = DatasourceServices.selectById(id);
						
						obj = JSON.parseObject(ds.getSourceDetail());
						obj.put("connId", selectConnId);
						
						//connId存在则更新
						if(StringUtils.isNotBlank(selectConnId)){
							DatasourceInfo dsParam = new DatasourceInfo();
							dsParam.setId(Integer.valueOf(id));
							dsParam.setSourceDetail(JSON.toJSONString(obj));
							dsParam.setSourceType(sourceType);
							DatasourceServices.update_sourceDetail(dsParam);
						}
						
						source = ds.getSource();
						sourceType = ds.getSourceType();
						
						request.setAttribute("mapp",obj);
						request.setAttribute("getMethod",obj.get("getMethod"));
						
						//if(JSON.parseObject(ds.getSourceDetail()).get("fileRule")!=null){
							//Map<String,String> fileRule = (Map<String,String>)JSON.parseObject(ds.getSourceDetail()).get("fileRule");
							//request.setAttribute("fileRule",fileRule.get("rule"));
							//request.setAttribute("getMethod",fileRule.get("getMethod"));
						//}
					}else{
						source = request.getParameter("source");
						sourceType = request.getParameter("sourceType");
					}
					
					request.setAttribute("source",source);
					request.setAttribute("sourceType",sourceType);
					
					String selectConnId = request.getParameter("selectConnId");
					DatasourceServlet.getDsBySession(session).getSourceDetailMap().put("connId", selectConnId);
				%>
				<%!
				String getIdParam(HttpServletRequest request){
					String id = request.getParameter("id");
					if(StringUtils.isNotBlank(id)){
						return "&id="+id;
					}
					return "";
				}
				%>
				
				<%!
				String selectRadio(HttpServletRequest request,String c1){
					String _id = request.getParameter("id");
					if(StringUtils.isNotBlank(_id) && Integer.valueOf(_id.toString()) > 0){
					//if(_id!=null && StringUtils.isNotBlank(_id.toString()) && Integer.valueOf(_id.toString()) > 0){
						String getMethod = request.getAttribute("getMethod").toString();
						if(getMethod.equals(c1)){
							System.out.println("_id="+_id+",c1="+c1+",getMethod="+getMethod);
							return "checked";
						}
					}else{
						if(c1.equals("increment")){
							return "checked";
						}
					}
					return "";
				}
				%>
				<form action="<%=request.getContextPath() %>/datasources?method=toFmt&source=${source}&sourceType=${sourceType}<%=getIdParam(request) %>" class="form-horizontal" role="form" method="post">
					<div class="form-group">
						<label for="" class="col-sm-2 control-label"></label>
						<div class="col-sm-5">
							<ul class="darwin-page-op-nav">
<!-- 								<li> -->
<!-- 									<a>数据连接设置</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a class="current">格式设置</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a>信息确定</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a>完成</a> -->
<!-- 								</li> -->
								<li>
									<a href="javascript:history.go(-1);">返回</a> 
								</li>
								<li>
									<input type="submit" value="下一步" class="btn btn-primary"/>
								</li>
							</ul>
						</div>
					</div>
					<div class="form-group">
						<label for="fileRule" class="col-sm-2 control-label">文件规则</label>
						<div class="col-sm-5">
							<input data-rule="required;fileRule" value="${mapp.rule}" name="fileRule" class="form-control input-sm" />
							<address>
							  <strong>说明</strong>
							    <p>如果是文件名中带日期，Darwin支持使用时间格式，具体格式为：％H（小时00..23）, %M(分00..59)，%Y(年，例如2015)，%m(月01..12)，%d(一个月的第几天01..31) ，例如：access.23.2015_01_01.log 可以配置为 access.%H.%Y_%m_%d.log，更多时间格式请参考shell日期格式。</p>
							</address>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								请输入您的文件在服务器上的全路径，如/home/user/aaa.txt。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="ftp_range_type" class="col-sm-2 control-label">类型</label>
						<div class="col-sm-2">
							<select data-rule="required;priority" id="ftp_range_type" name="ftp_range_type" class="form-control ">
								<%
									request.setAttribute("ftp_range_type", DataCache.ftp_range_type);
								%>
								<c:forEach items="${ftp_range_type}" var="item">
						           <option <c:if test='${mapp.range_type == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
						        </c:forEach>
							</select>
						</div>
						<div class="col-sm-3" id="timeRangeDiv">
							<div id="StartStopTime" style="display: none;">
								<input data-rule="required;stop_time" placeholder="开始时间" class="form-control Wdate" id="start_time" name="start_time" value="${mapp.start_time}" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'stop_time\')||\'2020-10-01\'}'})"/>
								~<input data-rule="required;stop_time" placeholder="结束时间" class="Wdate form-control" id="stop_time" name="stop_time" value="${mapp.stop_time}" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'start_time\')}',maxDate:'2020-10-01'})"/>
							</div>
							<div id="dy_StartStopTime" style="display: none;">
								<input data-rule="required;dy_startTime" placeholder="开始时间" class="form-control" id="dy_startTime" name="dy_startTime" value="${mapp.start_time}"/>
								~<input data-rule="required;dy_stopTime" placeholder="结束时间" class="form-control" id="dy_stopTime" name="dy_stopTime" value="${mapp.stop_time}"/>
							</div>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								类型为无，则获取数据时没有时间范围。<br>
								类型为固定，则获取指定时间范围的文件，前提是文件规则包含时间模式。<br>
								类型为动态，则获取动态时间范围的文件，如文件规则设置为/home/test/test-access_log_%Y%m%d%H 开始时间为-2 H, 结束时间为 -1 H, 假设每小时的30分获取数据，则在2015-01-01 14:30分获取数据时，则会获取名为test-access_log_2015010112和test-access_log_2015010113的文件。
							</p>
						</div>
					</div>
					<div class="form-group">
						<label for="increment" class="col-sm-2 control-label">获取方式</label>
						<div class="col-sm-5">
							<div class="radio">
							  <label>
							    <input type="radio" id="increment" name="getMethod" value="increment">每次获取增量数据
							  </label>
							</div>
							<div class="radio">
							  <label>
							    <input type="radio" id="full" name="getMethod" value="full">每次获取全量数据
							  </label>
							</div>
						</div>
						<div class="col-sm-5">
							<p class="help-block">
								每次获取增量数据：每次只是增量获取有变化的数据<br>
								每次获取全量数据：每次将符合条件的文件全部获取过来。
							</p>
						</div>
					</div>
					<input id="getMethod0" value="${getMethod}" type="hidden"/>
				</form>
			</div>
		</div>
		
		<script>
			$(function(){
				var _StartStopTime = $("#StartStopTime").clone(true);				
				var _dy_StartStopTime = $("#dy_StartStopTime").clone(true);	
				$("#StartStopTime").remove();
				$("#dy_StartStopTime").remove();
				
				$("#ftp_range_type").change(function(){
					timeRangeToggle();
				});
				
				var getMethod0 = $("#getMethod0").val();
				if(getMethod0=='increment'){
					$("#increment").attr("checked",true);
				}else{
					$("#full").attr("checked",true);
				}
				
				function timeRangeToggle(){
					var val = $("#ftp_range_type").val();
					$("#timeRangeDiv").html("");
					
					if(val=='fix'){
						$("#timeRangeDiv").html($(_StartStopTime).html());
					}else if(val=='dynamic'){
						$("#timeRangeDiv").html($(_dy_StartStopTime).html());
					}
				}
				
				timeRangeToggle();
			});
			
			
		</script>

	</div>
	<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>