package com.xoa.controller.ueTemplate;

import com.xoa.model.ueTemplate.UeTemplateWithBLOBs;
import com.xoa.service.ueTemplate.UeTemplateService;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("ueTemplate")
public class UeTemplateController {
    @Autowired
    private UeTemplateService ueTemplateService;
    //page
    @RequestMapping("/newUeTemplate")
    public String getnewUeTemplate(){
        return  "app/ueTemplate/newUeTemplate";
    }

    @RequestMapping("/ueTemplateManagement")
    public String ueTemplateManagement(){
        return  "app/ueTemplate/ueTemplateManagement";
    }

    //接口
    @RequestMapping("/insertUeTemplate")
    @ResponseBody
    public BaseWrapper insertUeTemplate(UeTemplateWithBLOBs ueTemplateWithBLOBs){
        return  ueTemplateService.insertUeTemplate(ueTemplateWithBLOBs);
    }
    @RequestMapping("/deleteUeTemplate")
    @ResponseBody
    public BaseWrapper deleteUeTemplate(Integer id){
        return  ueTemplateService.deleteUeTemplate(id);
    }
    @RequestMapping("/getUeTemplateById")
    @ResponseBody
    public BaseWrapper getUeTemplateById(Integer id){
        return  ueTemplateService.getUeTemplateById(id);
    }
    @RequestMapping("/updateUeTemplate")
    @ResponseBody
    public BaseWrapper updateUeTemplate(UeTemplateWithBLOBs ueTemplateWithBLOBs){
        return  ueTemplateService.updateUeTemplate(ueTemplateWithBLOBs);
    }
    @RequestMapping("/getUeTemplateList")
    @ResponseBody
    public BaseWrapper getUeTemplateList(){
        return  ueTemplateService.getUeTemplateList();
    }
}
