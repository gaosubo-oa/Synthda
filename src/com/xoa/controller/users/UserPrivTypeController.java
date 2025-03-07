package com.xoa.controller.users;


import com.xoa.model.users.UserPriv;
import com.xoa.model.users.UserPrivType;
import com.xoa.service.users.UserPrivTypeService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 创建作者:   hwx
 * 创建日期:   2022年2月15日
 * 类介绍  :   角色分类控制器
 */
@Controller
@RequestMapping(value="/userPrivType")
public class UserPrivTypeController {

    @Resource
    private UserPrivTypeService userPrivTypeService;


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   添加角色类型
     * 参数说明:   @param userPrivType  角色类型
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/addUserPrivType")
    public ToJson<UserPrivType> addUserPrivType(HttpServletRequest request, UserPrivType userPrivType) {
        return userPrivTypeService.addUserPrivType(request,userPrivType);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id删除角色类型
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/delUserPrivType")
    public ToJson<UserPrivType> delUserPrivType(HttpServletRequest request, Integer privTypeId) {
        return userPrivTypeService.delUserPrivType(request,privTypeId);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   修改角色类型
     * 参数说明:   @param userPrivType  角色类型信息
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/updateUserPrivType")
    public ToJson<UserPrivType> updateUserPrivType(HttpServletRequest request, UserPrivType userPrivType) {
        return userPrivTypeService.updateUserPrivType(request,userPrivType);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   查询角色类型列表
     * 参数说明:   @param userPrivType  角色类型信息
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/queryUserPrivType")
    public ToJson<UserPrivType> queryUserPrivType(HttpServletRequest request, UserPrivType userPrivType) {
        return userPrivTypeService.queryUserPrivType(request,userPrivType);
    }

    @ResponseBody
    @RequestMapping(value = "/queryUserPrivType/{deptId}")
    public ToJson<UserPrivType> queryUserPrivTypeByDeptId(HttpServletRequest request, UserPrivType userPrivType, @PathVariable String deptId) {
        return userPrivTypeService.queryUserPrivTypeNew(request, userPrivType, deptId);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据角色类型id查询对应的角色列表
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPriv>
     */
    @ResponseBody
    @RequestMapping(value = "/queryUserPrivByPrivTypeId")
    public ToJson<UserPriv> queryUserPrivByTypeId(HttpServletRequest request, Integer privTypeId) {
        return userPrivTypeService.queryUserPrivByTypeId(request,privTypeId);
    }

    @ResponseBody
    @RequestMapping(value = "/queryUserPrivByPrivTypeIdNew")
    public ToJson<UserPriv> queryUserPrivByTypeId(HttpServletRequest request, Integer privTypeId, Integer number, String deptId) {
        return userPrivTypeService.queryUserPrivByTypeIdNew(request,privTypeId,number,deptId);
    }

    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id查询角色类型
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/selUserPrivType")
    public ToJson<UserPrivType> selUserPrivType(HttpServletRequest request, Integer privTypeId) {
        return userPrivTypeService.selUserPrivType(request,privTypeId);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id查询角色类型(根据分级机构权限判断)
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/queryUserPrivTypeById")
    public ToJson<UserPrivType> queryUserPrivTypeById(HttpServletRequest request, Integer privTypeId) {
        return userPrivTypeService.queryUserPrivTypeById(request,privTypeId);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年3月23日
     * 方法介绍:   根据当前用户分级机构查询角色类型
     * @return ToJson<UserPrivType>
     */
    @ResponseBody
    @RequestMapping(value = "/queryUserPrivTypeByDept")
    public ToJson<UserPrivType> selUserPrivTypeByDept(HttpServletRequest request) {
        return userPrivTypeService.selUserPrivTypeByDept(request);
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据角色类型id查询对应的角色列表，需要经过分级机构过滤
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPriv>
     */
    @ResponseBody
    @RequestMapping(value = "/queryUserPrivByTypeIdAndDept")
    public ToJson<UserPriv> queryUserPrivByTypeIdAndDept(HttpServletRequest request, Integer privTypeId) {
        return userPrivTypeService.queryUserPrivByTypeIdAndDept(request,privTypeId);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/28
     * 方法介绍: 根据当前用户，管理的分支机构，查询角色分类
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPrivType>
     **/
    @ResponseBody
    @RequestMapping(value = "/selectUserPrivTypeByOrgAdmin")
    public ToJson<UserPrivType> selectUserPrivTypeByOrgAdmin(HttpServletRequest request) {
        return userPrivTypeService.selectUserPrivTypeByOrgAdmin(request);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/4
     * 方法介绍: 根据当前用户分级机构设置的角色类型范围的角色，查询所有角色。 高级查询（根据角色分类ID）
     * 参数说明: [request, privTypeId]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping(value = "/queryAllUserPriv")
    public ToJson<UserPriv> queryAllUserPriv(HttpServletRequest request, Integer privTypeId) {
        return userPrivTypeService.queryAllUserPriv(request, privTypeId);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/11/29
     * 方法介绍: 根据当前用户分级机构设置的角色类型范围的角色，通过角色名称模糊查询角色
     * 参数说明: [request, privName]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping(value = "/queryUserPrivByPrivName")
    public ToJson<UserPriv> queryUserPrivByPrivName(HttpServletRequest request, String privName) {
        return userPrivTypeService.queryUserPrivByPrivName(request, privName);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/12
     * 方法介绍: 根据当前用户所在的分支机构查询角色分类
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPrivType>
     **/
    @ResponseBody
    @RequestMapping(value = "/selectUserPrivTypeByClassifyOrg")
    public ToJson<UserPrivType> selectUserPrivTypeByClassifyOrg(HttpServletRequest request) {
        return userPrivTypeService.selectUserPrivTypeByClassifyOrg(request);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/26
     * 方法介绍: 分支机构 角色权限信息导入
     * 参数说明: [request, privName]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping(value = "/inputUserPriv")
    public ToJson<UserPriv> inputUserPriv(HttpServletRequest request, MultipartFile file) {
        return userPrivTypeService.inputUserPriv(request, file);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/26
     * 方法介绍: 分支机构 角色权限信息导出
     * 参数说明: [request, response]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping(value = "/outputUserPriv")
    public ToJson<UserPriv> outputUserPriv(HttpServletRequest request, HttpServletResponse response) {
        return userPrivTypeService.outputUserPriv(request, response);
    }

}
