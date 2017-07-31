<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<form id="rightForm" action="<%=request.getContextPath() %>/flowComp?method=save" method="post" class="form-horizontal" role="form" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" >
<input id="type" name="type" value="${param.type}" type="hidden"/>
<input id="compId" name="compId" value="${param.compId}" type="hidden"/>
<%request.setAttribute("topId", "41");%>
<%
	try{
		ComJspCode.getJspCode(request.getParameter("type"),request.getParameter("compId"),request);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<input id="flowId" name="flowId" value="${flowId}" type="hidden"/>
<div class="row">
	<div class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">所属的流程名称：${flowName}</a></li>
			<li class="active">本地文件监控配置</li>
		</ol>
		
		<div class="form-group">
			<label for="udcComp" class="col-sm-3 control-label"></label>
			<div class="col-sm-5">
				<input class="btn btn-primary" type="submit" value="保存"/>
			</div>
			<div class="col-sm-1">
				<a class="btn btn-primary"  href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">返回流程</a>
			</div>
		</div>
		
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
			<div class="col-sm-5">
				<input <c:if test='${empty name}'>value="组件名称"</c:if>value="${name}" class="form-control input-inline" placeholder="组件名称" id="name" name="name" data-rule="required;length[1~45];"/>
			</div>
		</div>
		<div class="form-group">
			<label for="monitorPath" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>本地文件路径</label>
			<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='监控的本地文件存在的地址，格式：节点地址/目录名/文件名' ></div>
			<div class="col-sm-5">
				<input value="${config.monitorPath}" class="form-control input-inline" placeholder="本地文件路径" id="monitorPath" name="monitorPath" data-rule="required;"/>
			</div>
		</div>
		<div class="form-group">
			<label for="hdfsPath" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>到hdfs目录</label>
			<div class="col-sm-5">
				<input value="${path}" class="form-control input-inline" placeholder="到hdfs目录" id="hdfsPath" name="hdfsPath" data-rule="required;" readonly="readonly"/>
			</div>
			<div class="col-sm-2">
				<input value="选择" class="btn input-inline" name="select" type="button"/>
			</div>
		</div>
				
	</div>
</div>		
<SCRIPT type="text/javascript">
//输入框说明
$(".propmt").popover({
     trigger:'hover',
     placement:'bottom',
     html: true
     });

function showLayer(_id,_value){
	layer.open({
	    type: 2,
// 	    border: [0,1,'#61BA7A'], //不显示边框
	    area: ['400px', '400px'],
// 	    shade: 0.8,
	    closeBtn: true,
	    shadeClose: true,
	    skin: 'layui-layer-molv', //墨绿风格
	    fix: false, //不固定
// 	    maxmin: true,
	    content: 'hdfsTree.jsp?compId='+_id+'&pathValue='+_value
	});
}

$("input[name=select]").click(function(){
	var _id = $(this).parent().parent().find("input:eq(0)").attr("id");
	var _value = $(this).parent().parent().find("input:eq(0)").val();
// 	console.log("focus..."+_id);
// 	console.log("_value..."+_value);
	showLayer(_id,_value);
});
</SCRIPT>
</form>

