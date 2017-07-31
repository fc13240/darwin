package com.realtime.unicom.ext;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.stonesun.Md5;
import com.stonesun.realTime.services.core.bean.LogInfo;
import com.realtime.unicom.bean.RegisterResult;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.realtime.unicom.bean.UserInfoEx;
import com.realtime.unicom.service.UserServices2;
import com.stonesun.realTime.services.util.SystemProperties;
import com.stonesun.realTime.utils.HdfsUtil;
/**
 * 注册
 * 1.插入用户表
 * 2.插入公司表(orgId、name、fullName、pid、nodeId(资源池)、createAccount(创建人))
 * 3.创建基础目录(/user/yimr/username)
 * @author Administrator
 *
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int DEFAULT_BUFFER_SIZE = 1024 * 4;
	LogInfo logInfo = new LogInfo(); //记录审计日志
    public RegisterServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//得到request的body中的Json数据
		InputStream inputStream = request.getInputStream();
		String json = getRequestBodyJson(inputStream);
		RegisterResult rr = new RegisterResult();
		Gson gson = new Gson();
/*	    response.setCharacterEncoding("UTF-8");  
	    response.setContentType("application/json; charset=utf-8");*/
		UserInfoEx user = gson.fromJson(json, UserInfoEx.class);
		//设置默认密码
		try {
			user.setPassword(Md5.md5("123456"));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
/*		String id = String.valueOf(user.getId());
		String version = user.getVersion();
		String action = user.getAction();*/
		String username = user.getUsername();
		String roleId = user.getRtw_roleId();
		String orgId = user.getRtw_orgId();
		String type = user.getType();
		user.setGroupIds("");
		
		if("rtw_register".equals(type)){
			if(username != null 
					&& roleId != null
					&& orgId != null
					//&& user.getRtw_orgName() != null 
					){
				//判断数据库中是否有重名用户
				UserInfo u = UserServices2.selectByUserName(username);
				if(u != null){
					System.out.println(u.getUsername());
					rr.setId(user.getId());
					rr.setStatus("0");
					rr.setType("rtw_register");
					rr.setAction("response");
					rr.setDesc("用户名已存在");
					response.getWriter().write(gson.toJson(rr));
				}else{
					//1.插入用户表
					boolean r = UserServices2.insert2(user,logInfo);
					
					//3.创建目录
					if(r){
					UserInfo user1 = UserServices2.selectByUserName(username);
					String hdfs_base_path = SystemProperties.getInstance().get("hdfs_base_path");
					try {
						HdfsUtil.getInstance().createWhenNotExists(hdfs_base_path,username,user1.getId()+"",false);
					} catch (Exception e) {
						e.printStackTrace();
					}
					}
					//封装结果对象
						rr.setId(user.getId());
						rr.setStatus("1");
						rr.setType("rtw_register");
						rr.setAction("response");
						rr.setDesc("注册成功");
						//放入response
						response.getWriter().write(gson.toJson(rr));
				}
				}else{
						rr.setId(user.getId());
						rr.setStatus("0");
						rr.setType("rtw_register");
						rr.setAction("response");
						rr.setDesc("必要字段不能为空");
						response.getWriter().write(gson.toJson(rr));
				}
				}else{
						rr.setId(user.getId());
						rr.setStatus("0");
						rr.setType("rtw_register");
						rr.setAction("response");
						rr.setDesc("请求错误");
						response.getWriter().write(gson.toJson(rr));
				}
	}
	//读取request中的json串
	private String getRequestBodyJson(InputStream inputStream) throws IOException{

		Reader input = new InputStreamReader(inputStream);
        Writer output = new StringWriter();
        char[] buffer = new char[DEFAULT_BUFFER_SIZE];
        int n = 0;
        while(-1 != (n = input.read(buffer))){
            output.write(buffer, 0, n);
        }
        return output.toString();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
