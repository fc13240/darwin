package com.realtime.unicom.ext;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasig.cas.client.authentication.AttributePrincipal;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.stonesun.realTime.services.db.bean.sys.MenuInfo;
import com.stonesun.realTime.services.servlet.BaseServlet;
import com.stonesun.realTime.services.servlet.Container;
import com.realtime.unicom.service.MenuServices2;
import com.realtime.unicom.service.UserServices2;
import com.stonesun.realTime.utils.LogUtils;

/**
 * 
 * 根据权限在一级平台上展示三级的菜单
 * 
 */
public class YijiServlet  extends BaseServlet  implements Container {
	private static final long serialVersionUID = 1L;
	static final String second = "second";//二级接口
	static final String show = "show";//三级接口显示
	static final String system = "system";//显示提升为一级的系统菜单
	static final String systemcheck = "systemcheck";//是否有系统菜单权限
	static final String deletuser = "deletuser";//删除用户
	LogInfo logInfo = new LogInfo(); //记录审计日志
	private static final int DEFAULT_BUFFER_SIZE = 1024 * 4;
    public YijiServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String method = request.getParameter("method");
		String callback = request.getParameter("callback");
		
		//1.得到二级菜单
		if(second.equals(method)){
			
			int roleId = 3;
			//得到cas客户端的用户名称
			String username=request.getRemoteUser();
			
			UserInfo user = new UserInfo();
			if(username != null){
				user = UserServices2.doLogin2(username);
			}
			
			if(user != null){
				if(user.getRoleId() != null){
					roleId = Integer.valueOf(user.getRoleId());
				}else{
					roleId = 3;
				}
			}else{
					roleId = 3;
			}
			//解决=号乱码问题
			Gson gson = new GsonBuilder().disableHtmlEscaping().create(); 
			//通过roleid得到二级菜单且将url变成http://10.1.131.104:9104/yiji?method=show&menunpid="+rs.getInt("id")
			//2级菜单因为url都是no所以需要跳转到写的jsp页面，即其子三级菜单
			List<MenuInfo> menulist = MenuServices2.selectUserPrivilegeMenus2(roleId,0);
			//request.setAttribute("menulist", menulist);
			String json = gson.toJson(menulist);
			System.out.println("2级数据："+json);
			response.getWriter().write(callback+"("+json+")");
		}
		//2.通过二级菜单的url跳到三级菜单列表jsp
		//在url在添加一个参数，区分是url来源
		else if(show.equals(method)){
			//得到父id
			String pid = request.getParameter("menunpid");
			//通过pid得到各个三级菜单
			List<MenuInfo> menulist = MenuServices2.selectListByPid2(Integer.valueOf(pid));
			//测试no
			//List<MenuInfo> menulist1 =  new LinkedList<MenuInfo>();
			//通用no
			List<MenuInfo> nochildlist = new LinkedList<MenuInfo>();
			/**
			 * 在for循环外创建一个集合，遍历id去得到相应的list集合，让这个list不停的自增
			 */
			//基础设置
			if("1".equals(pid)){
				//得到url=no的菜单
				List<MenuInfo> nomenulist = MenuServices2.selectListByPidandUrlIsno(Integer.parseInt(pid));
				//遍历得到所有no下的子菜单
				for(int i=0;i<nomenulist.size();i++){
					//no的子菜单
					List<MenuInfo> nochildlist1 = MenuServices2.selectListByPid2(nomenulist.get(i).getId());
					nochildlist.addAll(nochildlist1);
				}
				
				//得到no子菜单27、3---测试
				//menulist1 = MenuServices2.selectListByPidq(3,27);
			}
			//流程管理
			if("41".equals(pid)){
				//将监控管理的子菜单放入流程管理
				nochildlist = MenuServices2.selectListByPid2(137);
			}
			
			if(!nochildlist.isEmpty()){
				 menulist.addAll(nochildlist);
				 request.setAttribute("menulist", menulist);
			}
			
			//json数据测试专用
			Gson gson = new GsonBuilder().disableHtmlEscaping().create(); 
				
				
			String json = gson.toJson(menulist);
			System.out.println("3级数据："+json);
			//设置到域中
			request.setAttribute("menulist", menulist);
			//跳转到自己的jsp
			request.getRequestDispatcher("/yiji.jsp").forward(request, response);
		}
		//跳转三级系统菜单
		else if(system.equals(method)){
			
			//权限
			int roleId =2;
			AttributePrincipal prin =(AttributePrincipal) request.getUserPrincipal();
			String username = prin.getName();
			UserInfo user = new UserInfo();
			//System.out.println(username);
			if(username != null){
			 user = UserServices2.doLogin2(username);
			}
			
			if(user != null){
				if(user.getRoleId() != null){
					roleId = Integer.valueOf(user.getRoleId());
				}else{
					roleId = 2;
				}
			}else{
					roleId = 2;
			}
			
			List<MenuInfo> menulist = MenuServices2.selectUserPrivilegeMenus3(roleId);
			
			//json数据测试专用
			Gson gson = new GsonBuilder().disableHtmlEscaping().create(); 
			String json = gson.toJson(menulist);
			System.out.println("3级权限数据："+json);
			//设置到域中
			request.setAttribute("menulist", menulist);
			//跳转到自己的jsp
			request.getRequestDispatcher("/yiji.jsp").forward(request, response);
		}
		//动态判断获取系统权限是否存在
		else if(systemcheck.equals(method)){
			UserInfo user = new UserInfo();
			List<MenuInfo> menulist = new LinkedList<MenuInfo>();
			//得到用户名称
			String username=request.getRemoteUser();
			System.out.println(username);
			if(username != null){
				user = UserServices2.doLogin2(username);
			}
			//得到用户相关系统的权限
			if(user != null){
				menulist = MenuServices2.selectUserPrivilegeMenus3(Integer.parseInt(user.getRoleId()));
			}
			//判断集合是否为空
			if(menulist !=null && menulist.size()>0){
				//非空返回1并设置到域中
				response.getWriter().write(callback+"({\"status\":\"1\",\"desc\":\"有系统权限\"})");
			}else{
				//空返回0
				response.getWriter().write(callback+"({\"status\":\"0\",\"desc\":\"没有系统权限\"})");
			}
		}	
		//删除用户
		else if(deletuser.equals(method)){
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
				
				response.getWriter().write(callback+"({\"status\":\"0\",\"desc\":\"该用户不允许删除!\"})");
				}else {
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
				}
			//	response.sendRedirect("/org?method=index");
			}
		}
		}/*else{
			response.getWriter().write("{\"status\":\"1\",\"desc\":\"该用户不存在!\"}");
		}*/
		
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
