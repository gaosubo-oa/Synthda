package com.xoa.controller.sys;

import com.xoa.model.users.OrgManage;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/5/22 10:39
 * @类介绍: 多企业管理
 * @构造参数: 无
 **/
@Controller
@Scope(value = "prototype")
@RequestMapping("/sys")
public class OrgManageController {


    @Resource
    private SystemInfoService systemInfoService;
    @Resource
    private OrgManageService orgManageService;

    @Resource
    private UsersService usersService;

    /**
     * 创建作者: 韩成冰
     * 创建日期: 2017/5/22 11:49
     * 函数介绍: 查询所有的（OrgManage）信息
     * 参数说明:
     *
     * @return: String
     **/
    @ResponseBody
    @RequestMapping(value = "/getOrgManage", produces = {"application/json;charset=UTF-8"})
    public ToJson<OrgManage> getOrgManage(HttpServletRequest request) {
        String sqlType="xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        ToJson<OrgManage> toJson = new ToJson<OrgManage>(0, "");
        try {
            List<OrgManage> orgManageList = orgManageService.getOrgManage();
            if(orgManageList!=null&&orgManageList.size()>0){
                Map<String,String> stringStringMap=systemInfoService.getAuthorization(request);
                if("xoa1001".equals(sqlType)){
                    if("true".equals(stringStringMap.get("isAuthStr"))){//如果授权成功，则去获取授权文件的信息
                        if(!orgManageList.get(0).getName().equals(stringStringMap.get("company"))){
                            orgManageList.get(0).setName(stringStringMap.get("company"));
                            orgManageService.editOrgManage( orgManageList.get(0),request);
                        }
                        toJson.setCode("130130");
                        toJson.setMsg("ok");
                    }else{
                        toJson.setCode("130140");
                        toJson.setMsg("未授权（错误代码：130140）");
                    }
                }
            }
            if (orgManageList!=null && orgManageList.size()>0){
                String org = "xoa" + orgManageList.get(0).getOid();
                if (org.equals(sqlType)){
                    toJson.setTurn(true);
                }else {
                    toJson.setTurn(false);
                }
            }
            toJson.setFlag(0);
            toJson.setObject(orgManageList);
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }




    @ResponseBody
    @RequestMapping(value = "/getUserCountbyDataSouseId", produces = {"application/json;charset=UTF-8"})
    public ToJson<OrgManage> getUserCountbyDataSouseId(HttpServletRequest request,String id) {

        String sqlType="xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

        String dynamicsqlType= "xoa" + id;

        ContextHolder.setConsumerType(dynamicsqlType);

        ToJson toJson = new ToJson<OrgManage>(0, "");

        try {

            int count=usersService.getUserCount();
            toJson.setFlag(0);
            toJson.setObject(count);
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg("err");
        }finally {
            ContextHolder.setConsumerType(sqlType);
        }

        return toJson;
    }



    @ResponseBody
    @RequestMapping(value = "/getUserCountbySql", produces = {"application/json;charset=UTF-8"})
    public ToJson<OrgManage> getUserCountbySql(HttpServletRequest request,String databaseName) {

        String sqlType="xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

       // String dynamicsqlType= "xoa" + id;

       // ContextHolder.setConsumerType(dynamicsqlType);

        ToJson toJson = new ToJson<OrgManage>(0, "");

        try {

            int count=usersService.getUserCountBySql(databaseName);
            toJson.setFlag(0);
            toJson.setObject(count);
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg("err");
        }finally {
            //ContextHolder.setConsumerType(sqlType);
        }

        return toJson;
    }













    /**
     * 创建作者: 韩成冰
     * 创建日期: 2017/5/22 13:34
     * 函数介绍: 修改OrgManage
     * 参数说明: @param orgManage 修改为orgManage对象
     *
     * @return: String(页面跳转)
     **/
    @ResponseBody
    @RequestMapping(value = "/editOrgManage", produces = {"application/json;charset=UTF-8"})
    public ToJson<OrgManage> editOrgManage(OrgManage orgManage, HttpServletRequest request) throws UnsupportedEncodingException {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        if (orgManage != null && orgManage.getOid() != null) {
            orgManageService.editOrgManage(orgManage,request);
        }

        ToJson<OrgManage> toJson = new ToJson<OrgManage>(0, "");
        try {
        List<OrgManage> orgManageList = orgManageService.getOrgManage();
            toJson.setFlag(0);
            toJson.setObject(orgManageList);
            toJson.setMsg("ok");
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg("err");
        }

        return toJson;

    }

    /**
     * 创建作者: 韩成冰
     * 创建日期: 2017/5/22 11:51
     * 函数介绍: 根据oid查询公司, 返回json到页面
     * 参数说明: @param oid OrderManage的id
     *
     * @return: Json (返回Orgmanage的json对象)
     **/
    @ResponseBody
    @RequestMapping(value = "/getOrgManageById", produces = {"application/json;charset=UTF-8"})
    public ToJson<OrgManage> getOrgManageById(Integer oid, HttpServletRequest request) throws IOException {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<OrgManage> toJson = new ToJson<OrgManage>(0, "");
        OrgManage orgManage = null;
        try {
            orgManage = orgManageService.getOrgManageById(oid);
            toJson.setMsg("ok");
            toJson.setObject(orgManage);
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg("err");
        }

        return toJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/24 18:18
     * @函数介绍: 添加公司
     * @参数说明: @param orgManage 公司
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/addOrgManage", produces = {"application/json;charset=UTF-8"})
    public ToJson<OrgManage> addOrgManage(OrgManage orgManage, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);


        return orgManageService.addOrgManage(orgManage,request);

    }

    @ResponseBody
    @RequestMapping("/checkOrgManage")
    public BaseWrapper checkOrgManage(HttpServletRequest request){
        return orgManageService.checkOrgManage(request);
    }


    @RequestMapping("/getPostmanagement")
    public String get(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/sys/post";
    }


    /**
     * 根据代理商ID和查询接口密钥查询代理下组织
     * @param request
     * @param agentId 代理商ID
     * @param secretKey 密钥
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryAgentOrg")
    public BaseWrapper queryAgentOrg(HttpServletRequest request,
                                     @RequestParam(name = "agentId", required = true) String agentId,
                                     @RequestParam(name = "secretKey", required = true) String secretKey){
        return orgManageService.queryAgentOrg(request,agentId,secretKey);
    }


    /**
     * 创建组织
     * @param version      版本信息
     * @param isOrg        是否组织
     * @param enName       英文
     * @param ftName       繁体
     * @param jpName       日文
     * @param krName       韩文
     * @param registTime   开始时间
     * @param endTime      结束时间
     * @param remindTime   提醒时间
     * @param licenseUsers 授权用户数
     * @param licenseSpace 授权存储空间G
     * @param name         单位名称
     * @param agentId      代理商ID
     * @param secretKey    密钥
     * @return
     */
    @ResponseBody
    @RequestMapping("/createAgentOrg")
    public Integer createAgentOrg(HttpServletRequest request,
                                     String version,
                                     String isOrg,
                                     String enName,
                                     String ftName,
                                     String jpName,
                                     String krName,
                                     String registTime,
                                     String endTime,
                                     String remindTime,
                                     Integer licenseUsers,
                                     Integer licenseSpace,
                                     String name,
                                     @RequestParam(name = "agentId", required = true) Integer agentId,
                                     @RequestParam(name = "secretKey", required = true) String secretKey){
        return orgManageService.createAgentOrg(request,version,isOrg,enName,ftName,jpName,krName,registTime,endTime,remindTime,licenseUsers,licenseSpace,name,agentId,secretKey);
    }


    /**
     * 根据OID修改代理下组织授权参数
     * @param request
     * @param endTime      结束时间
     * @param remindTime   提醒时间
     * @param licenseUsers 授权用户数
     * @param licenseSpace 授权存储空间G
     * @param secretKey 密钥
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateAgentOrg")
    public Integer updateAgentOrg(HttpServletRequest request,
                                      String endTime,
                                      String remindTime,
                                      Integer licenseUsers,
                                      Integer licenseSpace,
                                     @RequestParam(name = "oid", required = true) Integer oid,
                                     @RequestParam(name = "secretKey", required = true) String secretKey){
        return orgManageService.updateAgentOrg(request,endTime,remindTime,licenseUsers,licenseSpace,oid,secretKey);
    }
}
