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
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
<!-- 	<div id="pagePrivilegeBtns">select,save</div> -->
<%-- 	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div> --%>
	<div class="navbar-inner">
		<div class="navbar-header hidden-sm" style="margin-left: 30px;">
			<a class="" href="<%=request.getContextPath()%>/index.jsp">
				<img width="142px;" height="62px;" src="<%=request.getContextPath()%>/resources/site/img/logo-union.png"/>
			</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="<%=tt.getA("index", request) %>">
					<a href="<%=request.getContextPath()%>/index.jsp">
						<span class="hidden-sm">首页</span>
					</a>
				</li>
				<li class="<%=tt.getA("datasources", request) %>" style="display: none;">
					<a href="<%=request.getContextPath()%>/datasources?method=index">
						<span class="hidden-sm">数据源</span>
					</a>
				</li>
				 
       			<li class="<%=tt.getA("analytics", request) %>" style="display: none;">
       				<a href="<%=request.getContextPath()%>/analytics?method=index">
       					<span class="hidden-sm">分析</span>
       				</a>
       			</li>
       			<!--<li class="<%=tt.getA("task", request) %>">
       				<a href="<%=request.getContextPath()%>/task?method=index">
       					<span class="fui-time"></span>
       					<span class="hidden-sm">任务</span>
       				</a>
       			</li>  -->
       			<li class="<%=tt.getA("configure", request) %>">
<%--        				<a href="<%=request.getContextPath()%>/dashBoard?method=index"> --%>
       				<a href="<%=request.getContextPath()%>/configure/index.jsp">
       					<span class="hidden-sm">配置向导</span>
       				</a>
       			</li>
       			<li class="<%=tt.getA("datasources", request) %>">
       				<a href="<%=request.getContextPath()%>/configure/hdfsManage.jsp">
       					<span class="hidden-sm">数据管理</span>
       				</a>
       			</li>
       			<li class="<%=tt.getA("flow", request) %>">
       				<a href="<%=request.getContextPath()%>/flow?method=index">
       					<span class="hidden-sm">流程管理</span>
       				</a>
       			</li>
       			<li class="<%=tt.getA("report", request) %>">
       				<a href="<%=request.getContextPath()%>/dashBoard?method=report">
       					<span class="hidden-sm">报表</span>
       				</a>
       			</li>
       			<li style="display: none;" class="<%=tt.getA("search", request) %>">
       				<a href="<%=request.getContextPath()%>/search/index.jsp">
       					<span class="hidden-sm"><b>检索</b></span>
       				</a>
       			</li>
       			<li class="<%=tt.getA("dashBoard", request) %>">
<%--        				<a href="<%=request.getContextPath()%>/dashBoard?method=index"> --%>
       				<a href="<%=request.getContextPath()%>/search/dashboard.jsp">
       					<span class="hidden-sm">检索仪表盘</span>
       				</a>
       			</li>
       			<li style="display: none;" class="<%=tt.getA("anaDashBoard", request) %>">
<%--        				<a href="<%=request.getContextPath()%>/dashBoard?method=index"> --%>
       				<a href="<%=request.getContextPath()%>/search/dashboard.jsp?isAna=true">
       					<span class="hidden-sm">仪表盘</span>
       				</a>
       			</li>
<%--        			<li class="<%=tt.getA("sysBoard", request) %>"> --%>
<%--        				<a href="<%=request.getContextPath()%>/sys/index.jsp"> --%>
<!--        					<span class="glyphicon glyphicon-lock"></span> -->
<!--        					<span class="hidden-sm">权限管理</span> -->
<!--        				</a> -->
<!--        			</li> -->
<%--        			<li class="<%=tt.getA("helpBoard", request) %>"> --%>
<%--        				<a href="<%=request.getContextPath()%>/sys/menu/index.jsp"> --%>
<!--        					<span class="fui-document"></span> -->
<!--        					<span class="hidden-sm">文档</span> -->
<!--        				</a> -->
<!--        			</li> -->
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
						<!-- todo:将来实现
						<li>
							<a href="">基本信息</a>
						</li>
						-->
						<li>
							<a href="<%=request.getContextPath()%>/user/updatePwd.jsp">修改密码</a>
						</li>
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/user/project?method=index">项目管理</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/user/taskGroup?method=index">任务组管理</a> --%>
<!-- 						</li> -->
						<!-- todo:将来实现
						<li>
							<a href="">模版管理</a>
						</li>
						-->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/user/connConf?method=index">连接管理</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/user/monitor?method=index">监控项管理</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/user/trigger?method=index">监控告警</a> --%>
<!-- 						</li> -->
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
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/chart?method=index2">分析图表</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/user/group?method=index">用户组</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/sys/index.jsp">权限</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/sys/menu/index.jsp">菜单</a> --%>
<!-- 						</li> -->
<!-- 						<li> -->
<%-- 							<a href="<%=request.getContextPath()%>/es?method=index">es索引管理</a> --%>
<!-- 						</li> -->
					</ul>
				</li><!-- todo:将来实现
				<li>
					<a class="dropdown-toggle" data-toggle="dropdown" title="系统管理">
						<span class="fui-gear"></span>
					</a>
					<ul class="dropdown-menu">
						
						<li>
							<a href="">系统监控</a>
						</li>
						<li>
							<a href="">系统升级</a>
						</li>
						<li>
							<a href="">导入导出</a>
						</li>
						<li>
							<a href="">用户管理</a>
						</li>
						<li>
							<a href="">角色管理</a>
						</li>
						<li>
							<a href="">权限管理</a>
						</li>
						
						<li>
							<a href="<%=request.getContextPath()%>/manage/cache/index.jsp">加载缓存</a>
						</li>
					</ul>
				</li> -->
				<li>
					<a href="<%=request.getContextPath()%>/manage/user?method=exit" title="退出系统">
						<span class="fui-exit"></span>
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
<script>
// $(function(){
		
// 	$("input,button,a").each(function(index,value){
// 		var code = $(value).attr("code");
		
// 		if(code && $.trim(code)!=''){
// 			$(value).attr("style","color:#999;");
// 		}
// 	});
		
// });
</script>