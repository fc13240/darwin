package com.realtime.unicom.ext;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.NodeServices;
import com.stonesun.realTime.services.db.ServerServices;
import com.stonesun.realTime.services.db.bean.NodeInfo;
import com.stonesun.realTime.services.db.bean.ServerInfo;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.stonesun.realTime.services.db.bean.sys.OrgInfo;
import com.stonesun.realTime.services.servlet.BaseServlet;
import com.stonesun.realTime.services.servlet.Container;
import com.stonesun.realTime.services.servlet.OrgServlet;
import com.realtime.unicom.service.OrgServices2;
import com.realtime.unicom.service.UserServices2;

public class PageloadServlet  extends BaseServlet  implements Container {
	private static final long serialVersionUID = 1L;
	static final String select = "select";//显示操作
	static final String orgTree = "orgTree";//显示菜单树
	static final String newOrg = "newOrg";//新增组织机构
	static final String existName = "existName";//判断主机名称是否重名
	static final String ziyuancollection = "ziyuancollection";
	static Logger logger = Logger.getLogger(OrgServlet.class);
	LogInfo logInfo = new LogInfo(); //记录审计日志
	
    public PageloadServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String method = req.getParameter("method");
		String callback = req.getParameter("callback");
	//	UserInfo user = (UserInfo)req.getSession().getAttribute(Container.session_userInfo);
		
		//树加载  org?method=orgTree&isTree=false
		
		if(orgTree.equals(method)){

			logger.error("orgTree...1");
//			String orgId = req.getParameter("orgId");
		//	String orgId = user.getOrgId();//登陆用户的组织机构
			String orgId = "1";
			String isTree = req.getParameter("isTree");
			logger.info("isTree==="+isTree);
			int orgIdVal = 0;
			if(StringUtils.isNotBlank(orgId)){
				orgIdVal = Integer.valueOf(orgId);
//				OrgInfo param = new OrgInfo();
//				param.setId(orgIdVal);
//				OrgInfo r = OrgServices.selectById(param);
//				if(r!=null){
//					orgIdVal = r.getPid();
//				}
			}
			if(StringUtils.isBlank(isTree)){
				isTree="true";
			}
			
			
			String json = JSONObject.toJSONString(OrgServices2.tree(orgIdVal,Boolean.valueOf(isTree),true,true));
			logger.info(json);
			logger.error("orgTree...2");
			System.out.println("xxxxxxxxxxxx"+json);
			resp.getWriter().write( callback+"("+json+")");
			logger.error("orgTree...3");
			return;
		}
		//根据id查询节点  org?method=select&id=1
		else if(select.equals(method)){
			
			String id = req.getParameter("id");
			String checkAll = req.getParameter("checkAll");
			String searchName = req.getParameter("searchName");
			String roleId = req.getParameter("newSelect");
			logger.info("checkAll = "+checkAll);
			logger.info("searchName == "+searchName);
			logger.info("roleId == "+roleId);
			if(StringUtils.isBlank(id)){
				logger.error("id is null !!!!!!!!!");
			}
			
			JSONObject obj = new JSONObject();
			//测试专用
			obj.put("isSave", true);
			obj.put("isDelete", true);
			List<UserInfo> list =new LinkedList<UserInfo>();
			// 其他成员
			if("-1".equals(id)){
				obj.put("id", -1);
				obj.put("pId", 0);
				obj.put("name", "其他");
				obj.put("fullName", "其他");
				list = UserServices2.selectByOrgIdIsNull(roleId,searchName);
			}else{

				OrgInfo info = new OrgInfo();
				info.setId(Integer.valueOf(id));
				info = OrgServices2.selectById(info);
				obj.put("id", id);
				obj.put("pId", info.getPid());
				obj.put("name", info.getName());
				obj.put("fullName", info.getFullName());
				
				if("on".equals(checkAll)){
					List<String> orgs = OrgServices2.treeByPid(Integer.valueOf(id));
					if(orgs.size()>0){
						list = UserServices2.selectByOrgIds(orgs,roleId,searchName);
					}
					logger.info("orgs = "+orgs);
				}else{
					list = UserServices2.selectByOrgId(id,roleId,searchName);
				}
			}
			obj.put("list", list);
			resp.getWriter().write( callback+"("+obj.toJSONString()+")");
			
		}
		//检查名称是否可用
		else if(existName.equals(method)){
			
			String name = req.getParameter("name");
			String id = req.getParameter("id");
			ServerInfo info = new ServerInfo();
			logger.info("name="+name+",id="+id);
			info.setName(name);
			if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(name)){
				//修改主机名称是否存在
				info = ServerServices.selectExistByName(name);
				resp.getWriter().write((info==null || info.getId()==Integer.valueOf(id))?"{\"status\":\"名称可用!\"}":"{\"status\":\"名称已存在!\"}");
			}else if(StringUtils.isNotBlank(name)){//新增主机名称是否存在
				info = ServerServices.selectExistByName(name);
				resp.getWriter().write(info==null?callback+"({\"status\":\"名称可用!\"})":callback+"({\"status\":\"名称已存在!\"})");
			}
			
		}
		//创建新的节点
		else if(newOrg.equals(method)){
			
			String pid = req.getParameter("rtw_orgpid");
			String name = req.getParameter("rtw_orgName");
			String nodeId = req.getParameter("addNodeId");
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
				OrgInfo pIdInfo = OrgServices2.selectById(param);
				String fullName = pIdInfo.getFullName()+"/"+name;
				
				OrgInfo info = new OrgInfo();
				info.setPid(Integer.valueOf(pid));
				info.setName(name);
				info.setFullName(fullName);
				info.setNodeId(Integer.valueOf(nodeId));
				//测试使用
				info.setCreateAccount("admin");
	//			info.setCreateAccount(user.getUsername());
				boolean flag = OrgServices2.insert(info,logInfo);
				
				resp.getWriter().write(flag==true?callback+"({\"status\":\"添加节点成功\"})":callback+"({\"status\":\"失败!\"})");
			}
			
			
		}
		//得到资源池集合
		else if(ziyuancollection.equals(method)){
			
			List<NodeInfo> nodelist = NodeServices.selectList(NodeInfo.node_type_node);
			Gson gson = new Gson();
			String nodes = gson.toJson(nodelist);
			resp.getWriter().write(callback+"("+nodes+")");
		}	
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
