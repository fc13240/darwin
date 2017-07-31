<%@page import="com.stonesun.realTime.services.db.ChartServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.ChartInfo"%>
<%@page import="com.stonesun.realTime.services.db.DashBoardServices"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>图表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_anaDashBoard);%>
	
	
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6">
				<div class="page-header-desc">
					<%
						request.setAttribute("dashBoardList",DashBoardServices.selectList());
						request.setAttribute("chartList",ChartServices.selectList());
						//request.setAttribute("chart",new ChartInfo());
					%>
					<select data-rule="required;quota" id="cur-dashboard" class="form-control">
						<c:forEach items="${dashBoardList}" var="item">
				           <option <c:if test='${chart.quota == item.name}'>selected="selected"</c:if>value="${item.name}">${item.name}</option>
				        </c:forEach>
					</select>
				</div>
				<div class="page-header-links">
					<input type="checkbox" id="dashboard-refresh-realtime"/>
					每隔
					<select id="time-interval">
						<option value="30000">30秒</option>
						<option value="60000">1分钟</option>
						<option value="3000">3秒</option>
						<option value="10000">10秒</option>
					</select>
					实时刷新	
				</div>
			</div>
			<div class="col-xs-6 text-right">
				<a class="btn btn-primary" id="btn-change-bg">更换背景</a>
				<a class="btn btn-primary" id="btn-add-text" data-toggle="modal" data-target="#add－text-modal">增加文字</a>
				<a class="btn btn-primary" id="btn-add-graph" data-toggle="modal" data-target="#add－graph-modal">增加图表</a>
				<a class="btn btn-primary" id="btn-full-screen">全屏显示</a>
				<a class="btn btn-primary" id="btn-export">导出</a>
			</div>
		</div>
	</div>
	<div id="darwin-dashboard" class="darwin-dashboard-container" style="background-image:url('<%=request.getContextPath() %>/resources/images/upload/1.png');">
	</div>
	<%-- <%@ include file="/resources/common_footer.jsp"%>	 --%>			
	<!-- 添加文本弹出层 -->
	<div class="modal fade" id="add－text-modal" tabindex="-1" role="dialog" aria-labelledby="add－text-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="add－text-modal-label">请输入您要显示的文字</h4>
				</div>
				<div class="modal-body">
					<!-- 这里是富文本编辑器 -->
					<textarea id="text-content" name="text-content" style="width:100%;height:300px;">
						请填写您的文本内容
					</textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="btn-add-text-confirm">确定</button>
				</div>
	    	</div>
		</div>
	</div>
	<!-- 添加图表弹出层 -->
	
<%-- 	<form action="<%=request.getContextPath() %>/panel?method=save" method="post" class="form-horizontal" role="form"> --%>
	
		<div class="modal fade" id="add－graph-modal" tabindex="-1" role="dialog" aria-labelledby="add－graph-modal-label" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="add－text-graph-label">请选择您要添加的图表</h4>
					</div>
					<div class="modal-body">
						<a href="<%=request.getContextPath() %>/chart/edit.jsp?method=add" target="_blank">添加图表</a>
						<!-- 这里是图表选择列表  TODO：后端需要给出 -->
	<!-- 					黄飞飞，给个图表列表呗，我先模拟成1了哦 -->
						<ul class="list-group" id="chartList">
							<c:forEach items="${chartList}" var="item">
								<li class="list-group-item">
									<input data-rule="checked" type="radio" name="chartType" value="${item.id}" 
									<c:if test='${chart.id == item.id}'>checked="checked"</c:if>/>${item.name}
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="btn-add-graph-confirm">确定</button>
					</div>
		    	</div>
			</div>
		</div>
<!-- 	</form> -->
	
	<input value="${panelArray}" id="_panelArray" type="hidden"/>
	<%@ include file="/resources/common_vis.jsp"%>
	<%@ include file="/resources/common_editor.jsp"%>
	<script>
		var dashboard = new DarwinDashboard('darwin-dashboard', $('#cur-dashboard').val(),function(paramsStyle){
			//面板移动
			$.ajax({
				url:"<%=request.getContextPath() %>/panel?method=savePanelStyleFunc",
				type:"post",
				data:{"style":JSON.stringify(paramsStyle)},
				dataType:"text",
				success:function(data, textStatus){
					//console.log("savePanelStyleFunc...success");
				},
				error:function(error){
					console.log(error);
				}
			});
		});
		//TODO:这里需要根据选中的仪表盘给出该仪表盘对应的面板
		var panels = eval('(' + <%=request.getAttribute("panelArray")%> + ')');//[{'panelid':1, 'graphid':1, 'layout':{}}, {'panelid':2, 'graphid':2, 'layout':{}}, {'panelid':3, 'graphid':3, 'layout':{'top':'40px', 'left':'300px','width':'500px','height':'600px'}}];
		dashboard.init(panels);
		DarwinVis['dashboard'] = dashboard;
		
		$(function(){
			$("#btn-add-graph-confirm").click(function(){
				var _dashBoard = 1;
				var _chartId = $("#chartList :radio:checked").attr("value");
				
				submitReq(_dashBoard,_chartId,null);
			});
			
			$("#btn-add-text-confirm").click(function(){
				var _dashBoard = 1;
				var _html = $("#text-content").val();
				
				submitReq(_dashBoard,null,_html);
			});
			
		});
		
		//ajax给面板增加图表和文字
		function submitReq(_dashBoard,_chartId,_html){
			$.ajax({
				url:"<%=request.getContextPath() %>/panel?method=save",
				type:"post",
				data:{"dashBoardId":_dashBoard,"chartId":_chartId,"html":_html},
				dataType:"text",
				success:function(data, textStatus){
					console.log("submitReq success!");
					location.reload();
				},
				error:function(err){
					alert("提交请求出错！");
					console.log(err);
				}
			});
		}
	</script>
</body>
</html>