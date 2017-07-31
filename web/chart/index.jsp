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
<style>
.darwin-dashboard-container{position:relative;width:100%;height:600px;background-color:#000;}
.darwin-board{position:absolute;}
.draggable{width:400px;height:300px;margin:10px;background-color:none;color:white;border:solid 0.4em #666;border-radius:0.75em;box-sizing:border-box;-webkit-transform:translate(0px, 0px);transform:translate(0px, 0px);}
.darwin-board-content{cursor:move;width:100%;height:100%;}
</style>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_chart);%>
	
	<div style="padding:0 50px;">
		<div class="row">
			<div class="col-xs-6">
				<select id="cur-dashboard">
					<!-- TODO：需要后端给出 -->
					<option value="1">仪表盘示例1</option>
				</select>
			</div>
			<div class="col-xs-6">
				<a class="btn btn-primary" id="btn-change-bg">更换背景</a>
				<a class="btn btn-primary" id="btn-add-text" data-toggle="modal" data-target="#add－text-modal">增加文字</a>
				<a class="btn btn-primary" id="btn-add-graph" data-toggle="modal" data-target="#add－graph-modal">增加图表</a>
				<a class="btn btn-primary" id="btn-full-screen">全屏显示</a>
				<a class="btn btn-primary" id="btn-export">导出</a>
			</div>
		</div>
		<!-- TODO:这块需要抽取出去的 -->
		<div class="row">
			<input type="checkbox" id="dashboard-refresh-realtime"/>
			每隔
			<select id="time-interval">
				<option value="30000">30秒</option>
				<option value="60000">1分钟</option>
				<option value="1000">1秒</option>
				<option value="10000">10秒</option>
			</select>
			实时刷新
			<select id="time-select">
				<option value="today">今天</option>
				<option value="week">本周</option>
				<option value="month">本月</option>
			</select>
			<input type="text" value="开始时间" id="time-start"/>
			<input type="text" value="当前时间" id="time-end"/>
		</div>
	</div>
	<div id="darwin-dashboard" class="darwin-dashboard-container" style="background:url('<%=request.getContextPath() %>/resources/images/upload/1.png') no-repeat 0 0;">
	</div>
						
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
	<div class="modal fade" id="add－graph-modal" tabindex="-1" role="dialog" aria-labelledby="add－graph-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="add－text-graph-label">请选择您要添加的图表</h4>
				</div>
				<div class="modal-body">
					<!-- 这里是图表选择列表  TODO：后端需要给出 -->
					黄飞飞，给个图表列表呗，我先模拟成1了哦
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="btn-add-graph-confirm">确定</button>
				</div>
	    	</div>
		</div>
	</div>
	<%@ include file="/resources/common_vis.jsp"%>
	<%@ include file="/resources/common_editor.jsp"%>
	<script>
		var dashboard = new DarwinDashboard('darwin-dashboard', $('#cur-dashboard').val());
		//TODO:这里需要根据选中的仪表盘给出该仪表盘对应的面板
		var panels = [{'panelid':1, 'graphid':1, 'layout':{}}, {'panelid':2, 'graphid':2, 'layout':{}}, {'panelid':3, 'graphid':3, 'layout':{'top':'40px', 'left':'300px','width':'500px','height':'600px'}}];
		dashboard.init(panels);
		DarwinVis['dashboard'] = dashboard;
	</script>
</body>
</html>