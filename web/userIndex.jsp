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

<script src="/resources/js/jquery.cookie.js"></script>
    <script type="text/javascript">
    $(function(){
    	$.cookie("userId",$("#userId").val(), {path:"/",expiress:7});
		
// 		console.log("userId.cookie:"+$.cookie("userId"));
    });
    </script>

<script src="resources/angular/angular.js"></script>
<script src="userInfo/js/import.js"></script>
<script src="resources/echarts/echarts.js"></script>
<script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: 'resources/echarts'
            }
        });
</script>
<style>
    .user-card{
        padding-left: 0px;
        padding-right: 0px;
        border: 1px solid #ccc;
        height: 160px;
        margin-left: 10px;
        margin-top: 15px;
        margin-bottom: 15px;
    }
    .user-card .content {
        background-color: white;
        float: left;
        height: 157px;
        width: 83%;
        padding: 15px;
    }

    .user-card .title {
        float: left; 
        height: 100%; 
        width: 17%;
        text-align: center;
        background-color: #f9fafc;
    }

	.user-card .title img{
        margin-top: 50px;
    }
</style>

</head>
<body>
	<%request.setAttribute("selectPage", "index");%>
	<%@ include file="/resources/common_menu.jsp"%>
	<%
		UserInfo user1 = (UserInfo) request.getSession().getAttribute(Container.session_userInfo);
	%>
	<input value="${sessionScope.session_userInfo.id }" id="userId" type="hidden"/>
	<div ng-app="userInfo" ng-controller="userInfo" class="container" style="margin-top: 75px; min-height: 450px;">
        <div class="view">
            <div class="row">
                <div id="user-info" class="col-md-4 column">
                    <div class="box-element user-card">
                        <div class="view">
                            <div class="title">
                                <img src="userInfo/img/contact-person.png"/>
                            </div>
                            <div class="content">
                                <center>
                                    <img src="userInfo/img/loading.gif">
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="user-spaces" class="col-md-4 column">
                    <div class="box-element user-card">
                        <div class="view">
                            <div class="title">
                                <img src="userInfo/img/spaces.png"/>
                            </div>
                            <div class="content">
                                <center>
                                    <img src="userInfo/img/loading.gif">
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="user-flow" class="col-md-4 column">
                    <div class="box-element user-card">
                        <div class="view">
                            <div class="title">
                                <img src="userInfo/img/flow.png"/>
                            </div>
                            <div class="content">
                                <center>
                                    <img src="userInfo/img/loading.gif">
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div id="user-db" class="col-md-4 column">
                    <div class="box-element user-card">
                        <div class="view">
                            <div class="title">
                                <img src="userInfo/img/db.png"/>
                            </div>
                            <div class="content">
                                <center>
                                    <img src="userInfo/img/loading.gif">
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="user-idx" class="col-md-4 column">
                    <div class="box-element user-card">
                        <div class="view">
                            <div class="title">
                                <img src="userInfo/img/idx.png"/>
                            </div>
                            <div class="content">
                                <center>
                                    <img src="userInfo/img/loading.gif">
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	<%@ include file="/resources/common_footer.jsp"%>
</body>
</html>
