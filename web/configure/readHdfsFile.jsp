<%@page import="com.stonesun.realTime.utils.HdfsUtil"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsResultInfo"%>
<%@page import="com.stonesun.realTime.services.db.bean.AnalyticsInfo"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsServices"%>
<%@page import="com.stonesun.realTime.services.db.AnalyticsResultServices"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/resources/common.jsp"%>

<!-- grid.simple.min.css, grid.simple.min.js -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/js/lang/grid.zh-CN.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jquery.bsgrid/builds/merged/bsgrid.all.min.js"></script>

<div id="buttons" style="padding:5px 10px">
	跳过指定字节数：<input type="text" value="0" id="offset"/>
	编码格式:
	<select id="charset" name="charset" onchange="getCharset();">
		<%
			session.setAttribute("charsetList", DataCache.charsetList);
		%>
<!-- 		<option value="">--请选择--</option> -->
		<c:forEach items="${charsetList}" var="list">
			<option value="${list.key}">${list.value}</option>
		</c:forEach>
	</select>

	<input type="button" value="查看" id="cat"/>
	<input type="button" value="首页" id="first"/>
	<input type="button" value="上一页" id="sub"/>
	<input type="button" value="下一页" id="next"/>
	<input type="button" value="末页" id="last"/>
<!-- 	<input type="button" value="导出" id="export"/> -->
	<a href="#" onclick="return exportOrigFile(this)">导出原始文件</a>&nbsp;
	<a href="#" onclick="return exportExcelAll(this)">导出Excel</a>&nbsp;
<!-- 	<a href="#" onclick="return exportExcel(this)">导出Excel</a>&nbsp; -->
	<a href="#" onclick="return exportPdf(this)">导出PDF</a>
</div>
<hr>
<div id="hdfsFileContent"></div>
<!-- <pre id="hdfsFileContent2"></pre> -->
<div id="_hide_path" style="display: none;"><%=request.getParameter("path") %></div>
<table id="searchTable" style="display: none;">
    <tr>
        <th w_index="data">data</th>
    </tr>
</table>
<script type="text/javascript">
	var gridObj;
	var charset;//获取编码格式
	
	function getCharset(){
		charset =$("#charset").val();
// 		console.info(charset);
	}
	
	function exportExcelAll(obj){
		var filepath = $("#_hide_path").text();
		$(obj).attr("href","<%=request.getContextPath() %>/config/hdfs?method=exportExcelAll&offset=0&charset=utf-8&path="+filepath);
		return true;
	}
	function exportExcel(obj){
		var filepath = $("#_hide_path").text();//"/user/yimr/test_load.log.100m";
		$(obj).attr("href","<%=request.getContextPath() %>/config/hdfs?method=exportExcel&offset=0&charset=utf-8&path="+filepath);
		return true;
	}
	function exportPdf(obj){
		var filepath = $("#_hide_path").text();//"/user/yimr/test_load.log.100m";
		$(obj).attr("href","<%=request.getContextPath() %>/config/hdfs?method=exportPdf&offset=0&charset=utf-8&path="+filepath);
		return true;
	}
	function exportOrigFile(obj){
		createMark();
		var filepath = $("#_hide_path").text();//"/user/yimr/test_load.log.100m";
		$(obj).attr("href","<%=request.getContextPath() %>/config/hdfs?method=exportOrigFile&offset=0&charset=utf-8&path="+filepath);
		$.unblockUI();
		return true;
	}
   
    $(function () {
    	var filepath = $("#_hide_path").text();//"/user/yimr/test_load.log.100m";
    	console.log("filepath="+filepath);
    	var urlfilepath = encodeURI(filepath);
    	var _url = '<%=request.getContextPath() %>/config/hdfs?method=cat&d='+(new Date()).getTime();
    	_url += "&offset=0&path="+urlfilepath;
    	
//         gridObj = $.fn.bsgrid.init('searchTable', {
//             url: _url,
//             // autoLoad: false,
//             pageSizeSelect: true,
//             pageSize: 10
//         });
        
        
        var offset = 0;
        
        function ajaxRequest(_url){
    		$.ajax({
    			url:_url,
    			type:"post",
    			dataType:"text",
    			async:true,
    			success:function(data, textStatus){
    				$("#hdfsFileContent").html(data);
//     				$("#hdfsFileContent").text(data);
//     				$("#hdfsFileContent2").html(data);
//     				var abc = $("#hdfsFileContent").text();
//     				console.log("abcoooooooo========="+abc);
    				if(offset < 0){
    					offset = 0;
    				}
    				$("#offset").val(offset);
    				$("#charset").val(charset);
    			},
    			error:function(){
    				console.log("加载数据出错！");
    			}
    		});
    	}
        
        ajaxRequest(_url);
        
        $("#cat").click(function(){
        	_url = '<%=request.getContextPath() %>/config/hdfs?method=cat&d='+(new Date()).getTime();
        	_url += "&offset="+$("#offset").val()+"&path="+urlfilepath+"&charset="+$("#charset").val();
        	offset =$("#offset").val();
        	ajaxRequest(_url);
        });
        
        $("#first").click(function(){
        	offset=0;
        	_url = '<%=request.getContextPath() %>/config/hdfs?method=cat&d='+(new Date()).getTime();
        	_url += "&offset="+offset+"&path="+urlfilepath+"&charset="+$("#charset").val();
        	ajaxRequest(_url);
        });

        $("#sub").click(function(){
        	offset = parseInt($("#offset").val()) - 1024*10;
        	if(offset <= 0){
        		offset = 0;
        	}
        	_url = '<%=request.getContextPath() %>/config/hdfs?method=cat&d='+(new Date()).getTime();
        	_url += "&offset="+offset+"&path="+urlfilepath+"&charset="+$("#charset").val();
        	
        	ajaxRequest(_url);
        });

        $("#next").click(function(){
        	<% 
	    		try{
	    			Long lashLen=HdfsUtil.getInstance().getLength(request.getParameter("path"),false) - 1024*10;
	        		request.setAttribute("lashLen", lashLen);
	    		}catch(Exception e){
	    			e.printStackTrace();
	    		}
	   		 %>
// 	   		console.info('${lashLen}');
	   		lashLen = ${lashLen};
            console.log("offset="+parseInt($("#offset").val()) + ",lashLen="+lashLen);
	    	if(parseInt($("#offset").val())>=lashLen){
	    		alert("已经是最后一页");
	    	}else{
	    		offset = parseInt($("#offset").val()) + 1024*10;
	        	_url = '<%=request.getContextPath() %>/config/hdfs?method=cat&d='+(new Date()).getTime();
	        	_url += "&offset="+offset+"&path="+urlfilepath+"&charset="+$("#charset").val();
	        	ajaxRequest(_url);
	    	}
        });
        
        $("#last").click(function(){
        	<% 
        		try{
//         			Long lashLen=HdfsUtil.cat4(request.getParameter("path"),1024*10);
        			Long lashLen=HdfsUtil.getInstance().getLength(request.getParameter("path"),false) - 1024*10;
            		request.setAttribute("lashLen", lashLen);
        		}catch(Exception e){
        			e.printStackTrace();
        		}
        		
       		 %>
//        		console.info('${lashLen}');
        	offset = ${lashLen};
        	_url = '<%=request.getContextPath()%>/config/hdfs?method=cat&d='+(new Date()).getTime();
        	_url += "&offset="+-1+"&path="+urlfilepath+"&charset="+charset;
        	ajaxRequest(_url);
        });
        
        $("#export").click(function(){
        	offset = parseInt($("#offset").val());
        	_url = '<%=request.getContextPath() %>/config/hdfs?method=export00&d='+(new Date()).getTime();
        	_url += "&offset="+offset+"&path="+urlfilepath+"&charset="+$("#charset").val();
        	ajaxReponse(_url);
        });
        
        
        function ajaxReponse(_url){
//         	var _data={};
//         	$("#hdfsFileContent").html(data);
			var data = $("#hdfsFileContent").text();
// 			console.log("dataoooooooo========="+data);
    		$.ajax({
    			url:_url,
    			type:"post",
    			dataType:"text",
    			async:true,
    			data:{"data":data},
    			success:function(data, textStatus){
    				
    			},
    			error:function(){
    				console.log("加载数据出错！");
    			}
    		});
    	}
        
        
        
    });

//     function operate(record, rowIndex, colIndex, options) {
//         return '<a href="#" onclick="alert(\'ID=' + gridObj.getRecordIndexValue(record, 'ID') + '\');">Operate</a>';
//     }
</script>

<script type="text/javascript">
$(function(){
	
	function showTable(tableID,isLog){
		var parent = $("#" + tableID + "").parent();
		var resultId = parent.find("div:eq(0)").html();
		var resultJobId = parent.find("div:eq(1)").html();
		var d = new Date();
		var _url = '<%=request.getContextPath() %>/analytics?method=analyticsResult&resultId='+resultId+"&resultJobId="+resultJobId+"&isLog="+isLog+"&d="+d.getTime()+"&linktype="+$("#type").val();
		
		ajaxPolling(parent,_url,tableID,isLog);
	}
	
	function showTable0(localData,tableID,isLog){
// 		console.log("showTable0...");
		gridObj = $.fn.bsgrid.init(tableID, {
            pageSizeSelect: false,
            pageAll:true,
            displayBlankRows: false, // single grid setting
            displayPagingToolbarOnlyMultiPages: true, // single grid setting
            localData: localData,
            processUserdata: function (userdata, options) {
                $("#" + tableID + ' tr th').remove();
                var dynamic_columns = userdata['dynamic_columns'];
                if(!dynamic_columns){return;}
                var cNum = dynamic_columns.length;
                for (var i = 0; i < cNum; i++) {
                    $("#"+tableID+' tr').append('<th w_index="' + dynamic_columns[i] + '">' + dynamic_columns[i] + '</th>');
                }
            }
        });
	}
});
        
</script>