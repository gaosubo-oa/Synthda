package com.xoa.controller.sys;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.model.common.SysPara;
import com.xoa.service.sys.SysTasksService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

@Controller
@RequestMapping("sysTasks")
public class SysTasksController {
    @Autowired
    public SysTasksService SysTasksService;

    @Autowired
    private SystemInfoService systemInfoService;

    @Resource
    SysParaMapper sysParaMapper;

    @RequestMapping("sysPersionSelectOrg")
    public String sysPersionSelectOrg(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "/app/sys/personSelect";
    }

    @RequestMapping("sysTaskIndex")
    public   String  eduSchoolIndex(HttpServletRequest request,HttpSession session) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        try {
            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            String realPath = request.getSession().getServletContext().getRealPath("/");
            Map<String, String> map = systemInfoService.getSystemInfo(realPath, locale,request);
            if(map!=null&&map.size()>0){
                Iterator i = map.entrySet().iterator();
                while (i.hasNext()) {
                    Map.Entry entry = (Map.Entry) i.next();
                    if(entry.getKey().equals("module")){
                        session.setAttribute("module",entry.getValue()) ;
                        break;
                    }

                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "/app/sys/sysTasks";
    }

    //即时通讯tab页面
    @RequestMapping("getIMTasks")
    public String getIMTasks(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "/app/sys/IMTasks";
    }
    //即时通讯tab页面
    @RequestMapping("ClientSeting")
    public String ClientSeting(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "/app/sys/ClientSeting";
    }
    //涉密系统
    @RequestMapping("ClassifiedSetting")
    public String ClassifiedSetting(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "/app/sys/ClassifiedSetting";
    }
    @ResponseBody
    @RequestMapping("updateSysTasks")
    public ToJson updateSysTasks(String jsonStr,HttpServletRequest request){
      return   SysTasksService.updateBatch(jsonStr,request);

    }

    @ResponseBody
    @RequestMapping("selectAll")
    public ToJson selectAll(){
        return  SysTasksService.selectAll();
    }

    //在线预览网站添加
    @ResponseBody
    @RequestMapping("/upPreview")// /sysTasks/upPreview
    public ToJson upPreview(SysPara sysPara){
        return SysTasksService.upPreview(sysPara);
    }
    //查询预览网站
    @ResponseBody
    @RequestMapping("/selectPreview")// /sysTasks/selectPreview
    public ToJson selectPreview(){
        return SysTasksService.selectPreview();
    }

    //修改是否开启网站
    @ResponseBody
    @RequestMapping("/upPreviewOpen")// /sysTasks/upPreviewOpen
    public ToJson upPreviewOpen(SysPara sysPara){
        return SysTasksService.upPreviewOpen(sysPara);
    }
    //查询状态
    @ResponseBody
    @RequestMapping("/selectPreviewOpen")// /sysTasks/selectPreviewOpen
    public ToJson selectPreviewOpen(){
        return SysTasksService.selectPreviewOpen();
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/10
     * @说明: 查询预览网址和是否允许预览 即selectPreview和selectPreviewOpen 整合到一起
     */
    @ResponseBody
    @RequestMapping("/getOfficePreviewSetting")
    public ToJson getOfficePreviewSetting(){
        return SysTasksService.getOfficePreviewSetting();
    }

    //设置附件加密KEY和开关
    @ResponseBody
    @RequestMapping("/setEncryptionKEY")// /sysTasks/upPreviewOpen
    public ToJson setEncryptionKEY(HttpServletRequest request,int Switch,String key){
        ToJson json = new ToJson(1,"false");
        int bol = 0;
        try {
            //判断注册文件是否授权了
            String modle = "";
            Map<String, String> map = systemInfoService.getAuthInfo(request);
            if(map!=null&&map.size()>0){
                Iterator i = map.entrySet().iterator();
                while (i.hasNext()) {
                    Map.Entry entry = (Map.Entry) i.next();
                    if(entry.getKey().equals("module")){
                        modle =  entry.getValue().toString();
                        break;
                    }

                }
            }
            String[] strCode = modle.split(",");
            //默认附件加密是没有授权的
            boolean flag = false;
            for(int i=0;i<strCode.length;i++){
                if("8".contains(strCode[i])){
                    flag = true;
                }
            }
            if(flag==true){
                if(Switch == 0 ){
                    if(key!=null && !"".equals(key.trim())){
                        if("".equals(sysParaMapper.getEncryptionKey())){
                            if(SysTasksService.setEncryptionKEY(key)){
                                bol = sysParaMapper.setEncryptionAes(Switch);
                            }
                        }else if(!key.trim().equals(sysParaMapper.getEncryptionKey().trim())){
                            if(SysTasksService.setEncryptionKEY(key)){
                                bol = sysParaMapper.setEncryptionAes(Switch);
                            }
                        }else {
                            bol = sysParaMapper.setEncryptionAes(Switch);
                        }
                    }else{
                        if(!"".equals(sysParaMapper.getEncryptionKey().trim())){
                            bol = sysParaMapper.setEncryptionAes(Switch);
                        }
                    }
                }else{
                    Switch =1;
                    bol = sysParaMapper.setEncryptionAes(Switch);
                }

            }else {
                Switch =1;
                bol = sysParaMapper.setEncryptionAes(Switch);
            }

            if(bol>0){
                json.setFlag(0);
                json.setMsg("true");
            }
        }catch (Exception e ){
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }

    //缓存设置tab页面
    @RequestMapping("opencache")
    public String opencache(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "/app/sys/cacheSetting";
    }

    /**
     *@作者: 廉立深
     *@时间: 2020/12/23
     *@介绍: 通过PARA_NAME串查找
     */
    @RequestMapping("/getSysParaList")
    @ResponseBody
    public ToJson getSysParaList(HttpServletRequest request,String[] paraName){
        return SysTasksService.getSysParaList(request, Arrays.asList(paraName));
    }
}
