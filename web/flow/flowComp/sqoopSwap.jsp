<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.util.ComJspCode"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<script src="<%=request.getContextPath() %>/resources/js/common-util.js"></script>
<form id="rightForm" action="<%=request.getContextPath() %>/flowComp?method=save" method="post" class="form-horizontal" role="form" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}" >
<input name="type" value="${param.type}" type="hidden"/> <!-- 组件类型 -->
<input name="compId" value="${param.compId}" type="hidden"/> <!-- 组件id -->
<%request.setAttribute("topId", "41");%>
<%session.setAttribute("type", "database");%>
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
		<li class="active">sqoop数据交换</li>
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
				<div class="panel-heading">数据库设置</div>
				<div class="panel-body">
					<div class="box box-default">
						<div class="box-heading">
							数据库连接
						</div>
						<div class="box-body">
							<span id="conn-count">${rulesize}</span>个表设置
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
						<div style="border: 2px;">
							<input type="radio" id="state01" name="state" <c:if test='${state == "toHdfs" or empty state}'>checked="checked"</c:if>value="toHdfs" /> 数据库 <span class="glyphicon glyphicon-arrow-right"></span> HDFS&nbsp;&nbsp; 
							<span id="dbchange" <c:if test='${state == "toDatabase"}'>style="display: none;"</c:if> >
								<input type="radio" id="db01" name="db" <c:if test='${dbStatus == "full" or empty dbStatus}'>checked="checked"</c:if>value="full" />  全量
								<input type="radio" id="db02" name="db" <c:if test='${dbStatus == "increment"}'>checked="checked"</c:if>value="increment" />  增量
							</span>
						</div>
						<div style="border: 2px;">	
							<br>
							<input type="radio" id="state02" name="state" <c:if test='${state == "toDatabase"}'>checked="checked"</c:if>value="toDatabase" /> 数据库  <span class="glyphicon glyphicon-arrow-left"></span> HDFS
						</div>
					</div>
					<div class="form-group">	
						<label for="mapCount" class="control-label"><span class="redStar">*&nbsp;</span>map任务数</label>
						<div>
							<input <c:if test='${empty config.other_config.map_count}'>value="4"</c:if>value="${config.other_config.map_count}" class="form-control input-inline" id="mapCount" name="mapCount" data-rule="required;integer[+];length[1~4];"/>
						</div>
					</div>
					<div class="form-group" id="compressDiv" <c:if test="${state == 'toDatabase'}">style="display:none;"</c:if>>
						<label for="compress" class="control-label"><span class="redStar">*&nbsp;</span>结果是否压缩 </label>
						<div>
							<select id="compress" name="compress" class="form-control" >
							   <option <c:if test='${empty config.other_config.compress or config.other_config.compress== "0"}'>selected="selected"</c:if>value="0">否</option>
							   <option <c:if test='${config.other_config.compress == "1"}'>selected="selected"</c:if>value="1">是</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="replaceNull" class="control-label">null字段替换 </label>
						<div>
							<input <c:if test='${empty config.other_config.replace_null}'>value="null"</c:if>value="${config.other_config.replace_null}" class="form-control input-inline" id="replaceNull" name="replaceNull"/>
						</div>
					</div>
					<div class="form-group">
						<label for="fieldSplit" class="control-label"><span class="redStar">*&nbsp;</span>分隔符 </label>
						<div>
							<select id="fieldSplit" name="fieldSplit" class="form-control">
							   <%
									request.setAttribute("splitMap", DataCache.splitToSqoopMap);
								%>
								<c:forEach items="${splitMap}" var="item">
								   <option <c:if test='${config.other_config.field_split == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row" id="customDiv" <c:if test="${config.other_config.field_split != 'custom'}">style="display:none;"</c:if>>
				    	<div>
							<input class="form-control" placeholder="自定义分隔符" id="custom" name="custom" <c:if test='${empty config.other_config.custom}'>value=","</c:if>value="${config.other_config.custom}"  type="text" data-rule="required;">
						</div>
				    </div>
				</div>
			</div>
		</div>
		<!-- 这里是输出设置 -->
		<div class="col-md-4">
			<div class="panel panel-darwin">
				<div class="panel-heading">HDFS设置</div>
				<div class="panel-body">
					<div class="form-group">
						<label for="hdfsPath" class="control-label"><span class="redStar">*&nbsp;</span>选择hdfs目录</label>
						<input value="${config.storeinfo.path}" class="form-control input-inline" placeholder="hdfs目录" id="hdfsPath" name="hdfsPath" data-rule="required;length[1~245];" readonly="readonly"/>
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
 				<h4 class="modal-title" id="myModalLabel">数据库连接设置</h4>
 			</div>
 			<div class="modal-body" style="margin-right:8px;margin-left:8px;">
				<div class="form-group">
					<label for="connId" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>数据库连接</label>
					<div class="col-sm-5">
						<select class="form-control" id="connId" name="connId" data-rule="required;">
							<option value="">--选择连接--</option>
							<c:forEach items="${sessionScope.session_dataBaseList}" var="list">
					            <option id="opt${list.id}" code="${list.type}" <c:if test='${list.id == datebase}'>selected="selected"</c:if>value="${list.id}">${list.name}</option>
					        </c:forEach>
						</select>
					</div>
					<div>
						<label class="help-block">*如果没有连接，请先<a href="<%=request.getContextPath() %>/user/connConf?method=index&type=database&compType=${param.type}&compId=${param.compId}">创建连接</a></label>
					</div>
				</div>
				<div class="form-group" id="toHdfs01" <c:if test='${state == "toDatabase" or (not empty state and dbStatus == "increment")}'>style="display:none;"</c:if>>
					<div class="text-left mtb10" >
						<button class="btn btn-xs btn-primary" type="button" id="newRow">
							<span class="glyphicon glyphicon-plus"></span>添加一行
						</button>
					</div>
					<div id="splitHelp">
						<label class="help-block">*分片字段：Column of the table used to split work units，建议为数字、日期类型的字段。</label>
					</div>	
					<table class="table table-bordered table-hover" id="ruleTable01" style="margin-bottom: 100px;">
						<tr class='success'>
							<td width="10%">序号</td>
							<td width="40%"><span class="redStar">*&nbsp;</span>表名称/查询语句</td>
							<td width="40%"><span class="redStar">*&nbsp;</span>分片字段</td>
							<td width="10">操作</td>
						</tr>
						<c:if test="${rulesize==0}">
							<tr class="tr-setting">
								<td>1</td>
								<td>
									<input type="text" value="" id="tableName1" name="tableName" data-rule="required;" class="form-control" placeholder="表名称/查询语句"/>
								</td>
								<td>
									<input type="text" value="" id="splitColumn1" name="splitColumn" data-rule="required;" class="form-control" placeholder="分片字段"/>
								</td>
								<td>
									<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
								</td>
							</tr>
						</c:if>
						<c:forEach var="stu" items="${rules1}" varStatus="status">
							<tr class="tr-setting">
								<td>${status.index + 1}</td>
								<td>
									<input type="text" value="${stu.db_table}" id="tableName${status.index + 1}" name="tableName" data-rule="required;" class="form-control" placeholder="表名称/查询语句"/>
								</td>
								<td>
									<input type="text" value="${stu.split_column}" id="splitColumn${status.index + 1}" name="splitColumn" data-rule="required;" class="form-control" placeholder="分片字段"/>
								</td>
								<td>
									<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="form-group" id="toHdfs02" <c:if test='${empty state or state == "toDatabase" or dbStatus == "full"}'>style="display:none;"</c:if>>
					<div class="text-left mtb10" >
						<button class="btn btn-xs btn-primary" type="button" id="newRow01">
							<span class="glyphicon glyphicon-plus"></span>添加一行
						</button>
					</div>
					<div id="splitHelp">
						<label class="help-block">*分片字段：Column of the table used to split work units，建议为数字、日期类型的字段。</label>
						<label class="help-block">*增量检查字段：Specifies the column to be examined when determining which rows to import，必须为数字或者日期类型（不能重复）。</label>
					</div>	
				<table class="table table-bordered table-hover" id="ruleTable02" style="margin-bottom: 100px;">
					<tr class='success'>
						<td width="8%">序号</td>
						<td width="30%"><span class="redStar">*&nbsp;</span>表名称/查询语句</td>
						<td width="20%"><span class="redStar">*&nbsp;</span>分片字段</td>
						<td width="20%"><span class="redStar">*&nbsp;</span>增量检查字段</td>
						<td width="14%">增量起始值</td>
						<td width="8">操作</td>
					</tr>
					<c:forEach var="stu" items="${rules2}" varStatus="status">
						<tr class="tr-setting">
							<td>${status.index + 1}</td>
							<td>
								<input type="text" value="${stu.db_table}" id="tableName${status.index + 1}" name="tableName" data-rule="required;" class="form-control" placeholder="表名称/查询语句"/>
							</td>
							<td>
								<input type="text" value="${stu.split_column}" id="splitColumn${status.index + 1}" name="splitColumn" data-rule="required;" class="form-control" placeholder="分片字段"/>
							</td>
							<td>
								<input type="text" value="${stu.check_column}" id="checkColumn${status.index + 1}" name="checkColumn" data-rule="required;" class="form-control" placeholder="增量检查字段"/>
							</td>
							<td>
								<input type="text" value="${stu.last_value}" id="startColumn${status.index + 1}" name="startColumn" class="form-control" placeholder="增量起始值"/>
							</td>
							<td>
								<input type="button" value="删除" onclick='delFunc(this)' class="btn-del"/>
							</td>
						</tr>
					</c:forEach>
				</table>
				</div>
				<div class="form-group" id="toDb" <c:if test='${empty state or state == "toHdfs"}'>style="display:none;"</c:if>>
					<div id="splitHelp">
						<label class="help-block">*更新参照字段：可以为多个，能够唯一确定一条记录。</label>
						<label class="help-block">*如果表中存在字段类型为Date，文件中对应的数据需要为yyyy-MM-dd。</label>
						<label class="help-block">*如果表中存在字段类型为DateTime，文件中对应的数据需要为yyyy-MM-dd HH:mm:dd。</label>
						<label class="help-block">*注意：数据库连接选择Oracle时，【对应字段名称】默认是全部字段。</label>
						<label class="help-block">*主要：数据库连接选择DB2时，【更新参照字段】无需填写，填写无效。</label>
					</div>	
				<table class="table table-bordered table-hover" id="ruleTable03" style="margin-bottom: 100px;">
					<tr class='success'>
						<td width="10%">序号</td>
						<td width="30%"><span class="redStar">*&nbsp;</span>表名称</td>
						<td width="30%">更新参照字段(Anchor column)</td>
						<td width="20%">对应字段名称</td>
					</tr>
					<c:forEach var="stu" items="${rules3}" varStatus="status">
						<tr class="tr-setting">
							<td>${status.index + 1}</td>
							<td>
								<input type="text" value="${stu.db_table}" id="tableName${status.index + 1}" name="tableName" data-rule="required;" class="form-control" placeholder="表名称"/>
							</td>
							<td>
								<input type="text" value="${stu.update_key}" id="updateKey${status.index + 1}" name="updateKey" data-rule="" class="form-control" placeholder="col1, col2"/>
							</td>
							<td>
								<input type="text" value="${stu.column_name}" id="columnName${status.index + 1}" name="columnName" class="form-control" placeholder="默认全部字段"/>
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
</div>
<script>
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
	
		
	$(function(){
		//通用按钮的提交表单事件
		$("form").on("valid.form", function(e, form){
			createMark();
			form.submit();
		});	
		$("#newRow").click(function(){
			addRow(null,null);
		});
		$("#newRow01").click(function(){
			addRow01(null,null);
		});
		$("#newRow02").click(function(){
			addRow02(null,null);
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
// 	    	$("#threads").val($('.tr-setting').length);

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
			alert("至少添加一个数据库表连接");
			return false;
		}
// 		var checkFlg=false;
// 		$("#ruleTable01 tr:gt(0)").each(function(index,value){
// 			var tableName00 = $(this).find("input[name='tableName']").val();

// 			console.log("tableName00=="+tableName00);
// 			$("#ruleTable01 tr:gt(1)").each(function(index,value){
// 				var tableName11 = $(this).find("input[name='tableName']").val();
// 				console.log("tableName11=="+tableName11);
// 				if(tableName11==tableName00){
// 					checkFlg=true;
// 					return false;
// 				}
// 			});
// 			if(checkFlg){return false;}
// 		});
// 		if(checkFlg){
// 			alert("表名称不能相同！");
// 			return false;
// 		}
		
		
	}
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow(target,insertBefore){
		var ruleTableTr = $("#ruleTable01 tr").size();
		var _row ="";
		_row = "<tr class='tr-setting'>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td><input type='text' value='' id='tableName"+ruleTableTr+"' name='tableName' data-rule='required;' class='form-control' placeholder='表名称/查询语句'/></td>";
		_row += "<td><input type='text' value='' id='splitColumn"+ruleTableTr+"' name='splitColumn' data-rule='required;' class='form-control' placeholder='分片字段'/></td>";
		_row += "<td><input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";
		
		if(target){
			if(insertBefore){
				//$(target).insertBefore(_row);
				$(_row).insertBefore(target);
			}else{
				$(_row).insertAfter(target);
			}
		}else{
			$("#ruleTable01").append(_row);
		}
		
	}
	
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow01(target,insertBefore){
		var ruleTableTr = $("#ruleTable02 tr").size();
		var _row ="";
		_row = "<tr class='tr-setting'>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td><input type='text' value='' id='tableName"+ruleTableTr+"' name='tableName' data-rule='required;' class='form-control' placeholder='表名称/查询语句'/></td>";
		_row += "<td><input type='text' value='' id='splitColumn"+ruleTableTr+"' name='splitColumn' data-rule='required;' class='form-control' placeholder='分片字段'/></td>";
		_row += "<td><input type='text' value='' id='checkColumn"+ruleTableTr+"' name='checkColumn' data-rule='required;' class='form-control' placeholder='增量检查字段'/></td>";
		_row += "<td><input type='text' value='' id='startColumn"+ruleTableTr+"' name='startColumn' class='form-control' placeholder='增量起始值'/></td>";
		_row += "<td><input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";
		
		if(target){
			if(insertBefore){
				//$(target).insertBefore(_row);
				$(_row).insertBefore(target);
			}else{
				$(_row).insertAfter(target);
			}
		}else{
			$("#ruleTable02").append(_row);
		}
		
	}
	/**
	* target插入的目标元素
	* insertBefore:true插入到目标元素前面
	*/
	function addRow02(target,insertBefore){
		var ruleTableTr = $("#ruleTable03 tr").size();
		var _row ="";
		_row = "<tr class='tr-setting'>";
		_row += "<td>"+ruleTableTr+"</td>";
		_row += "<td><input type='text' value='' id='tableName"+ruleTableTr+"' name='tableName' data-rule='required;' class='form-control' placeholder='表名称'/></td>";
		_row += "<td><input type='text' value='' id='updateKey"+ruleTableTr+"' name='updateKey' data-rule='' class='form-control' placeholder='col1, col2'/></td>";
		_row += "<td><input type='text' value='' id='columnName"+ruleTableTr+"' name='columnName' class='form-control' placeholder='默认全部字段'/></td>";
		_row += "<td><input type='button' value='删除' id='del' onclick='delFunc(this)' class='btn-del'/></td>";
		_row += "</tr>";
		
		if(target){
			if(insertBefore){
				//$(target).insertBefore(_row);
				$(_row).insertBefore(target);
			}else{
				$(_row).insertAfter(target);
			}
		}else{
			$("#ruleTable03").append(_row);
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
		showLayer(_id,_value);
	});
	
	$("#state01").click(function () {
        $("#dbchange").attr("style","");
        $("#db01").prop("checked",true);
        $("#db02").prop("checked",false);
        $("#toDb").attr("style","display: none;");
        $("#toHdfs01").attr("style","");
        $("#toHdfs02").attr("style","display: none;");
        $('#conn-count').html(0);
        var ruleTableTr02 = $("#ruleTable02 tr").size();
        var ruleTableTr03 = $("#ruleTable03 tr").size();
        if(ruleTableTr03 > 0){
        	$("#ruleTable03").empty();
        	var _row ="<tr class='success'><td width='10%'>序号</td><td width='30%'><span class='redStar'>*&nbsp;</span>表名称</td><td width='30%'>更新参照字段(Anchor column)</td><td width='20%'>对应字段名称</td></tr>";
        	$("#ruleTable03").append(_row);
        }
        if(ruleTableTr02 > 0){
        	$("#ruleTable02").empty();
        	var _row ="<tr class='success'><td width='8%'>序号</td><td width='30%'><span class='redStar'>*&nbsp;</span>表名称/查询语句</td><td width='20%'><span class='redStar'>*&nbsp;</span>分片字段</td><td width='20%'><span class='redStar'>*&nbsp;</span>增量检查字段</td><td width='14%'>增量起始值</td><td width='8'>操作</td></tr>";
			$("#ruleTable02").append(_row);
        }
        addRow(null,null);
        $("#compressDiv").attr("style","");
    });
	$("#state02").click(function () {
        $("#connId").val("");
        $("#dbchange").attr("style","display: none;");
        $("#toDb").attr("style","");
        $("#toHdfs01").attr("style","display: none;");
        $("#toHdfs02").attr("style","display: none;");
        $('#conn-count').html(0);
        var ruleTableTr01 = $("#ruleTable01 tr").size();
        var ruleTableTr02 = $("#ruleTable02 tr").size();
        if(ruleTableTr02 > 0){
        	$("#ruleTable02").empty();
        	var _row ="<tr class='success'><td width='8%'>序号</td><td width='30%'><span class='redStar'>*&nbsp;</span>表名称/查询语句</td><td width='20%'><span class='redStar'>*&nbsp;</span>分片字段</td><td width='20%'><span class='redStar'>*&nbsp;</span>增量检查字段</td><td width='14%'>增量起始值</td><td width='8'>操作</td></tr>";
			$("#ruleTable02").append(_row);
        }
        if(ruleTableTr01 > 0){
        	$("#ruleTable01").empty();
        	var _row ="<tr class='success'><td width='10%'>序号</td><td width=40%><span class=redStar>*&nbsp;</span>表名称/查询语句</td><td width=40%><span class='redStar'>*&nbsp;</span>分片字段</td><td width='10'>操作</td></tr>";
			$("#ruleTable01").append(_row);
        }
        
        var _row = "<tr class='tr-setting'>";
		_row += "<td>"+1+"</td>";
		_row += "<td><input type='text' value='' id='tableName' name='tableName' data-rule='required;' class='form-control' placeholder='表名称'/></td>";
		_row += "<td><input type='text' value='' id='updateKey' name='updateKey' data-rule='' class='form-control' placeholder='col1, col2'/></td>";
		_row += "<td><input type='text' value='' id='columnName' name='columnName' data-rule='' class='form-control' placeholder='默认全部字段'/></td>";
		_row += "</tr>";
    	$("#ruleTable03").append(_row);
    	$("#compressDiv").attr("style","display: none;");
    });
	
	$("#db01").click(function () {
        $("#toDb").attr("style","display: none;");
        $("#toHdfs01").attr("style","");
        $("#toHdfs02").attr("style","display: none;");
        $('#conn-count').html(0);
        var ruleTableTr01 = $("#ruleTable01 tr").size();
        var ruleTableTr02 = $("#ruleTable02 tr").size();
        var ruleTableTr03 = $("#ruleTable03 tr").size();
        if(ruleTableTr03 > 0){
        	$("#ruleTable03").empty();
        	var _row ="<tr class='success'><td width='10%'>序号</td><td width='30%'><span class='redStar'>*&nbsp;</span>表名称</td><td width='30%'>更新参照字段(Anchor column)</td><td width='20%'>对应字段名称</td></tr>";
        	$("#ruleTable03").append(_row);
        }
        if(ruleTableTr02 > 0){
        	$("#ruleTable02").empty();
        	var _row ="<tr class='success'><td width='8%'>序号</td><td width='30%'><span class='redStar'>*&nbsp;</span>表名称/查询语句</td><td width='20%'><span class='redStar'>*&nbsp;</span>分片字段</td><td width='20%'><span class='redStar'>*&nbsp;</span>增量检查字段</td><td width='14%'>增量起始值</td><td width='8'>操作</td></tr>";
			$("#ruleTable02").append(_row);
        }
        addRow(null,null);
        $("#compressDiv").attr("style","");
    });
	$("#db02").click(function () {
        $("#toDb").attr("style","display: none;");
        $("#toHdfs01").attr("style","display: none;");
        $("#toHdfs02").attr("style","");
        $('#conn-count').html(0);
        var ruleTableTr01 = $("#ruleTable01 tr").size();
        var ruleTableTr03 = $("#ruleTable03 tr").size();
        if(ruleTableTr03 > 0){
        	$("#ruleTable03").empty();
        	var _row ="<tr class='success'><td width='10%'>序号</td><td width='30%'><span class='redStar'>*&nbsp;</span>表名称</td><td width='30%'>更新参照字段(Anchor column)</td><td width='20%'>对应字段名称</td></tr>";
        	$("#ruleTable03").append(_row);
        }
        if(ruleTableTr01 > 0){
        	$("#ruleTable01").empty();
        	var _row ="<tr class='success'><td width='10%'>序号</td><td width=40%><span class=redStar>*&nbsp;</span>表名称/查询语句</td><td width=40%><span class='redStar'>*&nbsp;</span>分片字段</td><td width='10'>操作</td></tr>";
			$("#ruleTable01").append(_row);
        }
        addRow01(null,null);
        $("#compressDiv").attr("style","");
    });

	$("#fieldSplit").change(function(){
		var sval = $(this).val();
		if(sval=='custom'){
			$("#custom").val("");
			$("#customDiv").attr("style","");
		}else{
			$("#custom").val(",");
			$("#customDiv").attr("style","display: none;");
		}
	});
	
	$("#connId").change(function(){
		var sval = $(this).val();
		var code = $("#opt"+sval).attr("code");
		if(code == "Oracle"){
			$("#columnName").val("");
			$("#columnName").attr("disabled",true);
		}else{
			$("#columnName").attr("disabled",false);
		}
		if(code == "db2"){
			$("#updateKey").val("");
			$("#updateKey").attr("disabled",true);
		}else{
			$("#updateKey").attr("disabled",false);
		}
	});
</script>
</form>