<%@ page contentType="text/html; charset=UTF-8"%>

<div id="add-hdfs-source-seed" style="display:none">
	<div>
		<div style="width: 50%; float: left;">
			<div class="form-group">
				<label for="hdfsname" class="col-sm-3 control-label">名称：</label>
		    	<div class="col-sm-6">
		      		<input type="text" class="form-control" name="hdfsSource[source][{{index}}][hdfsname]" id="hdfsname" value="" placeholder="名称"/>
		    	</div>
		  	</div>
		  	<div class="form-group">
		    	<label for="hdfstype" class="col-sm-3 control-label">数据类型：</label>
		    	<div class="col-sm-6">
		    		<select class="form-control" name="hdfsSource[source][{{index}}][dataType]" id="dataType">
						<option value="gz">gz压缩的文本</option>
						<option value="text">文本</option>
						<option value="binary">二进制</option>
					</select>
		    	</div>
		  	</div>
		  	<div class="form-group">
		    	<label for="hdfstype" class="col-sm-3 control-label">字符编码：</label>
		    	<div class="col-sm-6">
		    		<select class="form-control" name="hdfsSource[source][{{index}}][code]" id="dataType">
						<option value="UTF-8">UTF-8</option>
						<option value="GBK">GBK</option>
						<option value="GB2312">GB2312</option>
						<option value="ISO8859-1">ISO8859-1</option>
						<option value="-">-</option>
					</select>
		    	</div>
		  	</div>
		  	<div class="form-group">
    			<label for="hdfssplit" class="col-sm-3 control-label">数据分隔符：</label>
		    	<div class="col-sm-6">
		      		<input type="text" class="form-control" name="hdfsSource[source][{{index}}][split]" id="split" value="" placeholder="分隔符">
		    	</div>
		    </div>
		    <div class="form-group">
		    	<label for="hdfscols" class="col-sm-3 control-label">分割列数：</label>
		    	<div class="col-sm-6">
		      		<input type="text" class="form-control" name="hdfsSource[source][{{index}}][columns]" id="columns" value="" placeholder="分割列数">
		    	</div>
  			</div>
		</div>
		<div style="width: 50%; float: left;">
			<div class="form-group">
		    	<label for="hdfspath" class="col-sm-4 control-label">文件路径：</label>
		    	<div class="col-sm-6">
		      		<input type="text" class="form-control" name="hdfsSource[source][{{index}}][hdfsPath]" id="hdfsPath{{index}}" value="" placeholder="文件路径" readonly="true"/>
		    	</div>
		    	<div class="col-sm-1">
					<input value="选择" class="btn input-inline" type="button" onclick="showLayer('hdfsPath{{index}}')"/>
				</div>
		  	</div>
		  	<div class="form-group">
		    	<label for="name" class="col-sm-4 control-label">数据范围：</label>
		    	<div class="col-sm-6">
		    		<select id="fileRuleType" name="hdfsSource[source][{{index}}][fileRuleType]" class="form-control">
						<option value="dir-time">目录下目录名符合【时间】规则的文件</option>
						<option value="file-time">目录下文件名符合【时间】规则的文件</option>
						<option value="file-all">选定的文件/目录下所有文件</option>
						<option value="file-rule">选定目录下所有符合规则的文件</option>
					</select>
		    	</div>
		  	</div>
		  	<div class="form-group">
		    	<label id="fileRuleLabel" for="fileRule" class="col-sm-4 control-label">目录名时间规则：</label>
		    	<div class="col-sm-6">
		      		<input id="fileRule" name="hdfsSource[source][{{index}}][fileRule]" type="text" class="form-control" value="" placeholder="yyyymmdd">
		    	</div>
		  	</div>
		    <div class="form-group">
		    	<label for="name" class="col-sm-4 control-label">处理最近：</label>
		    	<div class="col-sm-2">
		      		<input id="from" name="hdfsSource[source][{{index}}][from]" type="text" class="form-control" value="" placeholder="1">
		    	</div>
		    	<div class="col-sm-2">
		      		<input id="to" name="hdfsSource[source][{{index}}][to]" type="text" class="form-control" value="" placeholder="24">
		    	</div>
		    	<div class="col-sm-3">
		    		<select name="hdfsSource[source][{{index}}][company]" id="company" class="form-control">
						<option value="minute">分钟</option>
						<option value="hour">小时</option>
						<option value="day">天</option>
						<option value="week">周</option>
						<option value="month">月</option>
						<option value="year">年</option>
					</select>
		    	</div>
		  	</div>
		    <div class="form-group">
		    	<label for="name" class="col-sm-4 control-label">文件名符合：</label>
		    	<div class="col-sm-6">
		      		<input id="fileNameEq" name="hdfsSource[source][{{index}}][fileNameEq]" type="text" class="form-control" value="" placeholder="*.@{yyyymmdd}.txt">
		    	</div>
		  	</div>
		  	<div class="form-group">
		    	<label for="name" class="col-sm-4 control-label">文件名排除：</label>
		    	<div class="col-sm-6">
		      		<input id="fileNameExclude" name="hdfsSource[source][{{index}}][fileNameExclude]" type="text" class="form-control" value="" placeholder="bak.*">
		    	</div>
		  	</div>
		</div>
		<div style="clear:both"></div>
	</div>
	<div>
		<div class="text-right mtb10">
			<button class="btn btn-xs btn-primary new-hdfs-source-cols" type="button" id="newRow{{index}}" onclick="addFormatRow(null,null,{{index}})">
				<span class="glyphicon glyphicon-plus"></span>添加一行源字段
			</button>
		</div>
		<table class="table table-bordered table-hover" id="ruleTable{{index}}" style="margin-bottom: 100px;">
			<tr>
				<td width="60">列序号</td>
				<td>列名</td>
				<td>类型</td>
				<td>数据格式</td>
				<td>操作</td>
			</tr>
		</table>
	</div>
</div>
