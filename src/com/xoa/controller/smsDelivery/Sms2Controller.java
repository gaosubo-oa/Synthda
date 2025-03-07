
package com.xoa.controller.smsDelivery;

import com.xoa.model.sms2.Sms2;
import com.xoa.service.smsDelivery.Sms2Service;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/sms2")
public class Sms2Controller {

    @Resource
    private Sms2Service sms2Service;



    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 短信发送管理查询
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/selectSms2")
    public ToJson<Sms2> selectSms2(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize,  boolean useFlag,Sms2 sms2,String beginDate, String endDate, String fromIds) {
        return sms2Service.selectSms2(request,response,page,pageSize,useFlag,sms2,beginDate,endDate,fromIds);
    }
    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 短信发送管理能过id查询
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/selectSms2ById")
    public ToJson selectSms2ById(HttpServletRequest request, Integer id){

        return sms2Service.selectSms2ById(request,id);
    }

    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 短信发送管理增加
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/insertSms2")
    public ToJson insertSmsSettings(Sms2 sms2){

        return sms2Service.insertSms2(sms2);
    }
    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 短信发送管理删除
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/delSms2")
    public ToJson delSms2(Sms2 sms2,String beginDate, String endDate, String smsIds, String fromIds){
        return sms2Service.delSms2(sms2,beginDate,endDate,smsIds,fromIds);
    }

    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 短信发送管理修改
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/upSms2")
    public ToJson upSms2(Sms2 sms2){
        return sms2Service.upSms2(sms2);
    }


    @ResponseBody
    @RequestMapping("/SendSms")
    public ToJson SendSms(){
        return sms2Service.SendSms();
    }

    /**
    * @author 程叶同
    * @date 2018/8/1 14:03
    * @desc excel 短信发送
    */
    @ResponseBody
    @RequestMapping("/sendMessageByExcel")
    public BaseWrapper sendMessageByExcel(MultipartFile file){
        return sms2Service.sendMessageByExcel(file);
    }

    /**
     * @author 张鹏
     * @date 2022/1/4
     * @desc 短信统计(按人员活着部门)
     */
    @ResponseBody
    @RequestMapping("/sendSmsByUserOrDept")
    public ToJson sendSmsByUserIdOrDeptId(String beginDate, String endDate, String way, Integer page, Integer pageSize, boolean useFlag){
        return sms2Service.sendSmsByUserOrDept(beginDate,endDate,way,page,pageSize,useFlag);
    }

    /**
     * @author 张鹏
     * @date 2022/1/4
     * @desc 短信统计删除(按人员活着部门)
     */
    @ResponseBody
    @RequestMapping("/delSmsByUserOrDept")
    public ToJson delSmsByUserIdOrDeptId(String beginDate, String endDate, String fromId, Integer deptId){
        return sms2Service.delSmsByUserOrDept(beginDate,endDate,fromId,deptId);
    }
}
