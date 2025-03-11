package com.xoa.service.modulePriv;

import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 *
 * 创建作者:   张航宁
 * 创建日期:   2017-07-05
 * 类介绍  :   用户权限接口
 * 构造参数:   无
 *
 */
public interface ModulePrivService {

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   添加方法
     * @return ToJson<ModulePriv>
     */
    ToJson<ModulePriv> saveModulePriv(ModulePriv modulePriv,String applyModules,String applyDepts,String applyPrivs);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   更新方法
     * @return ToJson<ModulePriv>
     */
    ToJson<ModulePriv> updateModulePriv(ModulePriv modulePriv);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid和moduleid删除
     * @return ToJson<ModulePriv>
     */
    ToJson<ModulePriv> deleteModulePriv(ModulePriv modulePriv);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid查询
     * @return ToJson<ModulePriv>
     */
    ToJson<ModulePriv> getModulePrivSingle(ModulePriv modulePriv);

    /**
     * 查询可设置管理范围的模块列表
     * @param request
     * @return
     */
    ToJson<ModulePriv> queryModules(HttpServletRequest request);

    /**
     * 根据uid和moduleid查询单个模块管理范围
     * @param modulePriv
     * @return
     */
    ToJson<ModulePriv> queryModulePrivSingle(HttpServletRequest request,ModulePriv modulePriv);


    /**
     * 根据uid和moduleid查询有权限的部门和角色
     * @return
     */
    Map<String,Object> getModulePriv(Users users, String moduleId);
}
