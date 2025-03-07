
package com.xoa.controller.sms;

import com.xoa.model.sms.Sms;
import com.xoa.model.sms.SmsBody;
import com.xoa.service.sms.SmsService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/sms")
public class SmsController {

    @Resource
    private SmsService smsService;

    /**
     * @作者：张航宁
     * @时间：2017/7/31
     * @介绍：跳转到主页
     */
    @RequestMapping("/index")
    public String goIndex() {
        return "app/sms/smsIndex";
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/31
     * @介绍：跳转到未确认提醒页面
     */
    @RequestMapping("/unconfirmedSmsPage")
    public String unconfirmedSmsPage() {
        return "app/sms/unconfirmedSms";
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/31
     * @介绍：跳转到已接收提醒界面
     */
    @RequestMapping("/receivedSmsPage")
    public String receivedSmsPage() {
        return "app/sms/receivedSms";
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/31
     * @介绍：跳转到已发送提醒界面
     */
    @RequestMapping("/sentSmsPage")
    public String sentSmsPage() {
        return "app/sms/sentSms";
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/31
     * @介绍：跳转到查询提醒页面
     */
    @RequestMapping("/querySmsPage")
    public String querySmsPage() {
        return "app/sms/querySms";
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：根据提醒类型查询
     * @参数：queryType 1 未确认提醒 2已接收提醒 3已发送提醒
     */
    @ResponseBody
    @RequestMapping("/selectByQueryType")
    public ToJson<SmsBody> selectByQueryType(HttpServletRequest request, Integer queryType, Integer page, Integer pageSize) {
        return smsService.getSmsBodies(request, queryType, page, pageSize);
    }
    @ResponseBody
    @RequestMapping("/classification")
    public ToJson classification(HttpServletRequest request,Integer queryType){
        return smsService.classification(request,queryType);
    }
    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：更新删除状态（即页面中的删除操作）
     * @参数：request
     */
    @ResponseBody
    @RequestMapping("/delete")
    public ToJson<Sms> updateDeleteFlag(HttpServletRequest request, String deleteFlag, String smsIds) {
        return smsService.updateDeleteFlag(request, deleteFlag, smsIds);
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：更新阅读状态
     * @参数：request
     */
    @ResponseBody
    @RequestMapping("/updateRemind")
    public ToJson<Sms> updateRemindFlag(HttpServletRequest request, String remindFlag, String smsIds) {
        return smsService.updateRemindFlag(request, remindFlag, smsIds);
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：删除所有已读
     * @参数：request
     */
    @ResponseBody
    @RequestMapping("/deleteByRemind")
    public ToJson<Sms> deleteByRemind(HttpServletRequest request,String deleteType) {
        return smsService.deleteByRemind(request,deleteType);
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：删除所有收信人已删除的
     * @参数：request
     */
    @ResponseBody
    @RequestMapping("/deleteByDelFlag")
    public ToJson<Sms> deleteByDelFlag(HttpServletRequest request) {
        return smsService.deleteByDelFlag(request);
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：查看详情后更新阅读信息接口
     * @参数：request
     */
    @ResponseBody
    @RequestMapping("/setRead")
    public ToJson<Sms> setRead(HttpServletRequest request, Integer bodyId) {
        return smsService.setRead(request, bodyId);
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/3
     * @介绍：多条件查询
     * @参数：orderBy 排序字段 sortType 升序或降序 opeType 查询类型 1是查询 2是导出
     */
    @ResponseBody
    @RequestMapping("/query")
    public ToJson<SmsBody> querySmsBody(HttpServletRequest request, HttpServletResponse response, String toIds, String fromIds, String smsType, String beginDate, String endDate, String content, String orderBy, String sortType, String opeType, Integer page,
                                        Integer pageSize, boolean useFlag) {
        return smsService.querySmsBody(request,response,toIds, fromIds, smsType, beginDate, endDate, content, orderBy, sortType, opeType, page, pageSize, useFlag);
    }
}
