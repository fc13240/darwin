<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/underscore-min.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script> --%>
<style type="text/css">
	#hdfsSourceModal .form-group{height:30px;}
	#hdfsSourceModal .form-group label{line-height:2;padding:0;}
	#hdfsSourceModal .form-control{height:32px;padding:6px 12px;}
</style>
<div class="panel-heading" style="border:1px solid #ccc;">
	<div style="width:50%;float:left;">获取设置</div>
	<div style="width:50%;float:left;text-align:right;">
		<a id="add-hdfs-source"><span class="glyphicon glyphicon-plus"></span></a>
	</div>
	<div style="clear: both;"></div>
</div>
<div class="panel-body" id="hdfs-selected-blocks">
	
</div>
<div id="to-save" style="display:none;"></div>

<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="hdfsSourceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				<h4 class="modal-title" id="myModalLabel">HDFS数据设置</h4>
 			</div>
 			<div id="hdfsSourceModalBody" class="modal-body"></div>
			<div class="modal-footer">
				<input type="hidden" id="current-index"/>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        	<button type="submit" class="btn btn-primary" id="hdfs-source-save">保存</button>
	        </div>
		</div>
	</div>
</div>


<script>
$(function(){
	$('#add-hdfs-source').click(function(){
		var seed = $('#add-hdfs-source-seed').html();
		var length = $('#to-save').find('.hdfs-source').length;
		_.templateSettings = {interpolate: /\{\{(.+?)\}\}/g};
		var template = _.template(seed);
		$('#hdfsSourceModalBody').html(template({index:length}));
		$('#current-index').val(length);
		$('#hdfsSourceModal').modal('show');
	});
	
	$('#fileRuleType').change(function(){
		if ($(this).val()=='dir-time') {
			$('#fileRuleLabel').html('目录名时间规则');
		} else if ($(this).val()=='file-time') {
			$('#fileRuleLabel').html('文件名时间规则');
		} else if ($(this).val()=='file-all') {
			$('#fileRuleLabel').html('所有文件');
			$('#fileRule').val('*');
		} else {
			$('#fileRuleLabel').html('文件规则');
		}
	});
	$('#hdfs-source-save').click(function(){
		var hdfs_source = $('#hdfsSourceModalBody').formhtml();
		var index = $('#current-index').val();
		if ($('#hdfs-source-'+index).length>0) {
			$('#hdfs-source-'+index).html($('#hdfsSourceModalBody').formhtml());
			$('#hdfs-source-block-'+index+' .box-body').html($('#hdfsSourceModalBody input[id="hdfsname"]').val());
		} else {
			var div = $('<div class="hdfs-source" id="hdfs-source-'+index+'"></div>');
			$('#to-save').append(div);
			div.html(hdfs_source);
			var htmls = '<div class="box box-default" id="hdfs-source-block-'+index+'">'+
						'<div class="box-heading">'+
						'Hdfs数据设置'+
						'</div>'+
						'<div class="box-body">'+
						$('#hdfsSourceModalBody input[id="hdfsname"]').val()+
						'</div>'+
						'<div>'+
						'<button type="button" class="btn btn-xs btn-default hdfs-source-setting" onclick="openHdfsSource(\''+index+'\')">'+
						'<span class="glyphicon glyphicon-cog"></span>设置'+
						'</button>'+
						'</div>'+
						'</div>';
			$('#hdfs-selected-blocks').append('<div>'+htmls+'</div>');
		}
		$('#hdfsSourceModalBody').html('');
		$('#hdfsSourceModal').modal('hide');
	});
});
function openHdfsSource(index) {
	$('#hdfsSourceModalBody').html($('#hdfs-source-'+index).html());
	$('#current-index').val(index);
	$('#hdfsSourceModal').modal('show');
}
//del
function delFunc(obj){
	$(obj).parent().parent().remove();
}
/**
* target插入的目标元素
* insertBefore:true插入到目标元素前面
*/
function addFormatRow(target,insertBefore, index){
	var ruleTableTr = $("#ruleTable"+index+" tr").size();
	var _row = "<tr>";
	_row += "<td>"+ruleTableTr+"</td>";
	_row += "<td><input name='columnName' class='form-control' value='c"+ruleTableTr+"'/></td>";
	_row += "<td><input name='columnType' class='form-control' value='c"+ruleTableTr+"'/></td>";
	_row += "<td><input name='columnFormat' class='form-control' value=''/></td>";
	_row += "<td style=\"width:'280px'\"> <input type='button' class='btn-insertabove' title='上插' id='upInsert' onclick='upInsertFunc(this)'/> <input type='button' class='btn-insertbelow' title='下插' id='downInsert' onclick='downInsertFunc(this)'/> <input type='button' class='btn-moveup' title='上移' id='upShift' onclick='upShiftFunc(this)'/> <input type='button' class='btn-movedown' title='下移' id='downShift' onclick='downShiftFunc(this)'/> <input type='button' class='btn-del' title='删除' id='del' onclick='delFunc(this)'/></td>";
	_row += "</tr>";
	
	if(target){
		if(insertBefore){
			$(_row).insertBefore(target);
		}else{
			$(_row).insertAfter(target);
		}
	}else{
		console.log($("#ruleTable"+index));
		$("#ruleTable"+index).append(_row);
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

function showLayer(_id){
	layer.open({
	    type: 2,
	    area: ['600px', '600px'],
	    closeBtn: true,
	    shadeClose: true,
	    skin: 'layui-layer-molv', //墨绿风格
	    fix: false, //不固定
	    content: 'hdfsTree.jsp?compId='+_id
	});
}

</script>
