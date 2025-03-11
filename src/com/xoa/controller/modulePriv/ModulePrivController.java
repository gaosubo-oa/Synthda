package com.xoa.controller.modulePriv;


import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/modulePriv")
public class ModulePrivController {

    @Resource
    private ModulePrivService modulePrivService;

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月5日
     * 方法介绍:   保存方法
     * @return ToJson<ModulePriv>
     */
    @ResponseBody
    @RequestMapping( value = "/saveModulePriv",produces = {"application/json;charset=UTF-8"})
    public ToJson<ModulePriv> saveModulePriv(ModulePriv modulePriv,String applyModules,String applyDepts,String applyPrivs){
        return modulePrivService.saveModulePriv(modulePriv,applyModules,applyDepts,applyPrivs);
    }


    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月5日
     * 方法介绍:   根据uid和moduleId删除方法
     * @return ToJson<ModulePriv>
     */
    @ResponseBody
    @RequestMapping(value = "/deleteModulePriv",produces = {"application/json;charset=UTF-8"})
    public ToJson<ModulePriv> deleteModulePriv(ModulePriv modulePriv){
        return modulePrivService.deleteModulePriv(modulePriv);
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid和moduleId查询
     * @return ToJson<ModulePriv>
     */
    @ResponseBody
    @RequestMapping(value = "/getModulePrivSingle",produces = {"application/json;charset=UTF-8"})
    public ToJson<ModulePriv> getModulePrivByUid(ModulePriv modulePriv){
        return modulePrivService.getModulePrivSingle(modulePriv);
    }


    /**
     * 查询可设置管理范围的模块列表
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/queryModules",produces = {"application/json;charset=UTF-8"})
    public ToJson<ModulePriv> queryModules(HttpServletRequest request){
        return modulePrivService.queryModules(request);
    }

    /**
     * 查询可设置管理范围的模块列表
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/queryModulePrivSingle",produces = {"application/json;charset=UTF-8"})
    public ToJson<ModulePriv> queryModulePrivSingle(HttpServletRequest request,ModulePriv modulePriv){
        return modulePrivService.queryModulePrivSingle(request,modulePriv);
    }

    // 查询管理范围的选择界面
    @RequestMapping("/ManagementScope")
    public String  index(HttpServletRequest request){
        return "app/sys/ManagementScope";
    }
}
