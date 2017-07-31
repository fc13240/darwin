<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.stonesun.realTime.services.db.bean.NodeInfo"%>
<%@page import="java.util.List"%>
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
	//已生效的节点和未生效节点
	int nodeCount =NodeServices.selectCount();
	int successNode =NodeServices.selectSuccessNodeCount();
	int node = 100;
	if(nodeCount>0){
		successNode = successNode*100/nodeCount;
		node = node-successNode;
	}
	
	//已部署流程和未部署流程
	String createUid=String.valueOf(user1.getId());
	int flowCount =FlowServices.selectCount(createUid);
	int flowOnlineCount =FlowServices.selectOnlineCount(createUid);
	int flow = 100;
	if(flowCount>0){
		flowOnlineCount = flowOnlineCount*100/flowCount;
		flow = flow-flowOnlineCount;
	}
	
	session.setAttribute("nodeCount", node);
	session.setAttribute("successNode", successNode);
	request.setAttribute("flowCount", flow);
	request.setAttribute("flowOnlineCount", flowOnlineCount);
	//测试接口
	try{
			Map map= new HashMap<String,String>();
			map.put("Used", "0");
			map.put("Remaining", "100");
			session.setAttribute("Used", map.get("Used"));
			session.setAttribute("Remaining",map.get("Remaining"));
// 		
//       final Map map=new HashMap();
// 		 Thread thread=new Thread(){ 
// 	          public void run() { 
// 	        	  map= FlowServices.getHdfsStatus();
// 	          }
// 	      };
// 	      request.setAttribute("Used", map.get("Used"));
// 		  request.setAttribute("Remaining",map.get("Remaining"));
	     
// 	      thread.start();
			
	}catch(Exception e){e.printStackTrace();}

	//节点成功和失败
	%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					使用概览
				</div>
			</div>
		</div>
	</div>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	
	<div id="main1" style="height:300px;display:none;"  ></div>
    <div id="main" style="height:300px;dispaly:none;"></div>
    <!-- ECharts单文件引入 -->
    <script src="/resources/echarts/echarts.js"></script>
    <script type="text/javascript">
	  
    	//加载页面时
    	$(document).ready(function(){
  			// 在这里写你的代码...
    		$.ajax({
    			  type: "POST",
    			  url: "<%=request.getContextPath()%>/flow?method=getHdfsStatus",
    			  dataType: "json",
    			  success: function(data){
    				  var data=data;
    				  var used;
    				  var remaining;
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
//     					  console.info("--------------"+used);
        				  remaining=data.Remaining;
//         				  console.info("--------------"+remaining);
        				  callback(used,remaining);
    				  }
    			  },
    			  error:function (XMLHttpRequest, textStatus, errorThrown) {
    				  console.info("加载数据失败"); 
    			  }
    		});
		});
    	
    	function callback(used,remaining){
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
			                	var radius = [60, 75];
			                	option = {
			                	    legend: {
			                	        x : 'center',
			                	        y : '80%',
			                	        data:[
			                	            'Hdfs存储使用率','已生效节点','已部署流程'
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
			                	            center : ['15%', '30%'],
			                	            radius : radius,
			                	            x: '0%', 
			                	            itemStyle : labelFromatter,
			                	            data : [
												{name:'未使用', value:remaining, itemStyle : labelBottom},
			                	                {name:'Hdfs存储使用率', value:used,itemStyle : labelTop}
			                	            ]
			                	        },
			                	        {
			                	            type : 'pie',
			                	            center : ['49%', '30%'],
			                	            radius : radius,
			                	            x:'34%', // for funnel
			                	            itemStyle : labelFromatter,
			                	            data : [
			                    	                {name:'未生效节点', value:'${nodeCount}', itemStyle : labelBottom},
			                    	                {name:'已生效节点', value:'${successNode}',itemStyle : labelTop}
			                	            ]
			                	        },
			                	        {
			                	            type : 'pie',
			                	            center : ['82%', '30%'],
			                	            radius : radius,
			                	            x:'67%', // for funnel
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
                	var radius = [60, 75];
                	option = {
                	    legend: {
                	        x : 'center',
                	        y : '80%',
                	        data:[
                	            'Hdfs存储使用率','已生效节点','已部署流程'
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
                	            center : ['15%', '30%'],
                	            radius : radius,
                	            x: '0%', // for funnel
                	            itemStyle : labelFromatter,
                	            data : [
                	                {name:'未使用', value:'${Remaining}', itemStyle : labelBottom},
                	                {name:'Hdfs存储使用率', value:'${Used}',itemStyle : labelTop}
// 									{name:'未使用', value:'used', itemStyle : labelBottom},
//                 	                {name:'Hdfs存储使用率', value:'remaining',itemStyle : labelTop}
                	            ]
                	        },
                	        {
                	            type : 'pie',
                	            center : ['49%', '30%'],
                	            radius : radius,
                	            x:'34%', // for funnel
                	            itemStyle : labelFromatter,
                	            data : [
                    	                {name:'未生效节点', value:'${nodeCount}', itemStyle : labelBottom},
                    	                {name:'已生效节点', value:'${successNode}',itemStyle : labelTop}
                	            ]
                	        },
                	        {
                	            type : 'pie',
                	            center : ['82%', '30%'],
                	            radius : radius,
                	            x:'67%', // for funnel
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
    <div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					节点调度分布  
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<ul class="darwin-node-list" id="darwin-node-list">
		</ul>
	</div>
	<script>
		//块状热力显示
		function BlockHeatmap(container) {
			this.container = container;//绘制块状热点图的容器
			this.containerDom = $('#'+container);
			this.colors = ['rgb(200,200,200)','rgb(218, 226, 137)','rgb(206, 219, 156)','rgb(181, 207, 107)','rgb(99, 121, 57)','rgb(59, 100, 39)'];
		}
		//初始化
		BlockHeatmap.prototype.init = function() {
			this.containerDom.empty().html('<img src="/flow/workFlow/img/loading.gif"');
		};
		//刷新
		BlockHeatmap.prototype.refresh = function(data) {
			var self = this;
			if (data && data.nodes && data.nodes.length>0) {
				var itemdom = $('<li></li>'), blockdom;
				var count = 0, color = '#ccc', uldom;
				//data-toggle="popover" title="" data-content=""
				$.each(data.nodes,function(i, v){
					itemdom = $('<li></li>').appendTo(self.containerDom);
					count = v.flowCount;
					color = self.getColor(count);
					blockdom = $('<a></a>')
								.data('detail', v)
								.attr('role', 'button')
								.attr('tabindex', '0')
								.attr('data-toggle', 'popover')
								.attr('data-trigger','focus')
								.attr('data-placement','top')
								.append('<span class="darwin-node-desc" style="color:'+color+'">'+v.name+'</span>')
								.append('<span class="darwin-node-ip">'+v.ip+'</span>')
								.attr('href', '/flowStatus?method=flowMonitor&id='+v.id)
								.appendTo(itemdom);
					uldom = $('<ul class="darwin-node-flow-list"></ul>')
								.append('<li><span class="darwin-node-flow-desc">流程总数</span><span class="label label-info darwin-node-flow-status">'+v.flowCount+'</span></li>')
// 								.append('<li><span class="darwin-node-flow-desc">执行成功</span><span class="label label-success darwin-node-flow-status">'+v.successCount+'</span></li>')
// 								.append('<li><span class="darwin-node-flow-desc">执行失败</span><span class="label label-danger darwin-node-flow-status">'+v.faildCount+'</span></li>')
								.appendTo(blockdom);

				});
			}
		};
		//获得热力层级
		BlockHeatmap.prototype.getColor = function(value) {
			var level = 0;
			value = parseInt(value);
			if (value==0) {
				level = 0;
			} else if (value > 0 && value < 5) {
				level = 1;
			} else if (value <10) {
				level = 2;
			} else if (value < 20) {
				level = 3;
			} else if (value < 30) {
				level = 4;
			} else {
				level = 5;
			}
			return this.colors[level];
		};
		var blockHeatmap = new BlockHeatmap('darwin-node-list');
		blockHeatmap.init();

		$.ajax({
			url:'/node?method=nodes',
			type:"get",
			dataType:"json",
			async:true,
			success:function(data, textStatus){
				if(data){
					blockHeatmap.refresh(data);
				}
			},
			error:function(){
				console.log("加载数据出错！");
			}
		});
	</script>
	<%@ include file="/resources/common_footer.jsp"%>

</body>
</html>
