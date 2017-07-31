<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style>
.imgBox {
	background-image: url("../resources/images/weblogo.png");
	display: inline-block;
	margin: 5% 0 0 5%;
	width: 26%;
}

.imgBox_c1, .imgBox_c-1	 {
	width: 100%;
	text-align: center;
	color: white;
}

.imgBox_c1 a, .imgBox_c-1 a {
	line-height: 120px;
	font-size: 18px;
	font-family: "微软雅黑";
	color: white;
	text-decoration: none;
}

.imgBox_c1 {
	background-color: rgba(168, 168, 168, 1);
	transition: background-color 1s linear;
}

.imgBox_c-1 {
	background-color: rgba(241, 67, 60, 1);
	transition: background-color 1s linear;
}

.imgBox_c1:hover {
	background-color: rgba(168, 168, 168, 0.9);
	transition: background-color 1s linear;
}

.imgBox_c-1:hover {
	background-color: rgba(241, 67, 60, 0.9);
	transition: background-color 1s linear;
}

.content{
            margin: 0 auto;
            width: 800px;
            font-size: 20px;
            font-family: "Hiragino Sans GB", "微软雅黑", "Microsoft Yahei";
            text-align: center;
            padding-top: 150px;
        }

</style>
</head>

<body class="FrameMenu">

<c:if test="${empty menulist}">
		<div class="content">
    	
		<font color="#FF0000"><strong>抱歉，您没有访问权限……</strong></font>
				
   		 </div>
</c:if>
<c:if test="${!empty menulist}">

	<c:set var="count" value="-1"></c:set>
   <c:forEach var="p" items="${menulist}"  varStatus="status">
   		<c:if test="${status.index%3==0}">
				<c:set var="count" value="${-count }"></c:set>
			</c:if>
			<div class="imgBox">
				<div class="imgBox_c${count }">
					<a href="${p.url}" target="_self">${p.name}</a>
				</div>
			</div>
   		 </c:forEach>
   	</c:if>
</body>
</html>
