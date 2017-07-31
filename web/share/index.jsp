<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.servlet.DatasourceServlet"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>我的分享列表</title>
<%@ include file="/resources/common.jsp"%>
</head>
<body ng-app="common_share">
	<%request.setAttribute("selectPage", Container.module_datasources);%>
	<%request.setAttribute("isAdmin", DatasourceServlet.getUid(request));%>
	<%request.setAttribute("topId", "36");%>

<form action="<%=request.getContextPath() %>/share?method=index" method="post">

	<div style="display:none;" id="pagePrivilegeBtns">${sessionScope.session_pagePrivilegeBtns}</div>
	<div class="page-header">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="page-header-desc">
					数据分享管理
				</div>
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
				<!-- page header start -->
				<div class="page-header">
					<div class="row">
						<div class="col-xs-6 col-md-6">
							<div class="page-header-desc">
								数据分享管理
							</div>
<!-- 							<div class="page-header-links"> -->
<!-- 								数据分享列表 -->
<!-- 							</div> -->
						</div>
 						<div class="col-xs-6 col-md-6">
 							<div class="page-search r">
								<div class="form-group">
									<div class="input-group">
										<input type="search" placeholder="请输入搜索内容" name="name" value="${pager.params.name}" class="form-control" >
										<span class="input-group-btn">
											<button class="btn" type="submit" href="<%=request.getContextPath() %>/share?method=index">
												<span class="fui-search"></span>
											</button>
										</span>
									</div>
								</div>
							</div>
							<div class="page-header-op r" style="margin: 0 5px;width: 180px;">
								<select id="searchType" name="searchType" class="form-control">
									<option value="">--请选择类型--</option>
									<option <c:if test='${pager.params.searchType == "hdfs"}'>selected="selected"</c:if>value="hdfs">hdfs目录</option>
									<option <c:if test='${pager.params.searchType == "hbase"}'>selected="selected"</c:if>value="hbase">hbase表</option>
									<option <c:if test='${pager.params.searchType == "es"}'>selected="selected"</c:if>value="es">索引</option>
								</select>
							</div>
							<div class="page-header-op r">
							</div>
							<div class="page-header-op r">
								&nbsp;&nbsp;
							</div>
							<div class="page-header-op r">
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<!-- page header end -->	
				<!-- page content start -->
				<div>数据分享列表，当前找到 ${pager.total} 个分享</div><p></p>
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>资源类型</th>
							<th>资源</th>
							<th>分享给组织</th>
							<th>分享给指定用户</th>
							<th>状态</th>
							<th>创建日期</th>
							<th style="width: 120px;">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stu" items="${pager.list}">
							<tr>
								<td>${stu.id}</td>
								<td>
									<c:choose>
										<c:when test="${stu.type eq 'hdfs'}">
											hdfs目录
										</c:when>
										<c:when test="${stu.type eq 'hbase'}">
											hbase表
										</c:when>
										<c:when test="${stu.type eq 'es'}">
											索引
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</td>
								<td>${stu.resources}<c:if test="${not empty stu.esType}">/${stu.esType}</c:if></td>
								<td>${stu.orgName}</td>
								<td>${stu.shareUsers}</td>
								<td>
									<c:choose>
										<c:when test="${stu.status eq 'y'}">
											<span class="label label-success">已共享</span>
										</c:when>
										<c:otherwise>
											<span class="label label-default">未共享</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${stu.createtime}</td>
								<td>
									<a code="save" type="button" name="common_share_buttonOne" 
													data-target=".bs-example-modal-lg" onclick="return updateShareFunc(this);">编辑</a>
									<c:choose>
										<c:when test="${stu.status eq 'y'}">
											<!-- <a code="cancel" value="${stu.id}" status="n" href="javascript:void(0);">取消共享</a> -->

											<a code="save" href="/share?method=cancel&id=${stu.id}&status=n">取消共享</a>

										</c:when>
										<c:otherwise>
											<!-- <a code="cancel" value="${stu.id}" status="y" href="javascript:void(0);">共享</a> -->
											<a code="save" href="/share?method=cancel&id=${stu.id}&status=y">共享</a>

											<a code="delete" onclick="return confirmDel()" href="/share?method=deleteById&id=${stu.id}">删除</a>
										</c:otherwise>
									</c:choose>
									
									
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${pager.total==0}">没有查询到任何记录！</c:if>
				<div>
 					<%@ include file="/resources/pager.jsp"%>
				</div>
			</div>
		</div>
	</div>
</form>


<div id="myModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<div class="modal-header">
		        <button code="save" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">修改资源分享</h4>
		      </div>
			
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<ul id="treeDemo_share" class="ztree"></ul>
					</div>
					<div class="col-md-8">
						<!--<h3 style="font-size:18px;">资源分享</h3>-->
						<!-- <div id="title2">{{title2}}</div> -->
						<div class="radio" style="margin:10px;display:inline-block">
							<label><input type="radio" name="shareType" value="shareToOrg" checked="checked" />分享给选定的组织</label>
						</div>
						<div class="radio" style="margin:10px;display:inline-block">
							<label><input type="radio" name="shareType" value="shareToUsers" />分享给选定的用户
							</label>
						</div>
						
						<input code="save" id="shareBtn" type="button" value="分享" class="btn btn-success"  onclick="shareFunc()"/>
						<hr>
						<div id="userListDiv"></div>

					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<input name="shareId" type="hidden"/>
<input name="shareType" type="hidden"/>
<input name="shareResources" type="hidden"/>
<%-- <c:if test="${empty plateform}">
	<%@ include file="/resources/common_footer.jsp"%>
</c:if> --%>
<script>
function confirmDel(){
	if (confirm("确定要删除选择的共享吗？")) {  
		return true;
    }  return false;
}

$(function(){
	$("a[code='cancel']").click(function(){
		var status = $(this).attr("status");
		if(status=='y'){
			status = 'n';
		}else{
			status = 'y';
		}
		$.ajax({
			method:"get",
			url:"/share?method=cancel&id="+$(this).attr("value")+"&status="+status,
			type:"json",
			success:function(data){
				console.log(data);
				if(data.status=='y'){
					$(this).text("取消共享");
				}else{
					$(this).text("共享");
				}
			},error:function(err){
				console.log(err);

			}
		});

	});
	
	//下拉框选择切换事件
	$("#searchType").change(function(){
		if(true){
			var newSelect = $(this).val();
			href = "share?method=index&searchType="+newSelect;
			
			window.location.href=href;
		}
	});

	$("input[name=shareType]").click(function(){
		console.log("radio.click...");
		
		if($(this).attr("value")==='shareToOrg'){
			console.log("shareToOrg");
			$("#userListDiv :checkbox").prop("checked",true);
			$("#userListDiv :checkbox").attr("disabled","disabled");
		}else {
			$("#userListDiv :checkbox").prop("checked",false);
			$("#userListDiv :checkbox").attr("disabled",false);
		}
	});

});

function updateShareFunc(thisObj){
	console.log("updateShareFunc...");
	$(thisObj).attr("data-toggle","modal");
	var p = $(thisObj).parent().parent().find("td");
	var id = $(p.get(0)).text();
	var res = $(p.get(2)).text();
	console.log("id="+id+",res="+res);
	$("input[name='shareId']").val(id)

	initOrgTree();
}

function shareFunc(){
	console.log("shareFunc...");
	/*var res = $scope.shareConfig.resources();
	if(!res || res==''){
		return;
	}*/

	var shareUsers = [],shareType = $("input:checked").val(),orgId=null;
	var shareUsersStr = "";
	$("input[name='shareUser']").each(function(i,v){
		if($(v).prop("checked")){
			shareUsers.push($(v).attr("username"));	
		}
	});

	console.log("shareType="+shareType);

	if(shareType==='shareToUsers' && shareUsers.length == 0){
		alert("请至少选择一个用户！");
		return;
	}

	if(shareType==='shareToUsers'){
		shareUsersStr = shareUsers.toString(",");
	}else{
		
	}

	var treeObj = $.fn.zTree.getZTreeObj("treeDemo_share");
	var nodes = treeObj.getSelectedNodes();
	console.log(nodes);
	if(nodes.length > 0){
		orgId = nodes[0].id;
	}else{
		alert("请选择一个组织！");
	}


	//var treeObj = $.fn.zTree.getZTreeObj("tree");
	//var nodes = treeObj.getSelectedNodes();


	createMark();

	$.ajax({
		type:"get",
		url:"/share?method=update",
		dataType:"text",
		data:{
			"id":$("input[name='shareId']").val(),
			//"type":$scope.shareConfig.type,
			//"resources":$scope.shareConfig.resources(),
			"shareType":shareType,
			"shareUsers":shareUsersStr,
			"orgId":orgId
		},
		success:function(data){
			console.log(data);
			$.unblockUI();
			if(data==="0"){
				alert("分享成功！");
				$('#myModal').modal('hide');
			}else{
				alert("分享失败！");
			}
		},error:function(err){
			alert("分享失败！");
			$.unblockUI();
		}
	});
}

var setting = {
	callback:{
		onMouseDown:onMouseDown
	}
};

function initOrgTree(){
	console.log("init...");
	
	var zNodes = [];

	$.ajax({
		type:"get",
		url:"/org?method=orgTree",
		dataType:"json",
		success:function(data){

			console.log("data:");
			console.log(data);
			zNodes = data;
			$.fn.zTree.init($("#treeDemo_share"), setting, zNodes);
			$.fn.zTree.getZTreeObj("treeDemo_share").expandAll(true);

			//set root selected
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo_share");
			var nodes = treeObj.getNodes();
			// console.log(nodes);
			// console.log(nodes[0]);
			if (nodes.length>0) {
				treeObj.selectNode(nodes[0]);

				$.ajax({
					type:"get",
					url:"/share?method=selectById&id="+$("input[name='shareId']").val(),
					dataType:"json",
					success:function(shareData){
						console.log(shareData);

						if(shareData.status){

							var treeObj = $.fn.zTree.getZTreeObj("treeDemo_share");
							var nodes = treeObj.getNodesByParam("id",parseInt(shareData.shareInfo["orgId"]), null);
							console.log("nodes===="+shareData.shareInfo["orgId"]);

							console.log(nodes);
							if(nodes){
								treeObj.selectNode(nodes[0]);

								onMouseDown(null,null,nodes[0],shareData);
							}
						}else{
// 							alert("此分析已不存在！");
						}
					},error:function(err){
// 						alert("查询分析失败！！");
					}
				});

			}

		},error:function(err){
			alert("加载组织机构数据失败！");
		}
	});
}

function onMouseDown(e,treeId, treeNode,shareData){
	console.log("onMouseDown..");
	console.log(treeNode);
	if(!treeNode["id"]){
		console.log("onMouseDown.exit.");
		return;
	}

	$.ajax({
		type:"get",
		url:"/manage/user?method=getUserByOrgid",
		dataType:"json",
		data:{"orgid":treeNode.id},
		success:function(data){

			console.log("data:");
			console.log(data);
			var html = "";
			console.log("shareData:");
			console.log(shareData);
			if(shareData){
				console.log("shareData.shareInfo.shareType="+shareData.shareInfo.shareType);
			
				if(shareData.shareInfo.shareType==='shareToUsers'){
					$("input[name='shareType'][value='shareToUsers']").prop("checked",true);
					var shareUsers = shareData.shareInfo.shareUsers.split(",");
					for(var i in data){
						var find = false;
						for(var j in shareUsers){
							var u = shareUsers[j];
							if(u===data[i].username){
								find = true;
							}
						}
						if(find){
							html += "<div style='margin:10px;display:inline-block' class='checkbox'><label><input name='shareUser' type='checkbox' username='"+data[i].username+"' checked='checked' />"+data[i].nickname+"</label></div>";
						}else{
							html += "<div style='margin:10px;display:inline-block' class='checkbox'><label><input name='shareUser' type='checkbox' username='"+data[i].username+"' />"+data[i].nickname+"</label></div>";
						}
					}
				}else{
					//checked all
					for(var i in data){
						html += "<div style='margin:10px;display:inline-block' class='checkbox'><label><input name='shareUser' type='checkbox' username='"+data[i].username+"' checked='checked' disabled='disabled'/>"+data[i].nickname+"</label></div>";
					}
				}
			}else{
				$("input[name='shareType'][value='shareToOrg']").prop("checked",true);
				//checked all
				for(var i in data){
					html += "<div style='margin:10px;display:inline-block' class='checkbox'><label><input name='shareUser' type='checkbox' username='"+data[i].username+"' checked='checked' disabled='disabled'/>"+data[i].nickname+"</label></div>";
				}
			}
			$("#userListDiv").html(html);
			
		},error:function(err){
			alert("加载用户失败！");
		}
	});
}
		
</script>
<script src="<%=request.getContextPath() %>/resources/js/btnPrivilege.js"></script>
</body>
</html>