package com.xoa.service.sys.impl;

import com.tencent.xinge.*;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.service.sys.InterFaceService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.MachineCode;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/6/2 18:09
 * @类介绍: 软件界面设置处理类
 * @构造参数: 无
 **/
@Service
public class InterfaceServiceImpl implements InterFaceService {


    @Resource
    private SysInterfaceMapper sysInterfaceMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private OrgManageMapper orgManageMapper;

    @Resource
    private UsersMapper usersMapper;

    @Value("${xg_push_msg_android_key}")
    String androidKey;
    @Value("${xg_push_msg_android_sercetkey}")
    String androidSercetKey;
    @Value("${xg_push_msg_ios_key}")
    String iosKey;
    @Value("${xg_push_msg_ios_sercetkey}")
    String iosSercetKey;

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/19 11.44
     * @函数介绍: 查询界面窗口名称
     * @参数说明: @param
     * @return: String 窗口名称
     **/

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许设置主题
     * @参数说明: @param
     */
    @Override
    public InterfaceModel getThemeSelect() {
        return sysInterfaceMapper.getThemeSelect();
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许上传头像
     * @参数说明: @param
     */
    @Override
    public InterfaceModel getAvatarUpload() {
        return sysInterfaceMapper.getAvatarUpload();
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询使用什么登陆模板
     * @参数说明: @param
     */
    @Override
    public InterfaceModel getTemplate() {
        return sysInterfaceMapper.getTemplate();
    }

    @Override
    public List<InterfaceModel> getStaTusText() {

        List<InterfaceModel> list = sysInterfaceMapper.getStatusText();

        return list;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 18:08
     * @函数介绍: 系统界面设置
     * @参数说明: @param void
     * @return: List<InterfaceModel></InterfaceModel>
     **/

    @Override
    public void editStatusText(InterfaceModel interfaceModel) {
        sysInterfaceMapper.editStatusText(interfaceModel.getStatusText());
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 18:08
     * @函数介绍: 系统界面设置
     * @参数说明: @param void
     * @return: List<InterfaceModel></InterfaceModel>
     **/
    @Override
    public List<InterfaceModel> getInterfaceInfo(HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        String type = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        // 设置默认库
        if (StringUtils.checkNull(type)){

            String dataSource = "";
            // 1.先查询主组织即 org_manage 中的 is_org =1 的库 如果存在的话  直接使用该库
            List<OrgManage> orgManages = orgManageMapper.selOrgManageIsOrg();

            if(orgManages!=null&&orgManages.size()>0){
                OrgManage orgManage = orgManages.get(0);
                if(orgManage!=null){
                    Integer oid = orgManage.getOid();
                    dataSource = oid.toString();
                }
            }

            // 2.如果没有主组织的情况下 获取列表中的第一个组织
            if(StringUtils.checkNull(dataSource)){
                OrgManage orgManage = orgManageMapper.selFirstOrg();
                if(orgManage!=null&&orgManage.getOid()>0){
                    dataSource = orgManage.getOid().toString();
                }
            }

            sqlType = "xoa"+dataSource;
        }else{
            ContextHolder.setConsumerType(sqlType);
        }

        List<InterfaceModel> interfaceModelList = sysInterfaceMapper.getInterfaceInfo();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String theme = SessionUtils.getSessionInfo(request.getSession(), "InterfaceModel", String.class, redisSessionCookie);
        String AttachmentImgUrl = "/img/replaceImg/" + theme + "/LOGOMain.png";
        for (InterfaceModel interfaceModel : interfaceModelList) {
            if (!StringUtils.checkNull(interfaceModel.getAttachmentName()) && !StringUtils.checkNull(interfaceModel.getAttachmentId())) {
                List<Attachment> attachment = GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName(), interfaceModel.getAttachmentId(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE);
                if (attachment != null && attachment.size() > 0) {
                    interfaceModel.setAttachment(attachment);
                    interfaceModel.setJudgeAttachmentUrl("/xs?"+attachment.get(0).getAttUrl().replaceAll("xoanull", sqlType));
                } else {
                    interfaceModel.setJudgeAttachmentUrl(AttachmentImgUrl);
                }
            } else {
                interfaceModel.setJudgeAttachmentUrl(AttachmentImgUrl);
            }
            if (interfaceModel.getAttachmentName2() != null && interfaceModel.getAttachmentId2() != null) {
                interfaceModel.setAttachment2(GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName2(), interfaceModel.getAttachmentId2(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE));
            }
            if (interfaceModel.getAttachmentName3() != null && interfaceModel.getAttachmentId3() != null) {
                interfaceModel.setAttachment3(GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName3(), interfaceModel.getAttachmentId3(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE));
            }
            if (interfaceModel.getAttachmentName4() != null && interfaceModel.getAttachmentId4() != null) {
                interfaceModel.setAttachment4(GetAttachmentListUtil.returnAttachment(
                        interfaceModel.getAttachmentName4(), interfaceModel.getAttachmentId4(), sqlType,
                        GetAttachmentListUtil.MODULE_INTERFACE));
            }

        }

        SysPara sysPara = sysParaMapper.querySysPara("LOG_OUT_TEXT");
        SysPara sysPara1 = sysParaMapper.querySysPara("MIIBEIAN");
        SysPara sysPara2 = sysParaMapper.querySysPara("IM_WINDOW_CAPTION");
        SysPara sysPara3 = sysParaMapper.querySysPara("WORKFLOW_WATERMARK");

       /* if (interfaceModelList != null && interfaceModelList.size() == 1) {
            if (sysParatList != null && sysParatList.size() == 1) {
                interfaceModelList.get(0).setLogOutText(sysParatList.get(0).getParaValue());
            }
        }*/
        if (interfaceModelList != null) {
            for (InterfaceModel i : interfaceModelList) {
                if (sysPara != null || sysPara1 != null) {
                    i.setLogOutText(sysPara.getParaValue());
                    i.setFileNumber(sysPara1.getParaValue());
                    i.setTitle(sysPara2.getParaValue());
                }
                if(sysPara3!=null && !StringUtils.checkNull(sysPara3.getParaValue())){
                    i.setWorkFlowWaterMark(sysPara3.getParaValue());
                }
            }

        }
        return interfaceModelList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 19:04
     * @函数介绍: 修改界面设置
     * @参数说明: @param InterfaceModel 界面设置信息的实体类
     * @return: void
     */
    @Override
    public void updateInterfaceInfo(InterfaceModel interfaceModel) {

        //如果interfaceModel的所有属性都是null,sysInterfaceMapper.updateInterfaceInfo
        //会报错，所有先判断其中一个属性，如果为null，就是不修改，就从数据库查下来，在添加回数据库，
        //解决sqlwent
        List<InterfaceModel> statusTextList = sysInterfaceMapper.getStatusText();
        if (statusTextList != null && statusTextList.size() == 1) {
            String statusText = statusTextList.get(0).getStatusText();

            if (interfaceModel.getStatusText() == null) {
                interfaceModel.setStatusText(statusText);
            }

        }
        sysInterfaceMapper.updateInterfaceInfo(interfaceModel);

        //sysParaMapper.updateSysPara(sysPara) 如果sysPara的paraValue为null就会报错，所有先判断
        if (interfaceModel != null && interfaceModel.getLogOutText() != null) {
            SysPara sysPara = new SysPara();
            sysPara.setParaValue(interfaceModel.getLogOutText());
            sysPara.setParaName("LOG_OUT_TEXT");
            sysParaMapper.updateSysPara(sysPara);
        }

        if(interfaceModel != null && !StringUtils.checkNull(interfaceModel.getWorkFlowWaterMark())){
            SysPara workflow_watermark = sysParaMapper.querySysPara("WORKFLOW_WATERMARK");
            if(workflow_watermark!=null){
                workflow_watermark.setParaValue(interfaceModel.getWorkFlowWaterMark());
                sysParaMapper.updateSysPara(workflow_watermark);
            } else {
                workflow_watermark = new SysPara();
                workflow_watermark.setParaName("WORKFLOW_WATERMARK");
                workflow_watermark.setParaValue(interfaceModel.getWorkFlowWaterMark());
                sysParaMapper.insertSysPara(workflow_watermark);
            }
        }

    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年6月16日 19：37：05
     * 方法介绍:   保存部门
     * 参数说明:   @param interfaceModel 界面信息
     *
     * @return void    无
     */
    @Override
    public void insertInterfaceInfo(InterfaceModel interfaceModel) {
        sysInterfaceMapper.insertInterfaceInfo(interfaceModel);
    }


    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月16日 19：37：05
     * 方法介绍:   查询标题和离开信息
     * 参数说明:   @param interfaceModel 界面信息
     */
    @Override
    public InterfaceModel getIndexInfo() {
        InterfaceModel interfaceModel = sysInterfaceMapper.getIndexInfo();
        List<SysPara> paras = sysParaMapper.getTheSysParam("LOG_OUT_TEXT");
        SysPara sysPara = paras.get(0);
        interfaceModel.setLogOutText(sysPara.getParaValue());
        return interfaceModel;
    }

    @Override
    public InterfaceModel getInterfaceParam() {
        List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
        InterfaceModel interfaceModel = interfaceModels.get(0);
        return interfaceModel;
    }




    @Override
    public BaseWrapper pushMessage(String userId, String app, HttpServletRequest request, String title, String content) throws JSONException {
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setStatus(true);
        if (StringUtils.checkNull(userId)) {
            baseWrapper.setMsg("参数未传递");
            baseWrapper.setFlag(true);
            baseWrapper.setCode("-1");
        }
        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        String jixiema = this.getMachineCode12();
        String account = jixiema + userId + sqlType;
        XingeApp pushIos = new XingeApp(Long.parseLong(iosKey), iosSercetKey);//IOS
        XingeApp pushAndroid = new XingeApp(Long.parseLong(androidKey), androidSercetKey);//安卓
        if (StringUtils.checkNull(app)) {
            ClickAction clickAction = new ClickAction();
            clickAction.setActionType(ClickAction.TYPE_ACTIVITY);
            clickAction.setActivity("123");
            Style style = new Style(0, 0, 0, 1, 1, 1, 0, 1);
            Message mess = new Message();
            mess.setType(Message.TYPE_NOTIFICATION);
            mess.setStyle(style);
            mess.setTitle(title);
            mess.setContent(content);
            mess.setAction(clickAction);
            JSONObject ret = pushAndroid.pushSingleAccount(0, account, mess);
            JSONObject contentTest = new JSONObject();
            JSONObject obj = new JSONObject();
            JSONObject aps = new JSONObject();
            contentTest.put("title", title);//标题
            contentTest.put("body", content);//内容
            aps.put("badge", 1);
            aps.put("alert", contentTest);
            obj.put("aps", aps);
            MessageIOS messageIOS = new MessageIOS();
            messageIOS.setRaw(obj.toString());
            JSONObject ret3 = pushIos.pushSingleAccount(0, account, messageIOS, XingeApp.IOSENV_PROD);
            if ("-1".equals(ret3.get("ret_code").toString()) && "-1".equals(ret.get("ret_code").toString())) {
                baseWrapper.setCode(ret3.get("ret_code").toString());
            } else {
                baseWrapper.setCode("0");
            }
            baseWrapper.setMsg("推送完成");
            baseWrapper.setFlag(true);

        } else {
            if ("ios".equals(app)) {
                JSONObject contentTest = new JSONObject();
                JSONObject obj = new JSONObject();
                JSONObject aps = new JSONObject();
                contentTest.put("title", title);//标题
                contentTest.put("body", content);//内容
                aps.put("badge", 1);
                aps.put("alert", contentTest);
                obj.put("aps", aps);
                MessageIOS messageIOS = new MessageIOS();
                messageIOS.setRaw(obj.toString());
                JSONObject ret3 = pushIos.pushSingleAccount(0, account, messageIOS, XingeApp.IOSENV_PROD);
                baseWrapper.setMsg("推送完成");
                baseWrapper.setFlag(true);
                baseWrapper.setCode(ret3.get("ret_code").toString());
            } else {
                ClickAction clickAction = new ClickAction();
                clickAction.setActionType(ClickAction.TYPE_ACTIVITY);
                clickAction.setActivity("123");
                Style style = new Style(0, 0, 0, 1, 1, 1, 0, 1);
                Message mess = new Message();
                mess.setType(Message.TYPE_NOTIFICATION);
                mess.setStyle(style);
                mess.setTitle(title);
                mess.setContent(content);
                mess.setAction(clickAction);
                JSONObject ret = pushAndroid.pushSingleAccount(0, account, mess);
                baseWrapper.setMsg("推送完成");
                baseWrapper.setFlag(true);
                baseWrapper.setCode(ret.get("ret_code").toString());
            }
        }


        return baseWrapper;
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/15 14:24
     * 方法介绍:   查询是否开启移动端水印
     * 参数说明:   @param :
     * 返回值说明: InterfaceModel
     */
    @Override
    public ToJson getMobileWatermark(String userId) {
        ToJson toJson = new ToJson(1,"error");
        try {
            InterfaceModel interfaceModel = sysInterfaceMapper.getMobileWatermark();
            if (interfaceModel != null){
                Users users = usersMapper.findUsersByuserId(userId);
                if (users != null){
                    interfaceModel.setUserName(users.getUserName());
                    String mobilNo = users.getMobilNo();
                    if (!StringUtils.checkNull(mobilNo)){
                        interfaceModel.setMobilNo(mobilNo.substring(mobilNo.length()-4));
                    }else {
                        interfaceModel.setMobilNo("");
                    }
                    toJson.setFlag(0);
                    toJson.setObject(interfaceModel);
                    toJson.setMsg("ok");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/3/3
     * 方法介绍: 查询是否开启黑色主题 黑色主题（0-关，1-开）
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.sys.InterfaceModel>
     **/
    @Override
    public ToJson<Object> getBlackTheme(HttpServletRequest request) {
        ToJson<Object> toJson = new ToJson<>(1,"error");
        try {
            InterfaceModel interfaceModel = sysInterfaceMapper.getBlackTheme();
            if (interfaceModel != null && !StringUtils.checkNull(interfaceModel.getBlackTheme())){
                Map<String, Object> map = new HashMap<>();
                map.put("blackTheme", interfaceModel.getBlackTheme());
                toJson.setFlag(0);
                toJson.setObject(map);
                toJson.setMsg("ok");
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    public String getMachineCode12() {
        String machineCode = null;
        try {
            SysPara para = sysParaMapper.querySysPara("PUSH_MNO");
            if (para != null && !StringUtils.checkNull(para.getParaValue())) {
                machineCode = para.getParaValue().substring(0, 12);
            } else {
                machineCode = MachineCode.get16CharMacs() == null ? "" : MachineCode.get16CharMacs().get(0);
            }
        } catch (Exception e) {
        }
        return machineCode;
    }


}
