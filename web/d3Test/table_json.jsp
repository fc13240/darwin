<%@page import="java.net.URLEncoder"%>
<%@page import="com.stonesun.realTime.services.util.excel.CellData"%>
<%@page import="com.stonesun.realTime.services.util.excel.ExcelClient"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.stonesun.realTime.services.test.EsSqlDataParserHelper"%>
<%@page import="java.util.Set"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.stonesun.realTime.services.socket.msg.HeadMsg"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.stonesun.realTime.services.socket.ClientHandler"%>
<%@page import="com.stonesun.realTime.services.elasticsearch.bean.SearchResult"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.stonesun.realTime.services.servlet.SearchServlet"%>
<%@page import="java.util.UUID"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String method = request.getParameter("method");

if(StringUtils.isBlank(method)){

}else if(method.equals("data")){
	/*
	int from = Integer.valueOf(request.getParameter("curPage"));
	int size = Integer.valueOf(request.getParameter("pageSize"));
	System.out.println("form="+from+",size="+size);
	String keyword = request.getParameter("keyword");
	String dsId = request.getParameter("dsId");
	if(StringUtils.isBlank(keyword)){
		keyword = "";
	}

	int dsIdInt = 0;
	if(StringUtils.isNotBlank(dsId)){
		dsIdInt = Integer.valueOf(dsId);
	}

	SearchResult result = SearchServlet.search0(dsIdInt,keyword,from-1,size);
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("success", "true");
	map.put("totalRows", result.getTotal());
	map.put("curPage", from);

	map.put("data", result.getData());

	Map<String,Object> userdataMap = new HashMap<String,Object>();
	userdataMap.put("dynamic_columns", result.getFileds().keySet());
	System.out.println("dynamic_columns="+result.getFileds().keySet());
	map.put("userdata", userdataMap);
	out.println(JSON.toJSONString(map));*/
}else if(method.equals("sql")){
	/*
	int from = Integer.valueOf(request.getParameter("curPage"));
	int size = Integer.valueOf(request.getParameter("pageSize"));
	System.out.println("form="+from+",size="+size);
	String keyword = request.getParameter("keyword");
	String dsId = request.getParameter("dsId");
	if(StringUtils.isBlank(keyword)){
		keyword = "";
	}

	int dsIdInt = 0;
	if(StringUtils.isNotBlank(dsId)){
		dsIdInt = Integer.valueOf(dsId);
	}

	SearchResult result = SearchServlet.search0BySql(dsIdInt,keyword,from-1,size);
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("success", "true");
	map.put("totalRows", result.getTotal());
	map.put("curPage", from);

	map.put("data", result.getData());

	Map<String,Object> userdataMap = new HashMap<String,Object>();
	userdataMap.put("dynamic_columns", result.getFileds().keySet());
	System.out.println("dynamic_columns="+result.getFileds().keySet());
	map.put("userdata", userdataMap);
	out.println(JSON.toJSONString(map));*/

}else if(method.equals("socketSql")){
	//给总线发送sql的搜索请求
	String keyword = request.getParameter("keyword");
	String rangeType = request.getParameter("rangeType");
	String startTime = request.getParameter("startTime");
	String stopTime = request.getParameter("stopTime");
	String op = request.getParameter("op");//search|exportExcel
	int pageSize = Integer.valueOf(request.getParameter("pageSize"));
	int curPage = Integer.valueOf(request.getParameter("curPage"));

	String sql = null;
	if(op.equals("exportExcel")){
		int limitIndex = keyword.indexOf("limit",keyword.indexOf("from"));
		if( limitIndex == -1){
			//最大导出1000条
			sql = keyword;// + " limit 1000";
		}else{
			sql = keyword;
		}
	}else if(op.equals("search")){
		//去掉sql里面的limit，并且补上limit xx,xxx
		int limitIndex = keyword.indexOf("limit",keyword.indexOf("from"));
		if( limitIndex > 0){
			if(curPage >=2){
				sql = keyword.substring(0,limitIndex) + " limit " + (curPage - 1) * pageSize + "," + pageSize;
			}else{
				sql = keyword;
			}
		}else{
			sql = keyword + " limit " + (curPage - 1) * pageSize + "," + pageSize;
		}
	}else{
		throw new RuntimeException("未知操作！");
	}

	System.out.println("===&&&==sql===="+sql);
	if(StringUtils.isBlank(sql)){
		sql = SearchServlet.default_sql;
	}

	//if(StringUtils.isBlank(op)){
		//op = "search";
	//}

	if(StringUtils.isBlank(startTime)){
		startTime = "";
	}
	if(StringUtils.isBlank(stopTime)){
		stopTime = "";
	}
	String msg_id = String.valueOf(HeadMsg.uuid.incrementAndGet());
	JSONObject sqlReq = new JSONObject();
	JSONObject paramsReq = new JSONObject();
	sqlReq.put("service", "search");
	sqlReq.put("api", "sql");
	sqlReq.put("msg_id", msg_id);
	sqlReq.put("params", paramsReq);

	paramsReq.put("period_type", "");
	paramsReq.put("period", "");
	paramsReq.put("range_type", rangeType);
	paramsReq.put("start_time", startTime);
	paramsReq.put("stop_time", stopTime);
	paramsReq.put("sql", sql);
	System.out.println("sql="+sql);
	System.out.println("sqlReq.toJSONString()="+sqlReq.toJSONString());
	ClientHandler.msgQueue.offer(sqlReq.toJSONString());

	try{
		String result = SearchServlet.search(request, response, msg_id, op);
		System.out.println("====last sql=="+sql);
		System.out.println("====op=="+op);
		if(StringUtils.isNotBlank(result)){
			out.println(result);
		}
	}catch(Throwable e){
		e.printStackTrace();
	}

}else if(method.equals("fileds")){

}else if(method.equals("test")){
	/**/
	Map<String,Object> map = new HashMap<String,Object>();
	map.put("success", "true");
	map.put("totalRows", "123");
	map.put("curPage", "1");

	List<Map<String,String>> list = new LinkedList<Map<String,String>>();
	map.put("data", list);

	for(int i=0;i<3;i++){
		Map<String,String> row = new HashMap<String,String>();

		row.put("f1", i+1+"");
		row.put("f2", i+1+"");
		if(i==2){
	row.put("f3", "/default/index/cmanaresv2?itemid=10cba87ced94789e1fc1e2f8045643064");
		}else{
	row.put("f3", String.valueOf(i+1));
		}
		row.put("f4", "123");//UUID.randomUUID().toString() +"?"+ UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString() + UUID.randomUUID().toString()+UUID.randomUUID().toString() + UUID.randomUUID().toString());
		list.add(row);
	}
	Map<String,Object> userdataMap = new HashMap<String,Object>();
	List<String> fileds = new LinkedList<String>();
	fileds.add("f1");
	fileds.add("f2");
	fileds.add("f3");
	fileds.add("f4");
	userdataMap.put("dynamic_columns", fileds);
	map.put("userdata", userdataMap);
	out.println(JSON.toJSONString(map));
}
%>