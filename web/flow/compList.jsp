<%@ page contentType="text/html; charset=UTF-8"%>
<div class="panel panel-default panel-comp">
	<div class="panel-heading">组件库  <span class="darwin-tip-footer">*点击组件可添加至右侧流程*</span></div>
	<div class="darwin-comp-wrap">
		<ul class="list-group darwin-comp-type-list">
			<li class="list-group-item">
				<a class="darwin-comp-type">
					通用类
					<span class="badge">13</span>
				</a>
				<ul class="darwin-comp-list">
					<li>
						<a class="darwin-comp-item" data-type="sFTP">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-sFTP.png"/>
							<span class="desc">FTP获取</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="scp">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-scp.png"/>
							<span class="desc">SCP获取</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="sFTPIncrement">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-sFTPIncrement.png"/>
							<span class="desc">远程文件监控</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="localMonitor">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-localMonitor.png"/>
							<span class="desc">本地文件监控</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="mysql">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-mysql.png"/>
							<span class="desc">Mysql数据获取</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="oracle">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-oracle.png"/>
							<span class="desc">Oracle数据获取</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="toHbase">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-toHbase.png"/>
							<span class="desc">入Hbase</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="toEs">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-toEs.png"/>
							<span class="desc">入ES</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="sqoopSwap">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-sqoopSwap.png"/>
							<span class="desc">Sqoop数据交换</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="realtimeReceive">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-realtimeReceive.png"/>
							<span class="desc">实时接收</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="realtimeWatch">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-realtimeWatch.png"/>
							<span class="desc">实时监控</span>
						</a>
					</li>
				    <li>
						<a class="darwin-comp-item" data-type="esExport">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-esExport.png"/>
							<span class="desc">ES导出</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="realtimeToHdfs">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-realtimeToHdfs.png"/>
							<span class="desc">实时接收到HDFS</span>
						</a>
					</li>
				</ul>
			</li>
			<li class="list-group-item">
				<a class="darwin-comp-type">
					基础类
					<span class="badge">4</span>
				</a>
				<ul class="darwin-comp-list">
					<li>
						<a class="darwin-comp-item" data-type="dataClean">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-dataClean.png"/>
							<span class="desc">数据清洗</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="dataStat">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-dataStat.png"/>
							<span class="desc">统计分析</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="participle">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-participle.png"/>
							<span class="desc">分词应用</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="emotionAnalysis">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-emotionAnalysis.png"/>
							<span class="desc">正负面情绪分析</span>
						</a>
					</li>
				</ul>
			</li>
			<li class="list-group-item">
				<a class="darwin-comp-type">
					其他
					<span class="badge">2</span>
				</a>
				<ul class="darwin-comp-list">
					<li>
						<a class="darwin-comp-item" data-type="simpleCustom">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-simpleCustom.png"/>
							<span class="desc">自定义组件</span>
						</a>
					</li>
					<li>
						<a class="darwin-comp-item" data-type="uds">
							<img src="<%=request.getContextPath() %>/resources/site/img/comp-uds.png"/>
							<span class="desc">数据获取脚本</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</div>
<!-- 	<div class="darwin-tip-footer">***点击组件可添加至右侧流程***</div> -->
</div>
<script>
$('.darwin-comp-type').click(function(){
	if ($(this).hasClass('active')) {
		$('.darwin-comp-list').hide();
		$('.darwin-comp-type').removeClass('active');
	} else {
		$(this).addClass('active');
		$('.darwin-comp-list').hide();
		$(this).next().show();
	}
});
$('.darwin-comp-item').click(function(){
	var type = $(this).data('type');
	var flowid = $('#flowId').val();
	if (flowid=='' || flowid<0) {
		alert('请先保存流程后再选择组件');
		return false;
	}
	var compName = $(this).children('.desc').html();
	$.ajax({
		url:"<%=request.getContextPath() %>/flowComp?method=insertNew&flowId="+flowid+"&type="+type,
		type:"post",
		dataType:"json",
		success:function(data, textStatus){
			if (data) {
				update({comp:data,compName:compName,type:type,x:20,y:200});
			}
		},
		error:function(){
			console.log("新增组件出错！");
		}
	});
});
</script>