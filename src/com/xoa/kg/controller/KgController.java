package com.xoa.kg.controller;

import com.xoa.kg.model.KgSignKey;
import com.xoa.kg.model.KgSignature;
import com.xoa.kg.service.KgService;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by pfl on 2018-1-17.
 */
@RestController
@RequestMapping("/kg")
public class KgController {

    @Autowired
    KgService kgService;

    @RequestMapping("/getAllSignature")
    public BaseWrappers getAllSignatures(){
        return kgService.getAllSignatures();
    }

    @RequestMapping("/getUserSignature")
    public BaseWrappers getUserSignature(HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users =  SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        Integer uid=null;
        if(users!=null&&users.getUid()!=null){
            uid=users.getUid();
        }
        return kgService.getUserSignature(uid);
    }

    //获取印章管理列表
    @ResponseBody
    @RequestMapping("/getKgSignatureList")
    public BaseWrapper getKgSignatureList() {
        return kgService.getKgSignatureList();
    }

    //获取授权管理列表
    @ResponseBody
    @RequestMapping("/getKgSignKeyList")
    public BaseWrapper getKgSignKeyList(Integer signId) {
        return kgService.getKgSignKeyList(signId);
    }

    //添加印章
    @ResponseBody
    @RequestMapping("/addKgSignature")
    public BaseWrapper addKgSignature(KgSignature kgSignature) {
        return kgService.addKgSignature(kgSignature);
    }

    //添加授权
    @ResponseBody
    @RequestMapping("/addKgSignKey")
    public BaseWrapper addKgSignKey(KgSignKey kgSignKey, Integer signId) {
        return kgService.addKgSignKey(kgSignKey, signId);
    }

    //修改印章
    @ResponseBody
    @RequestMapping("/updateKgSignature")
    public BaseWrapper updateKgSignature(KgSignature kgSignature) {
        return kgService.updateKgSignature(kgSignature);
    }

    //修改授权
    @ResponseBody
    @RequestMapping("/updateKgSignKey")
    public BaseWrapper updateKgSignKey(KgSignKey kgSignKey) {
        return kgService.updateKgSignKey(kgSignKey);
    }

   //删除印章
    @ResponseBody
    @RequestMapping("/deleteKgSignature")
    public BaseWrapper deleteKgSignature(Integer signatureId) {
        return kgService.deleteKgSignature(signatureId);
    }

    //删除授权
    @ResponseBody
    @RequestMapping("/deleteKgSignKey")
    public BaseWrapper deleteKgSignKey(Integer signkeyId) {
        return kgService.deleteKgSignKey(signkeyId);
    }

    //根据主键查询印章
    @ResponseBody
    @RequestMapping("/getKgSignatureByKey")
    public BaseWrapper getKgSignatureByKey(Integer signatureId) {
        return  kgService.getKgSignatureByKey(signatureId);
    }

    //根据主键查询授权
    @ResponseBody
    @RequestMapping("/getKgSignKetByKey")
    public BaseWrapper getKgSignKetByKey(Integer signkeyId) {
        return  kgService.getKgSignKetByKey(signkeyId);
    }
}
