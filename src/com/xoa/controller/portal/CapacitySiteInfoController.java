package com.xoa.controller.portal;

import com.xoa.model.portal.CapacitySiteInfo;
import com.xoa.service.portal.CapacitySiteInfoService;
import com.xoa.service.portal.wrapper.PortalWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(value = "/capacitySiteInfo")
public class CapacitySiteInfoController {
    @Autowired
    private CapacitySiteInfoService capacitySiteInfoService;
    @RequestMapping(value = "/selectCapacitySiteInfoList")
    public BaseWrappers selectCapacitySiteInfoList(HttpServletRequest request,
                                                   @RequestParam(name = "page", required = false, defaultValue = "1") Integer page,
                                                   @RequestParam(name = "pageSize", required = false, defaultValue = "10") Integer pageSize){
        return  capacitySiteInfoService.selectCapacitySiteInfoList(request,page,pageSize);
    }
    @RequestMapping(value = "/updateCapacitySiteInfo")
    public PortalWrapper updateCapacitySiteInfo(CapacitySiteInfo capacitySiteInfo,HttpServletRequest request){
        return capacitySiteInfoService.updateCapacitySiteInfo(capacitySiteInfo,request);
    }
    @RequestMapping(value = "/addCapacitySiteInfo")
    public PortalWrapper addCapacitySiteInfo(CapacitySiteInfo capacitySiteInfo, HttpServletRequest request){
        return  capacitySiteInfoService.addCapacitySiteInfo(capacitySiteInfo,request);
    }
    @RequestMapping(value = "/queryCapacitySiteInfoOne")
    public PortalWrapper queryCapacitySiteInfoOne(Integer sid){
        return  capacitySiteInfoService.queryCapacitySiteInfoOne(sid);
    }
    @RequestMapping(value = "/deleteCapacitySiteInfoOne")
    public PortalWrapper deleteCapacitySiteInfoOne(Integer sid){
        return  capacitySiteInfoService.deleteCapacitySiteInfoOne(sid);
    }
}
