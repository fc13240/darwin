package com.realtime.unicom.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.LinkedBlockingQueue;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.C3p0;
import com.stonesun.realTime.services.db.CommonServices;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.stonesun.realTime.services.db.bean.sys.MenuInfo;
import com.stonesun.realTime.services.db.bean.sys.MenuTree;
import com.stonesun.realTime.services.db.bean.sys.PrivilegeInfo;
import com.stonesun.realTime.services.db.sys.PrivilegeServices;
import com.stonesun.realTime.services.servlet.ConfigureServlet;
import com.stonesun.realTime.services.servlet.Container;
import com.stonesun.realTime.services.util.SystemProperties;
import com.stonesun.realTime.utils.LogUtils;
import com.realtime.unicom.utils.PropertiesUtils;

/**
 * 角色的数据层操作
 */
public class MenuServices2 extends CommonServices{
	
	static Logger logger = Logger.getLogger(MenuServices2.class);
	
	public static void main(String[] args) throws Exception {
		//加载配置
		SystemProperties.getInstance().load();
				
		//初始化数据库连接池
		C3p0.getInstance().init();
//		JSONArray root = tree(1);
//		System.out.println(root.toJSONString());
		System.out.println(treeWhenLogin(3).toJSONString());
		
//		MenuInfo MenuInfo = new MenuInfo();
//		MenuServices.insert(MenuInfo);
	}
	
	/**
	 * 显示资源菜单树；如果角色id大于0，则勾选指定角色的资源
	 * @param roleId
	 * @return
	 * @throws ServletException
	 */
	public static JSONArray tree(int roleId) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		JSONArray root = new JSONArray();
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=0 ORDER BY orderNum");
			stmt = conn.prepareStatement(sql.toString());
			rs = stmt.executeQuery();
			
			while(rs.next()){
				MenuTree item = new MenuTree();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setNodeType(rs.getString("type"));
				if(item.getNodeType().equals(MenuTree.MenuTree_type_module)){
					item.setIsParent(true);
				}
				
				//禁用 管理员角色的 《权限管理》 module的checkbox
				if(item.getId() == 48 && roleId==1){
					item.setChkDisabled(true);
				}
				root.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		
		if (root.size() > 0) {
			boolean chkDisabled = false;
			for (int i = 0; i < root.size(); i++) {
				MenuTree orgInfo = (MenuTree) root.get(i);
				
				chkDisabled = false;
				if(orgInfo.getId()==48 && roleId==1){
					chkDisabled = true;
				}
				treeRecursion(chkDisabled,orgInfo);
				
//				addRoles(orgInfo);
			}
			
			if(roleId > 0){
				// 加载指定角色的权限
				PrivilegeInfo privilege = new PrivilegeInfo();
				privilege.setRid(roleId);
				List<PrivilegeInfo> rolePs = PrivilegeServices.selectList(privilege);
				logger.info("加载指定角色的权限.roleId="+roleId);
				logger.info("rolePs="+rolePs);
				
				// 拿角色拥有的菜单和全部的菜单做比对，进行勾选
				for (int i = 0; i < rolePs.size(); i++) {
					PrivilegeInfo p = rolePs.get(i);
					eeee(p, root);
				}
			}
		}
		return root;
	}
	
	/**
	 * 角色权限和资源菜单进行对比，使checkbox选中
	 * @param p
	 * @param menus
	 */
	private static void eeee(PrivilegeInfo p,JSONArray menus){
		for (int j = 0; j < menus.size(); j++) {
			MenuTree menu = (MenuTree) menus.get(j);
			if (p.getMid() == menu.getId()) {
				menu.setChecked(true);
				return;
			}else{
				if(menu.getChildren()!=null && menu.getChildren().size()>0){
					JSONArray list2 = new JSONArray();
					list2.addAll(menu.getChildren());
					eeee(p, list2);
				}
			}
		}
	}
	
//	 and `type`='module'
	private static void treeRecursion(boolean chkDisabled,MenuTree item) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=?  ORDER BY orderNum");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, item.getId());
			rs = stmt.executeQuery();
			
			item.setChildren(new LinkedList<MenuTree>());
			
			while(rs.next()){
				MenuTree item2 = new MenuTree();
				item2.setId(rs.getInt("id"));
				item2.setName(rs.getString("name"));
				item2.setNodeType(rs.getString("type"));//(MenuTree.MenuTree_type_module);
				if(item2.getNodeType().equals(MenuTree.MenuTree_type_module)){
					item2.setIsParent(true);
				}
				
				if(item2.getNodeType().equals(MenuTree.MenuTree_type_page)){
					item2.setIcon("/resources/images/e.png");
				}else if(item2.getNodeType().equals(MenuTree.MenuTree_type_button)){
					item2.setIcon("/resources/images/btn.png");
				}
				
				item2.setChkDisabled(chkDisabled);
				
				item.getChildren().add(item2);
				
//				addRoles(item2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		
		if (item.getChildren() != null && item.getChildren().size() > 0) {
			for(int i=0;i<item.getChildren().size();i++){
				MenuTree item3 = item.getChildren().get(i);
				treeRecursion(chkDisabled,item3);
				
//				addRoles(item3);
			}
		}
	}
	
	public static Map<String, List<String>> selectBtnsPrivilege(UserInfo user,int roleId) throws ServletException{
		List<MenuInfo> menus = selectUserPrivilegeBtnMenus(roleId);
		Map<String, List<String>> pages = new HashMap<String, List<String>>();
		for (Iterator<MenuInfo> it = menus.iterator(); it.hasNext();) {
			MenuInfo item = it.next();
			if (item.getType().equals(MenuInfo.menu_type_page)) {
				String url=item.getUrl();
				if(url.contains("?")){
					url=url.substring(0,url.indexOf("?"));
				}else{
					if("/sys/menu/index.jsp".equals(url)){
						url="/sys";
					}else if("/es/edit.jsp".equals(url)){
						url="/es";
					}else if("/configure/hdfsManage.jsp".equals(url)){
						url="/config/hdfs";
					}
				}
				pages.put(url, getPageBtns(roleId,item.getId(),user));
			}
		}

		return pages;
	}
	
	/**
	 * 判断hdfs页面权限
	 * @param user
	 * @param roleId
	 * @return
	 * @throws ServletException
	 */
	public static void selectHdfsPagePrivilege(HttpServletRequest req,UserInfo user,int roleId) throws ServletException{
		logger.info("selectHdfsPagePrivilege ..........");
		List<MenuInfo> menus = selectUserPrivilegeBtnMenus(roleId);
		for (Iterator<MenuInfo> it = menus.iterator(); it.hasNext();) {
			MenuInfo item = it.next();
			if (item.getType().equals(MenuInfo.menu_type_page)) {
				String url=item.getUrl();
				if("/configure/hdfsManage.jsp".equals(url)){
					List<String> list = getPageBtns(roleId,item.getId(),user);
					if(list.size()>0){
						req.getSession().setAttribute(Container.session_hdfsSavePrivilege,(list.toString().contains("save")));
						req.getSession().setAttribute(Container.session_hdfsDeletePrivilege,(list.toString().contains("delete")));
					}
					break;
				}
			}
		}
	}
	
	public static List<String> selectPagePrivilege(UserInfo user, int roleId,String menuUrl) throws ServletException {
		logger.info("selectHdfsPagePrivilege ..........");
		List<MenuInfo> menus = selectUserPrivilegeBtnMenus(roleId);
		for (Iterator<MenuInfo> it = menus.iterator(); it.hasNext();) {
			MenuInfo item = it.next();
			if (item.getType().equals(MenuInfo.menu_type_page)) {
				String url=item.getUrl();
				if(menuUrl.equals(url)){
					return getPageBtns(roleId,item.getId(),user);
				}
			}
		}
		return Collections.EMPTY_LIST;
	}
	
	/**
	 * 管理员首页，分为只读和读写两种
	 * @param roleId
	 * @return
	 * @throws ServletException
	 */
	public static boolean selectIndexPrivilege(int uid,int roleId) throws ServletException{
		if(uid==1){
			return true;
		}else{
			List<MenuInfo> menus = selectUserPrivilegeBtnMenus(roleId);
			boolean hostFlg=false;
			boolean nodeFlg=false;
			for (Iterator<MenuInfo> it = menus.iterator(); it.hasNext();) {
				MenuInfo item = it.next();
				if (item.getType().equals(MenuInfo.menu_type_page)) {
					String url=item.getUrl();
					String btns = getPageBtns(roleId,item.getId(),null).toString();
					if("/node?method=index".equals(url)){
						if("save".contains(btns) && "delete".equals(btns)){
							hostFlg=true;
						}
					}
					if("/server?method=index".equals(url)){
						if("save".contains(btns) && "delete".equals(btns)){
							nodeFlg=true;
						}
					}
				}
			}
			
			return (hostFlg && nodeFlg);
		}
	}
	
	private static List<String> getPageBtns(int roleId,int pageId,UserInfo user){
		List<MenuInfo> btnMenus;
		List<String> pageBtns = new LinkedList<String>();
		try {
			btnMenus = selectUserPrivilegeMenus(roleId,pageId);
			
			for (MenuInfo menu : btnMenus) {
				if(menu.getPid() == pageId){
					if(user!=null && StringUtils.isNotBlank(user.getRealLoginAccount())){
						pageBtns.add("select");
					}else{
						pageBtns.add(menu.getUrl());
					}
				}
			}
		} catch (ServletException e) {
			e.printStackTrace();
		}
		
		return pageBtns;
	}
	
	/**
	 * 从数据库加载用户的指定角色的全部资源，内存递归形成树
	 * @param roleId
	 * @return
	 * @throws ServletException
	 */
	public static JSONArray treeWhenLogin(int roleId) throws ServletException {
		logger.info("roleId=" + roleId);
		if (roleId <= 0) {
			throw new ServletException("roleId不能小于0，roleId=" + roleId);
		}
		

		JSONArray root = new JSONArray();
		//所有根权限
		List<MenuInfo> menus = selectUserPrivilegeMenus(roleId,0);
//		logger.info(menus);
		for (Iterator<MenuInfo> it = menus.iterator(); it.hasNext();) {
			MenuInfo item = it.next();
//			if (item.getPid() == 0) {
				JSONArray aaa = abc(item, root);
//				it.remove();
				treeWhenLogin0(aaa, roleId,item.getId());
//			}
		}
		
//		logger.info("treeWhenLogin="+root.toJSONString());
		return root;
	}
	
	private static List<MenuInfo> selectUserPrivilegeMenus(int roleId,int menuPid) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			//得到对应角色所有根权限（pid=0）
			StringBuilder sql = new StringBuilder("SELECT * FROM t_menu m where m.id in (SELECT mid FROM t_privilege p where p.rid = ?) and m.pid=? ORDER BY orderNum");//and `type`<> 'button' 
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, roleId);
			stmt.setInt(2, menuPid);
			
			List<MenuInfo> menus = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(rs.getString("url"));
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				menus.add(info);
			}
			return menus;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	/**
	 *二级菜单专用
	 *
	 */
	public static List<MenuInfo> selectUserPrivilegeMenus2(int roleId,int menuPid) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		PropertiesUtils.setProperties("/yiji.properties");
		String Ip = PropertiesUtils.getPropertiesValue("ip");
		try {
			conn = C3p0.getInstance().getConnection();
			//得到对应角色所有根权限（pid=0）
			StringBuilder sql = new StringBuilder("SELECT * FROM t_menu m where m.id in (SELECT mid FROM t_privilege p where p.rid = ?) and m.pid=? ORDER BY orderNum");//and `type`<> 'button' 
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, roleId);
			stmt.setInt(2, menuPid);
			
			List<MenuInfo> menus = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(Ip+"/yiji/aaa?method=show&menunpid="+rs.getInt("id"));
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				//目前需要在一级平台显示的菜单
				if("数据管理".equals(rs.getString("name"))
						||"流程管理".equals(rs.getString("name"))
						||"基础配置".equals(rs.getString("name"))
						){
					menus.add(info);
				}
			}
			return menus;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	//系统管理页面
	public static List<MenuInfo> selectUserPrivilegeMenus3(int roleId) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String aft="&plateform=1";
		try {
			conn = C3p0.getInstance().getConnection();
			//系统管理的列表--数字可以提取出去
			StringBuilder sql = new StringBuilder("SELECT * FROM t_menu m where m.id in (SELECT mid FROM t_privilege p where p.rid = ?) and m.pid in(48,121) ORDER BY orderNum");//and `type`<> 'button' 
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, roleId);
		//	stmt.setInt(2, menuPid);
			
			List<MenuInfo> menus = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(rs.getString("url")+aft);
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				//目前需要在一级平台显示的菜单
			
					menus.add(info);
			
			}
			return menus;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	
	/**
	 * 获取按钮列表
	 * @param roleId
	 * @param menuPid
	 * @return
	 * @throws ServletException
	 */
	private static List<MenuInfo> selectUserPrivilegeBtnMenus(int roleId) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("SELECT * FROM t_menu m where m.id in (SELECT mid FROM t_privilege p where p.rid = ?) and `type`<> 'button' ORDER BY orderNum");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, roleId);
			
			List<MenuInfo> menus = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(rs.getString("url"));
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				menus.add(info);
			}
			return menus;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}

	public static void treeWhenLogin0(JSONArray children, int roleId,int menuPid) throws ServletException {
		List<MenuInfo> menus = selectUserPrivilegeMenus(roleId,menuPid);
		for (Iterator<MenuInfo> it = menus.iterator(); it.hasNext();) {
			MenuInfo item = it.next();
//			if (item.getPid() == pid) {
				JSONArray aaa = abc(item, children);
//				it.remove();
				if(aaa!=null){
					treeWhenLogin0(aaa,roleId,item.getId());
				}
				
//			}
		}
	}
	
	private static JSONArray abc(MenuInfo item, JSONArray root) {
		String type = item.getType();
		if(!MenuInfo.menu_type_botton.equals(type)){
			JSONArray children = new JSONArray();
			JSONObject node = new JSONObject();
			
			node.put("name", item.getName());
			node.put("orderNum", item.getOrderNum());
			if(item.getType().equals("page")){
				node.put("url", item.getUrl());
			}
			node.put("target", "_self");
			if(item.getPid()== 0){
				node.put("open", false);
				node.put("topId", item.getId());
			}else{
				node.put("open", true);
			}
			
			node.put("children", children);
			root.add(node);
			return children;
		}else{
			return null;
		}
		
	}
	
//	private static void addRoles(MenuTree menuTree) throws ServletException {
//		//查询页面列表
//		List<MenuInfo> pages = MenuServices.selectPagesByModuleId(menuTree.getId());
//		if (pages != null && pages.size() > 0) {
//			if(menuTree.getChildren()==null){
//				menuTree.setChildren(new LinkedList<MenuTree>());
//			}
//			for (int j = 0; j < pages.size(); j++) {
//				MenuInfo role = pages.get(j);
//				
//				MenuTree roleNode = new MenuTree();
//				roleNode.setId(role.getId());
//				roleNode.setName(role.getName());
//				roleNode.setNodeType(MenuTree.MenuTree_type_page);
////				roleNode.setIcon(roleNode.icon());
//				menuTree.getChildren().add(roleNode);
//				
//				//查询用户组列表
//				List<MenuInfo> buttons = MenuServices.selectButtons(role.getId());
//				if (buttons != null && buttons.size() > 0) {
//					if(roleNode.getChildren()==null){
//						roleNode.setChildren(new LinkedList<MenuTree>());
//					}
//					for (int k = 0; k < buttons.size(); k++) {
//						MenuInfo g = buttons.get(j);
//						
//						MenuTree gNode = new MenuTree();
//						gNode.setId(g.getId());
//						gNode.setName(g.getName());
//						gNode.setNodeType(MenuTree.MenuTree_type_button);
////						gNode.setIcon(gNode.icon());
//						
//						roleNode.getChildren().add(gNode);
//					}
//				}
//				//查询用户列表
//				
//			}
//		}
//	}
	
	private static List<MenuInfo> selectButtons(int pageId) throws ServletException {
		return ss(pageId);
	}

	private static List<MenuInfo> selectPagesByModuleId(int moduleId) throws ServletException {
		return ss(moduleId);
	}
	
	private static List<MenuInfo> ss(int pid) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, pid);
			
			List<MenuInfo> pages = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo btn = new MenuInfo();
				btn.setId(rs.getInt("id"));
				btn.setPid(rs.getInt("pid"));
				btn.setUrl(rs.getString("url"));
				btn.setName(rs.getString("name"));
				btn.setOrderNum(rs.getInt("orderNum"));
				btn.setType(rs.getString("type"));
				
				pages.add(btn);
			}
			return pages;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}

	public static boolean insert(MenuInfo info,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int i = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("insert into t_menu (pid,url,name,orderNum,type) values (?,?,?,?,?)");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(++i, info.getPid());
			stmt.setString(++i, info.getUrl());
			stmt.setString(++i, info.getName());
			stmt.setInt(++i, info.getOrderNum());
			stmt.setString(++i, info.getType());
			
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
//			LogUtils.write(logInfo);
			
			if(count == 1){
				rs = stmt.getGeneratedKeys();
				if(rs.next()){
					int autoId = rs.getInt(1);
					info.setId(autoId);
				}
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		throw new ServletException("创建失败！");
	}
	
	public static boolean update(MenuInfo info,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int i = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_menu set url=?,name=?,orderNum=?,type=? where id=?");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
//			stmt.setInt(++i, info.getPid());
			stmt.setString(++i, info.getUrl());
			stmt.setString(++i, info.getName());
			stmt.setInt(++i, info.getOrderNum());
			stmt.setString(++i, info.getType());
			stmt.setInt(++i, info.getId());
			
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
//			LogUtils.write(logInfo);
			
			if(count==1){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		return false;
	}
	
	/**
	 * 根据ID查询
	 * @param id
	 * @return
	 */
	public static MenuInfo selectById(int id) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, id);
			
			MenuInfo info = new MenuInfo();
			rs = stmt.executeQuery();
			if(rs.next()){
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(rs.getString("url"));
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				
				return info;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		return null;
	}
	
	public static boolean deleteById(int id,int createUid) throws ServletException{
		logger.info("deleteById.id="+id+",createUid="+createUid);
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement("delete from t_menu where id = ?");
			stmt.setInt(1, id);
			int sql_update = stmt.executeUpdate();
			return sql_update == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}

	/**
	 * 删除菜单
	 * @param ids：菜单的ID
	 * @param deleteParent：是否级联删除父菜单
	 * @throws ServletException 
	 */
	public static void deleteMenu(String ids, boolean deleteParent,LogInfo logInfo) throws ServletException {
		if(StringUtils.isBlank(ids)){
			throw new NullPointerException();
		}
		
		//反复检查，每次都只是删除叶子菜单；deleteParent=true，则尝试删除父菜单，但是 如果父节点下面存在未被选中的子节点，则不继续往下面删除了。
//		deleteMenu0(ids,deleteParent);
		
		
		String[] idArr = ids.split(",");
//		System.out.println(Arrays.toString(idArr));
		// 按照从小到大排序
		Arrays.sort(idArr, new Comparator<String>() {
			public int compare(String o1, String o2) {
				int a1 = Integer.parseInt(o1);
				int a2 = Integer.parseInt(o2);
				if (a1 > a2) {
					return 1;
				} else if (a1 < a2) {
					return -1;
				}
				return 0;
			}
		});
		MenuInfo menu = new MenuInfo();

		if (!deleteParent) {
			// 从菜单ID最小的开始删起，避免先把ID大的删除了，倒置ID小的成为了叶子节点而被删除掉
			for (int i = 0; i < idArr.length; i++) {
				/*
				 * 1、菜单下没有子菜单，直接删除 2、菜单下有子菜单，检查所有的子菜单是否全部已经勾选 A)全部勾选，则可以删除。
				 * B)没有全部勾选，则不能删除。
				 */
				menu.clear();
				menu.setPid(Integer.valueOf(idArr[i]));
				if (getCount(menu) == 0) {
					// 指定节点下没有子菜单，删除指定的菜单(叶子)
					menu.clear();
					menu.setId(Integer.valueOf(idArr[i]));
					deleteById(menu,logInfo);
				}
			}
		} else if (deleteParent) {
			for (int i = idArr.length - 1; i >= 0; i--) {
				/*
				 * 1、菜单下没有子菜单，直接删除 2、菜单下有子菜单，检查所有的子菜单是否全部已经勾选 A)全部勾选，则可以删除。
				 * B)没有全部勾选，则不能删除。
				 */
				menu.clear();
				menu.setPid(Integer.valueOf(idArr[i]));
				if (getCount(menu) == 0) {
					// 指定节点下没有子菜单，删除指定的菜单(叶子)
					menu.clear();
					menu.setId(Integer.valueOf(idArr[i]));
					deleteById(menu,logInfo);
				} else {
					menu.clear();
					menu.setPid(Integer.valueOf(idArr[i]));
					// 查询指定菜单下的全部子菜单
					List<MenuInfo> menus = selectListByPid(menu);
//					System.out.println("find menus:" + menus);
					if (menus != null && menus.size() > 0) {
						if (checkAllContains(idArr, menus)) {
							deleteByPid(menu,logInfo);
//							System.out.println("del menus:" + menu);
						}
					}
				}
			}
		} else {
			throw new NullPointerException("deleteParent:" + deleteParent);
		}
	}
	
	/**
	 * 检查指定的菜单列表是否全部存在于另一个列表中
	 * 
	 * @param idArr
	 *            待删除的菜单列表
	 * @param list
	 *            被检查的菜单列表
	 * @return 全部存在返回true，否则返回false
	 */
	private static boolean checkAllContains(String[] idArr, List<MenuInfo> list) {
		int n = list.size();
		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < idArr.length; j++) {
				if (list.get(i).getId() == Integer.valueOf(idArr[j])) {
					n--;
					break;
				}
			}
		}
		// System.out.println("=========="+Arrays.toString(idArr)+",list:"+list+",n:"+n);
		return n == 0 ? true : false;
	}
	
	private static int getCount(MenuInfo menu) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select count(*) c from t_menu t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, menu.getPid());
			
//			MenuInfo info = new MenuInfo();
			rs = stmt.executeQuery();
			if(rs.next()){
				return rs.getInt("c");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		return 0;
	}
	
	public static boolean deleteById(MenuInfo menu,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "delete from t_menu where id = ?";
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, menu.getId());
			int sql_update = stmt.executeUpdate();
			
			logInfo.setSql(sql);
			logInfo.setStatus(sql_update == 1);
			LogUtils.write(logInfo );
			
			return sql_update == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	public static boolean deleteByPid(MenuInfo menu,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "delete from t_menu where pid = ?";
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, menu.getPid());
			int sql_update = stmt.executeUpdate();
			
			logInfo.setSql(sql);
			logInfo.setStatus(sql_update == 1);
			LogUtils.write(logInfo );
			
			return sql_update == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	public static List<MenuInfo> selectListByPid(MenuInfo menu) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, menu.getPid());
			
			List<MenuInfo> list = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(rs.getString("url"));
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				list.add(info);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	
	public static List<MenuInfo> selectListByPid(int pid) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, pid);
			
			List<MenuInfo> list = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				info.setUrl(rs.getString("url"));
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				list.add(info);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	//加后缀区别哪个平台发送的url
	public static List<MenuInfo> selectListByPid2(int pid) throws ServletException{
	//	String pre = "http://";
	//	String ip = "10.1.131.104:9104/";
		String aft="&plateform=1";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, pid);
			
			List<MenuInfo> list = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				//判断是否是jsp页面
				if(rs.getString("url").contains("jsp")){
					info.setUrl(rs.getString("url"));
				}else{
					info.setUrl(rs.getString("url")+aft);
				}
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				//判断是否是父url
				if(!rs.getString("url").equals("no")){
					list.add(info);
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	//得到no
	public static List<MenuInfo> selectListByPidandUrlno(int pid) throws ServletException{
	//	String pre = "http://";
	//	String ip = "10.1.131.104:9104/";
		String aft="&plateform=1";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_menu t where pid=? and url=no");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, pid);
			
			List<MenuInfo> list = new LinkedList<MenuInfo>();
			//no
			List<MenuInfo> list2 = new LinkedList<MenuInfo>();
			rs = stmt.executeQuery();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setId(rs.getInt("id"));
				info.setPid(rs.getInt("pid"));
				//判断是否是jsp页面
				if(rs.getString("url").contains("jsp")){
					info.setUrl(rs.getString("url"));
				}else{
					info.setUrl(rs.getString("url")+aft);
				}
				info.setName(rs.getString("name"));
				info.setOrderNum(rs.getInt("orderNum"));
				info.setType(rs.getString("type"));
				//判断是否是父url
				if(!rs.getString("url").equals("no")){
					list.add(info);
				}else{
					 list2 = selectListByPid2(rs.getInt("id"));
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	//查询系统管理的两个提升的一级子菜单
	public static List<MenuInfo> selectListByPidq(int pid,int pid2) throws ServletException{
		//	String pre = "http://";
		//	String ip = "10.1.131.104:9104/";
			String aft="&plateform=1";
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				conn = C3p0.getInstance().getConnection();
				StringBuilder sql = new StringBuilder("select * from t_menu t where pid in(?,?)");
				stmt = conn.prepareStatement(sql.toString());
				stmt.setInt(1, pid);
				stmt.setInt(2, pid2);
				List<MenuInfo> list = new LinkedList<MenuInfo>();
				rs = stmt.executeQuery();
				while(rs.next()){
					MenuInfo info = new MenuInfo();
					info.setId(rs.getInt("id"));
					info.setPid(rs.getInt("pid"));
					//判断是否是jsp页面
					if(rs.getString("url").contains(".jsp")){
						info.setUrl(rs.getString("url"));
					}else{
						info.setUrl(rs.getString("url")+aft);
					}
					info.setName(rs.getString("name"));
					info.setOrderNum(rs.getInt("orderNum"));
					info.setType(rs.getString("type"));
					list.add(info);
				}
				return list;
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServletException(e);
			} finally {
				closeAll(conn, stmt, rs);
			}
		}
	
	
	
	//通过父id查询其子菜单中url是no的
		public static List<MenuInfo> selectListByPidandUrlIsno(int pid) throws ServletException{
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				try {
					conn = C3p0.getInstance().getConnection();
					StringBuilder sql = new StringBuilder("select * from t_menu t where pid=? and url='no'");
					stmt = conn.prepareStatement(sql.toString());
					stmt.setInt(1, pid);
					List<MenuInfo> list = new LinkedList<MenuInfo>();
					rs = stmt.executeQuery();
					while(rs.next()){
						MenuInfo info = new MenuInfo();
						info.setId(rs.getInt("id"));
						info.setPid(rs.getInt("pid"));
						list.add(info);
					}
					return list;
				} catch (Exception e) {
					e.printStackTrace();
					throw new ServletException(e);
				} finally {
					closeAll(conn, stmt, rs);
				}
			}
//	public static void deleteMenu0(String ids, boolean deleteParent) {
//		
//	}
	
	
}
