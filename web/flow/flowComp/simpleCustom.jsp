<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<form id="rightForm" action="<%=request.getContextPath() %>/flowComp?method=save" method="post" class="form-horizontal" role="form"  data-validator-option="{theme:'yellow_right_effect',stopOnError:true}">
<input id="type" name="type" value="${param.type}" type="hidden"/>
<input id="compId" name="compId" value="${param.compId}" type="hidden"/>
<%request.setAttribute("topId", "41");%>
<%
	ComJspCode.getJspCode(request.getParameter("type"),request.getParameter("compId"),request);
	
%>
<input id="flowId" name="flowId" value="${flowId}" type="hidden"/>
<div class="row">
	<div class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">所属的流程名称：${flowName}</a></li>
			<li class="active">自定义组件配置</li>
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
			<label for="udcComp" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>自定义组件选择</label>
			<div class="col-sm-5">
				<select class="form-control" id="udcComp" name="udcComp" data-rule="required;">
					
					<option value="">--选择组件--</option>
					<c:forEach items="${sessionScope.session_udcList}" var="list">
						<c:choose>
							<c:when test="${config.udcComp == list.id}">
								 <option selected="selected" value="${list.id}">${list.name}(${config.compVersion})</option>
							</c:when>
							<c:otherwise>
								<option value="${list.id}">${list.name}(${list.version})</option>
							</c:otherwise>
						</c:choose>
			        </c:forEach>
				</select>
				<input type="hidden" value="${config.compVersion}" id="selected-comp-version" name="compVersion"/>
			</div>
			<div class="col-sm-3" style="line-height:42px;font-size:16px;">
				<a title="选择历史版本" id="select-udc-his"><span class="glyphicon glyphicon-list-alt"></span></a>
				<a title="查看组件详情" id="view-udc-detail"><span class="glyphicon glyphicon-info-sign"></span></a>
			</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
			<div class="col-sm-5">
				<input <c:if test='${empty config.name}'>value="组件名称"</c:if>value="${config.name}" class="form-control input-inline" placeholder="组件名称" id="name" name="name" data-rule="required;length[1~45];"/>
			</div>
		</div>
		<div id="mainDiv"></div>
		<div class="form-group">
			<label for="output" class="col-sm-3 control-label">输出路径:outdir</label>
			<div class="col-sm-5">
				<input value="${path}" class="form-control input-inline" placeholder="输出路径" id="output" name="output" data-rule="required"/>
			</div>
			<div class="col-sm-1">
				<input value="选择" class="btn input-inline" name="select" type="button"/>
			</div>
		</div>
	</div>
</div>

</form>
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

$(function(){
	
	var udcVersionMap = ${udcVersionMap};
	
	function changeUdcVersion(newVersion) {
		$('#selected-comp-version').val(newVersion);
		var curComp = $('#udcComp option:selected').text();
		var compName = curComp.split('(')[0];
		$('#udcComp option:selected').text(compName+"("+newVersion+")");
		udcVersionMap[$('#udcComp').val()] = newVersion;
	}
	$('#udcComp').change(function(){
		$('#selected-comp-version').val(udcVersionMap[$(this).val()]);
	});
	
	$("input[name=select]").on('click',function(){
		var _id = $(this).parent().parent().find("input:eq(0)").attr("id");
		var _value = $(this).parent().parent().find("input:eq(0)").val();
		showLayer(_id,_value);
	});
	
	$('#select-udc-his').click(function(){
		layer.open({
		    type: 2,
		    area: ['600px', '600px'],
		    closeBtn: true,
		    shadeClose: true,
		    skin: 'layui-layer-molv', //墨绿风格
		    fix: false, //不固定
		    content: 'udcHistory.jsp?id='+$('#udcComp').val()
		});
	});
	$('#view-udc-detail').click(function(){
		if ($('#udcComp').val()>0) {
			window.open("/udc/edit.jsp?id="+$('#udcComp').val());
		}
	});


// 	var _StartStopTime = $("#StartStopTime").clone(true);				
// 	var _dy_StartStopTime = $("#dy_StartStopTime").clone(true);	
// 	$("#StartStopTime").remove();
// 	$("#dy_StartStopTime").remove();
	
	$("#udcComp").change(function(){
		pamShow();
	});
	
	function pamShow(){
		var udcComp = $("#udcComp").val();
		var compVersion = $("#selected-comp-version").val();
		
		var _url = '<%=request.getContextPath() %>/udc?method=getPamShow&flowCompId=${compId}&udcComp='+udcComp+'&compVersion='+compVersion;
		//alert(_url);
		ajaxPam(_url);
	}
	
	pamShow();
	
	function ajaxPam(_url){
		$.ajax({
			url:_url,
			type:"post",
			dataType:"text",
// 			async:true,
			success:function(data, textStatus){
				if(!data || data==''){
					var _html = "<div >";
					_html += "</div>";
					$("#mainDiv").html(_html);
					return;
				}
				
				var _d = eval('('+data+')');
				var _html = "";
				$.each(_d,function(index,item){
					var readStatus="";
					if(item["status"] == "online"){
						readStatus = "readonly='readonly'";
					}
					
					var _id = item["name"].replace(" ","");
					var _value = item["value"];
					if(item["type"]=='hdfspath'){
						_html += "<div class='form-group' >";
						_html += "<lable for='"+_id+"' class='col-sm-3 control-label'>" +item["type"]+"_参数名称:"+item["name"] + "</lable>";
						_html += "<input id='pamName' name='pamName' value='"+_id+ "' type='hidden'/>";
						_html += "<input id='pamType' name='pamType' value='"+item["type"]+ "' type='hidden'/>";
						_html += "<div class='col-sm-5'>";
						_html += "<input name='pamValue' id='"+_id+"' class='form-control input-inline' "+readStatus+" value='"+item["value"]+"'/>";
						_html += "</div>";
						_html += "<div class='col-sm-1'>";
						if(readStatus == ""){
							_html += "<input value='选择' class='btn input-inline' name='select' onclick='showLayer(\""+_id+"\",\""+_value+"\");' type='button'/>";
						}else{
							_html += "<input value='选择' class='btn input-inline' type='button' disabled='disabled'/>";
						}
						_html += "</div>";
						_html += "</div>";
					}else if(item["type"]=='textarea'){
						_html += "<div class='form-group' >";
						_html += "<lable for='c' class='col-sm-3 control-label'>" +item["type"]+"_参数名称:"+item["name"] + "</lable>";
						_html += "<input id='pamType' name='pamType' value='"+item["type"]+ "' type='hidden'/>";
						_html += "<input id='pamName' name='pamName' value='"+_id+ "' type='hidden'/>";
						_html += "<div class='col-sm-8'>";
// 						_html += "<textarea name='pamValue' id='pamValue' rows='8' cols='230' class='form-control' data-rule='required;' "+readStatus+">"+decodeURIComponent(item["value"])+ "</textarea>";
						_html += "<textarea name='pamValue' id='pamValue' rows='8' cols='230' class='form-control' "+readStatus+">"+item["value"]+ "</textarea>";
						_html += "</div>";
						if(item["remark"] != ""){
							_html += "<p class='help-block'>"+ "说明:"+item["remark"]+"</p>";
						}
						_html += "</div>";
					}else if(item["type"]=='select'){
						_html += "<div class='form-group' >";
						_html += "<lable for='c' class='col-sm-3 control-label'>" +item["type"]+"_参数名称:"+item["name"] + "</lable>";
						_html += "<input id='pamType' name='pamType' value='"+item["type"]+ "' type='hidden'/>";
						_html += "<input id='pamName' name='pamName' value='"+_id+ "' type='hidden'/>";
						_html += "<div class='col-sm-5'>";
						_html += "<select "+readStatus+" id='pamValue' name='pamValue' class='form-control'>";
// 						var _select = eval('('+item["select"]+')');
						var _select = item["select"];
						$.each(_select,function(index,item01){
							if(item01["key"] == item["value"]){
								_html += "<option selected='selected' value='"+item01["key"]+"'>"+item01["value"]+"</option>";
							}else{
								_html += "<option value='"+item01["key"]+"'>"+item01["value"]+"</option>";
							}
							
						});
						_html += "</select>";
						_html += "</div>";
						if(item["remark"] != ""){
							_html += "<p class='help-block'>"+ "说明:"+item["remark"]+"</p>";
						}
						_html += "</div>";
					}else{
						_html += "<div class='form-group' >";
						_html += "<lable for='c' class='col-sm-3 control-label'>" +item["type"]+"_参数名称:"+item["name"] + "</lable>";
						_html += "<input id='pamName' name='pamName' value='"+_id+ "' type='hidden'/>";
						_html += "<input id='pamType' name='pamType' value='"+item["type"]+ "' type='hidden'/>";
						_html += "<div class='col-sm-5'>";
						if(item["type"]=='password'){
							_html += "<input name='pamValue'  class='form-control' type='password'  value='"+item["value"]+ "' "+readStatus+"/>";
						}else {
							_html += "<input name='pamValue'  class='form-control'  value='"+item["value"]+ "' "+readStatus+"/>";
						}
						_html += "</div>";
						if(item["remark"] != ""){
							_html += "<p class='help-block'>"+ "说明:"+item["remark"]+"</p>";
						}
						_html += "</div>";
					}
				});
				$("#mainDiv").html(_html);
			
			},
			error:function(){
				console.log("加载数据出错！");
			}
		});
	}
});

	
</script>

<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
<script>
// document.getElementById("name").onkeypress = function(e){
//     checkChar(e);
// }
 
// function checkChar(e){
//     e = window.event || e;
//     var code = e.keyCode || e.which;
//     var reg = /[////:/*/?"/</>/|]/;// 禁止 //:*?"<>|
//     if(reg.test(String.fromCharCode(code))){
//         if(window.event){
//             e.returnValue = false;
//         }else{
//             e.preventDefault();
//         }
//     }
// }
</script>