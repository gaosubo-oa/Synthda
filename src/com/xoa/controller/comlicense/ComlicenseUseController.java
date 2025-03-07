package com.xoa.controller.comlicense;

import com.xoa.model.comlicense.ComlicenseUseWithBLOBs;
import com.xoa.service.comlicense.ComlicenseUseService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/comlicenseUse")
public class ComlicenseUseController {

    @Autowired
    private ComlicenseUseService comlicenseUseService;

    @RequestMapping("toPage")
    public String inboxPage(HttpServletRequest request) {
        return "app/comlicenseType/comlicenseUse";
    }


    @RequestMapping("getDataByCondition")
    @ResponseBody
    public ToJson getDataByCondition(HttpServletRequest request, ComlicenseUseWithBLOBs comlicenseUseWithBLOBs, PageParams pageParams){
        return comlicenseUseService.getDataByCondition(request,comlicenseUseWithBLOBs,pageParams);
    }

    @RequestMapping("approvalStatus")
    @ResponseBody
//    管理员去审批借阅订单
    public ToJson approvalStatus(HttpServletRequest request,ComlicenseUseWithBLOBs comlicenseUseWithBLOBs){
        return comlicenseUseService.approvalStatus(request,comlicenseUseWithBLOBs);
    }

    @RequestMapping("updateComlicenseUse")
    @ResponseBody
//    提交人修改证照借阅信息
    public ToJson updateComlicenseUse(HttpServletRequest request,ComlicenseUseWithBLOBs comlicenseUseWithBLOBs){
        return comlicenseUseService.updateComlicenseUse(request,comlicenseUseWithBLOBs);
    }

    @RequestMapping("addComlicenseUse")
    @ResponseBody
//    申请人申请提交证照借阅信息
    public ToJson addComlicenseUse(HttpServletRequest request,ComlicenseUseWithBLOBs comlicenseUseWithBLOBs){
        return comlicenseUseService.addComlicenseUse(request,comlicenseUseWithBLOBs);
    }

    @RequestMapping("delComlicenseUse")
    @ResponseBody
//    申请人取消证照借阅
    public ToJson delComlicenseUse(HttpServletRequest request,String licenseUseIds){
        return comlicenseUseService.delComlicenseUse(request,licenseUseIds);
    }

    @RequestMapping("getDataByLicenseUseId")
    @ResponseBody
    public ToJson getDataByLicenseUseId(HttpServletRequest request,Integer licenseUseId){
        return comlicenseUseService.getDataByLicenseUseId(request,licenseUseId);
    }

}
