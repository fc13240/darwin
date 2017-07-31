<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@page import="java.util.*"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.EsIndexServices"%>
<%@page import="com.alibaba.fastjson.*"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<script src="<%=request.getContextPath() %>/resources/js/common-util.js"></script>
<script src="<%=request.getContextPath() %>/flow/flowComp/esExport/js/lib/angular.js"></script>
<script src="<%=request.getContextPath() %>/flow/flowComp/esExport/js/import.js"></script>
<script src="<%=request.getContextPath() %>/ng-common/import.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/flow/workFlow/css/common.css">
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
			<li class="active">ES导出组件配置</li>
		</ol>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
			<div class="col-sm-5">
				<input value="{{esExportConfig.compname}}"  ng-model="esExportConfig.compname" class="form-control input-inline" placeholder="组件名称" id="name" name="postForm[name]" data-rule="required;length[1~45];"/>
			</div>
			<div class="col-sm-1">
				<input id="submitButton"  class="btn btn-primary" type="button" value="保存" ng-click="saveComp()"/>
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
					<store-set es-index='${sessionScope.session_esIndexList}' ></store-set>
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

			var ftplist_select;
			$(function(){
				init();

				ftplist_select = $("#ftpJson").html();
				$("#ftpJson").remove();

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



				//验证hdfs-store，弹出层区域，如果验证通过则隐藏，能提交则提交，不能则
				$('form').validator({
					valid: function(form){
						console.log("valid...");
					},
					invalid: function(form){
						console.log("invalid...");
						$("#connModal1").isValid(function(v){
							console.log(v ? 'connModal1表单验证通过' : 'connModal1表单验证不通过');
							if(v)
			 				    $('#connModal1').modal('hide');
			 			    return;
						});
					}
				});



				
				

				//line切换
				$("#line").click(function(){
// 					console.log("line.checked="+$(this).is(":checked")+",id="+$(this).attr("id"));
					if($(this).is(":checked")){
						$("#lineReg").show();
					}else{
						$("#lineReg").hide();
					}
				});
				/*
				$("#newRow").click(function(){
					addRow(null,null);
				});*/

				$("#autoCreate").click(function(){
					if(confirm("确定自动生成吗？")){
						$("#ruleTable tr:gt(0)").each(function(index,value){
							$(this).remove();
						});

						var _delimited = $("#delimited").val();
						var delimited_char = _delimited;
						var _columns = 0;
// 							console.log("_delimited！"+_delimited+","+(_delimited=='REGX'));
// 						console.log("_exampleData="+_exampleData);
// 						console.log("_delimited="+_delimited);
// 						console.log("_columns="+_columns);
						//批量创建html
						for (var i=0;i < _columns ; i++){
							if(i==0 && _delimited=='REGX'){
								continue;
							}
							addRow(null,null);
						}
					}
				});

				$("#newDateTimeRow").click(function(){
					addDateTimeRow(null,null);
				});

				$("#delimited").change(function(){
					var sval = $(this).val();
					if(sval=='REGX'){
						var _input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
						if($("#delimited_hidden").text()!=''){
							_input = "<textarea id=\"delimited_char\" name=\"delimited_char\" rows=\"\" cols=\"100\" class=\"form-control delimited_char_css\" data-rule=\"required;delimited_char\" placeholder=\"请输入正则表达式\">"+$("#delimited_hidden").text()+"</textarea>";
						}
						$("#regInput").html(_input);
					}else{
						$("#regInput").html("");
					}
				});

			});


			$("#clearRadioSelect").click(function(){
				$("input[name='columnTime']").attr("checked",false);
			});

			$("select[name='columnType']").bind("change",function(){
				columnTypeChange0($(this))
			});
		</script>


<script type="text/javascript">
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
</script>
