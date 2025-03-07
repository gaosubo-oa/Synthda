package com.xoa.model.users;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName (类名):  UserPriv
 * @Description(简述): TODO
 * @author(作者):      张龙飞
 * @date(日期):        2017年4月17日 下午5:36:41
 *
 */
public class UserPriv implements Serializable{
    private static final long serialVersionUID = 1L;

	/**
	 *角色ID
	 */
    private Integer userPriv;
    /**
	 *角色名称
	 */
    private String privName;
    /**
	 *角色编码
	 */
    private Short privNo;
    /**
	 *角色对应的功能ID串
	 */
        private String funcIdStr;
    /**
	 *所属部门
	 */
    private Integer privDeptId;
    /**
     *所属部门名字
     */
    private String privDeptName;

    /**
	 *角色类型
	 */
    private Integer privType;
    /**
	 *全局角色
	 */
    private Integer isGlobal;
    /**
     *角色分类id
     */
    private Integer privTypeId;
    /**
     *角色分类名称
     */
    private String privTypeName;
    /**
     * 主角色主登录数/角色禁止登录用户数/辅助角色用户数
     */
    private String showCount;

    private Integer insertCounts;

    private Integer failCounts;

    private Integer emptyCount;

    private Integer reapNameCount;
    //角色用户
    private List<Users> users;
    //辅助角色用户
    private List<Users> otherUsers;

    //是否为中高管
    private String isZhongGaoGuan;

    //角色分类菜单id串
    private String userPrivTypeFuncIdStr;

    public Integer getEmptyCount() {
        return emptyCount==null?0:emptyCount;
    }

    public void setEmptyCount(Integer emptyCount) {
        this.emptyCount = emptyCount;
    }

    public Integer getReapNameCount() {
        return reapNameCount==null?0:reapNameCount;
    }

    public void setReapNameCount(Integer reapNameCount) {
        this.reapNameCount = reapNameCount;
    }

    public Integer getFailCounts() {
        return failCounts==null?0:failCounts;
    }

    public void setFailCounts(Integer failCounts) {
        this.failCounts = failCounts;
    }

    public Integer getInsertCounts() {
        return insertCounts==null?0:insertCounts;
    }

    public void setInsertCounts(Integer insertCounts) {
        this.insertCounts = insertCounts;
    }

    public String getShowCount() {
        return showCount;
    }

    public void setShowCount(String showCount) {
        this.showCount = showCount;
    }
    //     /**
//      * 接受页面json串
//      */
//    private String[] mapList;
     /**
      * 接受页面json串
      */
    private String mapList;


    public String getPrivDeptName() {
        return privDeptName;
    }

    public void setPrivDeptName(String privDeptName) {
        this.privDeptName = privDeptName;
    }

    public Integer getUserPriv() {
        return userPriv;
    }

    public void setUserPriv(Integer userPriv) {
        this.userPriv = userPriv;
    }

    public String getPrivName() {
        return privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName == null ? null : privName.trim();
    }

    public Short getPrivNo() {
        return privNo;
    }

    public void setPrivNo(Short privNo) {
        this.privNo = privNo;
    }

    public String getFuncIdStr() {
        return funcIdStr;
    }

    public void setFuncIdStr(String funcIdStr) {
        this.funcIdStr = funcIdStr == null ? null : funcIdStr.trim();
    }

    public Integer getPrivDeptId() {
        return privDeptId;
    }

    public void setPrivDeptId(Integer privDeptId) {
        this.privDeptId = privDeptId;
    }

    public Integer getPrivType() {
        return privType;
    }

    public void setPrivType(Integer privType) {
        this.privType = privType;
    }

    public Integer getIsGlobal() {
        return isGlobal;
    }

    public void setIsGlobal(Integer isGlobal) {
        this.isGlobal = isGlobal;
    }

    /**
     * 接受页面json串
     * @return
     */
    public String getMapList() {
        return mapList;
    }

    /**
     * 接受页面json串
     * @param mapList
     */
    public void setMapList(String mapList) {
        this.mapList = mapList;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public List<Users> getUsers() {
        return users;
    }

    public void setUsers(List<Users> users) {
        this.users = users;
    }

    public List<Users> getOtherUsers() {
        return otherUsers;
    }

    public void setOtherUsers(List<Users> otherUsers) {
        this.otherUsers = otherUsers;
    }

    public Integer getPrivTypeId() {
        return privTypeId;
    }

    public void setPrivTypeId(Integer privTypeId) {
        this.privTypeId = privTypeId;
    }

    public String getPrivTypeName() {
        return privTypeName;
    }

    public void setPrivTypeName(String privTypeName) {
        this.privTypeName = privTypeName;
    }

    public String getIsZhongGaoGuan() {
        return isZhongGaoGuan;
    }

    public void setIsZhongGaoGuan(String isZhongGaoGuan) {
        this.isZhongGaoGuan = isZhongGaoGuan;
    }

    public String getUserPrivTypeFuncIdStr() {
        return userPrivTypeFuncIdStr;
    }

    public void setUserPrivTypeFuncIdStr(String userPrivTypeFuncIdStr) {
        this.userPrivTypeFuncIdStr = userPrivTypeFuncIdStr;
    }
}