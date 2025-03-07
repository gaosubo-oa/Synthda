package com.xoa.dao.users;

import com.xoa.model.users.OrgManage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrgManageMapper {
    public List<OrgManage> queryId();

    public List<OrgManage> querylistId(@Param("Ids") List Ids);


    int editOrgManage(OrgManage orgManage);


    List<OrgManage> getOrgManage();


    OrgManage getOrgManageById(Integer oid);

    void addOrgManage(OrgManage orgManage);

    int editOid(OrgManage orgManage);

    /**
     * @作者: 张航宁
     * @时间: 2019/7/16
     * @说明: 获取主组织库 使用list是为了防止有多个主组织的错误数据
     */
    List<OrgManage> selOrgManageIsOrg();

    /**
     * @作者: 张航宁
     * @时间: 2019/7/16
     * @说明: 获取列表中的第一个数据库组织
     */
    OrgManage selFirstOrg();

    List<OrgManage> selOrgInIds(@Param("Ids") List Ids);

    List<OrgManage>  getOrgManageByAgentId(@Param("agentId")Integer agentId);

    int updateDirectorySize(OrgManage orgManage);

    int insertSelective(OrgManage orgManage);

    int selectUsedUsers(@Param("xoa") String xoa);

    OrgManage selectOrgManageByOid(@Param("xoa") String xoa,@Param("oid") String oid);

    List<OrgManage> queryAll();
}