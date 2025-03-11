package com.xoa.controller.sys;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.OrgManage;
import com.xoa.service.sys.InterFaceService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.OrgManageService;
import com.xoa.util.AjaxJson;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ReflectionUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/5/25 9:53
 * @类介绍: 软件界面设置处理类  系统配置信息，对应interface表,这个interface和接口无关
 * @构造参数: 无
 **/

@Controller
@RequestMapping("/sys")
public class InterfaceController {

    @Resource
    private InterFaceService interfaceService;
    @Resource
    private SysParaService sysParaService;
    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private OrgManageService orgManageService;


    @Value("${xoa_statusText}")
    String statusText;

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月16日 19：37：05
     * 方法介绍:   查询标题和离开信息
     * 参数说明:   @param interfaceModel 界面信息
     *
     */
    @ResponseBody
    @RequestMapping(value = "/getIndexInfo")
    public ToJson<InterfaceModel> getInterfaceInfoIeTitle(HttpServletRequest request){

        ToJson<InterfaceModel> json = new ToJson<InterfaceModel>(0, "");
        try {
            InterfaceModel InterfaceModel = interfaceService.getIndexInfo();
            json.setObject(InterfaceModel);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/25 12:21
     * @函数介绍: 查询interface表的STATUS_TEXT字段
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getStatusText")
    public ToJson<InterfaceModel> getStatusText(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);


        ToJson<InterfaceModel> tojson = new ToJson<InterfaceModel>(0, "");
        try {

            List<InterfaceModel> interfaceModelList = interfaceService.getStaTusText();

            //list=sysParaService.getIeTitle1();
            String[] statusTextArr = null;
            if (interfaceModelList != null && interfaceModelList.size() > 0) {
                InterfaceModel interfaceModel = interfaceModelList.get(0);
                String statusText = interfaceModel.getStatusText();
                if (!StringUtils.checkNull(statusText)) {
                    statusTextArr = statusText.split("\\n");
                } else {
                    statusTextArr = new String[1];
                    /*statusTextArr[0] = "欢迎使用"+statusText;*/
                    statusTextArr[0]="";
                }
            }else{
                statusTextArr[0]="";
            }
            tojson.setObject(statusTextArr);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }
        return tojson;

    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/25 12:23
     * @函数介绍: 修改
     * @参数说明: @param interfaceModel paramintroduce
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "editStatusText")
    public ToJson<InterfaceModel> editStatusText(InterfaceModel interfaceModel) {

        ToJson<InterfaceModel> tojson = new ToJson<InterfaceModel>(0, "");
        if (interfaceModel != null && interfaceModel.getStatusText() != null) {
            try {
                interfaceModel.setStatusText(URLDecoder.decode(interfaceModel.getStatusText(),"UTF-8"));
                interfaceService.editStatusText(interfaceModel);

                List<InterfaceModel> interfaceModelList = interfaceService.getStaTusText();

                //list=sysParaService.getIeTitle1();

                if (interfaceModelList != null && interfaceModelList.size() == 1) {
                    InterfaceModel interfaceModel1 = interfaceModelList.get(0);
                    String statusText = interfaceModel1.getStatusText();
                    String[] statusTextArr = null;
                    if (statusText != null) {
                        statusTextArr = statusText.split("\\n");
                    } else {
                        statusTextArr = new String[1];
                        statusTextArr[0] = "欢迎使用"+statusText;
                    }

                    tojson.setObject(statusTextArr);
                }
                tojson.setMsg("ok");
                tojson.setFlag(0);
            } catch (Exception e) {
                e.printStackTrace();
                tojson.setFlag(1);
                tojson.setMsg("err");
            }

        }
        return tojson;

    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 10：29
     * @函数介绍: 查询界面信息
     * @参数说明: @param request
     * @return:
     **/

    @ResponseBody
    @RequestMapping("/getInterfaceInfo")
    public ToJson<InterfaceModel> getInterfaceInfo(HttpServletRequest request) {
       /* ContextHolder.setConsumerType("xoa"+(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组

        if(cookies!=null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("company")){
                    ContextHolder.setConsumerType("xoa" +  cookie.getValue());
                }
                // get the cookie name
                // get the cookie value
            }
        }*/
        ToJson<InterfaceModel> tojson = new ToJson<InterfaceModel>(0, "");
        try {

            List<InterfaceModel> interfaceModelList = interfaceService.getInterfaceInfo(request);
            if (interfaceModelList != null && interfaceModelList.size() == 1) {
             /*   String loginId = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                String aaa=interfaceModelList.get(0).getAttachmentId();
                String[] one=aaa.split("@");
                String[] two=one[1].split("_");
                String str="xs?AID="+one[0]+"&MODULE=interface&COMPANY=xoa"+loginId+"&YM="+two[0]+"&ATTACHMENT_ID="+two[1]+"&ATTACHMENT_NAME="+interfaceModelList.get(0).getAttachmentName();
                File file=new File(str);
                if(!file.exists()){
                    interfaceModelList.remove(0);
                }else {
                    tojson.setObject(interfaceModelList.get(0));
                }*/
                tojson.setObject(interfaceModelList.get(0));

            }

            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }
       /* //判断是否显示验证码-GXY
        SysPara sysPara=sysParaService.getSecGraphic();
        if(sysPara==null){
            tojson.setObj1("0");
        }else{

            tojson.setObj1(sysPara.getParaValue()==null?"0":sysPara.getParaValue());
        }*/
        return tojson;
    }

    /**
     * @创建作者: 张丽军
     * @创建日期: 2018/11/28 10：39
     * @函数介绍: 判断当前库是否是默认库
     * @参数说明: @param
     * @return: XXType(value introduce)
     **/
    @ResponseBody
    @RequestMapping("/selectMySql")
    public ToJson<Object> selectMySql(HttpServletRequest request) {
      /*  Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);*/
        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        //ContextHolder.setConsumerType(sqlType);
        ToJson<Object> tojson = new ToJson<Object>(0, "");
        try {
            //遍历数据库
            ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
            List<OrgManage> obj = zh_cn.getObj();
            if(obj!=null&&obj.size()>0){
                for(OrgManage obj1:obj){
                    String a =obj1.getIsOrg();
                    int b =obj1.getOid();
                    if(Integer.valueOf(sqlType)==b){
                        if(a.equals("1")){
                            tojson.setCode("1");
                            return tojson;
                        }
                    }else {
                        tojson.setCode("0");
                    }
                }
            }
            /*String size = String.valueOf(obj.get(0).getOid());
            if(sqlType.equals(size)){
                tojson.setCode("1");
            }else {
                tojson.setCode("0");
            }*/
        } catch (Exception e) {
            tojson.setMsg("err");
            tojson.setFlag(1);
        }

        return tojson;
    }



    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/19 10：39
     * @函数介绍: 修改界面设置信息
     * @参数说明: @param
     * @return: XXType(value introduce)
     **/
    @ResponseBody
    @RequestMapping("/updateInterfaceInfo")
    public ToJson<Object> updateInterfaceInfo(HttpServletRequest request, InterfaceModel interfaceModel, String LOG_OUT_TEXT, String MIIBEIAN,String IM_WINDOW_CAPTION/*, @RequestParam(value = "titleImgFile", required = false)MultipartFile titleImgFile*/) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Object> tojson = new ToJson<Object>(0, "");
        try {
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String resourcePath = "ui/img/sys";
            // 左上角图片上传，去掉注释可以直接使用
            /*if (titleImgFile != null) {
                if (FileUploadUtil.allowUpload(titleImgFile.getContentType())) {
                    // 获取后缀名 拼接图片名称
                    int i = titleImgFile.getOriginalFilename().lastIndexOf(".");
                    String fileName = "titleImg"+titleImgFile.getOriginalFilename().substring(i);
                    File dir = new File(realPath + resourcePath);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    File file = new File(dir, fileName);
                    titleImgFile.transferTo(file);
                    interfaceModel.setAttachmentName(fileName);
                }
            }*/
            if(!StringUtils.checkNull(MIIBEIAN)){
                SysPara sysPara =new SysPara();
                sysPara.setParaName("MIIBEIAN");
                sysPara.setParaValue(MIIBEIAN);
                sysParaService.updateSysPara(sysPara);
            }

            SysPara sysPara1 =new SysPara();
            sysPara1.setParaName("LOG_OUT_TEXT");
            sysPara1.setParaValue(LOG_OUT_TEXT);
            sysParaService.updateSysPara(sysPara1);
            SysPara sysPara2 =new SysPara();
            sysPara2.setParaName("IM_WINDOW_CAPTION");
            sysPara2.setParaValue(IM_WINDOW_CAPTION);
            sysParaService.updateSysPara(sysPara2);
            interfaceService.updateInterfaceInfo(interfaceModel);
            tojson.setMsg("ok");
            tojson.setFlag(0);

        } catch (Exception e) {
            tojson.setMsg("err");
            tojson.setFlag(1);
        }

        return tojson;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/19 9:19
     * @函数介绍: 添加界面设置信息
     * @参数说明: @param
     */
    @ResponseBody
    @RequestMapping(value = "/addinterfaceinfo")
    public ToJson<InterfaceModel> insertInterfaceInfo(HttpServletRequest request, InterfaceModel interfaceModel){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<InterfaceModel> json = new ToJson<InterfaceModel>(0, null);
        try {
            interfaceService.insertInterfaceInfo(interfaceModel);
            json.setObject(interfaceModel);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许设置主题
     * @参数说明: @param
     */
    @ResponseBody
    @RequestMapping(value = "/getThemeSelect")
    public ToJson<InterfaceModel> getThemeSelect() {
        ToJson<InterfaceModel> json = new ToJson<InterfaceModel>();
        try {
            InterfaceModel themeSelect = interfaceService.getThemeSelect();
            json.setObject(themeSelect);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e ){
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许上传头像
     * @参数说明: @param
     */
    @ResponseBody
    @RequestMapping("/getAvatarUpload")
    public  ToJson<InterfaceModel> getAvatarUpload() {
        ToJson<InterfaceModel> json = new ToJson<InterfaceModel>();
        try {
            InterfaceModel avatarUpload = interfaceService.getAvatarUpload();
            json.setObject(avatarUpload);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e ){
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询登陆主题
     * @参数说明: @param
     */
    @ResponseBody
    @RequestMapping("/getTemplate")
    public  ToJson<InterfaceModel> getTemplate() {
        ToJson<InterfaceModel> json = new ToJson<InterfaceModel>();
        try {
            InterfaceModel template = interfaceService.getTemplate();
            json.setObject(template);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e ){
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }


    @ResponseBody
    @RequestMapping("/getInterfaceParam")
    public AjaxJson getInterfaceParam(HttpServletRequest request,String params) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            String serverName = request.getServerName();
            ContextHolder.setConsumerType("xoa1001");
            ToJson<OrgManage> org = orgManageService.queryId2("zh_CN", serverName);
            if(org!=null&&org.isFlag()){
                List<OrgManage> obj = org.getObj();
                if(obj!=null&&obj.size()>0){
                    OrgManage orgManage = obj.get(0);
                    ContextHolder.setConsumerType("xoa"+orgManage.getOid());
                } else {
                    String sqlType = this.getSqlType(request);
                    ContextHolder.setConsumerType(sqlType);
                }
            }
            InterfaceModel interfaceModel = interfaceService.getInterfaceParam();
            Map<String,Object> map = ReflectionUtils.getFileds(interfaceModel,params);
            List<String> item = new ArrayList<>();
            item.add("IS_CHECK_DEMO");
            item.add("MIIBEIAN");
            item.add("QRCODE_LOGIN_SET");
            item.add("IS_SHOW_JMJ");
            item.add("IS_OPEN_GET_PASSWORD");
            item.add("IS_USE_APP");
            List<SysPara> sysParaList = sysParaMapper.getSysParaList(item);
            for (SysPara sysPara : sysParaList) {
                if("IS_CHECK_DEMO".equals(sysPara.getParaName())){
                    map.put("loginValidation",sysPara==null?"1":sysPara.getParaValue());
                }else {
                    map.put(sysPara.getParaName(),sysPara.getParaValue());
                }
            }
            ajaxJson.setObj(map);
            ajaxJson.setFlag(true);
            ajaxJson.setMsg("OK");
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setFlag(false);
            ajaxJson.setMsg(e.getMessage());
        }
        return ajaxJson;
    }


    public String getSqlType(HttpServletRequest request){

        SysPara sysParaCloudOa = sysParaMapper.querySysPara("CLOUD_OA");
        if (sysParaCloudOa!=null){
            if ("1".equals(sysParaCloudOa.getParaValue())){
                Integer oid ;
                String serverName = request.getServerName();
                String[] split = serverName.split("\\.");
                if (split[0].length() == 4) {
                    oid = Integer.parseInt(split[0]);
                    return "xoa"+oid;
                }

            }
        }

        return "xoa1001";
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/15 14:29
     * 方法介绍:   是否开启移动端水印
     * 参数说明:   @param :
     * 返回值说明: ToJson
     */
    @ResponseBody
    @RequestMapping("/getMobileWatermark")
    public ToJson getMobileWatermark(String userId) {
        return interfaceService.getMobileWatermark(userId);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/3/3
     * 方法介绍: 查询是否开启黑色主题 黑色主题（0-关，1-开）
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.sys.InterfaceModel>
     **/
    @ResponseBody
    @RequestMapping("/getBlackTheme")
    public ToJson<Object> getBlackTheme(HttpServletRequest request) {
        return interfaceService.getBlackTheme(request);
    }

}