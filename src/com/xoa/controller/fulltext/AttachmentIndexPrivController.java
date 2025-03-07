package com.xoa.controller.fulltext;

import com.xoa.model.fulltext.AttachmentIndex;
import com.xoa.model.fulltext.AttachmentIndexPriv;
import com.xoa.model.fulltext.AttachmentIndexSwitch;
import com.xoa.service.fulltext.AttachmentIndexPrivService;
import com.xoa.service.fulltext.AttachmentIndexService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/attachPriv")
public class AttachmentIndexPrivController {
    @Resource
    private AttachmentIndexPrivService attachmentIndexPrivService;

    @Resource
    private AttachmentIndexService attachmentIndexService;

    @RequestMapping("/AttachmentIndexPriv")
    public String AttachmentIndexPriv(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/fulltext/AttachmentIndexPriv";
    }

    @RequestMapping("/AttachmentIndexIframe")
    public String AttachmentIndexIframe(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/fulltext/AttachmentIndexIframe";
    }
//    全文检索搜索页面
    @RequestMapping("/fullTextSearch")
    public String fullTextSearch(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/fulltext/fullTextSearch";
    }
    //    全文检索搜索数据页面
    @RequestMapping("/fullTextList")
    public String fullTextList(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/fulltext/fullTextList";
    }

    @RequestMapping("/selectByModuleId")
    @ResponseBody
    public ToJson selectByModuleId(Integer moduleId) {
        return attachmentIndexPrivService.selectByModuleId(moduleId);
    }
    @RequestMapping("/insert")
    @ResponseBody
    public ToJson insert(AttachmentIndexPriv attachmentIndexPriv){
        return attachmentIndexPrivService.insert(attachmentIndexPriv);
    }
    @RequestMapping("/update")
    @ResponseBody
    public ToJson update(AttachmentIndexPriv attachmentIndexPriv){
        return attachmentIndexPrivService.update(attachmentIndexPriv);
    }
    @RequestMapping("/AttachUpdate")
    @ResponseBody
    public ToJson AttachUpdate(HttpServletRequest request, AttachmentIndexSwitch attachmentIndexSwitch){
        return attachmentIndexPrivService.AttachUpdate(request,attachmentIndexSwitch);
    }

    @RequestMapping("/selectAttach")
    @ResponseBody
    public ToJson selectAttach(){
        return attachmentIndexPrivService.selectAttach();
    }

//    @RequestMapping("/selectStr")
//    @ResponseBody
//    public ToJson selectStr(HttpServletRequest request, @RequestParam("str") String str, @RequestParam("priv") String priv){
//        return attachmentIndexService.selectByStr(request, str, priv);
//    }

    @RequestMapping("/selectModule")
    @ResponseBody
    public ToJson selectModule(HttpServletRequest request){
        return attachmentIndexService.selectModule(request);
    }
    @RequestMapping("/selectBySubject")
    @ResponseBody
    public ToJson selectBySubject(HttpServletRequest request, String subject, String flag,Integer moduleId,Integer page, Integer pageSize, boolean useFlag){

        if (moduleId==null){
            return new ToJson(1,"err");
         }
        switch (moduleId){
            case 1: return attachmentIndexService.selectBySubject(request,subject,flag,page,pageSize,useFlag);
            case 4: return attachmentIndexService.selectNotice(request,subject,flag,page,pageSize,useFlag);
            case 5: return attachmentIndexService.selectNews(request,subject,flag,page,pageSize,useFlag);
            case 6: return attachmentIndexService.selectDiary(request,subject,flag,page,pageSize,useFlag);
            case 7: return attachmentIndexService.selectCalendar(request,subject,flag,page,pageSize,useFlag);
            case 12: return attachmentIndexService.selectHr(request,subject,flag,page,pageSize,useFlag);
            case 26: return attachmentIndexService.selectIm(request,subject,flag,page,pageSize,useFlag);
            case 98:return attachmentIndexService.selectUser(request,subject,flag,page,pageSize,useFlag);
        }
        return new ToJson(1,"err");
    }


    @RequestMapping("/resetting")
    @ResponseBody
    public ToJson resetting(HttpServletRequest request){
        return attachmentIndexPrivService.resetting(request);
    }
}
