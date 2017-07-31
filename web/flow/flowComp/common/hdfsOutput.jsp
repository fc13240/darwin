<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/underscore-min.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script> --%>
<style type="text/css">
	#hdfsOutputModal .form-group{height:30px;}
	#hdfsOutputModal .form-group label{line-height:2;padding:0;}
	#hdfsOutputModal .form-control{height:32px;padding:6px 12px;}
</style>
<div class="panel-heading" style="border: 1px solid #ccc;">
	<div style="width: 50%; float: left;">输出设置</div>
	<div style="width: 50%; float: left;text-align: right;">
		<a id="add-hdfs-output"><span class="glyphicon glyphicon-plus"></span></a>
	</div>
	<div style="clear: both;"></div>
</div>
<div class="panel-body">
	<div class="box box-default">
		<div class="box-heading">
			HDFS数据
		</div>
		<div class="box-body">
			<span id="conn-count"></span>
		</div>
		<div>
			<button type="button" class="btn btn-xs btn-default" data-toggle="modal" data-target="#outputRoute">
				<span class="glyphicon glyphicon-cog"></span>设置/修改路由
			</button>
			<button type="button" class="btn btn-xs btn-default" data-toggle="modal" data-target="#connModal">
				<span class="glyphicon glyphicon-cog"></span>显示字段
			</button>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="hdfsOutputModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				<h4 class="modal-title" id="myModalLabel">HDFS数据选择</h4>
 			</div>
 			<div class="modal-body" id="hdfsOutputModalBody" style="min-height: 400px;"></div>
			<div class="modal-footer" style="clear: both;">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        	<button type="submit" class="btn btn-primary" id="hdfs-output-save">保存</button>
	        </div>
		</div>
	</div>
</div>

<div id="add-hdfs-output-seed" style="display:none">
	<div class="form-group" style="height: 30px;">
    	<label for="name" class="col-sm-3 control-label">数据类型：</label>
    	<div class="col-sm-9">
    		<select class="form-control">
				<option value="gz">gz压缩的文本</option>
				<option value="text">文本</option>
				<option value="binary">二进制</option>
			</select>
    	</div>
  	</div>
  	<div class="form-group" style="height: 30px;">
    	<label for="name" class="col-sm-3 control-label">数据分隔符：</label>
    	<div class="col-sm-9">
      		<input type="text" class="form-control" value="" placeholder="分隔符">
    	</div>
  	</div>
  	<div class="form-group" style="height: 30px;">
    	<label for="name" class="col-sm-3 control-label">父目录名：</label>
    	<div class="col-sm-9">
      		<input type="text" class="form-control" value="" placeholder="/home/yimr/dept1">
    	</div>
  	</div>
  	<div class="form-group" style="height: 30px;">
    	<label for="name" class="col-sm-3 control-label">目录名：</label>
    	<div class="col-sm-9">
      		<input type="text" class="form-control" value="" placeholder="dir@{yyyymmdd}">
      		留空则直接写文件
    	</div>
  	</div>
  	<div class="form-group" style="height: 30px;">
    	<label for="name" class="col-sm-3 control-label">文件名：</label>
    	<div class="col-sm-9">
      		<input type="text" class="form-control" value="" placeholder="abc@{yyyymmdd}.txt">
    	</div>
  	</div>
  	<div class="form-group" style="height: 30px;">
    	<label for="name" class="col-sm-3 control-label">数据条件：</label>
    	<div class="col-sm-9">
    		<select class="form-control">
				<option value="text">条件输出</option>
				<option value="binary">全部输出</option>
			</select>
    	</div>
  	</div>
  	<div class="form-group" style="height: 30px;">
  		<label for="name" class="col-sm-3 control-label"></label>
    	<div class="col-sm-9">
    		<div style="line-height: 30px; padding: 5px;">
    			<input type="radio">条件And
    			<input type="radio">条件Or
    		</div>
    		<div style="padding: 5px;">
    			<span style="float: left; line-height: 42px;">
		    		<select>
						<option value="text">data1.col2</option>
						<option value="binary">data2.col3</option>
						<option value="binary">vcol4</option>
					</select>
					<select>
						<option value="text">等于</option>
						<option value="binary">不等于</option>
						<option value="binary">为空串</option>
						<option value="binary">数值大于</option>
						<option value="binary">数值小于</option>
						<option value="binary">字符串大于</option>
						<option value="binary">字符串小于</option>
						<option value="binary">行处理异常</option>
					</select>
				</span>
				<span style="float: left; margin-left: 10px;">
					<div>
						<input type="radio">字段值
						<select>
							<option value="text">data1.col2</option>
							<option value="binary">data2.col3</option>
							<option value="binary">vcol4</option>
						</select>
					</div>
					<div>
						<input type="radio">固定值
						<input type="text" />
					</div>
				</span>
				<span style="clear: both;"></span>
			</div>
			<div>
				<select multiple="multiple" style="width: 100%;"></select>
			</div>
    	</div>
  	</div>
</div>
<script>
$(function(){
	$('#add-hdfs-output').click(function(){
		var seed = $('#add-hdfs-output-seed').html();
		var length = $('#to-save').find('.hdfs-output').length;
		_.templateSettings = {interpolate: /\{\{(.+?)\}\}/g};
		var template = _.template(seed);
		$('#hdfsOutputModalBody').html(template({index:length}));
		$('#hdfsOutputModal').modal('show');
	});
	
	$("#newRow").click(function(){
		addRow(null,null);
	});
	$('#hdfs-output-save').click(function(){
		var hdfs_output = $('#hdfsOutputModalBody').html();
		var div = $('<div class="hdfs-output"></div>');
		$('#to-save').append(div);
		div.html(hdfs_output);
		$('#hdfsOutputModalBody').html('');
		$('#hdfsOutputModal').modal('hide');
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
		console.log("No……");
		return;
	}
	
	if(insertBefore){
		$(select).insertBefore(target);
	}else{
		console.log("insertAfter");
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
