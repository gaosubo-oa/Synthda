package com.xoa.controller.comlicense;


import com.xoa.model.comlicense.ComlicenseType;
import com.xoa.service.comlicense.ComlicenseTypeService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/comlicenseType")
public class ComlicenseTypeController {
    @Autowired
    private ComlicenseTypeService comlicenseTypeService;


    @RequestMapping("toPage")
    public String inboxPage(HttpServletRequest request) {
        return "app/comlicenseType/comlicenseType";
    }

    /**
     * 新增
     * @param request
     * @param comlicenseType
     * @return
     */
    @ResponseBody
    @RequestMapping("/add")
    public ToJson addComlicenseType(HttpServletRequest request,ComlicenseType comlicenseType){
        return comlicenseTypeService.addComlicenseType(request,comlicenseType);
    }

    /**
     * 根据主键删除
     * @param request
     * @param licenseType
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public ToJson deleteComlicenseType(HttpServletRequest request,Integer licenseType){
        return comlicenseTypeService.deleteComlicenseType(request,licenseType);
    }

    /**
     * 根据主键修改
     * @param request
     * @param comlicenseType
     * @return
     */
    @ResponseBody
    @RequestMapping("/update")
    public ToJson updateComlicenseType(HttpServletRequest request,ComlicenseType comlicenseType){
        return comlicenseTypeService.updateComlicenseType(request,comlicenseType);
    }

    /**
     * 查询全部
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryAll")
    public ToJson queryAll(HttpServletRequest request, PageParams pageParams){
        return comlicenseTypeService.queryAll(request,pageParams);
    }

    /**
     * 通过主键查询
     * @param request
     * @param licenseType
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryByTypeId")
    public ToJson queryByTypeId(HttpServletRequest request,Integer licenseType){
        return comlicenseTypeService.queryByTypeId(request,licenseType);
    }
}
