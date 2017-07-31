package com.realtime.unicom.ext;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.stonesun.realTime.services.servlet.BaseServlet;
import com.stonesun.realTime.services.servlet.Container;
import com.realtime.unicom.service.UserServices2;
import com.stonesun.realTime.utils.LogUtils;

/**
 * 
 * 删除
 * 
 */
public class DelUserServlet  extends BaseServlet  implements Container {
	private static final long serialVersionUID = 1L;
	static final String deletuser = "deletuser";//删除用户
	LogInfo logInfo = new LogInfo(); //记录审计日志
	private static final int DEFAULT_BUFFER_SIZE = 1024 * 4;
    public DelUserServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
							throws ServletException, IOException {
		
				InputStream inputStream = request.getInputStream();
				String username = getRequestBodyJson(inputStream);
				
				response.setContentType( "text/html;charset=utf-8" );
			//	username = request.getParameter("username");
				UserInfo info = UserServices2.selectByUserName(username);
				if(info != null){
					
				if ("admin".equals(username)) {
				logInfo.setStatus(false);
				logInfo.setHttp_message("该用户不允许删除");
				LogUtils.write(logInfo);//记录审计日志
				
				response.getWriter().write("{\"status\":\"0\",\"desc\":\"该用户不允许删除!\"}");
				}else{
					info = UserServices2.selectByUserName(username);
					if(info!=null){
					boolean re = UserServices2.deleteByUserName(username);
					
					logInfo.setStatus(re);
					LogUtils.write(logInfo);//记录审计日志
					
					if(re){
						response.getWriter().write("{\"status\":\"1\",\"desc\":\"该用户已删除!\"}");
						}else{
							response.getWriter().write("{\"status\":\"0\",\"desc\":\"用户删除失败!\"}");
						}
					}else{
						response.getWriter().write("{\"status\":\"1\",\"desc\":\"该用户不存在!\"}");
					}
			}
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
