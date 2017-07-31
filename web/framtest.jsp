<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page import="java.util.List"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
class Tmp{
	String getA(String pageName,HttpServletRequest request){
		String selectPage = null;
		if(request.getAttribute("selectPage")!=null){
			selectPage = request.getAttribute("selectPage").toString();
		}else{
			return "";
		}
		if(selectPage.equals(pageName)){
			return "active";
		}
		return "";
	}
}

Tmp tt = new Tmp();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="/resources/common.jsp"%>
<title>首页</title>
    <style>
        *{
            padding: 0;
            margin: 0;
        }
        ul li{
            list-style: none;
        }
        #head{ overflow: hidden; border:1px solid black;}
        #head li{
            line-height: 70px;
            float: left;
            text-align: center;
           margin-left: 50px;
        }
        #main{
        	overflow:hidden;
        	display:none;
        }
        #main2,#main{
        	width:1200px;
        	margin:0 auto;
        }
        #iframebox,#iframebox2{
        	overflow:auto;
        	display:block;
        	border:none;
        	/* with:100%; */
        	height:700px;
        }
        #left{
        	margin-top: 82px;
        	/* border:1px solid black; */
            float: left;
            width: 18%;
            /*border-left: 1px solid #b6b4b6;*/
            /*border-right: 1px solid #b6b4b6;*/
            /*height:auto !important;*/
            /*overflow:visible !important;*/
        }
    	.color{color:black; font-weight:bold;}
        #right{
            width: 80%;
            float:right;
        }
        #navbar-nav>li>span:hover{ color:red;} 
    </style>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/zTree3.5.17/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/zTree3.5.17/js/jquery.ztree.all-3.5.min.js"></script>
</head>
<body>
<div id="head">
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="navbar-inner">
		<div class="navbar-header hidden-sm" style="margin-left: 30px;">
			<a class="" href="<%=request.getContextPath()%>/index.jsp">
				<img width="142px;" height="62px;" src="<%=request.getContextPath()%>/resources/site/img/logo-union.png"/>
			</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav" id="navbar-nav">
				<li class="<%=tt.getA("index", request) %>">
					<%-- <a href="<%=request.getContextPath()%>/index.jsp">
						<span class="hidden-sm">首页</span>
					</a> --%>
					<span class="hidden-sm color">首页</span>
				</li>
				<li class="<%=tt.getA("datasources", request) %>" style="display: none;">
					<%-- <a href="<%=request.getContextPath()%>/datasources?method=index">
						<span class="hidden-sm">数据源</span>
					</a> --%>
					<span class="hidden-sm">数据源</span>
				</li>
				 
       			<li class="<%=tt.getA("analytics", request) %>" style="display: none;">
       				<%-- <a href="<%=request.getContextPath()%>/analytics?method=index">
       					<span class="hidden-sm">分析</span>
       				</a> --%>
       				<span class="hidden-sm">分析</span>
       			</li>
       			<li class="<%=tt.getA("configure", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/configure/index.jsp">
       					<span class="hidden-sm">配置向导</span>
       				</a> --%>
       				<span class="hidden-sm">配置向导</span>
       			</li>
       			<li class="<%=tt.getA("datasources", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/configure/hdfsManage.jsp">
       					<span class="hidden-sm">数据管理</span>
       				</a> --%>
       				<span class="hidden-sm">数据管理</span>
       			</li>
       			<li class="<%=tt.getA("flow", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/flow?method=index">
       					<span class="hidden-sm">流程管理</span>
       				</a> --%>
       				<span class="hidden-sm">流程管理</span>
       			</li>
       			<li class="<%=tt.getA("report", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/dashBoard?method=report">
       					<span class="hidden-sm">报表</span>
       				</a> --%>
       				<span class="hidden-sm">报表</span>
       			</li>
       			<li style="display: none;" class="<%=tt.getA("search", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/search/index.jsp">
       					<span class="hidden-sm"><b>检索</b></span>
       				</a> --%>
       				<span class="hidden-sm"><b>检索</b></span>
       			</li>
       			<li class="<%=tt.getA("dashBoard", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/search/dashboard.jsp">
       					<span class="hidden-sm">检索仪表盘</span>
       				</a> --%>
       				<span class="hidden-sm">检索仪表盘</span>
       			</li>
       			<li style="display: none;" class="<%=tt.getA("anaDashBoard", request) %>">
       				<%-- <a href="<%=request.getContextPath()%>/search/dashboard.jsp?isAna=true">
       					<span class="hidden-sm">仪表盘</span>
       				</a> --%>
       				<span class="hidden-sm">仪表盘</span>
       			</li>
			</ul>
			<ul class="nav navbar-nav navbar-right nav-account">
				<li>
					<a class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span>
						<%
						UserInfo user002 = (UserInfo)session.getAttribute(Container.session_userInfo);
						boolean isAdmin=false;
						request.setAttribute("isAdmin", isAdmin);
						if(user002!=null && user002.getId()==1){
							isAdmin=true;
							request.setAttribute("isAdmin", isAdmin);
						}
						
						if(user002!=null){
						%>
						<%=user002.getNickname() %>
						
						<%} %>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="<%=request.getContextPath()%>/user/updatePwd.jsp">修改密码</a>
						</li>
						<c:if test="${isAdmin }">
							<li>
								<a href="<%=request.getContextPath()%>/user/properties/edit.jsp">系统设置</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/help/upgrade.jsp">升级管理</a>
							</li>
							<li>
								<a href="<%=request.getContextPath()%>/search/dashboard.jsp?type=selfMonitor">自监控</a>
							</li>
						</c:if>
					</ul>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/manage/user?method=exit" title="退出系统">
						<span class="fui-exit"></span>
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
</div>
<div id="main2">
	<iframe id="iframebox2" style="width: 100%;" src="<%=request.getContextPath()%>/index.jsp"></iframe>
</div>
<div id="main">
	<div id="left">
		<!-- 左侧菜单树 -->
			<div id="myTabContent" class="tab-content">
				 <div role="tabpanel" class="tab-pane fade active in" id="lefthome" aria-labelledby="lefthome-tab">
				 		<div class="panel panel-default darwin-left-tree">
							<ul id="treeDemomain" class="ztree ztreeDarwin"></ul>
						</div>
						<%request.setAttribute("type", request.getAttribute("type"));%>
		  		 </div> 
			</div>
	</div>
	<div id="right"><iframe id="iframebox" style="width: 100%;" src=""></iframe></div>
</div>
<%-- <div id="footer">
	<%@ include file="/resources/common_footer.jsp"%>
</div> --%>

<SCRIPT type="text/javascript">
$(function(){
	$(".hidden-sm").click(function(){
		
		$(".hidden-sm").removeClass("color");
		$(this).addClass("color");

		var text=$(this).text();
	/* 	alert(100);
		alert(text);*/
		var url,url2;
		if(text=="首页"){
			$("#main").hide();
			$("#main2").show();
			url2="<%=request.getContextPath()%>/index.jsp";
		}else if(text=="数据管理"){
			$("#main2").hide();
			$("#main").show();
			url="<%=request.getContextPath()%>/configure/hdfsManage.jsp";
		}else if(text=="配置向导"){
			$("#main2").hide();
			$("#main").show();
			url="<%=request.getContextPath()%>/configure/index.jsp";
		}else if(text=="流程管理"){
			$("#main2").hide();
			$("#main").show();
			url="<%=request.getContextPath()%>/flow?method=index";
		}else if(text=="报表"){
			$("#main2").hide();
			$("#main").show();
			url="<%=request.getContextPath()%>/dashBoard?method=report";
		}else if(text=="检索仪表盘"){
			$("#main2").hide();
			$("#main").show();
			url="<%=request.getContextPath()%>/search/dashboard.jsp";
		}
		$("#iframebox").attr("src",url);
		$("#iframebox2").attr("src",url2);
		
	})
	var zt = null;

	var setting = {
			check: {
				enable: false,
				dblClickExpand: false
			},callback: {
// 				onMouseDown: onMouseDown,
				onClick: onClickLeft
			},
			view: {
				showLine: false
			},
			data: {
				key: {
					//将默认的url属性名称改变，他就不会再进行跳转了
					url: "xUrl"
				}
			}
	};
	
	function onClickLeft(e,treeId, treeNode) {
		$.fn.zTree = zt;
		var zTree = $.fn.zTree.getZTreeObj("treeDemomain");
		/* 判断一下这个节点的url是不是undefinded,不是就赋值*/
 		var url = treeNode.url;
		
		// alert(url);
		 
		 if(typeof(url) == 'undefined'){
		 
		 }else{
			 url="<%=request.getContextPath()%>" +url;
			// alert(url);
			 $("#iframebox").attr("src",url);
		 } 
		
		zTree.expandNode(treeNode);
	}
	
	//加载菜单树
	function loadMenusTreeLeft(){
// 		console.log("loadmenu..");
		zt = window.$.fn.zTree;
		$.ajax({
				url:"<%=request.getContextPath() %>/manage/user?method=getPrivilegeMenus&topId=${topId}",
				type:"post",
				dataType:"JSON",
				success:function(data, textStatus){
					if(true){
						
 				//		var zNodes = eval('('+data+')');
 				
						$.fn.zTree.init($("#treeDemomain"), setting, data);
						$("#loadImg").hide();
						$("#treeDemomain").show();
						
						return;
						
					}
					
				},
				error:function(){
					console.log("加载数据出错！");
				}
		});
	}
	
	loadMenusTreeLeft();
	
	
});
</SCRIPT>   
</body>
</html>