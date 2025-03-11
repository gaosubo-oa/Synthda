package com.xoa.controller.smsSettings;


import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.service.smssetting.SmsSettingsService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

//短信设置
@RequestMapping("/smsSettings")
@Controller
public class SmsSettingsController {

    @Autowired
  private  SmsSettingsService smsSettingsService;


    //短信设置首页面
    @RequestMapping("/index")
    public String smsIndex(){
        return "app/smsSettings/index";
    }

    //短信设置首页面中第一页面
    @RequestMapping("/indexnum1")
    public String smsIndex1(){
        return "app/smsSettings/indexnum1";
    }

    //短信设置首页面中第二页面
    @RequestMapping("/indexnum2")
    public String smsIndex2(){
        return "app/smsSettings/indexnum2";
    }

    //短信设置首页面中第三页面
    @RequestMapping("/indexnum3")
    public String smsIndex3(){
        return "app/smsSettings/indexnum3";
    }

    //短信设置首页面中第四页面
    @RequestMapping("/indexnum4")
    public String smsIndex4(){
        return "app/smsSettings/indexnum4";
    }

    //短信设置首页面中第五页面
    @RequestMapping("/indexnum5")
    public String smsIndex5(){
        return "app/smsSettings/indexnum5";
    }

    //短信设置首页面中第七页面
    @RequestMapping("/indexnum7")
    public String smsIndex7(){
        return "app/smsSettings/indexnum7";
    }

    //短信设置首页面中第六页面
    @RequestMapping("/indexnum6")
    public String smsIndex6(){
        return "app/smsSettings/indexnum6";
    }

    //短信设置首页面中第八页面
    @RequestMapping("/indexnum8")
    public String smsIndex8(){
        return "app/smsSettings/indexnum8";
    }



    //事务提醒设置页面
    @RequestMapping("/remindindex")
    public String remindindex(){
        return "app/smsSettings/remindindex";
    }

    @ResponseBody
    @RequestMapping("/insertSmsSettings")
    public ToJson insertSmsSettings(SmsSettings smsSettings){

        return smsSettingsService.insertSmsSettings(smsSettings);
    }


    @ResponseBody
    @RequestMapping("/delSmsSettings")
    public ToJson delSmsSettings(int id){
        return smsSettingsService.delSmsSettings(id);
    }


    @ResponseBody
    @RequestMapping("/upSmsSettings")
    public ToJson upSmsSettings(SmsSettings smsSettings){
        return smsSettingsService.upSmsSettings(smsSettings);
    }

    @ResponseBody
    @RequestMapping("/selectSmsSettings")
    public ToJson selectSmsSettings(){
        return smsSettingsService.selectSmsSettings();
    }

    @ResponseBody
    @RequestMapping("/selectSmsSettingsAll")
    public ToJson selectSmsSettingsAll(){
        return smsSettingsService.selectSmsSettingsAll();
    }

    @ResponseBody
    @RequestMapping("/selectSmsSettingsById")
    public ToJson selectSmsSettingsById(HttpServletRequest request, Integer id){

        return smsSettingsService.selectSmsSettingsById(request,id);
    }


}
