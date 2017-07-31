<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.commons.io.*"%>
<%@page import="com.stonesun.realTime.services.servlet.UserServlet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%

String version = request.getParameter("version").toLowerCase();
String path = UserServlet.class.getResource("/").getFile();
String pp = "WEB-INF/classes/";
String rootPath = path.substring(0, path.indexOf(pp));
String backLib = rootPath + "backLib/";

System.out.println("path="+path);
out.println("path="+path+"<br>");
out.println("rootPath="+rootPath+"<br>");
out.println("backLib="+backLib+"<br>");

String hdfsCoreLib = "hadoop-core-1.2.1.jar";
String outputFile = rootPath + "WEB-INF/lib/"+hdfsCoreLib;

out.println("outputFile = " + outputFile + "<br>");

if(version.equalsIgnoreCase("1x")){
	//copy hdfs.core.jar to web/lib
	BufferedInputStream input = new BufferedInputStream(new FileInputStream(backLib+hdfsCoreLib));
	BufferedOutputStream output = new BufferedOutputStream(new FileOutputStream(outputFile,false));
	int n = IOUtils.copy(input, output);
	output.flush();
	IOUtils.closeQuietly(input);
	IOUtils.closeQuietly(output);
	out.println("n = " + n);
}else{
	//delete hdfs.core.jar to web/lib
	File f = new File(outputFile);
	if(f.exists()){
		boolean r = FileUtils.deleteQuietly(new File(outputFile));
		out.println("r = " + r);
	}else{
		out.println("文件已不存在！");
	}
}
%>