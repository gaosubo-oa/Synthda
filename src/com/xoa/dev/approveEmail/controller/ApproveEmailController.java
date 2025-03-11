package com.xoa.dev.approveEmail.controller;

import com.xoa.dev.approveEmail.model.EmailSet2;
import com.xoa.dev.approveEmail.service.ApproveEmailService;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


/**
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:32:14
 * 类介绍  :   邮件
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/approveEmail")
public class ApproveEmailController {


    @Resource
    private ApproveEmailService emailService;


    @Resource
    private SmsService smsService;


    //    邮件审批
    @RequestMapping("/mailApproval")
    public String mailApproval(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String bodyId = request.getParameter("bodyId");
        if (!StringUtils.checkNull(bodyId)) {
            smsService.setSmsReadStatus(request, Integer.valueOf(bodyId));
        }
        return "app/email/mailApproval";
    }


    @RequestMapping("/transfer")
    public String transfer(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/transfer";
    }

    @RequestMapping("/internetEmailList")
    public String internetEmailList() {
        return "app/email/internetEmailList";
    }

    @RequestMapping("/internetEmailInfo")
    public String internetEmailInfo() {
        return "app/email/internetEmailInfo";
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:39:24
     * 方法介绍:   为null时转换为""
     * 参数说明:   @param value 需转换字符串
     * 参数说明:   @return Json
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    public static String returnValue(String value) {
        if (value != null) {
            return value;
        } else {
            return "";
        }
    }

    @RequestMapping("/emailSet")
    public String EmailSet(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/emailSet";
    }

    @RequestMapping("/addEmailSet1")
    public String EmailSet1(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/addEmailSet";
    }

    @ResponseBody
    @RequestMapping(value = "/addEmailSet", produces = {"application/json;charset=UTF-8"})
    public ToJson<EmailSet2> addEmailSet(HttpServletRequest request, EmailSet2 emailSet2) {
        ToJson<EmailSet2> emailSet2ToJson = emailService.addEmailSet(request, emailSet2);
        return emailSet2ToJson;
    }

    @ResponseBody
    @RequestMapping("/delEmailSet")
    public ToJson<EmailSet2> delEmailSetById(HttpServletRequest request, int essId) {
        return emailService.delEmailSetById(request, essId);
    }

    @ResponseBody
    @RequestMapping("/updateEmailSet")
    public ToJson<EmailSet2> updateEmailSet(HttpServletRequest request, EmailSet2 emailSet) {
        return emailService.updateEmailSetById(request, emailSet);
    }

    @ResponseBody
    @RequestMapping("/selEmailSet")
    public ToJson<EmailSet2> selEmailSet(HttpServletRequest request) {
        return emailService.selEmailSet(request);
    }

    /**
     * 创建作者：李燃
     * 创建时间：2018-04-26  下午15:19
     * 方法介绍：邮件审批模块
     */
    @RequestMapping("/emailCheck")
    public String emailCheck(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/emailCheck";
    }

    /**
     * 邮件设置反显，根据部门进行反显
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/selEmailSetByDept")
    public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request, int essId) {
        return emailService.selEmailSetByDept(request, essId);
    }

    /**
     * 查询需要进行一般审批的邮件
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/selExamEmail")
    public ToJson<EmailBodyModel> selExamEmail(HttpServletRequest request) {
        return emailService.selExamEmail(request);
    }

    /**
     * 审批邮件
     * flag:1-一般邮件审批，2-过滤词审批
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/examEmail")
    public ToJson<EmailBodyModel> examEmail(EmailBodyModel emailBodyModel, Integer flag, HttpServletRequest request) {
        return emailService.examEmail(emailBodyModel, flag, request);
    }

    /**
     * 查询需要进行审批的邮件(过滤词审核)
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/selwordExamEmail")
    public ToJson<EmailBodyModel> selWordExamEmail(HttpServletRequest request) {
        return emailService.selWordExamEmail(request);
    }
}