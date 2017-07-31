<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<script src="<%=request.getContextPath() %>/resources/js/common-util.js"></script>
<form id="rightForm" action="<%=request.getContextPath() %>/flowComp?method=save" method="post" class="form-horizontal" role="form" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" >
<input name="type" value="${param.type}" type="hidden"/> <!-- 组件类型 -->
<input name="compId" value="${param.compId}" type="hidden"/> <!-- 组件id -->
<%session.setAttribute("type", "database");%>
<%request.setAttribute("topId", "41");%>
<%
	try{
		ComJspCode.getJspCode(request.getParameter("type"),request.getParameter("compId"),request);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<input id="flowId" name="flowId" value="${flowId}" type="hidden"/>  <!-- 所属流程id -->
<input id="oldname" name="oldname" value="${oldname}" type="hidden"/>  <!-- 组件旧名称 -->
<!-- 组件通用信息设置 -->
<div class="panel panel-default">
	<ol class="breadcrumb">
		<li><a href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">所属的流程名称：${flowName}</a></li>
		<li class="active">Mysql数据获取配置</li>
	</ol>
	<div class="form-group">
		<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>组件名称</label>
		<div class="col-sm-5">
			<input <c:if test='${empty name}'>value="组件名称"</c:if>value="${name}" class="form-control input-inline" placeholder="组件名称" id="name" name="name" data-rule="required;length[1~45];"/>
		</div>
		<div class="col-sm-1">
			<input class="btn btn-primary" type="submit" onclick="return test();"  value="保存"/>
		</div>
		<div class="col-sm-1">
			<a class="btn btn-primary"  href="<%=request.getContextPath() %>/flow/init.jsp?id=${flowId}">返回流程</a>
		</div>
	</div>
	<div class="container">
	<div class="row">
		<!-- 这里是获取设置 -->
		<div class="col-md-4">
			<div class="panel panel-darwin">
				<div class="panel-heading">获取设置</div>
				<div class="panel-body">
					<div class="box box-default">
						<div class="box-heading">
							Mysql连接
						</div>
						<div class="box-body">
							<span id="conn-count">${rulesize}</span>个Mysql设置
						</div>
						<div>
							<button type="button" class="btn btn-xs btn-default" data-toggle="modal" data-target="#connModal">
								<span class="glyphicon glyphicon-cog"></span>设置
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 这里是处理过程 -->
		<div class="col-md-4">
			<div class="panel panel-darwin">
				<div class="panel-heading">处理过程</div>
				<div class="panel-body">
					<div class="form-group">	
						<label for="charset" class="control-label"><span class="redStar">*&nbsp;</span>数据库编码</label>
						
						<div>
<%-- 						<input value="${config.config.encode}" class="form-control input-inline" placeholder="数据库编码" id="encode" name="encode" data-rule="required;length[1~45];"/> --%>
							<select class="form-control" id="charset" name="charset">
								<%
									session.setAttribute("charsetList", DataCache.charsetList);
								%>
								<c:forEach items="${charsetList}" var="list">
						           <option <c:if test='${list.key == config.config.charset}'>selected="selected"</c:if>value="${list.key}">${list.value}</option>
						        </c:forEach>
							</select>
						</div>
					</div>
					<div class="form-group" style="display:none">	
						<label for="threads" class="control-label"><span class="redStar">*&nbsp;</span>并发线程数</label>
						<div>
							<input <c:if test='${empty config.config.threads}'>value="1"</c:if>  value="${config.config.threads}" class="form-control input-inline" placeholder="并发线程数" id="threads" name="threads" data-rule="required;integer;length[1~45];"/>
						</div>
					</div>
					<div class="form-group">
						<label for="timeout" class="control-label"><span class="redStar">*&nbsp;</span>连接超时(秒)</label>
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='连接服务器的等待最长时间，超过规定时间则连接失败' ></div>
						<div>
							<input <c:if test='${empty config.config.timeout}'>value="30"</c:if> value="${config.config.timeout}" class="form-control input-inline" placeholder="连接超时(秒)" id="timeout" name="timeout" data-rule="required;integer;length[1~45];"/>
						</div>
					</div>
					<div class="form-group">
						<label for="sleep" class="control-label"><span class="redStar">*&nbsp;</span>重试间隔(秒)</label>
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip"  data-content='获取文件时的重试的间隔时间'></div>
						<div>
							<input <c:if test='${empty config.config.sleep}'>value="10"</c:if> value="${config.config.sleep}" class="form-control input-inline" placeholder="重试间隔(秒)" id="sleep" name="sleep" data-rule="required;integer;length[1~45];"/>
						</div>
					</div>
					<div class="form-group">
						<label for="exception" class="control-label">某数据库获取不到</label>
						<div>
							<select class="form-control" >
								<option value="-1">不处理(仅记录日志)</option>
								<option value="-2">报错退出</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 这里是输出设置 -->
		<div class="col-md-4">
			<div class="panel panel-darwin">
				<div class="panel-heading">输出设置</div>
				<div class="panel-body">
<!-- 					<div class="form-group"> -->
<!-- 						<label for="dir" class="control-label">路由</label> -->
<!-- 						<div> -->
<!-- 							<select class="form-control" data-rule="required;"> -->
<!-- 								<option>全部到目录</option> -->
<!-- 								<option>按文件名条件到不同的目录</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="form-group">
						<label for="hdfsPath" class="control-label"><span class="redStar">*&nbsp;</span>到hdfs目录</label>
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='获取文件后的存储位置' ></div>
						<input value="${config.storeinfo.path}" class="form-control input-inline" placeholder="到hdfs目录" id="hdfsPath" name="hdfsPath" data-rule="required;length[1~245];" readonly="readonly"/>
						<input value="选择" class="btn input-inline" name="select" type="button"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="connModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content content">
			<div class="modal-header header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				<h4 class="modal-title" id="myModalLabel">Mysql连接设置</h4>
 			</div>
 			<div class="modal-body">
 				<div>
					<button class="btn btn-xs btn-primary" type="button" id="newRow"><span class="glyphicon glyphicon-plus"></span>增加一行</button>
					<label class="help-block">*如果没有连接，请先<a href="<%=request.getContextPath() %>/user/connConf?method=index&type=database&compType=${param.type}&compId=${param.compId}">创建连接</a></label>
				</div>
				<table class="table table-bordered table-hover" id="ruleTable" style="margin-bottom: 100px;">
					<tr>
						<td width="50">序号</td>
						<td width="180"><span class="redStar">*&nbsp;</span>连接
						<div  class="glyphicon glyphicon-question-sign propmt" data-toggle="tooltip" data-content='远程连接的服务器地址' ></div>
						</td>
						<td width="100"><span class="redStar">*&nbsp;</span>数据库
						</td>
						<td><span class="redStar">*&nbsp;</span>sql</td>
						<td width="50">操作</td>
					</tr>
					<c:if test="${rulesize==0}">
						<tr class="tr-setting">
							<td>1</td>
							<td>
								<select class="form-control"  id="connId1" name="connId" data-rule="required;">
									<c:forEach items="${sessionScope.session_mysqlList}" var="list">
							           <option <c:if test='${list.id == stu.connId}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
							        </c:forEach>
								</select>
							</td>
							<td>
								<input type="text" value="${stu.database}" id="database${status.index + 1}" name="database" data-rule="required;" class="form-control" placeholder="database"/>
							</td>
							<td>
								<textarea rows="3" cols="5" id="sql${status.index + 1}" name='sql' data-rule="required;" class='form-control' placeholder='sql'>${stu.sql}</textarea>
							</td>
							<td>
								<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
							</td>
						</tr>
					</c:if>
					<c:forEach var="stu" items="${rules}" varStatus="status">
						<tr class="tr-setting">
							<td>${status.index + 1}</td>
							<td>
								<select class="form-control" id="connId${status.index + 1}" name="connId" data-rule="required;">
									<option value="">--选择连接--</option>
									<c:forEach items="${sessionScope.session_mysqlList}" var="list">
							           <option <c:if test='${list.id == stu.connId}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
							        </c:forEach>
								</select>
							</td>
							<td>
								<input type="text" value="${stu.database}" id="database${status.index + 1}" name="database" data-rule="required;" class="form-control" placeholder="database"/>
							</td>
							<td>
								<textarea rows="3" cols="5" id="sql${status.index + 1}" name='sql' data-rule="required;" class='form-control' placeholder='sql'>${stu.sql}</textarea>
							</td>
							<td>
								<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        	<button type="button" class="btn btn-primary" id="conn-save">保存</button>
	        </div>
		</div>
	</div>
</div>
<div id="mysqlJson" style="display: none;">
	<select class="form-control" name="connId" data-rule="required;">
		<option value="">--选择连接--</option>
		<c:forEach items="${sessionScope.session_mysqlList}" var="list">
           <option value="${list.id}">${list.name}</option>
        </c:forEach>
	</select>
</div>
<script>
//输入框说明
$(".propmt").popover({
     trigger:'hover',
     placement:'bottom',
     html: true
     });
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
	
		
	var mysqllist_select;
	$(function(){
		mysqllist_select = $("#mysqlJson").html();
		$("#mysqlJson").remove();
		//通用按钮的提交表单事件
		$("form").on("valid.form", function(e, form){
			createMark();
			form.submit();
		});	
		$("#newRow").click(function(){
			addRow(null,null);
		});
		$('#conn-save').click(function(){
			//检测表单是否所有字段都验证通过
			$('#connModal').isValid(function(v){
// 			    console.log(v ? '表单验证通过' : '表单验证不通过');
			    if(v)
				    $('#connModal').modal('hide');
			    return;
			});
			
	    	$('#conn-count').html($('.tr-setting').length);
	    	$("#threads").val($('.tr-setting').length);

			$("form").on("valid.form", function(e, form){
				$('#connModal').modal('hide');
			});
		});
		
		//验证，弹出层区域，如果验证通过则隐藏，能提交则提交，不能则
		$('form').validator({
			valid: function(form){
			},
			invalid: function(form){
				$("#connModal").isValid(function(v){
// 					console.log(v ? 'connModal表单验证通过' : 'connModal表单验证不通过');
					if(v)
	 				    $('#connModal').modal('hide');
	 			    return;
				});
			}
		});
	});
	
	function test(){
		var count=$("#conn-count").text();
		if(count==0){
			alert("至少添加一个连接");
			return false;
		}
		var threads=$("#threads").val();
		if(count!=threads){
			alert("并大线程数应等于远程文件数");
			return false;
		}
		
	}
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow(target,insertBefore){
		var ruleTableTr = $("#ruleTable tr").size();
		var _row = "<tr class='tr-setting'>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td>"+mysqllist_select+"</td>";
		_row += "<td><input type='text' value='' id='database"+ruleTableTr+"' name='database' data-rule='required;' class='form-control' placeholder='database'/></td>";
		_row += "<td><textarea rows='3' cols='5' id='sql"+ruleTableTr+"' name='sql' data-rule='required;' class='form-control' placeholder='sql'></textarea></td>";
		_row += "<td style=\"width:'50px'\"> <input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";
		
		if(target){
			if(insertBefore){
				//$(target).insertBefore(_row);
				$(_row).insertBefore(target);
			}else{
				$(_row).insertAfter(target);
			}
		}else{
			$("#ruleTable").append(_row);
		}
		
	}
		
	//del
	function delFunc(obj){
		$(obj).parent().parent().remove();
	}
	function showLayer(_id,_value){
		layer.open({
		    type: 2,
		    area: ['400px', '400px'],
		    closeBtn: true,
		    shadeClose: true,
		    skin: 'layui-layer-molv', //墨绿风格
		    fix: false, //不固定
		    content: 'hdfsTree.jsp?compId='+_id+'&pathValue='+_value
		});
	}

	$("input[name=select]").click(function(){
		var _id = $(this).parent().parent().find("input:eq(0)").attr("id");
		var _value = $(this).parent().parent().find("input:eq(0)").val();
// 		console.log("focus..."+_id);
// 		console.log("_value..."+_value);
		showLayer(_id,_value);
	});
</script>
</form>