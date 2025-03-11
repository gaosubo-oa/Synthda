package com.xoa.controller.wechat;


import com.xoa.model.wechat.WxCheck;
import com.xoa.service.wechat.wxCheck.WxCheckService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/wxCheck")
public class WxCheckController {

    @Resource
    WxCheckService wxCheckService;

    @RequestMapping("/wxCheck")
    public String EmailSet(HttpServletRequest request) {

        return "app/weChat/wxCheck";
    }
    @RequestMapping("/addWxCheck1")
    public String EmailSet1(HttpServletRequest request) {

        return "app/weChat/addWxCheck";
    }

    @ResponseBody
    @RequestMapping(value = "/addWxCheck", produces = {"application/json;charset=UTF-8"})
    public ToJson<WxCheck> addWxCheck(HttpServletRequest request, WxCheck wxCheck){

        return wxCheckService.addWxCheck(request,wxCheck);
    }

    @ResponseBody
    @RequestMapping("/delWxCheck")
    public ToJson<WxCheck> delWxCheckById(HttpServletRequest request,WxCheck wxCheck){
        return wxCheckService.delWxCheckById(request,wxCheck);
    }

    @ResponseBody
    @RequestMapping("/updateWxCheck")
    public ToJson<WxCheck> updateWxCheck(HttpServletRequest request,WxCheck wxCheck){
        return wxCheckService.updateWxCheck(request,wxCheck);
    }

    @ResponseBody
    @RequestMapping("/selWxCheck")
    public ToJson<WxCheck> selWxCheck(HttpServletRequest request){
        return wxCheckService.selWxCheck(request);
    }

}
