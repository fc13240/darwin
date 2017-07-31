<%@page import="java.net.URLDecoder"%>
<%@page import="com.stonesun.realTime.utils.HdfsUtil"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.stonesun.realTime.services.servlet.Container"%>
<%@page import="com.stonesun.realTime.services.db.bean.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%

/**
 * KindEditor JSP
 * 
 * 本JSP程序是演示程序，建议不要直接在实际项目中使用。
 * 如果您确定直接使用本程序，使用之前请仔细确认相关安全设置。
 * 
 */
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
//文件保存目录路径
String savePath = pageContext.getServletContext().getRealPath("/") + "attached/";
//对用户Id做限制
//UserInfo userInfoUpload = (UserInfo)request.getSession().getAttribute(Container.session_userInfo);
//String uid = String.valueOf(userInfoUpload.getId());
//文件保存目录URL
String saveUrl  = request.getContextPath() + "/attached/";

//定义允许上传的文件扩展名
HashMap<String, String> extMap = new HashMap<String, String>();
extMap.put("file", "txt,zip,jar,csv,tsv,xls,xlsx,doc,docx,log");

//最大文件大小
long maxSize = 1024*1024 * 1024; // 1024m

response.setContentType("text/html; charset=UTF-8");

if(!ServletFileUpload.isMultipartContent(request)){
	out.println(getError("请选择文件。"));
	return;
}
//检查目录
File uploadDir = new File(savePath);
if(!uploadDir.isDirectory()){
	out.println(getError("上传目录不存在。"));
	return;
}
//检查目录写权限
if(!uploadDir.canWrite()){
	out.println(getError("上传目录没有写权限。"));
	return;
}

String dirName = request.getParameter("dir");
if (dirName == null) {
	dirName = "image";
}
if(!extMap.containsKey(dirName)){
	out.println(getError("目录名不正确。"));
	return;
}
//创建文件夹
savePath += dirName + "/";// + uid + "/";
saveUrl += dirName + "/";// + uid + "/";
File saveDirFile = new File(savePath);
if (!saveDirFile.exists()) {
	saveDirFile.mkdirs();
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
String ymd = sdf.format(new Date());
savePath += ymd + "/";
saveUrl += ymd + "/";
File dirFile = new File(savePath);
if (!dirFile.exists()) {
	dirFile.mkdirs();
}

FileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");
List items = upload.parseRequest(request);
System.out.println("items.size22="+items.size());
Iterator itr = items.iterator();
while (itr.hasNext()) {
	FileItem item = (FileItem) itr.next();
	String fileName = item.getName();
	System.out.println("fileName="+fileName+","+!item.isFormField());
	long fileSize = item.getSize();
	if (!item.isFormField()) {
		//检查文件大小
		if(item.getSize() > maxSize){
			out.println(getError("上传文件大小超过限制。"));
			return;
		}
		//检查扩展名
		String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
		if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){
			out.println(getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。"));
			return;
		}

		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
		try{
			File uploadedFile = new File(savePath, newFileName);
			item.write(uploadedFile);
			
			//File localFile = new File("f:\\Desktop\\localfile\\123.txt");
			
			System.out.println("request.getParameterMap()="+request.getParameterMap());
			String dscDir = request.getParameter("dscDir");
			dscDir = URLDecoder.decode(dscDir,"utf-8");
// 			String dscDir2 = request.getParameter("dscDir2");
// 			System.out.println("dscDir="+dscDir);
			System.out.println("dscDir="+dscDir);
// 			System.out.println("dscDir2="+dscDir2);
// 			System.out.println("dscDir2="+new String(dscDir2.getBytes(),"utf-8"));
			
			//String hdfsDir = "/user/yimr/localfile/"+fileName;
			//String hdfsDir = dscDir + "/"+fileName;
			//System.out.println("uploadedFile="+uploadedFile+",hdfsDir="+hdfsDir);
			try{
				HdfsUtil.getInstance().uploadLocalFileToHdfs(uploadedFile,dscDir,fileName);
			}catch(Exception e){
				e.printStackTrace();
				//throw e;
				out.println(getError(e.getMessage()));
				return;
			}
			
		}catch(Exception e){
			out.println(getError("上传文件失败。"));
			return;
		}

		//JSONObject obj = new JSONObject();
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("error", 0);
		obj.put("url", saveUrl + newFileName);
		out.println(JSON.toJSONString(obj));//obj.toJSONString());
	}
}
%>
<%!
private String getError(String message) {
	//JSONObject obj = new JSONObject();
	Map<String,Object> obj = new HashMap<String,Object>();
	obj.put("error", 1);
	obj.put("message", message);
	return JSON.toJSONString(obj);
}
%>