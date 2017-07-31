package com.realtime.unicom.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.stonesun.realTime.services.core.PagerModel;
import com.stonesun.realTime.services.core.bean.LogInfo;
import com.stonesun.realTime.services.db.C3p0;
import com.stonesun.realTime.services.db.CommonServices;
import com.stonesun.realTime.services.db.ProjectServices;
import com.stonesun.realTime.services.db.bean.ProjectInfo;
import com.stonesun.realTime.services.db.bean.UserInfo;
import com.realtime.unicom.bean.UserInfoEx;
import com.stonesun.realTime.services.util.SystemProperties;
import com.stonesun.realTime.utils.LogUtils;

/**
 * 用户管理
 * @author huangf
 *
 */
public class UserServices2 extends CommonServices{
	
	static Logger logger = Logger.getLogger(ProjectServices.class);
	
	public static void main(String[] args) throws Exception {
		//加载配置
		SystemProperties.getInstance().load();
				
		//初始化数据库连接池
		C3p0.getInstance().init();
		
		UserInfo pro = new UserInfo();
//		pro.setName("打的哈可怜");
//		insert(pro);
		
		pro.setId(4);
//		pro.setName("name");
//		update(pro);
		
		//System.out.println(deleteById(4));
		PagerModel pm = new PagerModel();
		selectPagerList(null, pm);
		System.out.println(pm);
	}
	
	/**
	 * 
	 * 从t_user表中得到数据源列表，返回pager
	 */
	public static PagerModel selectPagerList(String name,PagerModel pm) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("select u.*,(select r.name from t_role r where r.id = u.roleId) roleName from t_user u where 1=1 ");
//			if(StringUtils.isNotBlank(name)){
//				sql.append(" and name like ? ");
//			}
//			if(StringUtils.isNotBlank(data_type)){
//				sql.append(" and ds_type=? ");
//			}
			sql.append("order by id desc limit ?,?");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			int paramIndex = 0;
			if(StringUtils.isNotBlank(name)){
				stmt.setString(++paramIndex, "%"+name+"%");
			}
//			if(StringUtils.isNotBlank(data_type)){
//				stmt.setString(++paramIndex,data_type);
//			}
			stmt.setInt(++paramIndex, pm.getOffset());
			stmt.setInt(++paramIndex, pm.getPageSize());
			
			rs = stmt.executeQuery();

			List<UserInfo> list = new LinkedList<UserInfo>();
			while (rs.next()) {

				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				data.setRoleName(rs.getString("roleName"));
				data.setOrgId(rs.getString("orgId"));
				data.setTotalSpace(rs.getString("totalSpace"));

				list.add(data);
			}
			pm.setList(list);
			pm.setTotal(selectPagerListCount(name));
			pm.cacl();
			return pm;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	/**
	 * 
	 * 统计t_user表中的记录数目
	 */
	public static int selectPagerListCount(String name) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("select count(*) c from t_user where 1=1 ");
//			if(StringUtils.isNotBlank(name)){
//				sql.append("and name like ?");
//			}
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
//			if(StringUtils.isNotBlank(name)){
//				stmt.setString(1, "%"+name+"%");
//			}
			
			rs = stmt.executeQuery();

			if (rs.next()) {
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

	public static boolean insert(UserInfo pro,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int autoId = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("insert into t_user (username,password,nickname,email,roleId,createTime,groupIds,orgId,totalSpace) values (?,?,?,?,?,now(),?,?,?)");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, pro.getUsername());
			stmt.setString(2, pro.getPassword());
			stmt.setString(3, pro.getNickname());
			stmt.setString(4, pro.getEmail());
			stmt.setString(5, pro.getRoleId());
			stmt.setString(6, pro.getGroupIds());
			stmt.setString(7, pro.getOrgId());
			stmt.setString(8, pro.getTotalSpace());
			
			int r = stmt.executeUpdate();
			
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+r+";");
			
			if(r==1){
				rs = stmt.getGeneratedKeys();
				if(rs.next()){
					autoId = rs.getInt(1);
					pro.setId(autoId);
					// 增加用户，顺便新增一个默认的项目组
					ProjectInfo projectInfo = new ProjectInfo();
					projectInfo.setName("默认项目");
					projectInfo.setCreateUid(String.valueOf(autoId));
					projectInfo.setCreateUsername(pro.getUsername());
					ProjectServices.insert(projectInfo,logInfo);
				}
			}else{
				//打印审计日志
				logInfo.setStatus(false);
				LogUtils.write(logInfo);
			}
			return r==1;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	/**
	 * sso注册插入
	 */
	public static boolean insert2(UserInfoEx pro,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int autoId = 0;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("insert into t_user (username,password,nickname,email,roleId,createTime,groupIds,orgId,totalSpace) values (?,?,?,?,?,now(),?,?,?)");
			stmt = conn.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, pro.getUsername());
			stmt.setString(2, pro.getPassword());
			stmt.setString(3, pro.getNickname());
			stmt.setString(4, pro.getEmail());
			stmt.setString(5, pro.getRtw_roleId());
			stmt.setString(6, pro.getGroupIds());
			stmt.setString(7, pro.getRtw_orgId());
			stmt.setString(8, pro.getTotalSpace());
			
			int r = stmt.executeUpdate();
			
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+r+";");
			
			if(r==1){
				rs = stmt.getGeneratedKeys();
				if(rs.next()){
					autoId = rs.getInt(1);
					pro.setId(autoId);
					// 增加用户，顺便新增一个默认的项目组
					ProjectInfo projectInfo = new ProjectInfo();
					projectInfo.setName("默认项目");
					projectInfo.setCreateUid(String.valueOf(autoId));
					projectInfo.setCreateUsername(pro.getUsername());
					ProjectServices.insert(projectInfo,logInfo);
				}
			}else{
				//打印审计日志
				logInfo.setStatus(false);
				LogUtils.write(logInfo);
			}
			return r==1;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	
	public static List<UserInfo> selectList(String orgid) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("select * from t_user where 1=1 ");
			if(StringUtils.isNotBlank(orgid)){
				sql.append(" and orgId=? ");
			}
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			if(StringUtils.isNotBlank(orgid)){
				stmt.setString(1, orgid);
			}
			rs = stmt.executeQuery();
			List<UserInfo> list = new LinkedList<UserInfo>();
			while (rs.next()) {

				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));

				list.add(data);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	public static List<UserInfo> selectListByGroupId(int groupId) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("SELECT u.* FROM t_user u where id in (SELECT uid FROM t_ug where gid=?)");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, groupId);
			rs = stmt.executeQuery();
			List<UserInfo> list = new LinkedList<UserInfo>();
			while (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));

				list.add(data);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	public static List<UserInfo> selectListByRoleId(int roleId) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("SELECT * FROM t_user u where roleId = ?");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, roleId);
			rs = stmt.executeQuery();
			List<UserInfo> list = new LinkedList<UserInfo>();
			while (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));

				list.add(data);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	public static UserInfo selectByUserName(String username) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("select * from t_user where 1=1 and username=?");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1,username);
			rs = stmt.executeQuery();
			if (rs.next()) {

				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
//				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
//				data.setNickname(rs.getString("nickname"));
//				data.setEmail(rs.getString("email"));
//				data.setCreateTime(rs.getString("createTime"));
//				data.setGroupIds(rs.getString("groupIds"));
//				data.setRoleId(rs.getString("roleId"));
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		return null;		
	}
	public static boolean update(UserInfo pro,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			//将该用户的用户组置为空,重新设置用户组
			UserInfo byId = selectById(pro.getId());
			byId.setGroupIds(null);
			updateGroupIds(byId);
			StringBuilder sql = new StringBuilder("update t_user set nickname=?,password=?,email=?,roleId=?,groupIds=?,orgId=?,totalSpace=?,updatetime=now(),updateAccount=? where id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, pro.getNickname());
			stmt.setString(2, pro.getPassword());
			stmt.setString(3, pro.getEmail());
			stmt.setString(4, pro.getRoleId());
			stmt.setString(5, pro.getGroupIds());
			stmt.setString(6, pro.getOrgId());
			stmt.setString(7, pro.getTotalSpace());
			stmt.setString(8, pro.getUpdateAccount());
			stmt.setInt(9, pro.getId());
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
			LogUtils.write(logInfo);
			
			return count == 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	
	/**
	 * 将用户的用户组置为空
	 * @param byId
	 */
	
	private static void updateGroupIds(UserInfo byId) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_user set groupIds=? where id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, byId.getGroupIds());
			stmt.setInt(2, byId.getId());
		} catch (Exception e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	/**
	 * 查询用户组下是否存在用户
	 * @param id
	 * @return
	 */
	public static List<UserInfo> selectByGroupIds(String id){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<UserInfo> list=new LinkedList<UserInfo>();
		try {
			StringBuilder sql = new StringBuilder("select * from t_user where 1=1 ");
			if (id!=null) {
				sql.append(" and groupIds like '"+"%"+id+"%'");
			}
			logger.info("_________________________"+sql);
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				data.setGroupIds(rs.getString("groupIds"));
				data.setRoleId(rs.getString("roleId"));
				list.add(data);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
		return list;
	}
	
	
	/**
	 * 查询是否有用户在使用这个角色
	 * @param id
	 * @return
	 */
	public static List<UserInfo> selectByRoleId(String id){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<UserInfo> list=new LinkedList<UserInfo>();
		try {
			StringBuilder sql = new StringBuilder("select * from t_user where 1=1 ");
			if (id!=null) {
				sql.append(" and roleId=?");
			}
			logger.info("_________________________"+sql);
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			if (id!=null) {
				stmt.setString(1, id);
			}
			rs = stmt.executeQuery();
			if (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				data.setGroupIds(rs.getString("groupIds"));
				data.setRoleId(rs.getString("roleId"));
				list.add(data);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
		return list;
	}
	
	/**
	 * 查询没有组织机构的用户列表
	 * @param id
	 * @return
	 */
	public static List<UserInfo> selectByOrgIdIsNull(String roleId,String searchName){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<UserInfo> list=new LinkedList<UserInfo>();
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("SELECT u.*,(SELECT r.name FROM `t_role` r WHERE r.id=u.`roleId`");
			if(StringUtils.isNotBlank(roleId)){
				sql.append(") AS roleName FROM t_user u ,`t_role` rr  WHERE u.orgId='' AND rr.id=? AND  rr.`id`=u.`roleId`");
				if(StringUtils.isNotBlank(searchName)){
					sql.append(" AND (u.username LIKE ? OR u.nickname LIKE ? )");
				}
				stmt = conn.prepareStatement(sql.toString());
				stmt.setInt(1, Integer.valueOf(roleId));
				if(StringUtils.isNotBlank(searchName)){
					stmt.setString(2, "%"+searchName+"%");
					stmt.setString(3, "%"+searchName+"%");
				}
			}else{
				sql.append(") AS roleName FROM t_user u WHERE u.orgId='' ");
				if(StringUtils.isNotBlank(searchName)){
					sql.append(" AND (u.username LIKE ? OR u.nickname LIKE ? )");
				}
				stmt = conn.prepareStatement(sql.toString());
				if(StringUtils.isNotBlank(searchName)){
					stmt.setString(1, "%"+searchName+"%");
					stmt.setString(2, "%"+searchName+"%");
				}
			}
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				String updatetime = rs.getString("updatetime");
				if(StringUtils.isBlank(updatetime)){
					updatetime=" ";
				}
				data.setUpdatetime(updatetime);
				data.setGroupIds(rs.getString("groupIds"));
				data.setRoleId(rs.getString("roleId"));
				String roleName = rs.getString("roleName");
				if(StringUtils.isBlank(roleName)){
					roleName="-(无)";
				}
				data.setRoleName(roleName);
				String totalSpace = rs.getString("totalSpace");
				if(StringUtils.isBlank(totalSpace)){
					totalSpace="0GB";
				}else{
					totalSpace=totalSpace+"GB";
				}
				data.setTotalSpace(totalSpace);
				list.add(data);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
		logger.info("组织机构下的用户列表！！！！===="+list);
		return list;
	}
	
	/**
	 * 查询同一个组织机构的用户
	 * @param id
	 * @return
	 */
	public static List<UserInfo> selectByOrgId(String orgId,String roleId,String searchName){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<UserInfo> list=new LinkedList<UserInfo>();
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("SELECT u.*,(SELECT r.name FROM `t_role` r WHERE r.id=u.`roleId`");
			if(StringUtils.isNotBlank(roleId)){
				sql.append(") AS roleName FROM t_user u ,`t_role` rr  WHERE u.orgId=? AND rr.id=? AND  rr.`id`=u.`roleId`");
				if(StringUtils.isNotBlank(searchName)){
					sql.append(" AND (u.username LIKE ? OR u.nickname LIKE ? )");
				}
				stmt = conn.prepareStatement(sql.toString());
				stmt.setString(1, orgId);
				stmt.setInt(2, Integer.valueOf(roleId));
				if(StringUtils.isNotBlank(searchName)){
					stmt.setString(3, "%"+searchName+"%");
					stmt.setString(4, "%"+searchName+"%");
				}
			}else{
				sql.append(") AS roleName FROM t_user u WHERE orgId=? ");
				if(StringUtils.isNotBlank(searchName)){
					sql.append(" AND (u.username LIKE ? OR u.nickname LIKE ? )");
				}
				stmt = conn.prepareStatement(sql.toString());
				stmt.setString(1, orgId);
				if(StringUtils.isNotBlank(searchName)){
					stmt.setString(2, "%"+searchName+"%");
					stmt.setString(3, "%"+searchName+"%");
				}
			}
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				String updatetime = rs.getString("updatetime");
				if(StringUtils.isBlank(updatetime)){
					updatetime=" ";
				}
				data.setUpdatetime(updatetime);
				data.setGroupIds(rs.getString("groupIds"));
				data.setRoleId(rs.getString("roleId"));
				String roleName = rs.getString("roleName");
				if(StringUtils.isBlank(roleName)){
					roleName="-(无)";
				}
				data.setRoleName(roleName);
				String totalSpace = rs.getString("totalSpace");
				if(StringUtils.isBlank(totalSpace)){
					totalSpace="0GB";
				}else{
					totalSpace=totalSpace+"GB";
				}
				data.setTotalSpace(totalSpace);
				list.add(data);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
		logger.info("组织机构下的用户列表！！！！===="+list);
		return list;
	}
	
	
	/**
	 * 查询同一个组织机构的用户(包括子机构/部门用户 )
	 * @param id
	 * @return
	 */
	public static List<UserInfo> selectByOrgIds(List<String> orgs,String roleId,String searchName){
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<UserInfo> list=new LinkedList<UserInfo>();
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("SELECT u.*,(SELECT r.name FROM `t_role` r WHERE r.id=u.`roleId` ");
			if(StringUtils.isNotBlank(roleId)){
				sql .append(" ) AS roleName FROM t_user u,`t_role` rr WHERE u.orgId in( ");
				for(int i=0;i<orgs.size();i++){
					sql.append(" ?");
					if(i+1 != orgs.size()){
						sql.append(",");
					}
				}
				sql.append(")");
				sql.append(" and rr.id=? AND rr.`id`=u.`roleId`");
				if(StringUtils.isNotBlank(searchName)){
					sql.append(" AND (u.username LIKE ? OR u.nickname LIKE ? )");
				}
				stmt = conn.prepareStatement(sql.toString());
				for(int i=0;i<orgs.size();i++){
					stmt.setInt(i+1, Integer.valueOf(orgs.get(i)));
				}
				stmt.setInt(orgs.size()+1, Integer.valueOf(roleId));
				if(StringUtils.isNotBlank(searchName)){
					stmt.setString(orgs.size()+2, "%"+searchName+"%");
					stmt.setString(orgs.size()+3, "%"+searchName+"%");
				}
				
			}else{
				sql .append(" ) AS roleName FROM t_user u WHERE orgId in( ");
				for(int i=0;i<orgs.size();i++){
					sql.append(" ?");
					if(i+1 != orgs.size()){
						sql.append(",");
					}
				}
				sql.append(")");
				if(StringUtils.isNotBlank(searchName)){
					sql.append("  AND (u.username LIKE ? OR u.nickname LIKE ? )");
				}
				stmt = conn.prepareStatement(sql.toString());
				for(int i=0;i<orgs.size();i++){
					stmt.setInt(i+1, Integer.valueOf(orgs.get(i)));
				}
				if(StringUtils.isNotBlank(searchName)){
					stmt.setString(orgs.size()+1, "%"+searchName+"%");
					stmt.setString(orgs.size()+2, "%"+searchName+"%");
				}
			}
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				String updatetime = rs.getString("updatetime");
				if(StringUtils.isBlank(updatetime)){
					updatetime=" ";
				}
				data.setUpdatetime(updatetime);
				data.setGroupIds(rs.getString("groupIds"));
				data.setRoleId(rs.getString("roleId"));
				String roleName = rs.getString("roleName");
				if(StringUtils.isBlank(roleName)){
					roleName="-(无)";
				}
				data.setRoleName(roleName);
				String totalSpace = rs.getString("totalSpace");
				if(StringUtils.isBlank(totalSpace)){
					totalSpace="0GB";
				}else{
					totalSpace=totalSpace+"GB";
				}
				data.setTotalSpace(totalSpace);
				list.add(data);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
		logger.info("组织机构下的用户列表！！！！===="+list);
		return list;
	}

	public static boolean updateNotUpdataPassword(UserInfo pro,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_user set nickname=?,email=?,roleId=?,groupIds=?,orgId=?,totalSpace=?,updatetime=now(),updateAccount=? where id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, pro.getNickname());
			stmt.setString(2, pro.getEmail());
			stmt.setString(3, pro.getRoleId());
			stmt.setString(4, pro.getGroupIds());
			stmt.setString(5, pro.getOrgId());
			stmt.setString(6, pro.getTotalSpace());
			stmt.setString(7, pro.getUpdateAccount());
			stmt.setInt(8, pro.getId());
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
			LogUtils.write(logInfo);
			
			return count == 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	public static boolean deleteById(int id,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("delete from t_user where id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, id);
			return stmt.executeUpdate() == 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	//根据用户名称进行删除
	public static boolean deleteByUserName(String username) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("delete from t_user where username=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, username);
			return stmt.executeUpdate() == 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	public static UserInfo selectById(int id) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("SELECT u.*,(SELECT fullName FROM `t_org` o WHERE o.id=u.`orgId`) AS orgName FROM t_user u WHERE id=? ");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {

				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				data.setGroupIds(rs.getString("groupIds"));
				data.setRoleId(rs.getString("roleId"));
				data.setOrgId(rs.getString("orgId"));
				data.setOrgName(rs.getString("orgName"));
				data.setTotalSpace(rs.getString("totalSpace"));
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		return null;
	}

	public static UserInfo doLogin(String username, String password) throws ServletException{
		if(StringUtils.isBlank(username) || StringUtils.isBlank(password)){
			throw new ServletException("账号密码不能为空!");
		}
		
		UserInfo info = new UserInfo();
		info.setUsername(username);
		info.setPassword(password);
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement("select * from t_user where 1=1 and username=? and `password`=?");
			stmt.setString(1, username);
			stmt.setString(2, password);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				data.setRoleId(rs.getString("roleId"));
//				data.setGroupIds(rs.getString("groupIds"));
				data.setOrgId(rs.getString("orgId"));
				data.setTotalSpace(rs.getString("totalSpace"));
//				data.setCreateUsername(rs.getString("createUsername"));
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		throw new ServletException("登陆失败！");
	}

	
	
	public static UserInfo doLogin2(String username) throws ServletException{
		if(StringUtils.isBlank(username) ){
			throw new ServletException("账号密码不能为空!");
		}
		
		UserInfo info = new UserInfo();
		info.setUsername(username);
		//info.setPassword(password);
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement("select * from t_user where 1=1 and username=?");
			stmt.setString(1, username);
			//stmt.setString(2, password);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
				data.setNickname(rs.getString("nickname"));
				data.setEmail(rs.getString("email"));
				data.setCreateTime(rs.getString("createTime"));
				data.setRoleId(rs.getString("roleId"));
//				data.setGroupIds(rs.getString("groupIds"));
				data.setOrgId(rs.getString("orgId"));
				data.setTotalSpace(rs.getString("totalSpace"));
//				data.setCreateUsername(rs.getString("createUsername"));
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		throw new ServletException("登陆失败！");
	}
	
	
	
	
	
	
	public static boolean updatePwd(UserInfo info,LogInfo logInfo) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_user set ");
			if(StringUtils.isNotBlank(info.getPassword())){
				sql.append("password=? ");
			}
			if(StringUtils.isNotBlank(info.getGroupIds())){
				sql.append(",groupIds=? ");
			}
			sql.append(" where id=? ");
			stmt = conn.prepareStatement(sql.toString());
			int n = 0;
			if(StringUtils.isNotBlank(info.getPassword())){
				stmt.setString(++n, info.getPassword());
			}
			if(StringUtils.isNotBlank(info.getGroupIds())){
				stmt.setString(++n, info.getGroupIds());
			}
			stmt.setInt(++n, info.getId());
			logInfo.setSql(sql.toString()+","+info.getId());
			if(stmt.executeUpdate() == 1){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		
		throw new ServletException("修改密码失败！");
	}
	
	public static boolean updatePwdAndGroupids(UserInfo info) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_user set groupIds=?");
			if(StringUtils.isNotBlank(info.getPassword())){
				sql.append(",password=? ");
			}
			sql.append(" where id=? ");
			stmt = conn.prepareStatement(sql.toString());
			int n = 0;
			stmt.setString(++n, info.getGroupIds());
			if(StringUtils.isNotBlank(info.getPassword())){
				stmt.setString(++n, info.getPassword());
			}
			stmt.setInt(++n, info.getId());
			if(stmt.executeUpdate() == 1){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		
		throw new ServletException("修改密码失败！");
	}

	public static List<String> selectGroupsById() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("select groupIds from t_user where 1=1");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			rs = stmt.executeQuery();
			List<String> groups = new LinkedList<String>();
			while (rs.next()) {
				groups.add(rs.getString("groupIds"));
			}
			return groups;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stmt, rs);
		}
		return null;
	}

	/**
	 * 判断用户名是否唯一
	 * @param username
	 * @return
	 */
	public static UserInfo decideExist(String username) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("select * from t_user where username=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, username);
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				UserInfo info=new UserInfo();
				info.setId(rs.getInt("id"));
				return info;
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				throw new ServletException(e);
			} catch (ServletException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			closeAll(conn, stmt, rs);
		}
		return null;
	}

	public static UserInfo selectByAccount(String createAccount) throws ServletException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			StringBuilder sql = new StringBuilder("select * from t_user where 1=1 and username=?");
			conn = C3p0.getInstance().getConnection();
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1,createAccount);
			rs = stmt.executeQuery();
			if (rs.next()) {

				UserInfo data = new UserInfo();
				data.setId(rs.getInt("id"));
//				data.setUsername(rs.getString("username"));
				data.setPassword(rs.getString("password"));
//				data.setNickname(rs.getString("nickname"));
//				data.setEmail(rs.getString("email"));
//				data.setCreateTime(rs.getString("createTime"));
//				data.setGroupIds(rs.getString("groupIds"));
//				data.setRoleId(rs.getString("roleId"));
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
		return null;		
	}
	
	/**
	 * 取消角色权限，把角色清空
	 * @param pro
	 * @return
	 * @throws ServletException
	 */
	public static boolean updateRoleId(int userId,String userName,LogInfo logInfo) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_user set roleId='',updatetime=now(),updateAccount=? where id=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, userName);
			stmt.setInt(2, userId);
			int count = stmt.executeUpdate();
			
			//打印审计日志
			logInfo.setStatus(count == 1);
			logInfo.setSql(logInfo.getSql()+sql.toString()+" count="+count+";");
			LogUtils.write(logInfo);
			
			return  count== 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
	
	/**
	 * 删除组织机构，把用户对应该组织机构ID清空
	 * @param pro
	 * @return
	 * @throws ServletException
	 */
	public static boolean updateOrgId(int orgId,String userName) throws ServletException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = C3p0.getInstance().getConnection();
			StringBuilder sql = new StringBuilder("update t_user set orgId='',updatetime=now(),updateAccount=? where orgId=?");
			stmt = conn.prepareStatement(sql.toString());
			stmt.setString(1, userName);
			stmt.setInt(2, orgId);
			
			return stmt.executeUpdate() == 1;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		} finally {
			closeAll(conn, stmt, rs);
		}
	}
}
