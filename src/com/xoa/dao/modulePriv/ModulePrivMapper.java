package com.xoa.dao.modulePriv;


import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.UserPriv;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ModulePrivMapper {

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   添加方法
     * @return ToJson<ModulePriv>
     */
    void addModulePriv(ModulePriv modulePriv);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   更新方法
     * @return ToJson<ModulePriv>
     */
    void updateModulePriv(ModulePriv modulePriv);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   批量删除方法
     * @return ToJson<ModulePriv>
     */
    void deleteModulePrivs(@Param(value = "uids") String[] uids,@Param(value = "moduleId")Integer moduleId);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   单个删除方法
     * @return ToJson<ModulePriv>
     */
    void deleteModulePriv(ModulePriv modulePriv);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid的多个删除
     * @return ToJson<ModulePriv>
     */
    void deleteModulePrivByUids(String[] uids);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid和moduleId查询单个实体方法
     * @return ToJson<ModulePriv>
     */
    ModulePriv getModulePrivSingle(ModulePriv modulePriv);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   获取权限字符串中的部门名称
     * @return ToJson<ModulePriv>
     */
    List<Department> getDeptNameByIds(String[] ids);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   获取权限字符串中的角色名称
     * @return ToJson<ModulePriv>
     */
    List<UserPriv> getPrivNameByIds(String[] ids);


    String getPrivNameById(String s);

    // 获取当前用户的白名单对应的名字
    ModulePriv selectWhiteListNameByUid(Integer uid);
}
