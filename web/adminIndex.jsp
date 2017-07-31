<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.sun.istack.internal.logging.Logger"%>
<%@page import="java.util.Map"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.NodeServices"%>
<%@page import="com.stonesun.realTime.services.db.FlowServices"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>首页</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", "index");%>
	<%@ include file="/resources/common_menu.jsp"%>
	<%
	UserInfo user1 = (UserInfo) request.getSession().getAttribute(Container.session_userInfo);
	request.setAttribute("indexInfo", DataCache.indexInfo);
	//已部署流程和未部署流程
	String createUid=String.valueOf(user1.getId());
	int flowCountDb =FlowServices.selectCount(createUid);
	int flowOnlineCountDb =FlowServices.selectOnlineCount(createUid);
	int flowOnlineCount =0;
	int flow = 100;
	if(flowCountDb>0){
		flowOnlineCount = (int)Math.round(flowOnlineCountDb*100.00/flowCountDb);
		flow = flow-flowOnlineCount;
	}

	request.setAttribute("flowCount", flow);
	request.setAttribute("flowOnlineCount", flowOnlineCount);
	request.setAttribute("flowCountDb", flowCountDb);
	request.setAttribute("flowOnlineCountDb", flowOnlineCountDb);
	//测试接口
	try{
			Map map= new HashMap<String,String>();
			map.put("Used", "0");
			map.put("Remaining", "100");
			map.put("UsedVCores", "0");
			map.put("AllocatedVCores", "100");
			map.put("UsedMB", "0");
			map.put("AllocatedMB", "100");
			request.setAttribute("Used", map.get("Used"));
			request.setAttribute("Remaining",map.get("Remaining"));
			request.setAttribute("UsedVCores", map.get("UsedVCores"));
			request.setAttribute("AllocatedVCores",map.get("AllocatedVCores"));
			request.setAttribute("UsedMB", map.get("UsedMB"));
			request.setAttribute("AllocatedMB",map.get("AllocatedMB"));
	}catch(Exception e){e.printStackTrace();}

	//节点成功和失败
	%>
	<input value="${sessionScope.session_userInfo.id }" id="userId" type="hidden"/>
<!-- 	<div class="page-header" style="margin-top:60px;position: relative;"> -->
<!-- 		<ul id="myTab" style="display: block;width: 230px;margin: 0 auto;position: relative;" class="nav nav-tabs" role="tablist"> -->
	<div class="page-header" style="margin-top:60px;">
		<ul id="myTab" class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">系统使用概览</a></li>
		    <li role="presentation" ><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">平台环境检查
		    </a></li>
	    </ul>
	    <div id="myTabContent" class="tab-content panel panel-body">
	        <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
				<c:choose>
					<c:when test="${sessionScope.session_indexPrivilegeBtns}">
						<jsp:include page="checklist.jsp"></jsp:include>
					</c:when>
					<c:otherwise>
						<jsp:include page="checklistReadonly.jsp"></jsp:include>
					</c:otherwise>
				</c:choose>
			</div>
			<div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
<!-- 		    	<div class="header" style="margin:20px 0;font-size:20px;"> -->
<!-- 					系统使用概览 -->
<!-- 				</div> -->
				<div style="margin-top:50px;">
					<div id="main1" style="height:300px;display:none;"></div>
					<div id="main" style="height:300px;dispaly:none;"></div>
					<div class="page-header">
						<div class="row">
							<div class="col-xs-3 col-md-3">
								<div style="text-align:center;" id="hdfsInfoHidden" >
									<img alt="加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
								</div>
								<div style="text-align:center;" id="hdfsInfo"></div>
								<div style="text-align:center;" class="page-header-desc">
									HDFS磁盘使用情况
								</div>
							</div>
							<div class="col-xs-3 col-md-3">
								<div style="text-align:center;" id="cpuInfoHidden" >
									<img alt="加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
								</div>
								<div style="text-align:center;" id="cpuInfo"></div>
								<div style="text-align:center;" class="page-header-desc">
									资源池cpu管理情况
								</div>
							</div>
							<div class="col-xs-3 col-md-3">
								<div style="text-align:center;" id="memoryInfoHidden" >
									<img alt="加载中......" src="<%=request.getContextPath() %>/resources/images/loading.gif"><span style="font-size: 12px">加载中...</span>
								</div>
								<div style="text-align:center;" id="memoryInfo"></div>
								<div style="text-align:center;" class="page-header-desc">
									资源池内存管理情况
								</div>
							</div>
							<div class="col-xs-3 col-md-3">
								<div style="text-align:center;">总流程数：${flowCountDb }<br>已部署：${flowOnlineCountDb }</div>
								<div style="text-align:center;" class="page-header-desc">
									流程部署情况
								</div>
							</div>
						</div>
					</div>
				</div>
		    </div>
	    </div>
	</div>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->


    <!-- ECharts单文件引入 -->
    <script src="/resources/js/jquery.cookie.js"></script>
    <script src="/resources/echarts/echarts.js"></script>
    <script type="text/javascript">

    	//加载页面时
    	$(document).ready(function(){

    		$.cookie("userId",$("#userId").val(), {path:"/",expiress:7});

//     		console.log("userId.cookie:"+$.cookie("userId"));

 			$("#main").show();
			var used = 0;
			var remaining = 100;
			var usedVCores = 0;
			var allocatedVCores = 100;
			var usedMB = 0;
			var allocatedMB = 100;
					  
			callback(used,remaining,usedVCores,allocatedVCores,usedMB,allocatedMB);

			// 在这里写你的代码...
    		$.ajax({
    			  type: "POST",
    			  url: "<%=request.getContextPath()%>/manage/user?method=getHdfsInfo",
    			  dataType: "json",
    			  success: function(data){
    				  var data=data;
    				  
//     				  console.info(data);
    				  if(data!=null){
    					  $("#main").hide();
    					  $("#main1").show();
    				  }else{
    					  $("#main1").hide();
    					  $("#main").attr("style","height:300px;");
    				  }
    				  if(data!=null){
    					  used=data.Used;
        				  remaining=data.Remaining;
    					  var status = data.status;
    					  if(status){
    						  $("#hdfsInfo").html("总容量："+data.RemainingDb+"<br>已使用："+data.UsedDb+"");
        				  }else{
        					  $("#hdfsInfo").html("<span style='color:red' class='glyphicon glyphicon-exclamation-sign'></span>警告：<br>请检查HDFS状态。");
        				  }
    					  $("#hdfsInfoHidden").hide();
        				  callback(used,remaining,usedVCores,allocatedVCores,usedMB,allocatedMB);
    				  }
    			  },
    			  error:function (XMLHttpRequest, textStatus, errorThrown) {
    				  console.info("加载数据失败");
    			  }
    		});
    		
  			// 在这里写你的代码...
    		$.ajax({
    			  type: "POST",
    			  url: "<%=request.getContextPath()%>/manage/user?method=getHdfsClusterInfo",
    			  dataType: "json",
    			  success: function(data){
    				  var data=data;
//     				  console.info(data);
    				  if(data!=null){
    					  $("#main").hide();
    					  $("#main1").show();
    				  }else{
    					  $("#main1").hide();
    					  $("#main").attr("style","height:300px;");
    				  }
    				  if(data!=null){
        				  usedVCores=data.UsedVCores;
    					  allocatedVCores=data.AllocatedVCores;
    					  
        				  usedMB=data.UsedMB;
    					  allocatedMB=data.AllocatedMB;
    					  var status = data.status;
    					  var redmark = "<span style='color:red' class='glyphicon glyphicon-exclamation-sign'></span>";
    					  if(status){
        					  if(data.statusVCores){
	        					  $("#cpuInfo").html("Hadoop集群总的cpu核数："+data.AllocatedVCoresDb+"<br>已分配的CPU核数："+data.UsedVCoresDb+"");
	            			  }else{
	            				  $("#cpuInfo").html("Hadoop集群总的cpu核数："+data.AllocatedVCoresDb+redmark+"<br>已分配的CPU核数："+data.UsedVCoresDb+""+redmark);	
			            	  }
        					  if(data.statusMB){
        						  $("#memoryInfo").html("Hadoop集群总的内存："+data.AllocatedMBDb+"MB<br>已分配的内存："+data.UsedMBDb+"MB");
	            			  }else{
	            				  $("#memoryInfo").html("Hadoop集群总的内存："+data.AllocatedMBDb+"MB"+redmark+"<br>已分配的内存："+data.UsedMBDb+"MB"+redmark);	
			            	  }  
        					   
        				  }else{
        					  $("#cpuInfo").html("<span style='color:red' class='glyphicon glyphicon-exclamation-sign'></span>警告：<br>请检查集群情况。");
        					  $("#memoryInfo").html("<span style='color:red' class='glyphicon glyphicon-exclamation-sign'></span>警告：<br>请检查集群情况。");
        				  }
    					  $("#cpuInfoHidden").hide();
    					  $("#memoryInfoHidden").hide();
        				  callback(used,remaining,usedVCores,allocatedVCores,usedMB,allocatedMB);
    				  }
    			  },
    			  error:function (XMLHttpRequest, textStatus, errorThrown) {
    				  console.info("加载数据失败");
    			  }
    		});
		});

    	
    	function callback(used,remaining,usedVCores,allocatedVCores,usedMB,allocatedMB){
    		 require(
			            [
			                'echarts',
			                'echarts/chart/pie'
			            ],
			            function (ec) {
			                // 基于准备好的dom，初始化echarts图表
			                var myChart = ec.init(document.getElementById('main1'));
			                var labelTop = {
			                	    normal : {
			                	        label : {
			                	            show : true,
			                	            position : 'center',
			                	            formatter : '{b}',
			                	            textStyle: {
			                	                baseline : 'bottom'
			                	            }
			                	        },
			                	        labelLine : {
			                	            show : false
			                	        }
			                	    }
			                	};
			                	var labelFromatter = {
			                	    normal : {
			                	        label : {
			                	            formatter : function (params){
			                	                return 100 - params.value + '%'
			                	            },
			                	            textStyle: {
			                	                baseline : 'top'
			                	            }
			                	        }
			                	    },
			                	}
			                	var labelBottom = {
			                	    normal : {
			                	        color: '#ccc',
			                	        label : {
			                	            show : true,
			                	            position : 'center'
			                	        },
			                	        labelLine : {
			                	            show : false
			                	        }
			                	    },
			                	    emphasis: {
			                	        color: 'rgba(0,0,0,0)'
			                	    }
			                	};
			                	var radius = [70, 85];
			                	option = {
			                	    legend: {
			                	        x : 'center',
			                	        y : '80%',
			                	        data:[
			                	            '已使用HDFS磁盘容量','已分配的cpu','已分配的内存','已部署流程'
			                	        ]
			                	    },
			                	    title : {
			                	        text: '',
			                	        subtext: '',
			                	        x: 'center'
			                	    },
			                	    series : [
			                	        {
			                	            type : 'pie',
			                	            center : ['15%', '40%'],
			                	            radius : radius,
			                	            x: '15%',
			                	            itemStyle : labelFromatter,
			                	            data : [
												{name:'HDFS磁盘容量', value:remaining, itemStyle : labelBottom},
			                	                {name:'已使用HDFS磁盘容量', value:used,itemStyle : labelTop}
			                	            ]
			                	        },
			                	        {
			                	            type : 'pie',
			                	            center : ['38%', '40%'],
			                	            radius : radius,
			                	            x:'38%', // for funnel
			                	            itemStyle : labelFromatter,
			                	            data : [
			                    	                {name:'Hadoop集群总的cpu核数', value:allocatedVCores, itemStyle : labelBottom},
			                    	                {name:'已分配的cpu', value:usedVCores,itemStyle : labelTop}
			                	            ]
			                	        },
			                	        {
			                	            type : 'pie',
			                	            center : ['63%', '40%'],
			                	            radius : radius,
			                	            x:'63%', // for funnel
			                	            itemStyle : labelFromatter,
			                	            data : [
			                    	                {name:'Hadoop集群总的内存', value:allocatedMB, itemStyle : labelBottom},
			                    	                {name:'已分配的内存', value:usedMB,itemStyle : labelTop}
			                	            ]
			                	        },
			                	        {
			                	            type : 'pie',
			                	            center : ['85%', '40%'],
			                	            radius : radius,
			                	            x:'85%', // for funnel
			                	            itemStyle : labelFromatter,
			                	            data : [
		                    	                {name:'未部署流程', value:'${flowCount}', itemStyle : labelBottom},
		                    	                {name:'已部署流程', value:'${flowOnlineCount}',itemStyle : labelTop}
			                	            ]
			                	        }

			                	    ]
			                	};
			                // 为echarts对象加载数据
			                myChart.setOption(option);
			            }
			        );
  				 }


        //路径配置
        require.config({
            paths: {
                echarts: '/resources/echarts'
            }
        });
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/pie'
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main'));
                var labelTop = {
                	    normal : {
                	        label : {
                	            show : true,
                	            position : 'center',
                	            formatter : '{b}',
                	            textStyle: {
                	                baseline : 'bottom'
                	            }
                	        },
                	        labelLine : {
                	            show : false
                	        }
                	    }
                	};
                	var labelFromatter = {
                	    normal : {
                	        label : {
                	            formatter : function (params){
                	                return 100 - params.value + '%'
                	            },
                	            textStyle: {
                	                baseline : 'top'
                	            }
                	        }
                	    },
                	}
                	var labelBottom = {
                	    normal : {
                	        color: '#ccc',
                	        label : {
                	            show : true,
                	            position : 'center'
                	        },
                	        labelLine : {
                	            show : false
                	        }
                	    },
                	    emphasis: {
                	        color: 'rgba(0,0,0,0)'
                	    }
                	};
                	var radius = [70, 85];
                	option = {
                	    legend: {
                	        x : 'center',
                	        y : '80%',
                	        data:[
                	            '已使用HDFS磁盘容量','已分配的cpu','已分配的内存','已部署流程'
                	        ]
                	    },
                	    title : {
                	        text: '',
                	        subtext: '',
                	        x: 'center'
                	    },
                	    series : [
                	        {
                	            type : 'pie',
                	            center : ['15%', '40%'],
                	            radius : radius,
                	            x: '15%', // for funnel
                	            itemStyle : labelFromatter,
                	            data : [
                	                {name:'HDFS磁盘容量', value:'${Remaining}', itemStyle : labelBottom},
                	                {name:'已使用HDFS磁盘容量', value:'${Used}',itemStyle : labelTop}
                	            ]
                	        },
                	        {
                	            type : 'pie',
                	            center : ['38%', '40%'],
                	            radius : radius,
                	            x:'38%', // for funnel
                	            itemStyle : labelFromatter,
                	            data : [
                    	                {name:'Hadoop集群总的cpu核数', value:'${AllocatedVCores}', itemStyle : labelBottom},
                    	                {name:'已分配的cpu', value:'${UsedVCores}',itemStyle : labelTop}
                	            ]
                	        },
                	        {
                	            type : 'pie',
                	            center : ['63%', '40%'],
                	            radius : radius,
                	            x:'63%', // for funnel
                	            itemStyle : labelFromatter,
                	            data : [
                    	                {name:'Hadoop集群总的内存', value:'${AllocatedMB}', itemStyle : labelBottom},
                    	                {name:'已分配的内存', value:'${UsedMB}',itemStyle : labelTop}
                	            ]
                	        },
                	        {
                	            type : 'pie',
                	            center : ['85%', '40%'],
                	            radius : radius,
                	            x:'85%', // for funnel
                	            itemStyle : labelFromatter,
                	            data : [
                	                {name:'未部署流程', value:'${flowCount}', itemStyle : labelBottom},
                	                {name:'已部署流程', value:'${flowOnlineCount}',itemStyle : labelTop}
                	            ]
                	        }
                	    ]
                	};
                // 为echarts对象加载数据
                myChart.setOption(option);
            }
        );
    </script>

<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>
