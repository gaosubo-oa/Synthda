package com.xoa.controller.infoCenter;

import com.xoa.service.infoCenter.InfoCenterService;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by 张雨 on 2018/1/15.
 * 首页标签卡设置
 */
@Controller
@RequestMapping("/infoCenter")
public class InfoCenterController {

    @Autowired
    InfoCenterService infoCenterService;

    //获取标签卡位置顺序
    @ResponseBody
    @RequestMapping("/getInfoCenterOrder")
    public BaseWrapper getInfoCenterOrder(HttpServletRequest request) {
        return infoCenterService.getInfoCenterOrder(request);
    }

    //设置标签卡位置顺序
    @ResponseBody
    @RequestMapping("/setInfoCenterOrder")
    public BaseWrapper setInfoCenterOrder(String infoCenterOrder,String infoLeftOrder,String infoRightOrder,HttpServletRequest request) {
        return infoCenterService.setInfoCenterOrder(infoCenterOrder,infoLeftOrder,infoRightOrder,request);
    }

    //获取菜单设置已添加的标签卡
    @ResponseBody
    @RequestMapping("/getHadInfoCenterList")
    public BaseWrapper getHadInfoCenterList(HttpServletRequest request) {
        return infoCenterService.getHadInfoCenterList(request);
    }

    //获取菜单设置未添加的标签卡
    @ResponseBody
    @RequestMapping("/getChooseInfoCenterList")
    public BaseWrapper getChooseInfoCenterList(HttpServletRequest request) {
        return infoCenterService.getChooseInfoCenterList(request);
    }

    //获取全部的标签卡
    @ResponseBody
    @RequestMapping("/getInfoCenters")
    public BaseWrapper getInfoCenters(HttpServletRequest request) {
        return infoCenterService.getInfoCenters(request);
    }
}
