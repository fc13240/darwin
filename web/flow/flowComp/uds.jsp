<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<form id="rightForm" 
	action="<%=request.getContextPath() %>/flowComp?method=save" 
	method="post" class="form-horizontal" role="form"  
	data-validator-option="{theme:'yellow_right_effect',stopOnError:true}">
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
			<li class="active">数据获取脚本配置</li>
		</ol>
		
		<div class="form-group">
			<label for="udcComp" class="col-sm-3 control-label"></label>
			<div class="col-sm-5">
				<input code="save" class="btn btn-primary" type="submit" value="保存"/>
			</div>
			<div class="col-sm-1">
				<a class="btn btn-primary"  href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">返回流程</a>
			</div>
		</div>
		
		<div class="form-group">
			<label for="udsComp" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>数据获取脚本选择</label>
			<div class="col-sm-5">
				<select class="form-control" id="udsComp" name="udsComp" data-rule="required;" >
					<option value="">--选择脚本--</option>
					<c:forEach items="${sessionScope.session_udsList}" var="list">
						<option <c:if test='${list.id == config.udsComp}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
					</c:forEach>
				</select>
			</div>
				<label class="help-block">*如果没有脚本，请先<a href="<%=request.getContextPath() %>/script/edit.jsp">新建脚本</a></label>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
			<div class="col-sm-5">
				<input <c:if test='${empty name}'>value="组件名称"</c:if>value="${name}" class="form-control input-inline" placeholder="组件名称" id="name" name="name" data-rule="required;length[1~45];"/>
			</div>
		</div>
		<div class="form-group" style="display:none">
			<label for="alwaysRun" class="col-sm-3 control-label">是否持续运行</label>
			<div class="col-sm-5">
				<select class="form-control" id="alwaysRun" name="alwaysRun" data-rule="required;" >
					<option <c:if test='${"0" == config.alwaysRun}'>selected="selected"</c:if> value="0" >否</option>
					<option <c:if test='${"1" == config.alwaysRun}'>selected="selected"</c:if> value="1">是</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="args" class="col-sm-3 control-label">脚本执行参数</label>
			<div class="col-sm-5">
<%-- 				<input <c:if test='${empty config.args}'>value="--h"</c:if>value="${config.args}" class="form-control input-inline" placeholder="--h" id="args" name="args" data-rule="length[1~45];"/> --%>
				<input value="${config.args}" class="form-control input-inline" placeholder="--h" id="args" name="args" data-rule="length[1~45];"/>
			</div>
		</div>
		<div class="form-group">
			<label for="hdfsPath" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>到hdfs目录</label>
			<div class="col-sm-5">
				<input value="${path}" class="form-control input-inline" placeholder="到hdfs目录" id="hdfsPath" name="hdfsPath" data-rule="required;length[1~245];"/>
			</div>
			<div class="col-sm-2">
				<input value="选择" class="btn input-inline" name="select" type="button"/>
			</div>
		</div>
				
	</div>
</div>		
<SCRIPT type="text/javascript">
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
	showLayer(_id,_value);
});
</SCRIPT>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</form>

