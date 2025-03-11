
package com.xoa.controller.smsDelivery;

import com.xoa.model.sms2.Sms2Priv;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/sms2Priv")
public class Sms2PrivController {

    @Resource
    private Sms2PrivService sms2PrivService;


    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 模块权限查询
     *
     */
    @ResponseBody
    @RequestMapping("/selectSms2Priv")
    public ToJson<Sms2Priv> selectSms2Priv() {
        return sms2PrivService.selectSms2Priv();
    }
   @ResponseBody
    @RequestMapping("/selectSmS2Priv")
    public ToJson<Sms2Priv> selectSmS2Priv() {return  sms2PrivService.selectSmS2Priv(); }

    /**
     * @作者：左春晖
     * @时间：2018-8-21
     * @介绍: 判断模块是否有发送短信的权限
     *
     */
    @ResponseBody
    @RequestMapping("/selectSms2")
    public ToJson selectSms2(String sysCode,HttpServletRequest request) { return sms2PrivService.selectSms2(sysCode,request); }

    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 模块权限修改
     * @参数：sms2Priv
     */
    @ResponseBody
    @RequestMapping("/upSms2Priv")
    public ToJson upSms2Priv(Sms2Priv sms2Priv){

        return sms2PrivService.upSms2Priv(sms2Priv);
    }
    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 被提醒权限查询
     *
     */
    @ResponseBody
    @RequestMapping("/selectRemindPriv")
    public ToJson<Sms2Priv> selectRemindPriv() {
        return sms2PrivService.selectRemindPriv();
    }

    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 被提醒权限修改
     * @参数：sms2Priv
     */
    @ResponseBody
    @RequestMapping("/upRemindPriv")
    public ToJson upRemindPriv(Sms2Priv sms2Priv){
        return sms2PrivService.upRemindPriv(sms2Priv);
    }

    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 被提醒权限查询
     *
     */
    @ResponseBody
    @RequestMapping("/selectSms2RemindPriv")
    public ToJson<Sms2Priv> selectSms2RemindPriv() {
        return sms2PrivService.selectSms2RemindPriv();
    }

    /**
     * @作者：张海叶
     * @时间：2017/12/22
     * @介绍: 被提醒权限修改
     * @参数：sms2Priv
     */
    @ResponseBody
    @RequestMapping("/upselectSms2RemindPriv")
    public ToJson upselectSms2RemindPriv(Sms2Priv sms2Priv){
        return sms2PrivService.upselectSms2RemindPriv(sms2Priv);
    }

    /**
     * @作者：张海叶
     * @时间：2017/01/05
     * @介绍: 查询所有模块
     *
     */
    @ResponseBody
    @RequestMapping("/selectModuleOrder")
    public ToJson selectModuleOrder(){
        return sms2PrivService.selectModuleOrder();
    }

    /**
     * @作者：张海叶
     * @时间：2017/01/22
     * @介绍: 查询所有模块权限
     *
     */
    @ResponseBody
    @RequestMapping("/selectSmsRemind")
    public ToJson selectSmsRemind(){

        return sms2PrivService.selectSmsRemind();
    }

    /**
     * @作者：张海叶
     * @时间：2017/01/22
     * @介绍: 修改短信提醒设置
     * @参数：sms
     */
    @ResponseBody
    @RequestMapping("/upSmsRemindSet")
    public ToJson upSmsRemindSet(Sms2Priv sms2Priv){
        return sms2PrivService.upSmsRemindSet(sms2Priv);
    }


    /**
     * @作者：张海叶
     * @时间：2017/01/22
     * @介绍:查询默认选中发送事物与短信的值

     */
    @ResponseBody
    @RequestMapping("/selectSender")
    public ToJson selectSender(String name){
        return sms2PrivService.selectSender(name);
    }

    /**
     * @作者：张海叶
     * @时间：2017/01/22
     * @介绍:默认选中发送事物与短信
     */

    @ResponseBody
    @RequestMapping("/smsSender")
    public ToJson smsSender(StringBuffer mobileString, StringBuffer contextString,Sms2Priv sms2Priv,HttpServletRequest request) {

        return sms2PrivService.smsSender(mobileString, contextString,sms2Priv,request);
    }

    /**
     * @作者：左春晖
     * @时间：2018/07/30
     * @介绍:传入发送人电话号码  发送内容  网关就可以发送短信。
     */

    @ResponseBody
    @RequestMapping("/smsSenders") //   /sms2Priv/smsSenders
    public ToJson smsSenders( StringBuffer contextString,String privArray) {
        return sms2PrivService.smsSenders(contextString,privArray);
    }

    /**
     * 作者 廉立深
     * 日期 2020/10/19
     * 方法介绍   通过手机号发送短信
     * 参数 [contextString, privArray]
     * 返回 com.xoa.util.ToJson
     **/
    @ResponseBody
    @RequestMapping("/smsSenderMobiles")
    public ToJson smsSenderMobiles( StringBuffer contextString,String mobileArray) {
        return sms2PrivService.smsSenderMobiles(contextString,mobileArray);
    }


    /**
     * @作者：张海叶
     * @时间：2017/01/29
     * @介绍:根据部门，人员，角色查询出所属电话发送短信
     */
    @ResponseBody
    @RequestMapping("/selSenderMobile")
    public ToJson selSenderMobile(String smsDefault,Sms2Priv sms2Priv, StringBuffer contextString, HttpServletRequest request) {
        return sms2PrivService.selSenderMobile(smsDefault,sms2Priv,contextString,request);
    }
    /**
     * @作者：张海叶
     * @时间：2017/02/10
     * @介绍:查询外发权限
     */
    @ResponseBody
    @RequestMapping("/selOutPriv")
    public ToJson selOutPriv() {

        return sms2PrivService.selOutPriv();
    }
    /**
     * @作者：张海叶
     * @时间：2017/02/10
     * @介绍:修改外发权限
     */
    @ResponseBody
    @RequestMapping("/upOutPriv")
    public ToJson upOutPriv(Sms2Priv sms2Priv) {

        return sms2PrivService.upOutPriv(sms2Priv);
    }

    /**
     * @作者：张海叶
     * @时间：2017/02/10
     * @介绍:是否允许给自己发送手机短信(0-不允许,1-允许)
     */
    @ResponseBody
    @RequestMapping("/outToSelf")
    public ToJson outToSelf(Sms2Priv sms2Priv) {

        return sms2PrivService.outToSelf(sms2Priv);
    }

}
