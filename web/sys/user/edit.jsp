<%@page import="com.stonesun.realTime.services.db.sys.RoleServices"%>
<%@page import="com.stonesun.realTime.services.db.sys.UserServices"%>
<%@page import="com.stonesun.realTime.services.db.sys.GroupServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.sys.GroupInfo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>用户编辑</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body>
	<%request.setAttribute("selectPage", Container.module_configure);%>
	<%@ include file="/resources/common_menu2.jsp"%>
	<%request.setAttribute("topId", "48");%>
	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
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
		<%-- <c:if test="${empty plateform}">
			<div class="col-md-3">
				<%@ include file="/configure/leftMenu.jsp"%>
			</div>
			</c:if> --%>
			<div class="col-md-9">
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								用户编辑
							</div>
							<div class="page-header-links">
<%-- 								<a href="<%=request.getContextPath() %>/manage/user?method=index">用户管理列表</a> / 用户编辑 --%>
								<a href="<%=request.getContextPath() %>/sys/org/index.jsp">用户与组织机构管理列表</a> / 用户编辑
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-9">
					<%
						String id = request.getParameter("id");
						if(StringUtils.isNotBlank(id)){
							UserInfo user23 = UserServices.selectById(Integer.valueOf(id));
							user23.setPassword(null);
							user23.setPassword2(null);
							request.setAttribute("user", user23);
						}
					%>
					<form action="<%=request.getContextPath()%>/manage/user?method=save" class="form-horizontal" role="form" method="post">
						<input type="hidden" value="${user.id }" name="id"/>
						<input type="hidden" value="${user.orgId }" name="orgId" id="orgId"/>
						<input type="hidden" value="" name="checkGroups" id="checkGroups"/>
						<input type="hidden" value="${user.groupIds }" name="groupIdsShow" id="groupIdsShow"/>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label"></label>
							<div class="col-sm-5">
								<a href="javascript:history.go(-1);">返回</a>
								<input code="save" onclick="return test()" type="submit" value="保存" class="btn btn-primary" />
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>姓名</label>
							<div class="col-sm-5">
								<input data-rule="required;nickname;length[2~25];" value="${user.nickname}" class="form-control" id="nickname" name="nickname" placeholder="昵称">
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>用户名</label>
							<div class="col-sm-5">
								<c:choose>
									<c:when test="${not empty user.username}">
										<input data-rule="required;username;length[2~25];" value="${user.username}" class="form-control" id="username" name="username" placeholder="用户名" readonly="readonly">
									</c:when>
									<c:otherwise>
										<input data-rule="required;username;length[2~25];remote[/manage/user?method=exist&id=${id}]" value="${user.username}" class="form-control" id="username" name="username" placeholder="用户名">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group">
							<label for="orgPath" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>所属组织机构</label>
							<div class="col-sm-5">
								<input value="${user.orgName}" class="form-control input-inline" placeholder="所属组织机构" id="orgPath" name="orgPath" data-rule="required;length[1~245];" readonly="readonly"/>
							</div>
							<div class="col-sm-2">
								<input value="选择" class="btn input-inline" name="select" type="button"/>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>密码</label>
							<div class="col-sm-5">
								<c:choose>
									<c:when test="${not empty user.username}">
										<input data-rule="密码:password" value="${user.password}" class="form-control" id="password" name="password" placeholder="密码" type="password">
									</c:when>
									<c:otherwise>
										<input data-rule="密码:required;password" value="${user.password}" class="form-control" id="password" name="password" placeholder="密码" type="password">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group">
							<label for="password2" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>确认密码</label>
							<div class="col-sm-5">
								<c:choose>
									<c:when test="${not empty user.username}">
										<input data-rule="确认密码:match(password);" value="${user.password2}" class="form-control" id="password2" name="password2" type="password" placeholder="确认密码">
									</c:when>
									<c:otherwise>
										<input data-rule="确认密码:required;match(password);" value="${user.password2}" class="form-control" id="password2" name="password2" type="password" placeholder="确认密码">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label">邮箱</label>
							<div class="col-sm-5">
								<input data-rule="email" value="${user.email}" class="form-control" id="email" name="email" placeholder="邮箱">
							</div>
						</div>
						<div class="form-group">
							<label for="total" class="col-sm-3 control-label"><span class="redStar">*&nbsp;</span>存储配额</label>
							<div class="col-sm-5">
								<input data-rule="required;integer[+];length[1~10];remote[/user/group?method=totalValidate]" value="${user.totalSpace}" class="form-control" id="total" name="total" placeholder="存储配额">
							</div>
							<label class="help-block">*最大存储容量，GB为单位。</label>
						</div>
						<div class="form-group">
							<label for="roleId" class="col-sm-3 control-label" ><span class="redStar">*&nbsp;</span>角色</label>
							<div class="col-sm-5">
								<select data-rule="required;roleId" id="roleId" name="roleId" class="form-control ">
									<%
										request.setAttribute("roles", RoleServices.selectList());
									%>
									<c:choose>
										<c:when test='${user.id==1}'>
											<option value="${user.id}">超级管理员</option>
										</c:when>
										<c:otherwise>
											<option></option>
											<c:forEach items="${roles}" var="item">
									           <option <c:if test='${user.roleId == item.id}'>selected="selected"</c:if>value="${item.id}">${item.name}</option>
									        </c:forEach>
										</c:otherwise>
									</c:choose>
								</select>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%-- <c:if test="${empty plateform}">
<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>	
<script>
function showLayer(_id,_value){
	layer.open({
	    type: 2,
// 	    border: [0,1,'#61BA7A'], //不显示边框
	    area: ['400px', '400px'],
// 	    shade: 0.8,
	    closeBtn: true,
	    shadeClose: true,
	    skin: 'layui-layer-molv', //墨绿风格
	    fix: false, //不固定
// 	    maxmin: true,
	    content: '/sys/orgTree.jsp?compId='+_id+'&pathValue='+_value
		});
	}

	$("input[name=select]").click(function(){
		var _id = $(this).parent().parent().find("input:eq(0)").attr("id");
		var _value = $(this).parent().parent().find("input:eq(0)").val();
		showLayer(_id,_value);
	});
	
		

	
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>
