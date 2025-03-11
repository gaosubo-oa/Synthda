package com.xoa.service.securityApproval;

import com.xoa.model.department.Department;
import com.xoa.model.securityApproval.SecurityApprovalWithBLOBs;
import com.xoa.model.securityApproval.SecurityContentApproval;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface SecurityApprovalService {

    /**
     * 新增一条安全审批数据
     * @param moduleTable  模块主表
     * @param recordId  关联模块主表中ID
     * @param operationUserId  操作人USER_ID
     * @param operationContent  操作内容，记录操作人员填写的需要审批的操作内容，json格式
     * @param operationType  操作类型，用于标记进行哪种操作:0表示新建，1表示编辑，2表示删除
     * @param operationReason  操作原因
     * @param attachmentId  附件ID串
     * @param attachmentName  附件文件名串
     * @param approverUserId  审批人USER_ID
     * @return
     */
    SecurityApprovalWithBLOBs insertSelective(String moduleTable, Integer recordId, String operationUserId, String operationContent,
                                              String operationType, String operationReason, String attachmentId, String attachmentName,
                                              String approverUserId);

    /**
     * 查询三员用户
     * @param paraName 三员对应的系统参数名称（系统安全管理员-SYSECURITY_MANAGE_PRIV，系统安全保密员-SYSECURITY_SECRECY_PRIV，系统安全审计员-SYSECURITY_AUDIT_PRIV）
     * @return
     */
    Users selectSysSecurityUser(String paraName);

    /**
     * 查询需要保密员审批用户
     * @return
     */
    List<SecurityApprovalWithBLOBs> selectApproveUser(Map<String,Object> param);

    /**
     * 保密员审批用户
     * @param request
     * @param approvalStatus 审批状态，标记审批是否通过，0为未审批，1为通过，2为拒绝
     * @param approvalOpinion 审批意见
     * @param operationContent 操作内容
     * @return
     */
    ToJson approveUser(HttpServletRequest request, Integer spId, String approvalStatus,String approvalOpinion,String operationContent);

    /**
     * 查询三员角色
     * @return
     */
    List<String> querySecrecyUserPriv();

    /**
     * 返回结果中去除三员角色的用户和系统超级管理员、与内容密级不符的用户
     * @param usersList 用户列表
     * @param privList 角色列表
     */
    void removeSecrecyUsers(List<Users> usersList,List<UserPriv> privList);

    /**
     * 返回结果中去除指定的部门
     * @param departmentList 部门列表
     */
    void removeSecrecyDept(List<Department> departmentList);

    /**
     * 重置三员管理员的密码
     * @param request
     * @param approveUser 三员系统代码
     * @param password 需要重置的密码
     * @return
     */
    ToJson updateApproveUserPass(HttpServletRequest request, String approveUser, String password);


    /**
     * 查询需要系统安全保密员审批的用户信息
     * @param request
     * @return
     */
    ToJson queryApproveData(HttpServletRequest request,String approvalStatus,String moduleTable,Integer page,Integer pageSize,Boolean useFlag);


    /**
     * 查询未审批的用户或部门信息
     * @param approvalStatus 审批状态，标记审批是否通过，0为未审批，1为通过，2为拒绝
     * @param moduleTable  模块主表
     * @param recordId 关联模块主表中ID
     * @return
     */
    List<SecurityApprovalWithBLOBs> queryNotApprove(String approvalStatus,String moduleTable,String recordId);


    /**
     * 判断用户是否属于涉密系统管理员（超级管理员、系统安全保密员、系统安全审计员、系统安全管理员、系统运维管理员）
     * @param user
     * @return 0否1是
     */
    Integer checkIsSecrecyAdm(Users user);

}
