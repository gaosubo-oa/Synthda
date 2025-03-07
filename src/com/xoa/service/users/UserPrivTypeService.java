package com.xoa.service.users;

import com.xoa.model.users.UserPriv;
import com.xoa.model.users.UserPrivType;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 创建作者:   hwx
 * 创建日期:   2022年2月15日
 * 类介绍  :   角色类型接口
 */
public interface UserPrivTypeService {


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   添加角色类型
     * 参数说明:   @param userPrivType  角色类型
     * @return ToJson<UserPrivType>
     */
    ToJson<UserPrivType> addUserPrivType(HttpServletRequest request, UserPrivType userPrivType);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id删除角色类型
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPrivType>
     */
    ToJson<UserPrivType> delUserPrivType(HttpServletRequest request, Integer privTypeId);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   修改角色类型
     * 参数说明:   @param userPrivType  角色类型信息
     * @return ToJson<UserPrivType>
     */
    ToJson<UserPrivType> updateUserPrivType(HttpServletRequest request, UserPrivType userPrivType);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   查询角色类型列表
     * 参数说明:   @param userPrivType  角色类型信息
     * @return ToJson<UserPrivType>
     */
    ToJson<UserPrivType> queryUserPrivType(HttpServletRequest request, UserPrivType userPrivType);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据角色类型id查询对应的角色列表
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPriv>
     */
    ToJson<UserPriv> queryUserPrivByTypeId(HttpServletRequest request, Integer privTypeId);

    ToJson<UserPriv> queryUserPrivByTypeIdNew(HttpServletRequest request, Integer privTypeId, Integer number, String deptId);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id查询角色类型
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPrivType>
     */
    ToJson<UserPrivType> selUserPrivType(HttpServletRequest request, Integer privTypeId);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年3月23日
     * 方法介绍:   根据当前用户分级机构查询角色类型
     * @return ToJson<UserPrivType>
     */
    ToJson<UserPrivType> selUserPrivTypeByDept(HttpServletRequest request);


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据角色类型id查询对应的角色列表
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPriv>
     */
    ToJson<UserPriv> queryUserPrivByTypeIdAndDept(HttpServletRequest request, Integer privTypeId);


    List<Integer> checkPrivTypeIdByDept(Users users);


    List<Integer> getPrivTypeFuncIds(Users users);


    ToJson<UserPrivType> queryUserPrivTypeById(HttpServletRequest request, Integer privTypeId);

    ToJson<UserPrivType> queryUserPrivTypeNew(HttpServletRequest request, UserPrivType userPrivType, String deptId);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/28
     * 方法介绍: 根据当前用户，管理的分支机构，查询角色分类
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPrivType>
     **/
    ToJson<UserPrivType> selectUserPrivTypeByOrgAdmin(HttpServletRequest request);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/4
     * 方法介绍: 根据当前用户分级机构设置的角色类型范围的角色，查询所有角色。 高级查询（根据角色分类ID）
     * 参数说明: [request, privTypeId]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    ToJson<UserPriv> queryAllUserPriv(HttpServletRequest request, Integer privTypeId);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/11/29
     * 方法介绍: 根据当前用户分级机构设置的角色类型范围的角色，通过角色名称模糊查询角色
     * 参数说明: [request, privName]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    ToJson<UserPriv> queryUserPrivByPrivName(HttpServletRequest request, String privName);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/12
     * 方法介绍: 根据当前用户所在的分支机构查询角色分类
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPrivType>
     **/
    ToJson<UserPrivType> selectUserPrivTypeByClassifyOrg(HttpServletRequest request);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/26
     * 方法介绍: 分支机构 角色权限信息导入
     * 参数说明: [request, privName]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    ToJson<UserPriv> inputUserPriv(HttpServletRequest request, MultipartFile file);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/26
     * 方法介绍: 分支机构 角色权限信息导出
     * 参数说明: [request, response]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    ToJson<UserPriv> outputUserPriv(HttpServletRequest request, HttpServletResponse response);
}
