package com.realtime.unicom.ext;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alibaba.fastjson.JSON;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.stonesun.realTime.services.db.sys.MenuServices;
import com.realtime.unicom.service.UserServices2;
import com.stonesun.realTime.services.servlet.ConfigureServlet;
import com.stonesun.realTime.services.servlet.Container;
import com.stonesun.realTime.utils.AddressUtils;


public class SsoFilter  implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		//得到cas客户端的用户名称
		String username=req.getRemoteUser();
		//测试使用
		/*if(username==null){
			username = "admin";
		}*/
		
		//System.out.println("username:" + username);
		
	/*	if(username == null || username.equals("")){
			username = "admin";
		}*/
		//String password = MD5.GetMD5Code("admin");
	
			
		UserInfo user = UserServices2.doLogin2(username);
	//	System.out.println("hahaha" + user.getEmail());
		String ip = AddressUtils.getIp(req);
		
		
		req.getSession().setAttribute("session_userIp",ip);//登录IP
		req.getSession().setAttribute("session_userInfo",user);
		req.getSession().setAttribute("session_afterUserInfo",String.valueOf(user.getId()));
//		long start = System.currentTimeMillis();
//		req.getSession().setAttribute(session_userPrivilegeMenus,MenuServices.treeWhenLogin(rids.get(0)).toJSONString());
		
		req.getSession().setAttribute("session_userPrivilegeMenus",MenuServices.treeWhenLogin(Integer.valueOf(user.getRoleId())).toJSONString());
		req.getSession().setAttribute("session_userPrivilegeBtns",MenuServices.selectBtnsPrivilege(user,Integer.valueOf(user.getRoleId())));
		req.getSession().setAttribute("session_indexPrivilegeBtns",MenuServices.selectIndexPrivilege(user.getId(),Integer.valueOf(user.getRoleId())));
		req.getSession().setAttribute("session_defaultHdfsRoot",ConfigureServlet.getHdfsRoot());
		MenuServices.selectHdfsPagePrivilege(req,user,Integer.valueOf(user.getRoleId()));
		
		/**
		 * 加载hdfs数据管理页面的按钮权限（数据分享、清理规则），跨页面权限联动
		 */
		List<String> shareList = MenuServices.selectPagePrivilege(user, Integer.valueOf(user.getRoleId()), "/share?method=index");
		List<String> clearRuleList = MenuServices.selectPagePrivilege(user, Integer.valueOf(user.getRoleId()), "/clearRule?method=index");
		Map<String, String> map = new HashMap<String, String>();
		map.put("shareBtns", com.stonesun.realTime.utils.ArrayUtils.toString(shareList));
		map.put("clearRuleBtns", com.stonesun.realTime.utils.ArrayUtils.toString(clearRuleList));
		req.getSession().setAttribute("session_hdfsGlobalBtnPrivilege",JSON.toJSONString(map));
		
		
		//String url = "http://localhost:8080/RealTimeWeb/manage/user?method=doLogin";

		chain.doFilter(request, response);
	}


	private void ssocheck(ServletRequest req, ServletResponse resp, FilterChain chain, String username) 
			throws IOException, ServletException {
		HttpServletResponse response = (HttpServletResponse) resp;
		HttpServletRequest request = (HttpServletRequest) req;
		//1.先去session中取出user
		UserInfo user = (UserInfo) request.getSession().getAttribute(
				Container.session_userInfo);
		
		if(user == null ){
			//做登录操作--修改userServlet中的dologin
			String password = "admin";
			toLogin(response, request,username,password);
			return;
		}
		chain.doFilter(req, resp);
	}

	private void toLogin(HttpServletResponse response, HttpServletRequest request,
			String username,String password) throws IOException {
		
		String loginpath=request.getContextPath()+"/manage/user?method=doLogin";
		loginpath = loginpath+"&username="+username+"&password=admin";
		response.sendRedirect(loginpath);
		return ;
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

	
}
