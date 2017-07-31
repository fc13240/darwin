<%@page import="com.stonesun.realTime.services.db.KeyValueMainServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.MonitorInfo"%>
<%@page import="com.stonesun.realTime.services.db.MonitorServices"%>
<%@page import="com.stonesun.realTime.services.servlet.UserServlet"%>
<%@page import="com.stonesun.realTime.services.db.bean.ShareInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.EsIndexServlet"%>
<%@page import="com.stonesun.realTime.services.db.ShareServices"%>
<%@page import="com.stonesun.realTime.services.db.EsIndexServices"%>
<%@page import="com.stonesun.realTime.services.servlet.SearchServlet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.db.DatasourceServices"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.EsIndexInfo"%>
<%@page import="com.stonesun.realTime.services.core.DataCache"%>
<%@page import="com.stonesun.realTime.services.db.bean.FlowCompInfo"%>
<%@page import="com.stonesun.realTime.services.db.FlowCompServices"%>
<%@page import="com.stonesun.realTime.services.db.bean.TriggerInfo"%>
<%@page import="com.stonesun.realTime.services.db.TriggerServices"%>
<%@page import="com.stonesun.realTime.services.util.SystemProperties"%>

<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%request.setAttribute("selectPage", Container.module_dashBoard);%>
<%request.setAttribute("triggerId", request.getParameter("triggerId"));%>
<%@ include file="/resources/common.jsp"%>
<%-- <%@ include file="/resources/common_menu.jsp"%> --%>
<title>
<c:choose>
	<c:when test="${isAna eq 'true'}">
		仪表盘
	</c:when>
	<c:when test="${not empty triggerId}">
		告警回溯
	</c:when>
	<c:otherwise>
		检索
	</c:otherwise>
</c:choose>

</title>
</head>
<body>
<%
	UserInfo userInfo = ((UserInfo)request.getSession().getAttribute(Container.session_userInfo));
	int uid = userInfo.getId();
	request.setAttribute("uid", uid);
	request.setAttribute("dashbordName", request.getParameter("dashbordName"));
	
	//索引页面过来
	String id = request.getParameter("id");
	String compId = request.getParameter("compId");
	String searchIndex="";
	int categoryId=0; // 分类ID
	String categoryName="全部分类"; // 分类名称
	String befor = SystemProperties.getInstance().get("es_index");
	boolean flag = false;
	
	if(StringUtils.isNotBlank(request.getParameter("type")) 
			&& request.getParameter("type").equals("monitor")){
		String monitorId = request.getParameter("id");
		MonitorInfo monitorInfo = MonitorServices.selectById(Integer.valueOf(monitorId), userInfo.getId());
		request.setAttribute("monitorCond", monitorInfo.getCond());
		request.setAttribute("monitorId", monitorInfo.getId());
		searchIndex = monitorInfo.getIndex();
	}else if(StringUtils.isNotBlank(id) && Integer.valueOf(id) > 0){
		
		//if share es.index
		int shareId = Integer.valueOf(id) - EsIndexServlet.shareEs_id_value;
		if(shareId > 0){
			ShareInfo esShareInfo = ShareServices.selectById2(shareId);
			if(esShareInfo!=null){
				searchIndex = befor + esShareInfo.getResources();
			}else{
				throw new RuntimeException("分享已不存在！");
			}
		}else{
			String isTab = request.getParameter("isTab");
			EsIndexInfo info = EsIndexServices.selectByIdToJsp(id,isTab,userInfo.getUsername(),userInfo.getOrgId());
			if(info==null){
				flag = true;
				System.out.println("info==null,flag=true");
//	 			response.sendRedirect("/resources/403.jsp");
//	 			return;
			}else{
				String indexName = info.getIndexName();
				String tableName = info.getTableName();
				if(StringUtils.isNotBlank(indexName)){
					if(indexName.contains("{")){
						indexName = indexName.substring(0,indexName.indexOf("{") - 1)+"*";
					}
					indexName = befor+indexName;
					if(StringUtils.isNotBlank(isTab) && isTab.equals("true")){
						indexName = indexName+"/"+tableName;
					}
					searchIndex=indexName;
				}
			}
		}
	}else if (StringUtils.isNotBlank(compId) && Integer.valueOf(compId) > 0){
		try{
			
			FlowCompInfo flowComp = FlowCompServices.selectById0(Integer.valueOf(compId),userInfo.getId());
			
			if(flowComp!=null){
				if(StringUtils.isNotBlank(flowComp.getConfig())){
					JSONObject c2 = JSON.parseObject(flowComp.getConfig());
					request.setAttribute("storeinfo", c2.getJSONObject("storeinfo"));
					String indexName = "";
					String tableName = "";
					String compType = request.getParameter("type");
					if("realtimeReceive".equals(compType)){
						indexName = c2.getJSONObject("storeinfo").getJSONObject("esconfig").getString("index");
						tableName = c2.getJSONObject("storeinfo").getJSONObject("esconfig").getString("sourceType");
					}else{
						indexName = c2.getJSONObject("storeinfo").getString("index");
						tableName = c2.getJSONObject("storeinfo").getString("table");
					}
					EsIndexInfo esIndexInfo = EsIndexServices.selectByIndexName(indexName,tableName);
					if(esIndexInfo!=null){
						categoryId = esIndexInfo.getCategoryId();
						categoryName = esIndexInfo.getCategoryName();
					}
					if(StringUtils.isNotBlank(indexName)){
						if(indexName.contains("{")){
							indexName = indexName.substring(0,indexName.indexOf("{") - 1)+"*";
						}
						indexName = befor+indexName;
						searchIndex=indexName+"/"+tableName;
					}
					
					System.out.println("indexName = " + indexName);
					System.out.println("tableName = " + tableName);
					System.out.println("searchIndex = " + searchIndex);
				}
			}else{
				flag = true;
				System.out.println("last flat=true");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
			
	String isAna = request.getParameter("isAna");
	String triggerId = request.getParameter("triggerId");
	request.setAttribute("isAna", isAna);
	request.setAttribute("triggerId", request.getParameter("triggerId"));
	

    //获取需要打开的自监控仪表盘id
    if(StringUtils.isNotBlank(request.getParameter("kbId"))){
    	
    	request.setAttribute("_id",request.getParameter("kbId"));

    }else{
    	
    	request.setAttribute("_id","selfblank");
    }
    
	request.setAttribute("type",request.getParameter("type"));

	if( (StringUtils.isNotBlank(isAna) && isAna.equals("true")) 
			|| StringUtils.isNotBlank(triggerId)){
		
		if(StringUtils.isNotBlank(triggerId)){
			TriggerInfo triggerInfo = TriggerServices.selectById(Integer.valueOf(triggerId),userInfo.getId());
			if(triggerInfo==null){
				flag = true;
			}
		}else{
			request.setAttribute("selectPage", Container.module_dashBoard);
		}
		
	}else{
		request.setAttribute("selectPage", Container.module_dashBoard);
	}
	
	//加载字典列表
	request.setAttribute("keyvalueJsonList", JSON.toJSONString(KeyValueMainServices.selectList(userInfo.getId())));
	
	request.setAttribute("searchIndex", searchIndex);
	request.setAttribute("categoryId", categoryId);
	request.setAttribute("categoryName", categoryName);
	request.setAttribute("flag", flag);
	request.setAttribute("getDashboardPagePrivilegeBtns", UserServlet.getDashboardPagePrivilegeBtns(request.getSession()));
%>
	
	<input id="categoryId" name="categoryId" value="${categoryId}" type="hidden"/>
	<input id="categoryName" name="categoryName" value="${categoryName}" type="hidden"/>
	<input id="searchIndex" name="searchIndex" value="${searchIndex}" type="hidden"/>
	<input id="flag" name="flag" value="${flag}" type="hidden"/>
	<input id="dashbordName" name="dashbordName" value="${dashbordName}" type="hidden"/>
	<div style="display: none;" id="privilegeBtns">${getDashboardPagePrivilegeBtns}</div>
	<div style="display: none;" id="monitorCond">${monitorCond}</div>
	<div style="display: none;" id="monitorId">${monitorId}</div>
	<div style="display: none;" id="keyvalueJsonList">${keyvalueJsonList}</div>

	<div style="display: none;" id="aaaa">${type}</div>
		<div style="display: none;" id="bbbb">${type eq 'selfMonitor'}</div>
	
	<c:choose>
   		<c:when test="${flag}">
			<%@ include file="/resources/403simple.jsp"%>
   		</c:when>
   		<c:otherwise>
	   		<div id="kvList" style="display: none;"></div>
				<div id="dsColumnsDiv" style="display: none;"></div>
				<div id="lookDiv" style="display: none;"></div>
			
				<div style="margin-top: 60px;">
					<c:choose>
						<c:when test="${isAna eq 'true'}">
							<iframe id="dashboard_iframe" onload="this.height=1000" src="<%=request.getContextPath() %>/kbndash/index.html#/dashboard/file/blank.json?<%=request.getQueryString()%>&uid=${uid}" frameborder="no" border="0" scrolling="no" allowtransparency="yes" width="100%">
							</iframe>
						</c:when>
						<c:when test="${not empty triggerId}">
							<iframe id="dashboard_iframe" onload="this.height=1000" src="<%=request.getContextPath() %>/kbndash/index.html#/dashboard/json/lookDiv" frameborder="no" border="0" scrolling="no" allowtransparency="yes" width="100%">
							</iframe>
						</c:when>
						<c:when test="${not empty dashbordName}">
							<iframe id="dashboard_iframe" onload="this.height=1000" src="<%=request.getContextPath() %>/kbn9z/index.html#/dashboard/elasticsearch/${dashbordName}" frameborder="no" border="0" scrolling="no" allowtransparency="yes" width="100%">
							</iframe>
						</c:when>
						<c:when test="${type eq 'monitor'}">
							<iframe id="dashboard_iframe" onload="this.height=1000" src="<%=request.getContextPath() %>/kbn9z/index.html#/dashboard/monitor/blank.json?uid=${uid}&index=${searchIndex}&<%=request.getQueryString()%>" frameborder="no" border="0" scrolling="no" allowtransparency="yes" width="100%">
							</iframe>
						</c:when>
						
						<c:when test="${type eq 'selfMonitor'}">
							<iframe id="dashboard_iframe" onload="this.height=1000" src="<%=request.getContextPath() %>/kbn9z/index.html#/dashboard/selfMonitor/${_id}?<%=request.getQueryString()%>&uid=${uid}" frameborder="no" border="0" scrolling="no" allowtransparency="yes" width="100%">
							</iframe>
						</c:when>
						
						<c:otherwise>
							<iframe id="dashboard_iframe" onload="this.height=1000" src="<%=request.getContextPath() %>/kbn9z/index.html#/dashboard/file/blank.json?uid=${uid}&index=${searchIndex}&<%=request.getQueryString()%>" frameborder="no" border="0" scrolling="no" allowtransparency="yes" width="100%">
							</iframe>
						</c:otherwise>
					</c:choose>
				</div>
				<script type="text/javascript">
					function loadKeyvalue(func){
						var dd  = null;
						var dsId = <%=request.getParameter("dsId")%>;
						$.ajax({
							url:"<%=request.getContextPath() %>/dashApi?method=keyvalue&dsId="+dsId,
							type:"post",
							dataType:"text",
							success:function(data, textStatus){
// 								console.log("loadKeyvalue ajax complete...");
								func(data);
							},
							error:function(){
								console.log("loadKeyvalue加载数据出错！");
								func("error");
							}
						})
					}
                    
                    function iFrameHeight() {
                        var ifm= document.getElementById("dashboard_iframe");
                        var subWeb = document.frames ? document.frames["dashboard_iframe"].document :ifm.contentDocument;
                        if(ifm != null && subWeb != null && subWeb.body != null) {
                            var height = subWeb.body.scrollHeight;
                            if(height > ifm.height){
                                ifm.height = height;
                            }
                        }
                    }
                    
                    window.setInterval("iFrameHeight()", 1000);
                    
					function loadDsColumns(func){
						var dsId = <%=request.getParameter("dsId")%>;
						$.ajax({
							url:"<%=request.getContextPath() %>/dashApi?method=loadDsColumns&dsId="+dsId,
							type:"post",
							dataType:"text",
							success:function(data, textStatus){
// 								console.log("loadDsColumns ajax complete...");
								func(data);
							},
							error:function(){
								console.log("loadDsColumns加载数据出错！");
								func("error");
							}
						})
					}
					
					function loadLook(func){
						var triggerId = <%=request.getParameter("triggerId")%>;
						var time = <%=request.getParameter("time")%>;
						if(!triggerId && triggerId=='null'){
							triggerId = "";
						}
						$.ajax({
							url:"<%=request.getContextPath() %>/dashApi?method=look&triggerId="+triggerId+"&triggerDateTime="+time,
							type:"post",
							dataType:"text",
							success:function(data, textStatus){
// 								console.log("loadLook ajax complete...");
								func(data);
							},
							error:function(){
								console.log("loadLook加载数据出错！");
								func("error");
							}
						})
					}
					
					function getEsConfig(func){
						$.ajax({
							url:"<%=request.getContextPath() %>/dashApi?method=look&triggerId="+triggerId+"&triggerDateTime="+time,
							type:"post",
							dataType:"text",
							success:function(data, textStatus){
								console.log("loadLook ajax complete...");
								func(data);
							},
							error:function(){
								console.log("loadLook加载数据出错！");
								func("error");
							}
						})
					}
					
					loadKeyvalue(function(data){
						$("#kvList").text(data);
					});
					
					loadDsColumns(function(data){
						$("#dsColumnsDiv").text(data);
					});
					
					loadLook(function(data){
						$("#lookDiv").text(data);
					});
					
					</script>
   		</c:otherwise>
   	</c:choose>
	
</body>

<script>
// 	console.log("hahahah！"+$("#searchIndex").val());
// 	console.log("flag"+$("#flag").val());
</script>
</html>