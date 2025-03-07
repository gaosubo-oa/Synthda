package com.xoa.model.department;

import com.xoa.model.users.Users;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月19日 上午11:50:52
 * 类介绍  :    部门
 * 构造参数:   无
 *
 */
public class Department implements Serializable {
	/**
	 * 自增唯一ID
	 */
    private Integer deptId;
    /**
	 * 部门名称
	 */
    private String deptName;
    /**
     * 部门类型
     */
    private String deptType;
    /**
     * 部门简称
     */
    private String deptAbbrName;
    /**
	 * 电话
	 */
    private String telNo;
    /**
	 * 传真
	 */
    private String faxNo;
    /**
	 * 部门地址
	 */
    private String deptAddress;
    /**
	 * 部门排序号
	 */
    private String deptNo;

    //人员部门排序号
     private Integer userDeptNo;
     /**
      * 部门编码
      */
    private String deptCode;
    /**
	 * 上级部门ID
	 */
    private Integer deptParent;
     /**
      * 上级部门名称
      */
     private String deptParentName;
    /**
	 * 是否是分支机构(0-否,1-是)
	 */
    private String isOrg;
    /**
	 * 机构管理员
	 */
    private String orgAdmin;
    /**
	 * 保密邮件审核人
	 */
    private String deptEmailAuditsIds;
    /**
	 * 企业微信对应部门id
	 */
    private String weixinDeptId;
    /**
	 * 叮叮对应部门id
	 */
    private String dingdingDeptId;
    /**
	 * 是否全局部门(0-否,1-是)
	 */
    private Integer gDept;
    /**
	 * 部门主管
	 */
    private String manager;
    /**
     * 部门审核人
     */
    private String deptApprover;
    /**
     * 部门审核人名称
     */
    private String deptApproverName;
     /**
      * 部门主管名称
      */
    private String managerStr;
    /**
	 * 部门助理
	 */
    private String assistantId;
     /**
      * 部门助理名称
      */
    private String assistantStr;
    /**
	 * 上级主管领导
	 */
    private String leader1;

    private String leader1Name;
    /**
	 * 上级分管领导
	 */
    private String leader2;

    private String leader2Name;
    /**
	 * 部门职能
	 */
    private String deptFunc;
    /**
	 * 头像
	 */
    private String avatar;
    /**
	 * 用户名字
	 */
    private String userName;
    /**
	 * 用户uid
	 */
    private Integer uid;
    /**
	 * 用户角色名字
	 */
    private String userPrivName;
    /**
   	 * 返回类型
   	 */
    private String type;

    private String weLinkDept;

    private Integer colNumber;

    private String schoolType;
    private String schoolManageType;
    private String statePrivateId;
    private String statePrivateId2;
    private String statePrivateIdName;
    private String statePrivateId2Name;
    private String schoolManageTypeName;

    /**
     * 角色分类id串
     */
    private String privTypes;

    /**
     * 角色分类名称串
     */
    private String privTypeNames;

    /**
     * 部门是否失效（1有效   0失效）
     */
    private Integer deptDisplay;

    public String getStatePrivateId() {
        return statePrivateId;
    }

    public void setStatePrivateId(String statePrivateId) {
        this.statePrivateId = statePrivateId;
    }

    public String getStatePrivateId2() {
        return statePrivateId2;
    }

    public void setStatePrivateId2(String statePrivateId2) {
        this.statePrivateId2 = statePrivateId2;
    }

    public String getSchoolType() {
        return schoolType;
    }

    public void setSchoolType(String schoolType) {
        this.schoolType = schoolType;
    }

    public String getSchoolManageType() {
        return schoolManageType;
    }

    public void setSchoolManageType(String schoolManageType) {
        this.schoolManageType = schoolManageType;
    }

    public String getStatePrivateIdName() {
        return statePrivateIdName;
    }

    public void setStatePrivateIdName(String statePrivateIdName) {
        this.statePrivateIdName = statePrivateIdName;
    }

    public String getStatePrivateId2Name() {
        return statePrivateId2Name;
    }

    public void setStatePrivateId2Name(String statePrivateId2Name) {
        this.statePrivateId2Name = statePrivateId2Name;
    }

    public String getSchoolManageTypeName() {
        return schoolManageTypeName;
    }

    public void setSchoolManageTypeName(String schoolManageTypeName) {
        this.schoolManageTypeName = schoolManageTypeName;
    }

    public boolean isLeaf() {
        return isLeaf;
    }

    public void setLeaf(boolean leaf) {
        isLeaf = leaf;
    }

    public Integer getColNumber() {
        return colNumber;
    }

    public void setColNumber(Integer colNumber) {
        this.colNumber = colNumber;
    }

     public String getSmsGateAccount() {
         return smsGateAccount;
     }

     public void setSmsGateAccount(String smsGateAccount) {
         this.smsGateAccount = smsGateAccount;
     }

     private String smsGateAccount; //部门电话

     private String smsGatePassword;//密码

     public String getSmsGatePassword() {
         return smsGatePassword;
     }

     public void setSmsGatePassword(String smsGatePassword) {
         this.smsGatePassword = smsGatePassword;
     }

     /**
   	 * 统计
   	 */
    private String count;
    
    private String sex;
    
    private String userId;
    //是否拥有子部门
    private String isHaveCh;

     private String read;

     private String unread;

     private int hashUser;


     private String birthday;
     private String mobilNo;

     private String mystatus;

     private Integer classifyOrg;

     private String classifyOrgAdmin;

     private String classifyOrgAdminName;

     private String classifyOrgAdminUserId;

     private Integer importCount;//导入条数
     private Integer successCount;//成功条数
     private Integer failCount;//失败条数
     private Integer nameRepeat;//部门名称重复标记
     private Integer updateCount;//修改标记
     private Integer nameRoNoNull;//部门或编号为空标记
     private Integer noParent;//父部门不存在标记

     private String isSubOrg;//是否包含下级分支机构(0-否,1-是)



     private String theMainRoleallUsers; //主角色总用户

     private String noLoginUsers;//禁止登陆用户

     private String auxiliaryRoleUser;//辅助角色用户

     //部门主角色用户计数器
     private Integer theMainRoleallUsersCount;
     //部门禁止登陆用户计数器
     private Integer noLoginUsersCount;
     //辅助角色用户计数器
     private Integer auxiliaryRoleUserCount;

     //封装map存放必要字段
     private Map map;


    //是否有子集，无true,有false
     private boolean isLeaf;

     private List projectInfos;

     private String names;//计划考核需要的字段
    private Integer ids;

    public String getDeptType() {
        return deptType;
    }

    public void setDeptType(String deptType) {
        this.deptType = deptType;
    }

    public boolean getIsLeaf() {
        return isLeaf;
    }

    public void setIsLeaf(boolean leaf) {
        isLeaf = leaf;
    }

    public Map getMap() {
        return map;
    }

    public void setMap(Map map) {
        this.map = map;
    }

    public String getWeLinkDept() {
         return weLinkDept;
     }

     public void setWeLinkDept(String weLinkDept) {
         this.weLinkDept = weLinkDept;
     }

     public Integer getAllauxiliaryRoleUserCount() {
         return allauxiliaryRoleUserCount;
     }

     public void setAllauxiliaryRoleUserCount(Integer allauxiliaryRoleUserCount) {
         this.allauxiliaryRoleUserCount = allauxiliaryRoleUserCount;
     }

     private Integer allauxiliaryRoleUserCount;

     public Integer getTheMainRoleallUsersCount() {
         return theMainRoleallUsersCount;
     }

     public void setTheMainRoleallUsersCount(Integer theMainRoleallUsersCount) {
         this.theMainRoleallUsersCount = theMainRoleallUsersCount;
     }

     public Integer getNoLoginUsersCount() {
         return noLoginUsersCount;
     }

     public void setNoLoginUsersCount(Integer noLoginUsersCount) {
         this.noLoginUsersCount = noLoginUsersCount;
     }

     public Integer getAuxiliaryRoleUserCount() {
         return auxiliaryRoleUserCount;
     }

     public void setAuxiliaryRoleUserCount(Integer auxiliaryRoleUserCount) {
         this.auxiliaryRoleUserCount = auxiliaryRoleUserCount;
     }

     public String getNoLoginUsers() {
         return noLoginUsers;
     }

     public void setNoLoginUsers(String noLoginUsers) {
         this.noLoginUsers = noLoginUsers;
     }

     public String getAuxiliaryRoleUser() {
         return auxiliaryRoleUser;
     }

     public void setAuxiliaryRoleUser(String auxiliaryRoleUser) {
         this.auxiliaryRoleUser = auxiliaryRoleUser;
     }



     public String getTheMainRoleallUsers() {
         return theMainRoleallUsers;

     }

     public void setTheMainRoleallUsers(String theMainRoleallUsers) {
         this.theMainRoleallUsers = theMainRoleallUsers;
     }

    public Integer getImportCount() {
        return importCount;
    }

    public void setImportCount(Integer importCount) {
        this.importCount = importCount;
    }

    public Integer getSuccessCount() {
         return successCount==null?0:successCount;
     }

     public void setSuccessCount(Integer successCount) {
         this.successCount = successCount;
     }

     public Integer getFailCount() {
         return failCount==null?0:failCount;
     }

     public void setFailCount(Integer failCount) {
         this.failCount = failCount;
     }

     public Integer getNameRepeat() {
         return nameRepeat==null?0:nameRepeat;
     }

     public void setNameRepeat(Integer nameRepeat) {
         this.nameRepeat = nameRepeat;
     }

    public Integer getUpdateCount() {
        return updateCount;
    }

    public void setUpdateCount(Integer updateCount) {
        this.updateCount = updateCount;
    }

    public Integer getNameRoNoNull() {
         return nameRoNoNull==null?0:nameRoNoNull;
     }

     public void setNameRoNoNull(Integer nameRoNoNull) {
         this.nameRoNoNull = nameRoNoNull;
     }

     public Integer getNoParent() {
         return noParent==null?0:noParent;
     }

     public void setNoParent(Integer noParent) {
         this.noParent = noParent;
     }

     public String getMystatus() {
         return mystatus;
     }

     public void setMystatus(String mystatus) {
         this.mystatus = mystatus;
     }

     public String getBirthday() {
         return birthday;
     }

     public void setBirthday(String birthday) {
         this.birthday = birthday;
     }

     public String getMobilNo() {
         return mobilNo;
     }

     public void setMobilNo(String mobilNo) {
         this.mobilNo = mobilNo;
     }

     public Integer getClassifyOrg() {
         return classifyOrg==null?0:classifyOrg;
     }

     public String getClassifyOrgAdmin() {
         return classifyOrgAdmin;
     }

     public String getClassifyOrgAdminName() {
         return classifyOrgAdminName==null?"":classifyOrgAdminName;
     }

     public void setClassifyOrgAdminName(String classifyOrgAdminName) {
         this.classifyOrgAdminName = classifyOrgAdminName;
     }

     public void setClassifyOrg(Integer classifyOrg) {
         this.classifyOrg = classifyOrg;
     }

     public void setClassifyOrgAdmin(String classifyOrgAdmin) {
         this.classifyOrgAdmin = classifyOrgAdmin;
     }

    public String getClassifyOrgAdminUserId() {
        return classifyOrgAdminUserId;
    }

    public void setClassifyOrgAdminUserId(String classifyOrgAdminUserId) {
        this.classifyOrgAdminUserId = classifyOrgAdminUserId;
    }

     public int getHashUser() {
         return hashUser;
     }

     public void setHashUser(int hashUser) {
         this.hashUser = hashUser;
     }

     public String getRead() {
         return read;
     }

     public void setRead(String read) {
         this.read = read;
     }

     public String getUnread() {
         return unread;
     }

     public void setUnread(String unread) {
         this.unread = unread;
     }

     public void setDeptParentName(String deptParentName) {
         this.deptParentName = deptParentName;
     }

     public String getDeptParentName() {
         return deptParentName==null?"":deptParentName;
     }

     public String getIsHaveCh() {
         return isHaveCh;
     }

     public void setIsHaveCh(String isHaveCh) {
         this.isHaveCh = isHaveCh;
     }

     private List<Department> child;
    
    public List<Department> getChild() {
		return child;
	}

	public void setChild(List<Department> child) {
		this.child = child;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAvatar() {
		return avatar==null?"":avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getUserPrivName() {
		return userPrivName;
	}

	public void setUserPrivName(String userPrivName) {
		this.userPrivName = userPrivName;
	}

	private List<Users> users;
 
    public String getManager() {
        return manager== null ? "" : manager.trim();
    }

    public List<Users> getUsers() {
		return users;
	}

	public void setUsers(List<Users> users) {
		this.users = users;
	}

	public void setManager(String manager) {
        this.manager = manager == null ? "" : manager.trim();
    }

    public String getAssistantId() {
        return assistantId == null ? "" : assistantId.trim();
    }

    public void setAssistantId(String assistantId) {
        this.assistantId = assistantId == null ? "" : assistantId.trim();
    }

    public String getLeader1() {
        return leader1 == null ? "" : leader1.trim();
    }

    public void setLeader1(String leader1) {
        this.leader1 = leader1 == null ? "" : leader1.trim();
    }

    public String getLeader2() {
        return leader2 == null ? "" : leader2.trim();
    }

    public void setLeader2(String leader2) {
        this.leader2 = leader2 == null ? "" : leader2.trim();
    }

    public String getDeptFunc() {
        return deptFunc == null ? "" : deptFunc.trim();
    }

    public void setDeptFunc(String deptFunc) {
        this.deptFunc = deptFunc == null ? "" : deptFunc.trim();
    }
    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName == null ? "" : deptName.trim();
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? "" : deptName.trim();
    }

    public String getTelNo() {
        return telNo  == null ? "" : telNo.trim();
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo == null ? "" : telNo.trim();
    }

    public String getFaxNo() {
        return faxNo == null ? "" : faxNo.trim();
    }

    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo == null ? "" : faxNo.trim();
    }

    public String getDeptAddress() {
        return deptAddress==null?"":deptAddress;
    }

    public void setDeptAddress(String deptAddress) {
        this.deptAddress = deptAddress == null ? null : deptAddress.trim();
    }

    public String getDeptNo() {
        return deptNo== null ? "" : deptNo.trim();
    }

    public void setDeptNo(String deptNo) {
        this.deptNo = deptNo == null ? "" : deptNo.trim();
    }

    public Integer getDeptParent() {
        return deptParent;
    }

    public void setDeptParent(Integer deptParent) {
        this.deptParent = deptParent;
    }

    public String getIsOrg() {
        return isOrg == null ? "" : isOrg.trim();
    }

    public void setIsOrg(String isOrg) {
        this.isOrg = isOrg == null ? "" : isOrg.trim();
    }

    public String getOrgAdmin() {
        return orgAdmin == null ? "" : orgAdmin.trim();
    }

    public void setOrgAdmin(String orgAdmin) {
        this.orgAdmin = orgAdmin == null ? "" : orgAdmin.trim();
    }

    public String getDeptEmailAuditsIds() {
        return deptEmailAuditsIds == null ? "" : deptEmailAuditsIds.trim();
    }

    public void setDeptEmailAuditsIds(String deptEmailAuditsIds) {
        this.deptEmailAuditsIds = deptEmailAuditsIds == null ? "" : deptEmailAuditsIds.trim();
    }

     public String getWeixinDeptId() {
         return weixinDeptId;
     }

     public void setWeixinDeptId(String weixinDeptId) {
         this.weixinDeptId = weixinDeptId;
     }

     public String getDingdingDeptId() {
         return dingdingDeptId;
     }

     public void setDingdingDeptId(String dingdingDeptId) {
         this.dingdingDeptId = dingdingDeptId;
     }

     public Integer getgDept() {
        return gDept;
    }

    public void setgDept(Integer gDept) {
        this.gDept = gDept;
    }

     public void setManagerStr(String managerStr) {
         this.managerStr = managerStr;
     }

     public void setAssistantStr(String assistantStr) {
         this.assistantStr = assistantStr;
     }

     public String getManagerStr() {
         return managerStr==null?"":managerStr;
     }

     public String getAssistantStr() {
         return assistantStr==null?"":assistantStr;
     }

     public String getLeader1Name() {
         return leader1Name==null?"":leader1Name;
     }

     public void setLeader1Name(String leader1Name) {
         this.leader1Name = leader1Name;
     }

     public String getLeader2Name() {
         return leader2Name==null?"":leader2Name;
     }

     public void setLeader2Name(String leader2Name) {
         this.leader2Name = leader2Name;
     }

     public String getDeptCode() {
         return deptCode==null?"":deptCode;
     }

     public void setDeptCode(String deptCode) {
         this.deptCode = deptCode;
     }

     public String getIsSubOrg() {
         return isSubOrg;
     }

     public void setIsSubOrg(String isSubOrg) {
         this.isSubOrg = isSubOrg;
     }

     @Override
     public String toString() {
         return "Department{" +
                 "deptId=" + deptId +
                 ", deptName='" + deptName + '\'' +
                 ", telNo='" + telNo + '\'' +
                 ", faxNo='" + faxNo + '\'' +
                 ", deptAddress='" + deptAddress + '\'' +
                 ", deptNo='" + deptNo + '\'' +
                 ", deptCode='" + deptCode + '\'' +
                 ", deptParent=" + deptParent +
                 ", deptParentName='" + deptParentName + '\'' +
                 ", isOrg='" + isOrg + '\'' +
                 ", orgAdmin='" + orgAdmin + '\'' +
                 ", deptEmailAuditsIds='" + deptEmailAuditsIds + '\'' +
                 ", weixinDeptId=" + weixinDeptId +
                 ", dingdingDeptId=" + dingdingDeptId +
                 ", gDept=" + gDept +
                 ", manager='" + manager + '\'' +
                 ", managerStr='" + managerStr + '\'' +
                 ", assistantId='" + assistantId + '\'' +
                 ", assistantStr='" + assistantStr + '\'' +
                 ", leader1='" + leader1 + '\'' +
                 ", leader1Name='" + leader1Name + '\'' +
                 ", leader2='" + leader2 + '\'' +
                 ", leader2Name='" + leader2Name + '\'' +
                 ", deptFunc='" + deptFunc + '\'' +
                 ", avatar='" + avatar + '\'' +
                 ", userName='" + userName + '\'' +
                 ", uid=" + uid +
                 ", userPrivName='" + userPrivName + '\'' +
                 ", type='" + type + '\'' +
                 ", smsGateAccount='" + smsGateAccount + '\'' +
                 ", smsGatePassword='" + smsGatePassword + '\'' +
                 ", count='" + count + '\'' +
                 ", sex='" + sex + '\'' +
                 ", userId='" + userId + '\'' +
                 ", isHaveCh='" + isHaveCh + '\'' +
                 ", read='" + read + '\'' +
                 ", unread='" + unread + '\'' +
                 ", hashUser=" + hashUser +
                 ", birthday='" + birthday + '\'' +
                 ", mobilNo='" + mobilNo + '\'' +
                 ", mystatus='" + mystatus + '\'' +
                 ", classifyOrg=" + classifyOrg +
                 ", classifyOrgAdmin='" + classifyOrgAdmin + '\'' +
                 ", classifyOrgAdminName='" + classifyOrgAdminName + '\'' +
                 ", importCount=" + importCount +
                 ", successCount=" + successCount +
                 ", failCount=" + failCount +
                 ", nameRepeat=" + nameRepeat +
                 ", updateCount=" + updateCount +
                 ", nameRoNoNull=" + nameRoNoNull +
                 ", noParent=" + noParent +
                 ", isSubOrg='" + isSubOrg + '\'' +
                 ", theMainRoleallUsers='" + theMainRoleallUsers + '\'' +
                 ", noLoginUsers='" + noLoginUsers + '\'' +
                 ", auxiliaryRoleUser='" + auxiliaryRoleUser + '\'' +
                 ", theMainRoleallUsersCount=" + theMainRoleallUsersCount +
                 ", noLoginUsersCount=" + noLoginUsersCount +
                 ", auxiliaryRoleUserCount=" + auxiliaryRoleUserCount +
                 ", allauxiliaryRoleUserCount=" + allauxiliaryRoleUserCount +
                 ", child=" + child +
                 ", users=" + users +
                 '}';
     }

     public Integer getUserDeptNo() {
         return userDeptNo;
     }

     public void setUserDeptNo(Integer userDeptNo) {
         this.userDeptNo = userDeptNo;
     }

    public List getProjectInfos() {
        return projectInfos;
    }

    public void setProjectInfos(List projectInfos) {
        this.projectInfos = projectInfos;
    }

    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
    }

    public Integer getIds() {
        return ids;
    }

    public void setIds(Integer ids) {
        this.ids = ids;
    }

    public String getDeptAbbrName() {
        return deptAbbrName;
    }

    public void setDeptAbbrName(String deptAbbrName) {
        this.deptAbbrName = deptAbbrName;
    }

    public String getPrivTypes() {
        return privTypes;
    }

    public void setPrivTypes(String privTypes) {
        this.privTypes = privTypes;
    }

    public String getPrivTypeNames() {
        return privTypeNames;
    }

    public void setPrivTypeNames(String privTypeNames) {
        this.privTypeNames = privTypeNames;
    }

    public Integer getDeptDisplay() {
        return deptDisplay;
    }

    public void setDeptDisplay(Integer deptDisplay) {
        this.deptDisplay = deptDisplay;
    }

    public String getDeptApprover() {
        return deptApprover == null ? "" : deptApprover.trim();
    }

    public void setDeptApprover(String deptApprover) {
        this.deptApprover = deptApprover;
    }

    public String getDeptApproverName() {
        return deptApproverName;
    }

    public void setDeptApproverName(String deptApproverName) {
        this.deptApproverName = deptApproverName;
    }
}