<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<script src="<%=request.getContextPath() %>/resources/js/common-util.js"></script>
<script src="<%=request.getContextPath() %>/flow/flowComp/dataClean/js/lib/angular.js"></script>
<script src="<%=request.getContextPath() %>/flow/flowComp/participle/js/import.js"></script>
<script src="<%=request.getContextPath() %>/ng-common/import.js"></script>
<script src="<%=request.getContextPath() %>/resources/layer/extend/layer.ext.js"></script>
<%
	try{
		ComJspCode.getJspCode(request.getParameter("type"),request.getParameter("compId"),request);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<div ng-app="comp" ng-controller="compCtrl" ng-init="init()">
	<form id="rightForm" name="postForm" method="post" class="form-horizontal" role="form" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" >
	<input name="postForm[type]" value="${param.type}" type="hidden"/>
	<input name="postForm[compId]" value="${param.compId}" type="hidden"/>
	<input id="flowId" ng-init="flowId=${flowId}" name="postForm[flowId]" value="${flowId}" type="hidden"/>
	<input id="compId" ng-init="compId=${compId}" value="${compId}" type="hidden"/>
	<input id="oldname" name="postForm[oldname]" value="${oldname}" type="hidden"/>
	<%request.setAttribute("topId", "41");%>
	<!-- 组件通用信息设置 -->
	<div class="panel panel-default">
		<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">所属的流程名称：${flowName}</a></li>
			<li class="active">分词应用组件配置</li>
		</ol>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
			<div class="col-sm-5">
				<input value="{{statCompConfig.compname}}" ng-model="statCompConfig.compname" class="form-control input-inline" placeholder="组件名称" id="name" name="postForm[name]" data-rule="required;length[1~45];"/>
			</div>
			<div class="col-sm-1">
				<input class="btn btn-primary" type="button" value="保存" ng-click="saveComp()"/>
			</div>
			<div class="col-sm-1">
				<a class="btn btn-primary"  href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">返回流程</a>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<source-set></source-set>
				</div>
				<div class="col-md-4">
					<config-set></config-set>
				</div>
				<div class="col-md-4">
					<store-set></store-set>
				</div>
			</div>
		</div>
	</div>
	</form>
</div>
<script>

function setPath(hdfspath,id) {
	var dom = document.getElementById(id);
		var scope = angular.element(dom).scope();
		  
		scope.$apply(function(){
		scope.modelVal = hdfspath;
	});
}
var oldconfig = <%=request.getAttribute("config")%>;
//表单验证失败的函数
function invalidFormFunc(){
// 	console.log("表单验证失败...");
	if(true)return;
	$('#input').isValid(function(v){
// 	    console.log(v ? '00表单验证通过' : '00表单验证不通过');
	    $("#tabs").tabs( "select" , 0 );

	    if(v){
	    	$('#tabs-2').isValid(function(v){
	    		$("#tabs").tabs( "select" , 1 );
	    		if(v){
	    			$('#tabs-4').isValid(function(v){
	    				$("#tabs").tabs( "select" , 3 );
	    				if(v){
	    					//检测表单是否所有字段都验证通过
	    					$('#tabs-6').isValid(function(v){
// 	    						console.log(v ? '5表单验证通过' : '5表单验证不通过');
	    						$("#tabs").tabs( "select" , 5 );
	    					});
	    				}
	    			});
	    		}
	    	});
	    }
	});
}

	function confirmDel(){
		if (confirm("你确定要删除吗？")) {
			return true;
        }  return false;
	}

	function init(){
		if($("#lineCheckedFlg").val()==true){
			$("#line").prop("checked",true);
		}else{
			$("#line").prop("disabled",false);
		}
		$("#lineCheckedFlg").remove();

	}
	$(function(){
		init();

		//通用按钮的提交表单事件
		$("form").on("valid.form", function(e, form){
			if(!$("#notParser").prop("checked")){


				var _exist = false;
				$("#ruleTable tr:gt(0)").each(function(index,value){
					var _dirRule = $(this).find("input[name='dirRule']").val();

					if(_dirRule!=''){
						_exist = true;
					}
				});
			}

			createMark();

			form.submit();
		});

	});
</script>

