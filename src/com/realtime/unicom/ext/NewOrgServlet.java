package com.realtime.unicom.ext;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.bean.sys.OrgInfo;
import com.stonesun.realTime.services.servlet.BaseServlet;
import com.stonesun.realTime.services.servlet.Container;
import com.realtime.unicom.service.OrgServices2;

import net.sf.json.JSONObject;

public class NewOrgServlet extends BaseServlet  implements Container {
	private static final long serialVersionUID = 1L;
	static Logger logger = Logger.getLogger(NewOrgServlet.class);
	LogInfo logInfo = new LogInfo(); //记录审计日志   
	
    public NewOrgServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
			InputStream inputStream = request.getInputStream();
			//获取json
			String requestJson = getRequestBodyJson(inputStream);
			Map<String, String> map  = JSONObject.fromObject(requestJson);
			//与中国联通下
			String pid = "1";
			String name = map.get("bus_name");
			String nodeId = request.getParameter("addNodeId");
			logger.info("pid = "+pid);
			logger.info("name = "+name);
			logger.info("nodeId = "+nodeId);
			if(StringUtils.isBlank(nodeId)){
				nodeId = "0";
			}
			if(StringUtils.isBlank(pid)){
				throw new ServletException("pid is null!!");
//				resp.getWriter().write("1");
			}else{
			
				OrgInfo param = new OrgInfo();
				param.setId(Integer.valueOf(pid));
				OrgInfo pIdInfo = OrgServices2.selectByPid(Integer.parseInt(pid));
				String fullName = pIdInfo.getFullName()+"/"+name;
				
				OrgInfo info = new OrgInfo();
				info.setPid(Integer.valueOf(pid));
				info.setName(name);
				info.setFullName(fullName);
				info.setNodeId(Integer.valueOf(nodeId));
				//测试使用
				info.setCreateAccount("admin");
				boolean flag = OrgServices2.insert(info,logInfo);
				OrgInfo org = OrgServices2.selectByOrgName(name);
				response.getWriter().write(flag==true?"{\"status\":\"添加节点成功\",\"darwin_orgId\":\""+org.getId()+"\"}":"{\"status\":\"失败!\"}");
			}
		}
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	/**
	 * 读取request中的json数据
	 * @param inputStream
	 * @return
	 */
	private String getRequestBodyJson(InputStream inputStream) {
        Reader input = new InputStreamReader(inputStream);
        Writer output = new StringWriter();
        char[] buffer = new char[1024 * 4];
        int n = 0;
        try {
			while(-1 != (n = input.read(buffer))) {
			    output.write(buffer, 0, n);
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("异常：", e);
		}
       return output.toString();
    }
}
