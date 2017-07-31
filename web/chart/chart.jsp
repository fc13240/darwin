<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>数据源列表</title>
<%@ include file="/resources/common.jsp"%>
<style>

.darwin-dashboard-container{position:relative;width:100%;height:600px;background-color:#000;}
.darwin-board{position:absolute;}
/**
.resizable{cursor:nwse-resize;}
**/
.draggable{
  width: 400px;
  height: 300px;
  margin: 10px;

  background-color: none;
  color: white;

  border: solid 0.4em #666;
  border-radius: 0.75em;
  padding: 3%;
box-sizing: border-box;
  -webkit-transform: translate(0px, 0px);
          transform: translate(0px, 0px);
}
.darwin-board-content{cursor:move;width:100%;height:100%;}

</style>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_chart);%>
	<%@ include file="/resources/common_menu.jsp"%>
	<div id="darwin-dashboard" class="darwin-dashboard-container" style="background:url('<%=request.getContextPath() %>/resources/images/upload/1.png') no-repeat 0 0;">
		
	</div>
	<%@ include file="/resources/common_vis.jsp"%>
	<script>
	var dashboard = new DarwinDashboard('darwin-dashboard', 1);
	var panels = [{'panelid':1, 'graphid':1, 'layout':{}}, {'panelid':2, 'graphid':2, 'layout':{}}, {'panelid':3, 'graphid':3, 'layout':{'top':'40px', 'left':'300px','width':'500px','height':'600px'}}];
	dashboard.init(panels);
	DarwinVis['dashboard'] = dashboard;
	/*
	var select_container_resize = false, select_container_move = false; 	//是否有移动标记
	var select_container_dom = null;	//移动的div
	var select_container_x, select_container_y;	//鼠标离控件左上角的相对位置
	var container_padding_x = 0, container_padding_y = 71;
	$('.darwin-board').mousedown(function(e){
	    select_container_resize = true;
	    select_container_move = false;
	    select_container_x = parseInt($(this).css("left"));
	    select_container_y = parseInt($(this).css("top"));
	    $(this).fadeTo(20, 0.5);//点击后开始拖动并透明显示
	    select_container_dom = $(this);
	});
	$('.darwin-board-content').mousedown(function(e){
		e.stopPropagation()
		select_container_move = true;
		select_container_resize = false;
	    select_container_x = e.pageX - parseInt($(this).css("left"));
	    select_container_y = e.pageY - parseInt($(this).css("top")) - container_padding_y;
	    $(this).fadeTo(20, 0.5);//点击后开始拖动并透明显示
	    select_container_dom = $(this);
	});
	$(document).mousemove(function(e){
		if (select_container_resize || select_container_move) {
			console.log('select_container_resize='+select_container_resize);
			console.log('select_container_move='+select_container_move);
			if(select_container_resize){
		        var x = e.pageX - select_container_x;//移动时根据鼠标位置计算控件左上角的绝对位置
		        var y = e.pageY - select_container_y - container_padding_y;
		        select_container_dom.css({height:y, width:x});//控件新位置
		    } else if (select_container_move) {
		    	var x = e.pageX - container_padding_x ;//移动时根据鼠标位置计算控件左上角的绝对位置
		        var y = e.pageY - container_padding_y;
		    	console.log(x);
		    	console.log(y);
		    	console.log(select_container_dom);
		        select_container_dom.parent().css({top:y, left:x});//控件新位置
		    }
		}
	}).mouseup(function(){
		select_container_resize = false;
		select_container_move = false;
		if (select_container_dom) {
			select_container_dom.fadeTo("fast", 1);//松开鼠标后停止移动并恢复成不透明
			select_container_dom = null;
		}
	});	*/
	</script>
</body>
</html>