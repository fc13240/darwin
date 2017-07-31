<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>配置</title>
<%@ include file="/resources/common.jsp"%>
<style type="text/css">
        input[type=checkbox].css-checkbox {
            position: absolute; 
            overflow: hidden; 
            clip: rect(0 0 0 0); 
            height:1px; 
            width:1px; 
            margin:-1px; 
            padding:0;
            border:0;
        }

        input[type=checkbox].css-checkbox + label.css-label {
            padding-left:20px;
            height:15px; 
            display:inline-block;
            line-height:15px;
            background-repeat:no-repeat;
            background-position: 0 0;
            font-size:15px;
            vertical-align:middle;
            cursor:pointer;
        }

        input[type=checkbox].css-checkbox:checked + label.css-label {
            background-position: 0 -15px;
        }
        .lite-disabled{background-image:url(/flow/workFlow/img/disabledCheckbox.png);}
        .lite-check{background-image:url(/flow/workFlow/img/checkbox.png);}
	</style>

</head>
<body>
	<%request.setAttribute("selectPage", Container.module_flow);%>
	<%request.setAttribute("topId", "41");%>
	
	<%
		if(StringUtils.isNotBlank(request.getParameter("id"))){
			int uid = DatasourceServlet.getUid(request);
			if(uid!=1){
				FlowInfo _flowInfo = FlowServices.selectById0(Integer.valueOf(request.getParameter("id")),uid);
				if(_flowInfo == null){
					response.sendRedirect("/resources/403.jsp");
					return;
				}
			}
		}
	%>

	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					流程配置
				</div>
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
		<div class="col-md-3">
		<%-- <c:if test="${empty plateform}">
			<%@ include file="/configure/leftMenu.jsp"%>
		</c:if> --%>
		<%@ include file="compList.jsp"%>
		</div>
			<div class="col-md-9" id="right-container">
				<%try{ %>
					<%@ include file="/flow/workFlow/index.jsp"%>
				<%}catch(ServletException e){e.printStackTrace();throw new ServletException(e);} %>
			</div>
		</div>

	</div>
	<%-- <c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
</body>
</html>