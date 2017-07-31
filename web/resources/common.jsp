<%@page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<link href="<%=request.getContextPath() %>/resources/site/img/home.ico" rel="Shortcut Icon"/>
<!-- <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap3/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap3/css/bootstrap.css">
<!-- <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap3/css/bootstrap-theme.min.css"> -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap3/navbar-fixed-top.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/flatui/css/flat-ui2.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/site/css/common.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/site/css/ztreeForDarwin.css">

<script src="<%=request.getContextPath() %>/resources/js/jquery-1.9.1.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/bootstrap3/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/flatui/js/flat-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.blockUI.js"></script>
<script src="<%=request.getContextPath() %>/resources/layer/layer.js"></script>

<!-- <script src="http://res.sentsin.com/lay/lib/layer/src/layer.js?v=1.9"></script> -->
<script src="<%=request.getContextPath() %>/resources/js/common-util.js" charset="UTF-8"></script>

<script src="<%=request.getContextPath() %>/resources/ie/modernizr-custom.js"></script>
<script src="<%=request.getContextPath() %>/resources/ie/css3-mediaqueries.js"></script>
<!--[if lt IE 9]>
  <script src="<%=request.getContextPath() %>/resources/ie/respond.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/ie/html5shiv.min.js"></script>
<![endif]-->


<%@ include file="/resources/common_validator.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<meta name="renderer" content="webkit">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<script type="text/javascript">
	var common = {};
	common['$'] = window.$;
	common['blockUI'] = window.$.blockUI;
	common['unblockUI'] = window.$.unblockUI();

</script>
