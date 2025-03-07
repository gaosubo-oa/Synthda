package com.xoa.controller.syspara;

import com.alibaba.fastjson.JSON;
import com.xoa.model.common.SysPara;
import com.xoa.model.users.Users;
import com.xoa.service.common.SecureRuleService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.util.AjaxJson;
import com.xoa.util.Constant;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @ClassName (类名):  SysParaController
 * @Description(简述): 逻辑层
 * @author(作者): 张丽军
 * @date(日期): 2017-5-5 下午4:22:51
 */
@Controller
@RequestMapping(value = "/syspara")
public class SysParaController {


    @Resource
    private SysParaService sysParaService;

    @Resource
    private SecureRuleService secureRuleService;

    /**
     * @throws
     * @Title: selectSysPara
     * @Description: 查询状态栏信息
     * @author(作者): 张丽军
     * @param: @param request
     * @param: @return
     * @return: ToJson<SysPara>
     */
    @ResponseBody
    @RequestMapping(value = "/selectSysPara", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysPara> selectSysPara(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(0, "");
        try {
            List<SysPara> list = sysParaService.getIeTitle();
            //list=sysParaService.getIeTitle1();
            tojson.setObject(list);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }


    /**
     * @throws
     * @Title: selectPassword
     * @Description: 查询web签章是否购买
     * @author(作者): 张丽军
     * @param: @param request
     * @param: @return
     * @return: ToJson<SysPara>
     */
    @ResponseBody
    @RequestMapping(value = "/selectPassword", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysPara> selectPassword(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(0, "");
        try {
            SysPara sysPara = sysParaService.getSelectPassword();
            tojson.setObject(sysPara);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }

    /**
     * @throws
     * @Title: updateSysPara
     * @Description: 修改状态栏信息
     * @author(作者): 张丽军
     * @param: @param sysPara
     * @param: @param request
     * @param: @param surface
     * @param: @return
     * @return: ToJson<SysPara>
     */
    @RequestMapping(value = "/updateSysPara", method = RequestMethod.POST)
    @ResponseBody
    public ToJson<SysPara> updateSysPara(SysPara sysPara, HttpServletRequest request, SysParaService surface) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(0, "");
        try {
            sysParaService.updateSysPara(sysPara);
            tojson.setObject(sysPara);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/23 11:35
     * @函数介绍: 获取sys_para, 前台传入key, 获取对应value
     * @参数说明: @param paraName    sysParam表的PARA_NAME
     * @return: json (sysParam表的PARA_NAME对应的value)
     **/
    @ResponseBody
    @RequestMapping(value = "/selectTheSysPara", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysPara> selectTheSysPara(HttpServletRequest request, String paraName) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(0, "");
        try {
            List<SysPara> list = sysParaService.getTheSysParam(paraName);
            //list=sysParaService.getIeTitle1();
            tojson.setObject(list);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/23 14:07
     * @函数介绍: 修改sys_para表
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping(value = "/updateSysParaByParaName")
    public String updateSysPara(SysPara sysPara, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(0, "");
        try {
            sysParaService.updateSysPara(sysPara);
            return "redirect:selectTheSysPara?paraName=" + sysPara.getParaName();
        } catch (Exception e) {
            return null;

        }

    }

    /**
     * 获取三端版本号
     */

    @RequestMapping("/selectSysPCAI")
    @ResponseBody
    public Map<String,String> selectSysPCAI(HttpServletRequest request){
        return sysParaService.selectSysPCAI(request);
    }

    /**
     * 获取项目Id
     */
    @RequestMapping("/selectProjectId")
    @ResponseBody
    public ToJson selectProjectId(HttpServletRequest request){
        return sysParaService.selectProjectId(request);
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/29 16:55
     * @函数介绍: 修改sys_para表
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/editSysPara")
    @ResponseBody
    public ToJson<Object> editSysPara(String  usersIds){
        return sysParaService.editSysPara(usersIds);
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/29 17:19
     * @函数介绍: 查询sys_para表
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/getUserName")
    @ResponseBody
    public ToJson<SysPara> getUserName(String paraName){
          return sysParaService.getUserName(paraName);
    }

    /**
     * @创建作者: zlf
     * @创建日期: 2017/8/11 17:19
     * @函数介绍: 查询sys_para表
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/checkSecureAdmin")
    @ResponseBody
    public String checkSecureAdmin(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        if (users.getUserId().equals("admin")){
            return "OK";
        }
        return Constant.checkSecureAdminInfo;
    }

/*
    *//**
     * @创建作者: zlf
     * @创建日期: 2017/8/12 17:19
     * @函数介绍: 查询sys_para表的三员超级密码
     * @参数说明: @param sysPara
     * @return: json
     **//*
    @RequestMapping("/findPassWord")
    @ResponseBody
    public String findPassWord(HttpServletRequest request,String paraValue){
            List<SysPara> list = sysParaService.getTheSysParam(paraValue);
            SysPara sysPara = list.get(0);

    }*/


    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/9/26 17:19
     * @函数介绍: 设置教务管理中的参数设置
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/eduSetParam")
    @ResponseBody
    public ToJson<SysPara> eduSetParam(String firstDate,String secondDate,String initPwd){
        return sysParaService.eduSetParam(firstDate,secondDate,initPwd);
    }

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/9/26 17:19
     * @函数介绍: 获取教务管理的参数
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/selEduParam")
    @ResponseBody
    public AjaxJson selEduParam(){
        return sysParaService.selEduParam();
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/9/26 16:55
     * @函数介绍: 修改车辆调度员
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/editOperator")
    @ResponseBody
    public ToJson<Object> editOperator(String  usersIds){
        return sysParaService.editOperator(usersIds);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/29 17:19
     * @函数介绍: 查询今年学生是否升级过
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/getStatus")
    @ResponseBody
    public ToJson<Object> getStatus(){
        return sysParaService.getStatus();
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/9/22 17:19
     * @函数介绍: 查看调度员
     * @参数说明: @param sysPara
     * @return: json
     **/
    @RequestMapping("/getOperator")
    @ResponseBody
    public ToJson<SysPara> getOperator(String paraName){
        return sysParaService.getOperator(paraName);
    }


    /**
     * 参数设置，不存在插入，存在更新
     * @param sysPara
     * @return
     */
    @RequestMapping("/setSysPara")
    @ResponseBody
    public ToJson<Object> setSysPara(SysPara sysPara){
        return sysParaService.setSysPara(sysPara);
    }

    /**
     * @throws
     * @Title: updateSysPara
     * @Description: 修改是否是演示系统
     * @author(作者): 高亚峰
     * @param: @param sysPara
     * @param: @param request
     * @param: @return
     * @return: ToJson<SysPara>
     */
    @RequestMapping(value = "/updateDemo", method = RequestMethod.POST)
    @ResponseBody
    public ToJson<SysPara> updateDemo(SysPara sysPara, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(1, "err");
        try {
            sysParaService.updateSysPara(sysPara);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }

    /**
     * @throws
     * @Title: updateSysPara
     * @Description: 查询是演示系统
     * @author(作者): 高亚峰
     * @param: @param sysPara
     * @param: @return
     * @return: ToJson<SysPara>
     */
    @RequestMapping(value = "/selectDemo")
    @ResponseBody
    public ToJson<Object> selectDemo(SysPara sysPara, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> tojson = new ToJson<Object>(1, "err");
        try {
             return sysParaService.selectDemo(sysPara);
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }

    /**
     * @throws
     * @Title: updateSysPara
     * @Description: 根据是否是演示系统判断用户是否能修改密码
     * @author(作者): 高亚峰
     * @param: @param sysPara
     * @param: @return
     * @return: boolean
     */
    @RequestMapping(value = "/checkDemo", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<Object> checkDemo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
         return sysParaService.checkDemo();
    }




    /**
     * 修改人员选择范围管理
     * 王禹萌
     * 2018/12/27
     * @param sysPara
     * @return
     */
    @RequestMapping(value = "/updateOrgScope", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<Object> updatePersonnelSelectionRange(SysPara sysPara) {
        return sysParaService.updatePersonnelSelectionRange(sysPara);
    }


    @RequestMapping(value = "/queryOrgScope", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<Object> queryOrgScope() {
        return sysParaService.queryOrgScope();
    }

    /**
     * 通过sysPara查找 公用
     * @param paraName
     * @return
     */
    @RequestMapping(value = "/selectByParaName", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<Object> selectByParaName(String paraName) {
        return sysParaService.selectByParaName(paraName);
    }

    /**
     * 更新SysPara 公用
     * @param sysPara
     * @return
     */
    @RequestMapping("/updateSysParaPlus")
    @ResponseBody
    public ToJson updateSysParaPlus(SysPara sysPara) {
        return sysParaService.updateSysParaPlus(sysPara);
    }

    /**
    * 创建人: 海智
    * 创建时间: 2021-06-10 下午 14:21
    * 方法介绍: 查询NTKO授权信息
    * 参数说明:
    */
    @ResponseBody
    @RequestMapping(value = "/selectNtkoLicense", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysPara> selectNtkoLicense(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysPara> tojson = new ToJson<SysPara>(0, "");
        try {
            SysPara sysPara = sysParaService.selectNtkoLicense();
            tojson.setObj1(JSON.parse(sysPara.getParaValue()));//将字符串解析为json对象
            tojson.setObject(sysPara);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setMsg(e.getMessage());
        }
        return tojson;
    }

    /**
    * 创建人: 海智
    * 创建时间: 2021-06-22 上午 11:09
    * 方法介绍: 根据名称查询自定义告示栏
    * 参数说明:
    */
    @ResponseBody
    @RequestMapping(value = "/selectSysParaAtPortal", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> selectSysParaAtPortal(String title, String content) {
        return sysParaService.selectSysParaAtPortal(title, content);
    }

    /**
     * 创建人: 海智
     * 创建时间: 2021-06-21 下午 17:27
     * 方法介绍: 自定义告示栏的控制层方法
     * 参数说明:
     */
    @ResponseBody
    @RequestMapping(value = "/updateSysParaAtPortal")
    public ToJson<Object> updateSysParaAtPortal(String title1, String content1,String title2, String content2,String title3, String content3) {
        return sysParaService.updateSysParaProtal(title1,content1,title2,content2,title3,content3);
    }
    @ResponseBody
    @RequestMapping("/updateByParaName")
    public ToJson updateByParaName(SysPara sysPara){
        return sysParaService.updateByParaName(sysPara);
    }
    @ResponseBody
    @RequestMapping("/selectByParaNames")
    public ToJson selectByParaNames(HttpServletRequest request,String paraName){
        return sysParaService.selectByParaNames(request,paraName);
    }
   @ResponseBody
    @RequestMapping("/selectSysParaByParaName")
    public ToJson selectSysParaByParaName(String paraName){
        return sysParaService.selectSysParaByParaName(paraName);
   }


    /**
     * 创建人: hwx
     * 创建时间: 2022/01/10
     * 方法介绍: 查询三个自定义告示栏标题和内容
     * 参数说明: 无
     */
    @ResponseBody
    @RequestMapping("/querySysParaProtal")
    public ToJson selectSysParaByParaName(HttpServletRequest request){
        return sysParaService.querySysParaProtal();
    }


    /**
     * 创建人: hwx
     * 创建时间: 2023/03/17
     * 方法介绍: 查询涉密系统设置
     * 参数说明: 无
     */
    @ResponseBody
    @RequestMapping("/querySecrecySysPara")
    public ToJson querySecrecySysPara(HttpServletRequest request){
        return sysParaService.querySecrecySysPara(request);
    }

    /**
     * 创建人: hwx
     * 创建时间: 2023/03/17
     * 方法介绍: 保存涉密系统设置
     * 参数说明: 无
     */
    @ResponseBody
    @RequestMapping("/updateSecrecySysPara")
    public ToJson updateSecrecySysPara(String jsonStr,HttpServletRequest request){
        return  sysParaService.updateSecrecySysPara(jsonStr,request);
    }


    @ResponseBody
    @RequestMapping("/selAttendSetting")
    public BaseWrapper selAttendSetting(){
        return  sysParaService.selAttendSetting();
    }

    @ResponseBody
    @RequestMapping("/updateAttendSetting")
    public BaseWrapper updateAttendSetting(String attendFreeUserValue,String attendFreeDeptValue,String attendFreePrivValue){
        return  sysParaService.updateAttendSetting(attendFreeUserValue, attendFreeDeptValue, attendFreePrivValue);
    }

}
