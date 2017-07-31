<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<script type="text/javascript" src="../resources/bootstrap3/jquery.min.js"></script>
<style>
      *{padding: 0;margin: 0; font-family: "微软雅黑";}
      body{background-color: #f3f3f3;}
     .imgBox{
     	 display:block;
         width: 200px;
         float: left;
         margin-right: 56px;
         margin-bottom: 56px;
         text-align: center;
         text-decoration: none;
     }
     .imgBox span{
     	 text-decoration: none;
         display: block;
         line-height: 84px;
         background-color: white;
         font-size: 16px;
         color: #1e1a1a;
     }
     .imgBox img{
         margin: 62px 0;
     }
     .color0{ background-color: #86644c;}
     .color1{ background-color: #576d9b;}
     .color2{ background-color: #e26360;}
     .color3{ background-color: #506778;}
     .color4{ background-color: #8e8e8e;}
</style>
</head>

<body class="FrameMenu">

<c:if test="${empty menulist}">
		<div class="content">
    	
		<font color="#FF0000"><strong>抱歉，您没有访问权限……</strong></font>
				
   		 </div>
</c:if>
<c:if test="${!empty menulist}">
   <c:forEach var="p" items="${menulist}"  varStatus="status" >
				<a href="${p.url}" target="_self" id="imgBox${status.count}" class="imgBox" >
					<!-- 使用fmt标签从配置文件中获得相应信息 -->
					<img src="<fmt:bundle basename="yiji"><fmt:message key="${p.id}"/></fmt:bundle>">
					<span>${p.name}</span>
				</a>
   		 </c:forEach>
   	</c:if>
</body>
<script type="text/javascript">
	//随机生成标签的颜色
    for(j=1;j<50;j++){
        var ranDom=parseInt(Math.random()*5);
        if(ranDom==0){
            $("#imgBox"+j).addClass('color0');
        }else if(ranDom==1){

            $("#imgBox"+j).addClass('color1');
        }else if(ranDom==2){

            $("#imgBox"+j).addClass('color2');
        }else if(ranDom==3){

            $("#imgBox"+j).addClass('color3');
        }else if(ranDom==4){
            $("#imgBox"+j).addClass('color4');
        }

    }
</script>
</html>
