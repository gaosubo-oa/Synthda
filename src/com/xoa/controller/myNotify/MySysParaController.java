package com.xoa.controller.myNotify;

import com.xoa.model.myNotify.MySysPara;
import com.xoa.model.users.Users;
import com.xoa.service.common.SecureRuleService;
import com.xoa.service.myNotify.MySysParaService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.util.AjaxJson;
import com.xoa.util.Constant;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
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
@RequestMapping(value = "/mySyspara")
public class MySysParaController {


    @Resource
    private MySysParaService mySysParaService;

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
    public ToJson<MySysPara> selectSysPara(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<MySysPara> tojson = new ToJson<MySysPara>(0, "");
        try {
            List<MySysPara> list = mySysParaService.getIeTitle();
            //list=mySysParaService.getIeTitle1();
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
     * @return: ToJson<MySysPara>
     */
    @ResponseBody
    @RequestMapping(value = "/selectPassword", produces = {"application/json;charset=UTF-8"})
    public ToJson<MySysPara> selectPassword(HttpServletRequest request,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<MySysPara> tojson = new ToJson<MySysPara>(0, "");
        try {
            MySysPara sysPara = mySysParaService.getSelectPassword(specifyTable);
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
     * @return: ToJson<MySysPara>
     */
    @RequestMapping(value = "/updateSysPara", method = RequestMethod.POST)
    @ResponseBody
    public ToJson<MySysPara> updateSysPara(MySysPara sysPara, HttpServletRequest request, SysParaService surface,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<MySysPara> tojson = new ToJson<MySysPara>(0, "");
        try {
            mySysParaService.updateSysPara(sysPara,specifyTable);
            mySysParaService.updateSysPara1(sysPara,specifyTable);
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
    public ToJson<MySysPara> selectTheSysPara(HttpServletRequest request, String paraName,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<MySysPara> tojson = new ToJson<MySysPara>(0, "");
        try {
            List<MySysPara> list = mySysParaService.getTheSysParam(paraName,specifyTable);
            //list=mySysParaService.getIeTitle1();
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
    public String updateSysPara(MySysPara sysPara, HttpServletRequest request,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<MySysPara> tojson = new ToJson<MySysPara>(0, "");
        try {
            mySysParaService.updateSysPara(sysPara,specifyTable);
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
    public Map<String,String> selectSysPCAI(HttpServletRequest request,String specifyTable){
        return mySysParaService.selectSysPCAI(request,specifyTable);
    }

    /**
     * 获取项目Id
     */
    @RequestMapping("/selectProjectId")
    @ResponseBody
    public ToJson selectProjectId(HttpServletRequest request,String specifyTable){
        return mySysParaService.selectProjectId(request,specifyTable);
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
    public ToJson<Object> editSysPara(String  usersIds,String specifyTable){
        return mySysParaService.editSysPara(usersIds,specifyTable);
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
    public ToJson<MySysPara> getUserName(String paraName,String specifyTable){
          return mySysParaService.getUserName(paraName,specifyTable);
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
            List<SysPara> list = mySysParaService.getTheSysParam(paraValue);
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
    public ToJson<MySysPara> eduSetParam(String firstDate,String secondDate,String initPwd,String specifyTable){
        return mySysParaService.eduSetParam(firstDate,secondDate,initPwd,specifyTable);
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
    public AjaxJson selEduParam(String specifyTable){
        return mySysParaService.selEduParam(specifyTable);
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
    public ToJson<Object> editOperator(String  usersIds,String specifyTable){
        return mySysParaService.editOperator(usersIds,specifyTable);
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
    public ToJson<Object> getStatus(String specifyTable){
        return mySysParaService.getStatus(specifyTable);
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
    public ToJson<MySysPara> getOperator(String paraName,String specifyTable){
        return mySysParaService.getOperator(paraName,specifyTable);
    }


    /**
     * 参数设置，不存在插入，存在更新
     * @param sysPara
     * @return
     */
    @RequestMapping("/setSysPara")
    @ResponseBody
    public ToJson<Object> setSysPara(MySysPara sysPara,String specifyTable){
        return mySysParaService.setSysPara(sysPara,specifyTable);
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
    public ToJson<MySysPara> updateDemo(MySysPara sysPara, HttpServletRequest request,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<MySysPara> tojson = new ToJson<MySysPara>(1, "err");
        try {
            mySysParaService.updateSysPara(sysPara,specifyTable);
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
    public ToJson<Object> selectDemo(MySysPara sysPara, HttpServletRequest request,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> tojson = new ToJson<Object>(1, "err");
        try {
             return mySysParaService.selectDemo(sysPara,specifyTable);
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
    public ToJson<Object> checkDemo(HttpServletRequest request,String specifyTable) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
         return mySysParaService.checkDemo(specifyTable);
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
    public ToJson<Object> updatePersonnelSelectionRange(MySysPara sysPara,String specifyTable) {
        return mySysParaService.updatePersonnelSelectionRange(sysPara,specifyTable);
    }


    @RequestMapping(value = "/queryOrgScope", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<Object> queryOrgScope(String specifyTable) {
        return mySysParaService.queryOrgScope(specifyTable);
    }

    /**
     * 通过sysPara查找 公用
     * @param paraName
     * @return
     */
    @RequestMapping(value = "/selectByParaName", method = RequestMethod.GET)
    @ResponseBody
    public ToJson<Object> selectByParaName(String paraName,String specifyTable) {
        return mySysParaService.selectByParaName(paraName,specifyTable);
    }

    /**
     * 更新SysPara 公用
     * @param sysPara
     * @return
     */
    @RequestMapping("/updateSysParaPlus")
    @ResponseBody
    public ToJson updateSysParaPlus(MySysPara sysPara,String specifyTable) {
        return mySysParaService.updateSysParaPlus(sysPara,specifyTable);
    }
}
