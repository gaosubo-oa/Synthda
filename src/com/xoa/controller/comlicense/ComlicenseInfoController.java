package com.xoa.controller.comlicense;

import com.xoa.model.comlicense.ComlicenseInfoWithBLOBs;
import com.xoa.service.comlicense.ComlicenseInfoService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/comlicenseInfo")
@Controller
public class ComlicenseInfoController {
    @Autowired
    private ComlicenseInfoService comlicenseInfoService;


    @RequestMapping("toPage")
    public String inboxPage(HttpServletRequest request) {
        return "app/comlicenseType/comlicenseInfo";
    }


    /**
     * 新增
     * @param request
     * @param comlicenseInfo
     * @return
     */
    @ResponseBody
    @RequestMapping("/add")
    public ToJson addComlicenseInfo(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfo){
        return comlicenseInfoService.addComlicenseInfo(request,comlicenseInfo);
    }

    /**
     * 根据主键删除
     * @param request
     * @param licenseId
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public ToJson deleteComlicenseType(HttpServletRequest request,Integer licenseId){
        return comlicenseInfoService.deleteComlicenseType(request,licenseId);
    }

    /**
     * 根据主键修改
     * @param request
     * @param comlicenseInfo
     * @return
     */
    @ResponseBody
    @RequestMapping("/update")
    public ToJson updateComlicenseType(HttpServletRequest request,ComlicenseInfoWithBLOBs comlicenseInfo){
        return comlicenseInfoService.updateComlicenseInfo(request,comlicenseInfo);
    }

    /**
     * 查询全部
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryAll")
    public ToJson queryAll(HttpServletRequest request, PageParams pageParams){
        return comlicenseInfoService.queryAll(request,pageParams);
    }

    /**
     * 通过主键查询
     * @param request
     * @param licenseId
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryByTypeId")
    public ToJson queryByTypeId(HttpServletRequest request,Integer licenseId){
        return comlicenseInfoService.queryByInfoId(request,licenseId);
    }

    @RequestMapping("getLogById")
    @ResponseBody
//    通过licenseId查询该证照的历史日志数据
    public ToJson getLogById(HttpServletRequest request,Integer licenseId){
        return comlicenseInfoService.getLogById(request,licenseId);
    }

    @RequestMapping("getLogDetailById")
    @ResponseBody
//    根据版本的主键id查询某个证照的版本
    public ToJson getLogDetailById(HttpServletRequest request,Integer logId){
        return comlicenseInfoService.getLogDetailById(request,logId);
    }

    @RequestMapping("getDataByCondition")
    @ResponseBody
//    根据条件获取证照信息
    public ToJson getDataByCondition(HttpServletRequest request, ComlicenseInfoWithBLOBs comlicenseInfoWithBLOBs,PageParams pageParams){
        return comlicenseInfoService.getDataByCondition(request,comlicenseInfoWithBLOBs,pageParams);
    }
}
