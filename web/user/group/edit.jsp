<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.sys.GroupServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.sys.GroupInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>用户组编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%
		String group_total_size = SystemProperties.getInstance().get("group_total_size");
		request.setAttribute("group_total_size", group_total_size);
	%>
	
	<%request.setAttribute("topId", "48");%>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					配置
				</div>
				<!-- 
				<div class="page-header-links">
					<a href="<%=request.getContextPath() %>/analytics?method=index">配置</a> / 管理配置
				</div>
				 -->
			</div>
		</div>
	</div>
	<div class="container mh500">
		<div class="row">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								用户组编辑
							</div>
							<div class="page-header-links">
								<a href="<%=request.getContextPath() %>/user/group?method=index">用户组管理列表</a> / 用户组编辑
							</div>
						</div>
					</div>
				</div>
					<div class="col-md-9">
					<%
						String id = request.getParameter("id");
						if(StringUtils.isNotBlank(id)){
							GroupInfo pro = GroupServices.selectById(Integer.valueOf(id));
							request.setAttribute("group", pro);
						}
					%>
					<form action="<%=request.getContextPath()%>/user/group?method=save" class="form-horizontal" role="form" method="post">
						<input type="hidden" value="${group.id }" name="id"/>
						<input type="hidden" value="${group_total_size }" id="group_total_size"/>
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>用户组名称</label>
							<div class="col-sm-5">
								<input data-rule="required;name;length[1~45];remote[/user/group?method=exist&id=${id}]" value="${group.name}" class="form-control" id="name" name="name" placeholder="用户组名称">
							</div>
						</div>
						<div class="form-group">
							<label for="total" class="col-sm-2 control-label"><span class="redStar">*&nbsp;</span>空间大小</label>
							<div class="col-sm-3">
								<input data-rule="required; total;integer[+];remote[/user/group?method=totalValidate]" <c:if test='${group.total==null}'>value="50"</c:if> value="${group.total}" class="form-control" id="total" name="total" placeholder="空间大小">
							</div>
							
							<div class="col-sm-2">
								<select name="unit" class="form-control" >
									<%
										request.setAttribute("unitMap", DataCache.unitMap);
									%>
									<c:forEach items="${unitMap}" var="item">
							           <option <c:if test='${"GB" == item.key}'>selected="selected"</c:if>value="${item.key}">${item.value}</option>
							        </c:forEach>
								</select>
							</div>
							<label class="help-block">(*可自行设置空间大小,最大${group_total_size }G!)</label>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label"></label>
							<div class="col-sm-5">
								<a href="javascript:history.go(-1);">返回</a> 
								<input type="submit" onclick="return test();" value="保存" class="btn btn-primary" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/resources/common_footer.jsp"%>	
</body>

<script>
//通用按钮的提交表单事件
// 	$("form").on("valid.form", function(e, form){
// 		createMark();
// 		form.submit();
// 	});
	
	function test(){
		var total=$("#total").val();
		var group_total_size=$("#group_total_size").val();
		if(parseInt(total)>parseInt(group_total_size)){
			alert("最大300G哦！");
			return false;
		}
	}
	
	</script>
</html>