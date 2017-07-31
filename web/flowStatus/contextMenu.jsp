<!DOCTYPE html>
<html>
<head>
   <title>Bootstrap å®ä¾ - æ¡çº¹çè¿åº¦æ¡</title>
   <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
   <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
   <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>

<div class="progress progress-striped">
   <div class="progress-bar progress-bar-success" role="progressbar" 
      aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" 	
      style="width: 90%;">
      <span class="sr-only">90% å®æï¼æåï¼</span>
   </div>
</div>
<div class="progress progress-striped">
   <div class="progress-bar progress-bar-info" role="progressbar"
      aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" 	
      style="width: 30%;">
      <span class="sr-only">30% å®æï¼ä¿¡æ¯ï¼</span>
   </div>
</div>
<div class="progress progress-striped">
   <div class="progress-bar progress-bar-warning" role="progressbar" 
      aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" 	
      style="width: 20%;">
      <span class="sr-only">20% å®æï¼è­¦åï¼</span>
   </div>
</div>
<div class="progress progress-striped">
   <div class="progress-bar progress-bar-danger" role="progressbar" 
      aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" 	
      style="width: 10%;">
      <span class="sr-only">10% å®æï¼å±é©ï¼</span>
   </div>
</div>
<!-- <table> -->
<!-- <tr> -->
<!--     <td height="60px;" width="20%" align="right" valign="top"> -->
<!--       <font style="font-weight: bold;">标题：</font> -->
<!--      </td> -->
<!--     <td height="60px;" width="80%" align="left" valign="top"> -->
<!--         <a id="span_content" href="#" style="color: white;" onmousemove="showdiv('span_div','',event)" onmouseover="showdiv('span_div','',event)" onmouseout="showdiv('span_div','none',event)"> -->
<%--     <c:if test="${fn:length(schedule.content eq null?'无':schedule.content)>70}">${fn:substring(schedule.content eq null?'无':schedule.content,0,70)}...</c:if></a> --%>
<%--         <span id="span_content_span"><c:if test="${fn:length(schedule.content eq null?'无':schedule.content)<=70}"> --%>
<%--         ${schedule.content null?'无':schedule.content}</c:if></span> --%>
<!--     </td> -->
<!--      <div id="span_div" class="showDiv" style="display:none"> -->
<%--             ${schedule.content eq null?'无':schedule.content} --%>
<!--     </div>     -->
<!-- </tr></table> -->
<script type="text/javascript">
      function showdiv1(objstr,str,ev) {//根据鼠标位置显示对象,参数ev为event 
                    var ObjX,ObjY;//对象的位置(x,y) 
                    var mouseX=10;//对象的(x)水平位置距离鼠标的宽度 
                    var mouseY=-2;//对象的(y)垂直位置距离鼠标的高度 
                    var obj = document.getElementById(objstr); 
                    obj.style.display=str;//显示或隐藏对象 
                    obj.style.left ='200px'; 
                    obj.style.top ='110px'; 
                }
</script>
</body>
</html>			