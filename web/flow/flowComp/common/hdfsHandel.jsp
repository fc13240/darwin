<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/SelectUtil.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script> --%>
<style type="text/css">
	#calcModal .form-group{height:30px;}
	#calcModal .form-group label{line-height:2;padding:0;}
	#calcModal .form-control{height:32px;padding:6px 12px;}
	#srclb,#dstlb{border:1px solid #aaa;width:200px;height:195px;}
	.zhcxbtn{width:30px;}
</style>
<script type="text/javascript">
	var dstlb = new SelectUtil("dstlb");
	var srclb = new SelectUtil("srclb");
</script>
<div class="panel-heading" style="border: 1px solid #ccc;">处理配置</div>
<div class="panel-body">
	<a id="add-calc">添加运算字段 </a>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="calcModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				<h4 class="modal-title" id="myModalLabel">添加计算字段</h4>
 			</div>
 			<div class="modal-body">
			  	<div id="left" style="border: 1px solid #ccc; min-height: 400px; width: 300px; float: left;"></div>
			  	<div id="right" style="float: left; min-height: 400px;">
			  		<div class="form-group">
				    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
				    	</div>
				  	</div>
				  	<!-- 
				  	<div class="form-group">
				    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
				  	</div>
				  	 -->
				  	<div class="form-group">
				    	<label for="hdfspath" class="col-sm-3 control-label">连接符：</label>
				    	<div class="col-sm-9">
				      		<input type="text" class="form-control" id="hdfsPath" value="" placeholder="连接符"/>
				    	</div>
				  	</div>
				  	<div class="form-group">
				    	<label for="hdfsname" class="col-sm-3 control-label">列集合：</label>
				  	</div>
				  	<div class="form-group">
				    	<label for="hdfspath" class="col-sm-3 control-label"></label>
				    	<div class="col-sm-10">
				      		<table width="460" border="0" class="zhcx" cellpadding="0" cellspacing="0">
								<tr>
							    	<td>
							            <select multiple="multiple" name="srclb" id="srclb" ondblclick="srclb.moveSelectedItemTo(dstlb.getObject());">
							            	<option value="ccc">ccc</option>
							            </select>
							        </td>
							    	<td>
							            <input type="button" class="zhcxbtn" value=">" onclick="srclb.moveSelectedItemTo(dstlb.getObject());"/>
							            <input type="button" class="zhcxbtn" value=">>" onclick="srclb.moveAllItemTo(dstlb.getObject());"/>
							            <input type="button" class="zhcxbtn" value="<" onclick="dstlb.moveSelectedItemTo(srclb.getObject());"/>
							            <input type="button" class="zhcxbtn" value="<<" onclick="dstlb.moveAllItemTo(srclb.getObject());"/>
							        </td>
							    	<td>
							            <select multiple="multiple" name="dstlb" id="dstlb" ondblclick="dstlb.adjustItem();">
							            </select>
							        </td>
							    </tr>
							</table>
				    	</div>
				  	</div>
			  	</div>
 			</div>
 			<div style="clear:both"></div>
 			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        	<button type="submit" class="btn btn-primary" id="hdfs-source-save">保存</button>
	        </div>
		</div>
	</div>
</div>
<div id="config" style="display:none">
	<!-- 字符串拼接 -->
	<div id="string_replace">
  		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfspath" class="col-sm-3 control-label">连接符：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsPath" value="" placeholder="连接符"/>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">列集合：</label>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfspath" class="col-sm-3 control-label"></label>
	    	<div class="col-sm-10">
	      		<table width="460" border="0" class="zhcx" cellpadding="0" cellspacing="0">
					<tr>
				    	<td>
				            <select multiple="multiple" name="srclb" id="srclb" ondblclick="srclb.moveSelectedItemTo(dstlb.getObject());">
				            	<option value="ccc">ccc</option>
				            </select>
				        </td>
				    	<td>
				            <input type="button" class="zhcxbtn" value=">" onclick="srclb.moveSelectedItemTo(dstlb.getObject());"/>
				            <input type="button" class="zhcxbtn" value=">>" onclick="srclb.moveAllItemTo(dstlb.getObject());"/>
				            <input type="button" class="zhcxbtn" value="<" onclick="dstlb.moveSelectedItemTo(srclb.getObject());"/>
				            <input type="button" class="zhcxbtn" value="<<" onclick="dstlb.moveAllItemTo(srclb.getObject());"/>
				        </td>
				    	<td>
				            <select multiple="multiple" name="dstlb" id="dstlb" ondblclick="dstlb.adjustItem();">
				            </select>
				        </td>
				    </tr>
				</table>
	    	</div>
	  	</div>
	</div>
	
	<!-- 字符串替换 -->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">代替换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">data1</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">查找串：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="查找串"/>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">替换为：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="替换为"/>
	    	</div>
	  	</div>
	</div>
	
	<!-- 大小写转换-->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">类型：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">查找串：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="查找串"/>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">转换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">data1</option>
				</select>
	    	</div>
	  	</div>
	</div>
	
	<!-- 求长度-->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">求长度列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	</div>
	
	<!-- 种子加密-->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待加密列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">混淆值：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="混淆值"/>
	    	</div>
	  	</div>
	</div>
	
	<!-- 时间戳到日期 -->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待转换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">时间戳：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">毫秒</option>
					<option value="gz">秒</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">日期格式：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="yyyy-MM-dd HH:mm:SS"/>
	    	</div>
	  	</div>
	</div>
	
	<!-- 日期到时间戳-->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待转换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">日期格式：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="yyyy-MM-dd HH:mm:SS"/>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">时间戳：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">毫秒</option>
					<option value="gz">秒</option>
				</select>
	    	</div>
	  	</div>
	</div>
	
	<!-- URL 编码 -->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待转换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	</div>
	
	<!-- URL 解码 -->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待转换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	</div>
	
	<!-- URL参数提取 -->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待转换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数字符集：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="UTF-8">UTF-8</option>
					<option value="GB2312">GB2312</option>
					<option value="GBK">GBK</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数分隔方式：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="UTF-8">key和value等号对</option>
					<option value="GB2312">key和value斜杠分隔对</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数名集合：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="参数名集合"/>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">输出分隔符：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="输出分隔符"/>
	    	</div>
	  	</div>
	</div>
	
	<!-- IP转省市 -->
	<div id="string_replace">
		<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">新字段名称：</label>
	    	<div class="col-sm-9">
	      		<input type="text" class="form-control" id="hdfsname" value="" placeholder="新字段名称"/>
	    	</div>
	  	</div>
	  	<!-- 
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">参数赋值：</label>
	  	</div>
	  	 -->
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">待替换列：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">转小写</option>
					<option value="gz">转大写</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="form-group">
	    	<label for="hdfsname" class="col-sm-3 control-label">粒度：</label>
	    	<div class="col-sm-9">
	      		<select class="form-control" id="dataType">
					<option value="gz">省</option>
					<option value="gz">省市</option>
				</select>
	    	</div>
	  	</div>
	</div>
	
</div>
<script>
$(function(){
	$('#add-calc').click(function(){
		$('#calcModal').modal('show');
	});
	
	$("#newRow").click(function(){
		addRow(null,null);
	});
	$('#hdfs-source-save').click(function(){
		 //TODO:进行校验
		 var selectedHdfsDom = $('<div class="box box-default"></div>');
		 selectedHdfsDom.append('<div class="box-heading">HDFS数据</div>');
		 selectedHdfsDom.append('<div class="box-body">'+$('#hdfsname').val()+'</div>');
		 selectedHdfsDom.append('<div><button type="button" class="btn btn-xs btn-default class="hdfs-setting"><span class="glyphicon glyphicon-cog"></span>设置</button><button type="button" class="btn btn-xs btn-default" class="hdfs-cols-setting"><span class="glyphicon glyphicon-cog"></span>显示字段</button></div>');
	});
});
//del
function delFunc(obj){
	$(obj).parent().parent().remove();
}
/**
* target插入的目标元素
* insertBefore:true插入到目标元素前面
*/
function addRow(target,insertBefore){
	var ruleTableTr = $("#ruleTable tr").size();
	var _row = "<tr>";
	_row += "<td>"+ruleTableTr+"</td>";
	_row += "<td><input name='columnName' class='form-control' value='c"+ruleTableTr+"'/></td>";
	_row += "<td style=\"width:'280px'\"> <input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/></td>";
	_row += "</tr>";
	
	if(target){
		if(insertBefore){
			$(_row).insertBefore(target);
		}else{
			$(_row).insertAfter(target);
		}
	}else{
		$("#ruleTable").append(_row);
	}
	
}
function upInsertFunc(obj){
	var target = $(obj).parent().parent();
	addRow(target,true);
}

function downInsertFunc(obj){
	var target = $(obj).parent().parent();
	addRow(target,false);
}
//移动元素
function shift(select,target,insertBefore){
	var _no = $(target).find("td").eq(0).html();
	
	//alert(isNaN($(target).find("td").eq(0).html()));
	if(_no=="No"){
		return;
	}
	
	if(insertBefore){
		$(select).insertBefore(target);
	}else{
		$(select).insertAfter(target);
	}
}
//上移
function upShiftFunc(obj){
	var select = $(obj).parent().parent();
	var target = $(select).prev();
	shift(select,target,true);
}

//下移
function downShiftFunc(obj){
	var select = $(obj).parent().parent();
	var target = $(select).next();
	shift(select,target,false);
}
</script>
