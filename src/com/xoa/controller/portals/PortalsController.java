package com.xoa.controller.portals;

import com.xoa.model.portals.Portals;
import com.xoa.model.portals.PortalsUser;
import com.xoa.service.portals.PortalsService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2018/2/28.
 */
@Controller
@RequestMapping("/portals")
public class PortalsController {

    @Autowired
    private PortalsService portalsService;


    @RequestMapping("/index")
    public String indexPage() {
        return "app/portals/index";
    }

    @RequestMapping("/conSetting")
    public String conSetting() {
        return "app/portals/conSetting";
    }

    @RequestMapping("/appPortal")
    public String appPortal() {
        return "app/portals/appPortal";
    }

    @RequestMapping("/manaPortal")
    public String manaPortal() {
        return "app/portals/manaPortal";
    }

    //公文门户
    @RequestMapping("/officeIndex")
    public String officeIndex(HttpServletRequest request) {
        return "app/main/menu/officeIndex";
    }

    //大足办公管理门户
    @RequestMapping("/dazueduIndex")
    public String dazueduIndex(HttpServletRequest request){return "app/portals/dazueduIndex";}

    //办公门户
    @RequestMapping("/officePortal")
    public String officePortal(HttpServletRequest request){return "app/portals/officePortal";}

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 添加接口
     */
    @ResponseBody
    @RequestMapping("/add")
    public ToJson<Portals> addPortals(Portals portals){
        return portalsService.addPortals(portals);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据id更新
     */
    @ResponseBody
    @RequestMapping("/update")
    public ToJson<Portals> updatePortals(HttpServletRequest request,Portals portals){
        return portalsService.updatePortals(request,portals);
    }

    @ResponseBody
    @RequestMapping("/updatePersonal")
    public ToJson<Portals> updatePersonal(@RequestParam(value = "mytableRight",required = false) String mytableRight,@RequestParam(value = "portalsId",required = false)Integer portalsId){
        return portalsService.updatePersonal(mytableRight,portalsId);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 获取所有
     */
    @ResponseBody
    @RequestMapping("/selPortals")
    public ToJson<Portals> selPortals(PageParams pageParams,Portals portals){
        return portalsService.selPortals(pageParams,portals);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据ids删除
     */
    @ResponseBody
    @RequestMapping("/deletePortals")
    public ToJson<Portals> deletePortals(String portalsIds){
        return portalsService.deletePortals(portalsIds);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据id查询
     */
    @ResponseBody
    @RequestMapping("/selPortalsById")
    public ToJson<Portals> selPortalsById(Integer portalsId){
        return portalsService.selPortalsById(portalsId);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/3/2
     * 说明: 查询门户中的个人信息
     */
    @ResponseBody
    @RequestMapping("/selPortalsUser")
    public ToJson<PortalsUser> selPortalsUser(HttpServletRequest request) {
        return portalsService.selPortalsUser(request);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/3/2
     * 说明: 查询所有门户显示在主页 【有权限判断】
     */
    @ResponseBody
    @RequestMapping("/selIndexPortals")
    public ToJson<Portals> selIndexPortals(HttpServletRequest request){
        return portalsService.selIndexPortals(request);
    }
}
