package com.realtime.unicom.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;

import org.apache.log4j.Logger;

import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.C3p0;
import com.stonesun.realTime.services.db.CommonServices;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.realtime.unicom.bean.UserInfoEx;
import com.stonesun.realTime.services.db.bean.sys.OrgInfo;
import com.stonesun.realTime.services.db.bean.sys.OrgTree;
import com.stonesun.realTime.utils.LogUtils;

/**
 * 组织的数据层操作
 */
public class OrgServices2 extends CommonServices{
	
	static Logger logger = Logger.getLogger(OrgServices2.class);
	
	public static List<OrgTree> treeNew() throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<OrgTree> list = new LinkedList<OrgTree>();
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_role");
			stmt = conn.prepareStatement(sql.toString());
			rs = stmt.executeQuery();
			
			while(rs.next()){
				OrgTree item = new OrgTree();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setNodeId(rs.getInt("nodeId"));
				item.setNodeType(OrgTree.OrgTree_type_role);
				
				list.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OrgTree orgInfo = list.get(i);
				
				//查询每个用户组下的用户列表
				List<UserInfo> users = UserServices2.selectListByRoleId(orgInfo.getId());
				if(users!=null && users.size() > 0){
					if(orgInfo.getChildren()==null){
						orgInfo.setChildren(new LinkedList<OrgTree>());
					}
					for(int j=0;j<users.size();j++){
						UserInfo u = users.get(j);
						
						OrgTree uNode = new OrgTree();
						uNode.setId(u.getId());
						uNode.setName(u.getUsername());
						uNode.setNodeType(OrgTree.OrgTree_type_user);
						uNode.setIcon(uNode.icon());
						
						orgInfo.getChildren().add(uNode);
					}
				}
				
				
			}
		}
		return list;
	}
	
	/**
	 * 组织机构树
	 * @return
	 * @throws ServletException
	 */
	public static List<OrgTree> tree(int orgIdVal,boolean isTree,boolean isSave,boolean isDelete) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		List<OrgTree> listTree = new LinkedList<OrgTree>();
		OrgTree root = new OrgTree();
		listTree.add(root);
		
		try {
			conn = C3p0.getInstance().getConnection();
//			StringBuilder sql = new StringBuilder("select * from t_org t where pid=? ");
			StringBuilder sql = new StringBuilder("select * from t_org t where id=? ");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, orgIdVal);
			rs = stmt.executeQuery();
			
			root.setChildren(new LinkedList<OrgTree>());
			if(rs.next()){
				OrgTree item = new OrgTree();
				item.setPid(rs.getInt("pid"));
				item.setId(rs.getInt("id"));
				item.setNodeId(rs.getInt("nodeId"));
				item.setName(rs.getString("name"));
				item.setFullName(rs.getString("fullName"));
				item.setNodeType(OrgTree.OrgTree_type_org);
				
				root.setId(rs.getInt("id"));
				root.setPid(rs.getInt("pid"));
				root.setNodeId(rs.getInt("nodeId"));
				root.setName(rs.getString("name"));
				root.setFullName(rs.getString("fullName"));
				root.setNodeType(OrgTree.OrgTree_type_org);
				root.setTop(true);
				root.setSave(isSave);
				root.setDelete(isDelete);
				
				StringBuilder sql2 = new StringBuilder("select * from t_org t where pid="+rs.getInt("id"));
				stmt2 = conn.prepareStatement(sql2.toString());
				rs2 = stmt2.executeQuery();
				
				while(rs2.next()){
					OrgTree org = new OrgTree();
					org.setPid(rs2.getInt("pid"));
					org.setId(rs2.getInt("id"));
					org.setNodeId(rs2.getInt("nodeId"));
					org.setName(rs2.getString("name"));
					org.setFullName(rs2.getString("fullName"));
					org.setNodeType(OrgTree.OrgTree_type_org);
					org.setIsParent(true);
					org.setSave(isSave);
					org.setDelete(isDelete);
					
					root.getChildren().add(org);
					root.setIsParent(true);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
			closeAll(conn, stmt2, rs2);
		}
		
		if (root.getChildren() != null && root.getChildren().size() > 0) {
			for (int i = 0; i < root.getChildren().size(); i++) {
				OrgTree orgInfo = root.getChildren().get(i);
				treeRecursion(orgInfo,isSave,isDelete);
				
//				addRoles(orgInfo);
			}
		}
		
		//默认一个脱离了组织机构的成员组
		if(!isTree){
			OrgTree defchildren = new OrgTree();
			defchildren.setChildren(new LinkedList<OrgTree>());
			defchildren.setId(-1);
			defchildren.setPid(0);
			defchildren.setName("其他");
			defchildren.setFullName("其他");
			defchildren.setNodeType(OrgTree.OrgTree_type_org);
			defchildren.setIsParent(true);
			root.getChildren().add(defchildren);
		}
		
		
		return listTree;
	}
	
	/**
	 * 组织机构树
	 * @return
	 * @throws ServletException
	 */
	public static List<String> treeByPid(int pid) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<String> ids = new LinkedList<String>();
		ids.add(String.valueOf(pid));
		boolean pool=false;
		
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_org t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, pid);
			rs = stmt.executeQuery();
			
			while(rs.next()){
				ids.add(String.valueOf(rs.getInt("id")));
				pool=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		if(pool){
			treeByPidRecursion(ids);
		}
		return ids;
		
	}
	/**
	 * 组织机构树
	 * @return
	 * @throws ServletException
	 */
	public static List<String> treeByPidRecursion(List<String> pids) throws ServletException{
		
		for(int i=0;i<pids.size();i++){
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			boolean pool=false;
			List<String> ids = new LinkedList<String>();
			
			try {
				conn = C3p0.getInstance().getConnection();
				StringBuilder sql = new StringBuilder("select * from t_org t where pid=?");
				stmt = conn.prepareStatement(sql.toString());
				stmt.setString(1, pids.get(i));
				rs = stmt.executeQuery();
				
				while(rs.next()){
					ids.add(String.valueOf(rs.getInt("id")));
					pool=true;
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServletException(e);
			} finally {
				closeAll(conn, stmt, rs);
			}
			if(pool){
				treeByPidRecursion(ids);
			}
			pids.addAll(ids);
		}
		return pids;
	}
	

//	private static void addRoles(OrgTree orgInfo) throws ServletException {
//		//查询角色列表
//		List<RoleInfo> roles = RoleServices.selectByOrgId(orgInfo.getId());
//		if (roles != null && roles.size() > 0) {
//			if(orgInfo.getChildren()==null){
//				orgInfo.setChildren(new LinkedList<OrgTree>());
//			}
//			for (int j = 0; j < roles.size(); j++) {
//				RoleInfo role = roles.get(j);
//				
//				OrgTree roleNode = new OrgTree();
//				roleNode.setId(role.getId());
//				roleNode.setName(role.getName());
//				roleNode.setNodeType(OrgTree.OrgTree_type_role);
//				roleNode.setIcon(roleNode.icon());
//				orgInfo.getChildren().add(roleNode);
//				
//				//查询用户组列表
//				List<GroupInfo> groups = GroupServices.selectByRoleId(role.getId());
//				if (roles != null && roles.size() > 0) {
//					if(roleNode.getChildren()==null){
//						roleNode.setChildren(new LinkedList<OrgTree>());
//					}
//					for (int k = 0; k < groups.size(); k++) {
//						GroupInfo g = groups.get(j);
//						
//						OrgTree gNode = new OrgTree();
//						gNode.setId(g.getId());
//						gNode.setName(g.getName());
//						gNode.setNodeType(OrgTree.OrgTree_type_group);
//						gNode.setIcon(gNode.icon());
//						
//						roleNode.getChildren().add(gNode);
//						
//						//查询每个用户组下的用户列表
//						List<UserInfo> users = UserServices.selectListByGroupId(gNode.getId());
//						if(users!=null && users.size() > 0){
//							if(gNode.getChildren()==null){
//								gNode.setChildren(new LinkedList<OrgTree>());
//							}
//							for(int i=0;i<users.size();i++){
//								UserInfo u = users.get(i);
//								
//								OrgTree uNode = new OrgTree();
//								uNode.setId(u.getId());
//								uNode.setName(u.getUsername());
//								uNode.setNodeType(OrgTree.OrgTree_type_user);
//								uNode.setIcon(uNode.icon());
//								
//								gNode.getChildren().add(uNode);
//							}
//						}
//					}
//				}
//				
//			}
//		}
//	}
	
	private static void treeRecursion(OrgTree item,boolean isSave,boolean isDelete) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_org t where pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, item.getId());
			rs = stmt.executeQuery();
			
			item.setChildren(new LinkedList<OrgTree>());
			
			while(rs.next()){
				OrgTree item2 = new OrgTree();
				item2.setPid(rs.getInt("pid"));
				item2.setId(rs.getInt("id"));
				item2.setNodeId(rs.getInt("nodeId"));
				item2.setName(rs.getString("name"));
				item2.setFullName(rs.getString("fullName"));
				item2.setNodeType(OrgTree.OrgTree_type_org);
				item2.setIsParent(true);
				item2.setSave(isSave);
				item2.setDelete(isDelete);
				item.getChildren().add(item2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		
		if (item.getChildren() != null && item.getChildren().size() > 0) {
			for(int i=0;i<item.getChildren().size();i++){
				OrgTree item3 = item.getChildren().get(i);
				treeRecursion(item3,isSave,isDelete);
				
//				addRoles(item3);
			}
		}
	}
	
	/**
	 * 此方法同步，因为包含了多个操作
	 * @param info
	 * @return
	 * @throws ServletException
	 */
	public static synchronized boolean insert(OrgInfo info,LogInfo logInfo) throws ServletException{
		logger.info(info);
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int i = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("insert into t_org (name,fullName,pid,createtime,createAccount,nodeId) values (?,?,?,now(),?,?)");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
			stmt.setString(++i, info.getName());
			stmt.setString(++i, info.getFullName());
			stmt.setInt(++i, info.getPid());
			stmt.setString(++i, info.getCreateAccount());
			stmt.setInt(++i, info.getNodeId());
			
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
			LogUtils.write(logInfo);
			
			if(count == 1){
//				rs = stmt.getGeneratedKeys();
//				if(rs.next()){
//					int autoId = rs.getInt(1);
//					info.setId(autoId);
//					
//					//如果该组织下面没有角色，则增加默认的角色
//					PreparedStatement stmt2 = conn.prepareStatement("select count(*) c from t_role where orgId=?");
//					stmt2.setInt(1, info.getId());
//					ResultSet rr = stmt2.executeQuery();
//					if(rr.next()){
//						if(rr.getInt("c") == 0){
//							//增加默认角色
//							RoleInfo roleInfo = new RoleInfo();
//							roleInfo.setName("root");
//							roleInfo.setOrgId(String.valueOf(info.getId()));
//							RoleServices.insert(roleInfo);
//							
//							//增加默认用户组
//							GroupInfo groupInfo = new GroupInfo();
//							groupInfo.setName("group");
//							GroupServices.insert(groupInfo);
//							
//							//绑定用户组到指定的组织的默认角色下
//							GrInfo grInfo = new GrInfo();
//							grInfo.setGid(groupInfo.getId());
//							grInfo.setRid(roleInfo.getId());
//							logger.info(grInfo.toString());
//							GroupServices.insertGr(grInfo);
//							
//							//增加默认用户admin
//							UserInfo userInfo = new UserInfo();
//							userInfo.setUsername("admin_"+info.getId());
//							userInfo.setPassword("admin");
//							UserServices.insert(userInfo);
//						}
//					}
//				}
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
	
	public static synchronized boolean insert(UserInfoEx info) throws ServletException{
		logger.info(info);
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int i = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("insert into t_org (name,fullName,pid,createtime,nodeId) values (?,?,?,now(),?)");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
			stmt.setString(++i, info.getRtw_orgName());
		//	stmt.setString(++i, info.getFullName());
			stmt.setInt(++i, Integer.parseInt(info.getRtw_orgpid()));
			//stmt.setString(++i, info.getCreateAccount());
			stmt.setInt(++i, Integer.parseInt(info.getNodeId()));
			
			int count = stmt.executeUpdate();
					
			if(count == 1){

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
	
	
	
	/**
	 * 修改组织机构配置。
	 * @param info
	 * @return
	 * @throws ServletException
	 */
	public static boolean update(OrgInfo info,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int i = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_org set name=?,fullName=?,updatetime=now(),updateAccount=?,nodeId=? where id=?");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
			stmt.setString(++i, info.getName());
			stmt.setString(++i, info.getFullName());
			stmt.setString(++i, info.getCreateAccount());
			stmt.setInt(++i, info.getNodeId());
			stmt.setInt(++i, info.getId());
			
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
			LogUtils.write(logInfo);
			
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
	 * 根据组织机构ID查询
	 * @param id
	 * @return
	 */
	public static OrgInfo selectById(OrgInfo param) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_org t where t.id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, param.getId());
			
			OrgInfo info = new OrgInfo();
			rs = stmt.executeQuery();
			if(rs.next()){
				info.setId(rs.getInt("id"));
//				info.setCode(rs.getString("code"));
				info.setName(rs.getString("name"));
				info.setPid(rs.getInt("pid"));
				info.setNodeId(rs.getInt("nodeId"));
				info.setFullName(rs.getString("fullName"));
				
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
	
	/**
	 * 根据组织机构PID查询
	 * @param id
	 * @return
	 */
	public static OrgInfo selectByPid(int pid) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_org t where t.pid=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, pid);
			logger.info("select sql = "+sql);
			OrgInfo info = new OrgInfo();
			rs = stmt.executeQuery();
			if(rs.next()){
				info.setId(rs.getInt("id"));
//				info.setCode(rs.getString("code"));
				info.setName(rs.getString("name"));
				info.setFullName(rs.getString("fullName"));
				
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
	
	public static OrgInfo selectByOrgName(String bus_name) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_org t where t.name=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, bus_name);;
			logger.info("select sql = "+sql);
			OrgInfo info = new OrgInfo();
			rs = stmt.executeQuery();
			if(rs.next()){
				info.setId(rs.getInt("id"));
//				info.setCode(rs.getString("code"));
				info.setName(rs.getString("name"));
				info.setFullName(rs.getString("fullName"));
				
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
	
//	public static List<OrgInfo> selectList() throws ServletException{
//		Connection conn = null;
//		PreparedStatement stmt = null;
//		ResultSet rs = null;
//		try {
//			conn = C3p0.getInstance().getConnection();
//			StringBuilder sql = new StringBuilder("select * from t_org ana where 1=1 and type!='alert'");
//			stmt = conn.prepareStatement(sql.toString());
////			stmt.setInt(1, id);
//			
//			List<OrgInfo> list = new LinkedList<OrgInfo>();
//			rs = stmt.executeQuery();
//			while(rs.next()){
//				OrgInfo info = new OrgInfo();
//				info.setId(rs.getInt("id"));
////				info.setPid(rs.getInt("pid"));
////				info.setDsId(rs.getString("dsId"));
////				info.setGroupId(rs.getInt("groupId"));
////				info.setTriggerId(rs.getInt("triggerId"));
//				info.setName(rs.getString("name"));
////				info.setType(rs.getString("type"));
////				info.setScheduled(rs.getString("scheduled"));
////				info.setPriority(rs.getString("priority"));
////				info.setStatus(rs.getString("status"));
////				info.setCreateUid(rs.getInt("createUid"));
////				info.setCreateUsername(rs.getString("createUsername"));
////				info.setRemark(rs.getString("remark"));
////				
////				if(info.getType().equals(OrgInfo.OrgInfo_type_dataSource)){
////					DatasourceInfo ds = DatasourceServices.selectById(info.getDsId());
////					info.setSelectDsText("【数据源】id="+ds.getId()+","+ds.getName());
////				}else if(info.getType().equals(OrgInfo.OrgInfo_type_analysis)){
////					AnalyticsInfo ana = AnalyticsServices.selectById(info.getDsId());
////					info.setSelectDsText("【分析】id="+ana.getId()+","+ana.getName());
////				}
//				list.add(info);
//			}
//			return list;
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new ServletException(e);
//		} finally {
//			closeAll(conn, stmt, rs);
//		}
//	}
	
	public static boolean deleteById(int id,int createUid,String username,LogInfo logInfo) throws ServletException{
		logger.info("deleteById.id="+id+",createUid="+createUid);
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "delete from t_org where id = ?";
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			logInfo.setSql(sql);
			int sql_update = stmt.executeUpdate();
			if(sql_update == 1){
				UserServices2.updateOrgId(id, username);
			}
			return sql_update == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
}
