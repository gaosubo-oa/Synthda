
package com.xoa.controller.portalTemplate;

import com.xoa.model.portalTemplate.PortalTemplateWithBLOBs;
import com.xoa.service.portalTemplate.PortalTemplateService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/temp")
public class PortalTemplateController {

    @Resource
    private PortalTemplateService portalTemplateService;

    @RequestMapping("/temp")
    public String goIndex() {
        return "app/temp/index";
    }


    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍: 显示模板
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/selectPortalTemplate")
    public ToJson selectPortalTemplate(Integer portalId){

        return portalTemplateService.selectPortalTemplate(portalId);
    }

    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍: 显示模板
     * @参数：sms
     */
   @ResponseBody
    @RequestMapping("/selectPortalTemplateById")
    public ToJson selectPortalTemplateById(HttpServletRequest request,Integer templateId){

        return portalTemplateService.selectPortalTemplateById(request,templateId);
    }

    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍:添加模板
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/insertPortalTemplate")
    public ToJson insertPortalTemplate(HttpServletRequest request, PortalTemplateWithBLOBs portalTemplateWithBLOBs){
        return portalTemplateService.insertPortalTemplate(request,portalTemplateWithBLOBs);
    }
    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍:修改模板
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/upPortalTemplate")
    public ToJson upPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs){

        return portalTemplateService.upPortalTemplate(request,portalTemplateWithBLOBs);
    }
    /**
     * @作者：张海叶
     * @时间：2018/2/27
     * @介绍:删除模板
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/delPortalTemplate")
    public ToJson delPortalTemplate(HttpServletRequest request,PortalTemplateWithBLOBs portalTemplateWithBLOBs){

        return portalTemplateService.delPortalTemplate(request,portalTemplateWithBLOBs);
    }


}
