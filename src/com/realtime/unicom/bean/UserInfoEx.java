package com.realtime.unicom.bean;


public class UserInfoEx {



	
	private String createTime;
	private String updatetime;
	private String updateAccount;
//	private int groupId;
	private String groupIds;
	private int loginCount;
	private String loginIp;
	private String loginArea;
	private String loginTime;
	private String password;
	//----------Must-------------
	private int id;
	private String username;
	private String nickname;
	private String email;
	private String totalSpace;
	//扩展属性
	private String rtw_orgName;	
	private String fullName;	
	private String rtw_roleId;
	private String rtw_orgId;
	private String rtw_orgpid;
	private String folderName;
	private String nodeId;
	private String version ;
	private String type;
	private String action;
	@Override
	public String toString() {
		return "UserInfoEx [id=" + id + ", username=" + username + ", nickname=" + nickname + ", password=" + password
				+ ", email=" + email + ", rtw_roleId=" + rtw_roleId + ", rtw_orgId=" + rtw_orgId + ", totalSpace="
				+ totalSpace + ", createTime=" + createTime + ", updatetime=" + updatetime + ", updateAccount="
				+ updateAccount + ", groupIds=" + groupIds + ", loginCount=" + loginCount + ", loginIp=" + loginIp
				+ ", loginArea=" + loginArea + ", loginTime=" + loginTime + ", rtw_orgName=" + rtw_orgName
				+ ", rtw_orgpid=" + rtw_orgpid + ", folderName=" + folderName + ", nodeId=" + nodeId + ", version="
				+ version + ", type=" + type + ", action=" + action + "]";
	}


	public String getRtw_roleId() {
		return rtw_roleId;
	}


	public void setRtw_roleId(String rtw_roleId) {
		this.rtw_roleId = rtw_roleId;
	}


	public String getRtw_orgId() {
		return rtw_orgId;
	}


	public void setRtw_orgId(String rtw_orgId) {
		this.rtw_orgId = rtw_orgId;
	}


	public String getRtw_orgName() {
		return rtw_orgName;
	}


	public void setRtw_orgName(String rtw_orgName) {
		this.rtw_orgName = rtw_orgName;
	}


	public String getRtw_orgpid() {
		return rtw_orgpid;
	}


	public void setRtw_orgpid(String rtw_orgpid) {
		this.rtw_orgpid = rtw_orgpid;
	}


	public String getFolderName() {
		return folderName;
	}


	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}


	public String getNodeId() {
		return nodeId;
	}


	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getVersion() {
		return version;
	}


	public void setVersion(String version) {
		this.version = version;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getAction() {
		return action;
	}


	public void setAction(String action) {
		this.action = action;
	}


	public static final String unit_KB = "KB";
	public static final String unit_MB = "MB";
	public static final String unit_GB = "GB";
	public static final String unit_TB = "TB";
	public static final String unit_PB = "PB";
//	public int getGroupId() {
//		return groupId;
//	}
//
//	public void setGroupId(int groupId) {
//		this.groupId = groupId;
//	}

	public String getGroupIds() {
		return groupIds;
	}

	
	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}


	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}



	public int getLoginCount() {
		return loginCount;
	}


	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}


	public String getLoginIp() {
		return loginIp;
	}


	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}


	public String getLoginArea() {
		return loginArea;
	}


	public void setLoginArea(String loginArea) {
		this.loginArea = loginArea;
	}


	public String getLoginTime() {
		return loginTime;
	}


	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}





	public String getTotalSpace() {
		return totalSpace;
	}


	public void setTotalSpace(String totalSpace) {
		this.totalSpace = totalSpace;
	}




	public String getUpdatetime() {
		return updatetime;
	}


	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}


	public String getUpdateAccount() {
		return updateAccount;
	}


	public void setUpdateAccount(String updateAccount) {
		this.updateAccount = updateAccount;
	}


	
	public long getTotal2(String totalSpace) {
		long t = Integer.valueOf(totalSpace);
		String unit = "GB";
		
		if(unit.equals(unit_KB)){
			return t;
		}else if(unit.equals(unit_MB)){
			return t * 1024L;
		}else if(unit.equals(unit_GB)){
			return t * 1024L * 1024L;
		}else if(unit.equals(unit_TB)){
			return t * 1024L * 1024L * 1024L;
		}
		return 0;
	}
}
