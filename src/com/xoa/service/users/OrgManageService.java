package com.xoa.service.users;

import com.xoa.model.users.OrgManage;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface OrgManageService {
	
	public ToJson<OrgManage> queryId(String locale);
    public ToJson<OrgManage> queryId2(String locale,String serverName);

    /**
     *创建作者:  韩成冰
     *创建日期:  2017/5/22 14:14
     *函数介绍:  获取所有OrgManage
     *参数说明:  无
     *@return:   List<OrgManage>(OrgManage 的List集合)
     **/
    List<OrgManage> getOrgManage();

    /**
     *创建作者:  韩成冰
     *创建日期:  2017/5/22 14:15
     *函数介绍:  根据oid查询某个OrgManage
     *参数说明:  @param oid OrgManage的oid
     *@return:   OrgManage
     **/
    OrgManage getOrgManageById(Integer oid);

    /**
     *创建作者:  韩成冰
     *创建日期:  2017/5/22 14:17
     *函数介绍:  修改某个OrgManage
     *参数说明:  @param OrgManage对象
     *@return:   void
     **/
    void editOrgManage(OrgManage orgManage,HttpServletRequest request);

    /**
     *@创建作者:  韩成冰
     *@创建日期:  2017/5/24 18:50
     *@函数介绍:  添加分公司
     *@参数说明:  @param orgManage
     *@return:   void
     **/
    ToJson<OrgManage> addOrgManage(OrgManage orgManage, HttpServletRequest request);


    BaseWrapper checkOrgManage(HttpServletRequest request);

    /**
     * @作者: 张航宁
     * @时间: 2019/7/16
     * @说明: 获取主组织库 使用list是为了防止有多个主组织的错误数据
     */
    ToJson<OrgManage> selOrgManageIsOrg();

    /**
     * @作者: 张航宁
     * @时间: 2019/7/16
     * @说明: 获取列表中的第一个数据库组织
     */
    ToJson<OrgManage> selFirstOrg();

    /**
     * 根据代理商ID和查询接口密钥查询代理下组织
     * @param request
     * @param agentId 代理商ID
     * @param secretKey 密钥
     * @return
     */
    BaseWrapper queryAgentOrg(HttpServletRequest request, String agentId, String secretKey);

    /**
     * 创建组织
     * @param version      版本信息
     * @param isOrg        是否组织
     * @param enName       英文
     * @param ftName       繁体
     * @param jpName       日文
     * @param krName       韩文
     * @param registTime   开始时间
     * @param endTime      结束时间
     * @param remindTime   提醒时间
     * @param licenseUsers 授权用户数
     * @param licenseSpace 授权存储空间G
     * @param name         单位名称
     * @param agentId      代理商ID
     * @param secretKey    密钥
     * @return
     */
    Integer createAgentOrg(HttpServletRequest request, String version, String isOrg, String enName, String ftName, String jpName, String krName, String registTime, String endTime, String remindTime, Integer licenseUsers, Integer licenseSpace, String name, Integer agentId, String secretKey);


    Integer updateAgentOrg(HttpServletRequest request, String endTime, String remindTime, Integer licenseUsers, Integer licenseSpace, Integer oid, String secretKey);
}
