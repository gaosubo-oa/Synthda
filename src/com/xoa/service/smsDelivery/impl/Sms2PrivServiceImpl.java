package com.xoa.service.smsDelivery.impl;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mascloud.sdkclient.Client;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.sms.v20190711.SmsClient;
import com.tencentcloudapi.sms.v20190711.models.SendSmsRequest;
import com.tencentcloudapi.sms.v20190711.models.SendSmsResponse;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.sms2.Sms2Mapper;
import com.xoa.dao.sms2.Sms2PrivMapper;
import com.xoa.dao.smsSettings.SmsSettingsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.sms2.Sms2;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.model.users.Users;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.channel.SDKClientTest;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.sendUtil.HttpSend;
import com.xoa.util.sendUtil.SendYjt;
import com.xoa.util.sendUtil.send;
import com.xoa.util.sendmsg.MessageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;


@Service
public class Sms2PrivServiceImpl implements Sms2PrivService {

    @Resource
    private Sms2PrivMapper sms2PrivMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UsersService usersService;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SmsSettingsMapper smsSettingsMapper;

    @Autowired
    private SDKClientTest sdkClientTest;

    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private Sms2Mapper sms2Mapper;
    final static Client client =  Client.getInstance();
    final static Boolean MasLoginStatus = false;
    static{
        //Boolean loginresult = Sms2PrivServiceImpl.client.login("http://mas.ecloud.10086.cn/app/sdk/login", "senduser ", "s123456","河南华英农业发展股份有限公司");
        //Boolean loginresult = Sms2PrivServiceImpl.client.login("http://112.35.4.197:15000", "seu1", "sw123456","信阳市商务局");//http://112.35.4.197:15000/app/sdk/login
        // System.out.println(loginresult);
    }
    @Override
    @Transactional
    public ToJson<Sms2Priv> selectSms2Priv() {

        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();
            if(!StringUtils.checkNull(sms2Priv.getTypePriv())){
                //String split = sms2Priv.getTypePriv().split(",");
                // List<Sms2Priv> sms2Priv1 = sms2PrivMapper.selectSms2Priv1(split);
                // json.setObj(sms2Priv1);
            }

            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;

    }


    @Override
    @Transactional
    public ToJson upSms2Priv(Sms2Priv sms2Priv) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            int temp = sms2PrivMapper.upSms2Priv(sms2Priv);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }

    @Override
    @Transactional
    public ToJson<Sms2Priv> selectRemindPriv() {

        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();
            if(!StringUtils.checkNull(sms2Priv.getRemindPriv())){
                String[] split = sms2Priv.getRemindPriv().split(",");
                List<Sms2Priv> remindPriv1 = sms2PrivMapper.selectRemindPriv1(split);
                json.setObj(remindPriv1);
            }

            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;

    }
    @Override
    @Transactional
    public ToJson upRemindPriv(Sms2Priv sms2Priv) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            // if(!StringUtils.checkNull(sms2Priv.getRemindPriv())){
            //     String[] split = sms2Priv.getRemindPriv().split(",");
            //     List<Sms2Priv> sms2PrivList = sms2PrivMapper.upRemindPriv(split);//通过username查userid
            //     String str = "";
            //     for(Sms2Priv sms2Priv1:sms2PrivList){
            //         str+=sms2Priv1.getUserId()+",";
            //     }
            //     sms2Priv.setRemindPriv(str);
            // }
            //前端直接传入userIds直接修改数据库
            int temp = sms2PrivMapper.upSms2Priv(sms2Priv);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }
    @Override
    @Transactional
    public ToJson<Sms2Priv> selectSms2RemindPriv() {

        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();
            if(!StringUtils.checkNull(sms2Priv.getSms2RemindPriv())){
                String[] split = sms2Priv.getSms2RemindPriv().split(",");
                List<Sms2Priv> remindPriv1 = sms2PrivMapper.selectSms2RemindPriv1(split);
                json.setObj(remindPriv1);
            }

            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;

    }
    @Override
    @Transactional
    public ToJson upselectSms2RemindPriv(Sms2Priv sms2Priv) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            // if(!StringUtils.checkNull(sms2Priv.getSms2RemindPriv())){
            //     String[] split = sms2Priv.getSms2RemindPriv().split(",");
            //     List<Sms2Priv> sms2PrivList = sms2PrivMapper.upselectSms2RemindPriv(split);
            //     String str = "";
            //     for(Sms2Priv sms2Priv1:sms2PrivList){
            //         str+=sms2Priv1.getUserId()+",";
            //     }
            //     sms2Priv.setSms2RemindPriv(str);
            // }
            //前端直接传入userIds直接修改数据库
            int temp = sms2PrivMapper.upSms2Priv(sms2Priv);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }



    @Override
    @Transactional
    public ToJson selectModuleOrder() {
        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            List<Sms2Priv>  list = sms2PrivMapper.selectModuleOrder();
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    @Override
    @Transactional
    public ToJson selectSmsRemind() {
        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            Sms2Priv sms2Priv=  sms2PrivMapper.selectSmsRemind();
            if(!StringUtils.checkNull(sms2Priv.getParaValue())) {
                String[] split = sms2Priv.getParaValue().split("\\|");
                if(split.length == 1) {
                    sms2Priv.setColumn1(split[0]);
                }else if(split.length == 2){
                    sms2Priv.setColumn1(split[0]);
                    sms2Priv.setColumn2(split[1]);
                } else if(split.length == 3){
                    sms2Priv.setColumn1(split[0]);
                    sms2Priv.setColumn2(split[1]);
                    sms2Priv.setColumn3(split[2]);
                }

            }

            json.setObject(sms2Priv);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }
    @Transactional
    public ToJson upSmsRemindSet(Sms2Priv sms2Priv) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            int temp = sms2PrivMapper.upSmsRemindSet(sms2Priv);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    @Transactional
    public ToJson selectSender(String name) {
        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            Sms2Priv sms2Priv=  sms2PrivMapper.selectSmsRemind();
            if(!StringUtils.checkNull(sms2Priv.getParaValue())) {
                String[] split = sms2Priv.getParaValue().split("\\|");

                if(split[2].contains(","+name+",")){
                    sms2Priv.setSmsDefault("0");
                }else{
                    sms2Priv.setSmsDefault("1");
                }
                if(split[1].contains(","+name+",")){
                    sms2Priv.setThingDefault("0");
                }else{
                    sms2Priv.setThingDefault("1");
                }
                if(split[0].contains(","+name+",")){
                    sms2Priv.setThingRemind("0");
                }else{
                    sms2Priv.setThingRemind("1");
                }
            }
            json.setObject(sms2Priv);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    /***
     *       发送短信的接口
     * @param mobileString  电话号码。
     * @param contextString 短信内容
     * @param sms2Priv   短信权限内容
     * @return
     */
    @Override
    @Transactional
    public ToJson smsSender(StringBuffer mobileString, StringBuffer contextString,Sms2Priv sms2Priv,HttpServletRequest request) {
        ToJson toJson = new ToJson(1, "error");

        Map<String, String> maps = new HashMap<String, String>();
        // 追加发送时间，可为空，为空为及时发送
        String stime="";
        Sms2Priv sms2Priv1 = new Sms2Priv();
        sms2Priv.setStartTime(stime);
        String [] str = sms2Priv.getUserId().split(",");
        StringBuffer mobileString1=new StringBuffer();

        try {
            for(String uId:str){
                Users users = usersMapper.SimplefindUsersByuserId(uId);
                if (users!=null) {
                    String mobile = users.getMobilNo();
                    if(mobile!=null&&!mobile.equals("")){
                        mobileString.append(mobile+",");
                    }
                }
            }
            StringBuffer mobile1 = new StringBuffer();
            if(!("".equals(mobileString.toString()))){
                mobile1=mobileString.deleteCharAt(mobileString.length()-1);
            }
            SysPara sysPara=sysParaMapper.querySysPara("MOBILE_SMS_SET");

            //根据手机短信权限筛选出被设置了提醒权限的用户不发送短信
            mobileString = new StringBuffer(checkSmsAuth(mobileString.toString()));
            if(sysPara.getParaValue().equals("0")){
                List<SmsSettings> list = smsSettingsMapper.selectSmsSettings(new HashMap<>());
                for(SmsSettings smsSettings:list){
                    smsSettings.setSign("sign="+smsSettings.getSign());
                }
                for(SmsSettings smsSettings:list) {
                    StringBuffer extno = new StringBuffer(smsSettings.getExtend2());
                    if ("湖北移动".equals(smsSettings.getName())) {
                        String url = smsSettings.getProtocol() + "://" + smsSettings.getHost() + "/" + smsSettings.getPort();
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                        String[] p = smsSettings.getPwd().split("=");
                        String[] sign1 = smsSettings.getSign().split("=");
                        String str1 = p[1] + sdf.format(new Date());
                        String str2 = Md5Util.getMd5String(str1);
                        maps.put("sign", str2);
                        maps.put("timestamp", sdf.format(new Date()));
                        String[] username1 = smsSettings.getUsername().split("=");
                        maps.put("userName", username1[1]);
                        maps.put("phones", mobile1.toString());
                        maps.put("msgContent", contextString.toString());
                        String[] extend1 = smsSettings.getExtend1().split("=");
                        maps.put("serviceCode", extend1[1]);
                        // String[] extend3 = smsSettings.getExtend3().split("=");
                        maps.put("mhtMsgIds", mobile1.toString());
                        maps.put("encoding", "utf-8");
                        maps.put("priority", "5");
                        String msgResult = HttpSend.sendPost(url, maps);
                        // System.out.println("发送结果为：" + msgResult);
                    }else if("云MAS".equals(smsSettings.getName())){
                        String [] mobileStr = mobileString.toString().split(",");
                        mobileStr = rebuildArry(mobileStr);
                        String s = org.apache.commons.lang3.StringUtils.join(mobileStr, ",");
                        String res = YunMasUtile.LoginGo(s,contextString.toString(),smsSettings);
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }else if("东时方".equals(smsSettings.getName())){
                        String[] mobileStr = mobileString.toString().split(",");
                        List<String> mobleList = Arrays.asList(mobileStr);
                        StringBuilder sb = new StringBuilder();
                        // 分割字符串 70个字符为一组
                        String[] contextStrings = StringUtils.stringToStringArray(contextString.toString(), 55);
                        // 循环发送
                        for (String context : contextStrings) {
                            // 分割电话号码 100个为一组
                            for (int i = 0; i < mobleList.size(); i++) {
                                // 判断是否已经足够100次了 如果够了的话 发送短信 并清空sb
                                if(i!=0&&i%100==0){
                                    SendSms(sb.toString(), context, smsSettings);
                                    sb = new StringBuilder();
                                }
                                sb.append(mobleList.get(i)).append(",");
                                // 判断是否是最后一次了 如果是的话 发送短信
                                if(i==(mobleList.size()-1)){
                                    SendSms(sb.toString(), context, smsSettings);
                                    sb = new StringBuilder();
                                }
                            }
                        }
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    } else if("翼信云通信".equals(smsSettings.getName())){ // 恩施教育项目短信接口
                        if(!StringUtils.checkNull(mobileString.toString())){
                            String []userIds=sms2Priv.getUserId().split(",");
                            String []mobiles=null;
                            for(int i=0;i<userIds.length;i++){
                                Users u=usersMapper.getUserId(userIds[i]);
                                if(u!=null){
                                    mobiles=new String[i+1];
                                    mobiles[i]=u.getMobilNo();
                                }
                            }

                            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
                            Department department=departmentMapper.getFatherDept(users.getDeptId());
                            for(String mobile:mobiles){
                                if(!StringUtils.checkNull(department.getSmsGateAccount())) {
                                    for(String overName:userIds) {
                                        send.sms(mobile, department.getSmsGateAccount(), contextString.toString(), users.getByname(),overName,smsSettings );
                                    }
                                }else{
                                    toJson.setMsg("请设置部门号");
                                    break;
                                }
                            }
                            toJson.setFlag(0);
                            toJson.setMsg("ok");
                        }
                    } else if("lnsf".equals(smsSettings.getName())&&!StringUtils.checkNull(mobileString.toString())){
                        String [] mobileStr = mobileString.toString().split(",");
                        List<String> outAddresses = Arrays.asList(mobileStr);
                        if(!outAddresses.isEmpty()) {
                            MessageUtil.sendmsg("", contextString.toString(),
                                    "ydxy-mobile", new ArrayList(),
                                    outAddresses, 0, null, smsSettings);
                            toJson.setFlag(0);
                            toJson.setMsg("ok");
                        }
                    }else if("创瑞".equals(smsSettings.getName())){
                        String [] mobileStr = mobileString.toString().split(",");
                        List<String> mobleList = Arrays.asList(mobileStr);
                        StringBuffer sb = new StringBuffer();
                        for (String list1:mobleList){
                            sb.append(list1).append(",");
                        }
                        String ret = SendSmsCR(sb.toString(), contextString.toString(),smsSettings);
                        if ("0".equals(ret)){
                            toJson.setFlag(0);
                            toJson.setMsg("ok");
                        }
                    } else {
                        String[] mobileStringStr = null;
                        mobileStringStr = rebuildArry(mobileString.toString().split(","));
                        mobileString = new StringBuffer("");
                        for(String s : mobileStringStr){
                            mobileString.append(s).append(",");
                        }
                        if(mobileString.length()>0){
                            mobileString.deleteCharAt(mobileString.length() - 1);
                        }
                        send.doPost(mobileString, contextString, smsSettings.getProtocol(), smsSettings.getHost(), smsSettings.getPort(),
                                smsSettings.getUsername(), smsSettings.getPwd(), smsSettings.getContentField(),
                                smsSettings.getCode(), smsSettings.getMobile(), smsSettings.getTimeContent(), smsSettings.getSign(), smsSettings.getSignValue(), smsSettings.getSignPosition(),
                                smsSettings.getExtend1(), smsSettings.getExtend2(), smsSettings.getExtend3(), smsSettings.getExtend4(), smsSettings.getExtend5(),
                                sms2Priv.getStartTime());
                    }
                }
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    @Transactional
    @SuppressWarnings("all")
    public ToJson selSenderMobile(String smsDefault,Sms2Priv sms2Priv,StringBuffer contextString, HttpServletRequest request) {

        ToJson toJson = new ToJson(1, "error");
        try {
            List<String> userArray=new ArrayList();
            if(!StringUtils.checkNull(sms2Priv.getUserId())){
                String[] userIdList=sms2Priv.getUserId().split(",");

                for(String userId:userIdList){
                    userArray.add(userId);
                }
            }

            //部门人员
            List<Users> deptList=new ArrayList();
            if(!StringUtils.checkNull(sms2Priv.getToId())){
                if("ALL_DEPT".trim().equals(sms2Priv.getToId())){
                    List<Department>  deptListArr=departmentMapper.getAllDepartment();
                    StringBuffer stringBuffer=new StringBuffer();
                    for(Department department:deptListArr){
                        stringBuffer.append(department.getDeptId());
                        stringBuffer.append(",");
                    }
                    deptList=usersService.getUserByDeptIds(stringBuffer.toString(),1);
                }else {
                    deptList=usersService.getUserByDeptIds(sms2Priv.getToId(),1);
                }
            }
            List<String> deptArray=new ArrayList();
            for(Users users:deptList){
                deptArray.add(users.getUserId());
            }
            //角色人员
            List<Users> privList=new ArrayList();
            if(!StringUtils.checkNull(sms2Priv.getPrivId())){
                privList=usersService.getUserByDeptIds(sms2Priv.getPrivId(),2);
            }
            List<String> privArray=new ArrayList();
            for(Users users:privList){
                privArray.add(users.getUserId());
            }
            //删除重复的数据
            for(String userId:userArray){
                int f1=0;
                for(String deptUser:deptArray){
                    if(userId.equals(deptUser)){
                        f1=1;
                        break;
                    }
                }
                if(f1==0){
                    deptArray.add(userId);
                }
            }
            for(String temp1:deptArray){
                int f2=0;
                for(String privUser:privArray){
                    if(temp1.equals(privUser)){
                        f2=1;
                        break;
                    }
                }
                if(f2==0){
                    privArray.add(temp1);
                }
            }
            StringBuffer mobileString=new StringBuffer();
            Sms2Priv  sms2Privs = sms2PrivMapper.selectSms2Priv();
            String user = sms2Privs.getRemindPriv();
            String[] u =user.split(",");
            for(String tempUser:privArray){
                for (String u1 : u){
                    if (tempUser.equals(u1)){
                        String mobile = sms2PrivMapper.selSenderMobile(tempUser);
                        if(mobile!=null&&!mobile.equals("")){
                            mobileString.append(mobile+",");
                        }
                    }
                }
            }
               /* if(!sms2Priv.getAttendeeOut().equals("")&&sms2Priv.getAttendeeOut()!=null){
                    mobileString.append(sms2Priv.getAttendeeOut());
                }*/
            smsSender(mobileString,contextString,sms2Priv,request);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }


    @Override
    @Transactional
    public ToJson<Sms2Priv> selOutPriv() {

        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();
            if(!StringUtils.checkNull(sms2Priv.getOutPriv())){
                String[] split = sms2Priv.getOutPriv().split(",");
                List<Sms2Priv> sms2Priv1 = sms2PrivMapper.selOutPriv(split);
                json.setObj(sms2Priv1);
            }
            if (sms2Priv!=null){
                Map map = new HashMap();
                map.put("outToSelf",sms2Priv.getOutToSelf());
                json.setObject(map);
            }

            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {

            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;

    }

    @Override
    @Transactional
    public ToJson upOutPriv(Sms2Priv sms2Priv) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            // if(!StringUtils.checkNull(sms2Priv.getOutPriv())){
            //     String[] split = sms2Priv.getOutPriv().split(",");
            //     List<Sms2Priv> sms2PrivList = sms2PrivMapper.upOutPriv(split);
            //     String str = "";
            //     for(Sms2Priv sms2Priv1:sms2PrivList){
            //         str+=sms2Priv1.getUserId()+",";
            //     }
            //     sms2Priv.setOutPriv(str);
            // }
            //前端直接传入userIds直接修改数据库
            int temp = sms2PrivMapper.upSms2Priv(sms2Priv);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }

    @Override
    @Transactional
    public ToJson outToSelf(Sms2Priv sms2Priv) {
        ToJson toJson = new ToJson<>(1, "error");
        try {
            int temp = sms2PrivMapper.upSms2Priv(sms2Priv);
            if (temp > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;

    }

    @Override
    public ToJson<Sms2Priv> selectSmS2Priv() {
        ToJson<Sms2Priv> json = new ToJson<Sms2Priv>();
        try {
            List<Sms2Priv>  sms2Priv = sms2PrivMapper.selectSmS2Priv();
            Sms2Priv  sms2Privs = sms2PrivMapper.selectSmSType();
            List<Sms2Priv> sms2Privzz = new ArrayList<>();
            if(!StringUtils.checkNull(sms2Privs.getTypePriv())) {
                String sb = sms2Privs.getTypePriv();
                String[] sb1 = sb.split(",");
                for (int i = 0; i < sb1.length; i++) {
                    Sms2Priv sms2Privss = sms2PrivMapper.selectSmSA(sb1[i]);
                    sms2Privzz.add(sms2Privss);
                }
                for (int i = 0; i < sms2Privzz.size(); i++) {
                    for (int j = 0; j < sms2Priv.size(); j++) {
                        if (((sms2Priv.get(j)).getCodeNo()).equals(sms2Privzz.get(i).getCodeNo())) {
                            sms2Priv.remove(j);
                        }
                    }
                }
                json.setObj(sms2Privzz);//允许的list
            }
            json.setObject(sms2Priv);//备选的list
//            json.setObj2(sms2Priv);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 查询允许发送短信的模块  sms2_priv表中
     *
     *
     * {codeName":"公告通知","codeNo":"1"},{"codeName":"电子邮件","codeNo":"2"},{"codeName":"网络会议","codeNo":"3"},
     * {"codeName":"工资上报","codeNo":"4"},{"codeName":"日程安排","codeNo":"5"},{"codeName":"考勤批示","codeNo":"6"},
     * {"codeName":"工作流：提醒下一步经办人","codeNo":"7"},{"codeName":"工作流：提醒流程发起人","codeNo":"40"},
     * {"codeName":"工作流：提醒流程所有人员","codeNo":"41"},{"codeName":"会议申请","codeNo":"8"},{"codeName":"车辆申请","codeNo":"9"},
     * {"codeName":"手机短信","codeNo":"10"},{"codeName":"投票提醒","codeNo":"11"},{"codeName":"工作计划","codeNo":"12"},
     * {"codeName":"工作日志","codeNo":"13"},{"codeName":"新闻","codeNo":"14"},{"codeName":"考核","codeNo":"15"},
     * {"codeName":"公共文件柜","codeNo":"16"},{"codeName":"网络硬盘","codeNo":"17"},{"codeName":"内部讨论区","codeNo":"18"},
     * {"codeName":"工资条","codeNo":"19"},{"codeName":"个人文件柜","codeNo":"20"},{"codeName":"领导活动安排","codeNo":"23"},
     * {"codeName":"审核提醒","codeNo":"22"},{"codeName":"邮件互发","codeNo":"25"},{"codeName":"公文管理","codeNo":"70"},
     * {"codeName":"督办","codeNo":"71"},{"codeName":"会议","codeNo":"72"}
     */
    public ToJson selectSms2(String sysCode,HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String userid = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId).getUserId();
        ToJson json = new ToJson();
        boolean userPriv = false;
        Sms2Priv  sms2Priv = sms2PrivMapper.selectSms2Priv();
        //模块权限
        String code = sms2Priv.getTypePriv();
        //提醒权限
        String user = sms2Priv.getSms2RemindPriv();
        //当前登录人是否有提醒权限  如果有返回 true  没有 false    userPriv默认false
        if(user!=null&&user!=""){
            String[] u =user.split(",");
            for (int i = 0; i < u.length; i++) {
                if (!StringUtils.checkNull(u[i])) {
                    if (userid.equals(u[i])){
                        userPriv = true;
                    }

                }
            }
        }

        json.setCode("0");
        //判断是否显示  发送短信的选项   返回true显示   false不显示
        if (code!=""){
            String[]  c = code.split(",");
            for (int i = 0; i < c.length; i++) {
                if (!StringUtils.checkNull(c[i])) {
                    //有模块权限
                    if (sysCode.equals(c[i])) {
                        json.setFlag(0);
                        json.setTurn(true);
                        json.setMsg("OK");
                        json.setCode("1");
                        break;
                    }else {
                        json.setFlag(0);
                        json.setTurn(true);
                        json.setMsg("OK");
                        json.setCode("0");
                    }
                }
            }
        }else {
            json.setFlag(1);
            json.setTurn(false);
            json.setMsg("请先添加模块权限");
        }
        return json;
    }

    /***
     * 用于选择内部用户发送短信
     *       发送短信的接口  根据用户ID获取用户的电话号码  发送短信
     * @param privArray   用戶ID
     * @param contextString 短信内容
     * @return
     */
    @Override
    @Transactional
    public ToJson smsSenders( StringBuffer contextString,String privArray) {
        ToJson toJson = new ToJson(1, "error");
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, String> maps = new HashMap<String, String>();
        // 追加发送时间，可为空，为空为及时发送
        String stime="";
        Sms2Priv sms2Priv = new Sms2Priv();
        sms2Priv.setStartTime(stime);
        String [] str = privArray.split(",");
        StringBuffer mobileString=new StringBuffer();
        for(String uId:str){
            Users users = null;
            if(contextString.indexOf("公共文件柜")!= -1 || contextString.indexOf("网络硬盘")!=-1){
                users = usersMapper.findUsersByuserId(uId);
            }else{
                users = usersMapper.findUserByuid(Integer.valueOf(uId));
            }
            if (users!=null) {
                String mobile = users.getMobilNo();
                if(mobile!=null&&!mobile.equals("")){
                    mobileString.append(mobile+",");
                }
            }
        }
        StringBuffer mobile1 = new StringBuffer();
        if(!("".equals(mobileString.toString()))){
            mobile1=mobileString.deleteCharAt(mobileString.length()-1);
        }

        //根据手机短信权限筛选出被设置了提醒权限的用户不发送短信
        mobileString = new StringBuffer(checkSmsAuth(mobileString.toString()));
        try {
            List<SmsSettings> list = smsSettingsMapper.selectSmsSettings(map);
            for(SmsSettings smsSettings:list){
                smsSettings.setSign("sign="+smsSettings.getSign());
            }

            //参数extend_5为必填字段  在页面最下面  用来判断字符集编码格式的  为1是UTF-8  0是GBK
            //如果不填写代码接口不报错误 接口是通的但是不会给你短信内容他解析不出来  会以空的形式去发送短信  短信平台不发送空短信
            for(SmsSettings smsSettings:list){
                if ("湖北移动".equals(smsSettings.getName())){
                    String url = smsSettings.getProtocol()+"://"+smsSettings.getHost()+"/"+smsSettings.getPort();
                    SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMddHHmmss");
                    String[] p = smsSettings.getPwd().split("=");
                    String[] sign1 = smsSettings.getSign().split("=");
                    String str1 = p[1]+sdf.format(new Date());
                    String str2 = Md5Util.getMd5String(str1);
                    maps.put("sign",str2);
                    maps.put("timestamp",sdf.format(new Date()));
                    String[] username1 = smsSettings.getUsername().split("=");
                    maps.put("userName",username1[1]);
                    maps.put("phones",mobile1.toString());
                    maps.put("msgContent",contextString.toString());
                    String[] extend1 = smsSettings.getExtend1().split("=");
                    maps.put("serviceCode",extend1[1]);
                    // String[] extend3 = smsSettings.getExtend3().split("=");
                    maps.put("mhtMsgIds",mobile1.toString());
                    maps.put("encoding","utf-8");
                    maps.put("priority","5");
                    String msgResult = HttpSend.sendPost(url,maps);
                    // System.out.println("发送结果为：" + msgResult);
                }else if("云MAS".equals(smsSettings.getName())){
//                    String [] mobileStr = mobileString.toString().split(",");
//                    mobileStr = rebuildArry(mobileStr);
//                    int sendResult = client. sendDSMS (mobileStr, contextString.toString(), "",  5,"Penjmouve", UUID.randomUUID().toString(),true);
                    String [] mobileStr = mobileString.toString().split(",");
                    mobileStr = rebuildArry(mobileStr);
                    String s = org.apache.commons.lang3.StringUtils.join(mobileStr, ",");
                    String res = YunMasUtile.LoginGo(s,contextString.toString(),smsSettings);
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
//                    Boolean isMaslogin = MasLogin(smsSettings);
//                    if(isMaslogin){
//                        String [] mobileStr = mobileString.toString().split(",");
//                        mobileStr = rebuildArry(mobileStr);
//                        int sendResult = client.sendDSMS (mobileStr, contextString.toString(), "",  1,smsSettings.getSign(), UUID.randomUUID().toString(),true);
//                    }
                }else if("lnsf".equals(smsSettings.getName()) && !StringUtils.checkNull(mobileString.toString())){ //岭南OA
                    String [] mobileStr = mobileString.toString().split(",");
                    List<String> mobleList = Arrays.asList(mobileStr);
                    if(!mobleList.isEmpty()){

                        MessageUtil.sendmsg("", contextString.toString(),
                                "ydxy-mobile", new ArrayList(),
                                mobleList, 0, null,smsSettings);
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }
                }else if("东时方".equals(smsSettings.getName())){

                    String ret = "0";
                    String[] mobileStr = mobileString.toString().split(",");
                    List<String> mobleList = Arrays.asList(mobileStr);
                    StringBuilder sb = new StringBuilder();
                    // 分割字符串 70个字符为一组
                    String[] contextStrings = StringUtils.stringToStringArray(contextString.toString(), 55);
                    // 循环发送
                    for (String context : contextStrings) {
                        // 分割电话号码 100个为一组
                        for (int i = 0; i < mobleList.size(); i++) {
                            // 判断是否已经足够100次了 如果够了的话 发送短信 并清空sb
                            if(i!=0&&i%100==0){
                                SendSms(sb.toString(), context, smsSettings);
                                sb = new StringBuilder();
                            }
                            sb.append(mobleList.get(i)).append(",");
                            // 判断是否是最后一次了 如果是的话 发送短信
                            if(i==(mobleList.size()-1)){
                                SendSms(sb.toString(), context, smsSettings);
                                sb = new StringBuilder();
                            }
                        }
                    }

                    toJson.setFlag(0);
                    toJson.setMsg("ok");

                }else if("创瑞".equals(smsSettings.getName())){
                    String [] mobileStr = mobileString.toString().split(",");
                    List<String> mobleList = Arrays.asList(mobileStr);
                    StringBuffer sb = new StringBuffer();
                    for (String list1:mobleList){
                        sb.append(list1).append(",");
                    }
                    String ret = SendSmsCR(sb.toString(), contextString.toString(),smsSettings);
                    if ("1".equals(ret)){
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }
                } else if ("zzqyjt".equals(smsSettings.getName())){
                    SendYjt sendYjt = new SendYjt();
                    String [] mobileStr = mobileString.toString().split(",");
                    List<String> mobileList = Arrays.asList(mobileStr);
                    StringBuffer url = new StringBuffer();
                    url.append(smsSettings.getProtocol()).append("://").append(smsSettings.getHost()).append("/").append(smsSettings.getPort());

                    String ret = null;
                    for (String mobile:mobileList){
                        ret = sendYjt.sendSms(url.toString(),smsSettings.getUsername(),smsSettings.getPwd(),mobile,contextString.toString());
                    }
                    if ("1".equals(ret)){
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }
                } else {
                    String[] mobileStringStr = null;
                    mobileStringStr = rebuildArry(mobileString.toString().split(","));
                    mobileString = new StringBuffer("");
                    for(String s : mobileStringStr){
                        mobileString.append(s).append(",");
                    }
                    if(mobileString.length()>0){
                        mobileString.deleteCharAt(mobileString.length() - 1);
                    }
                    send.doPost(mobileString, contextString, smsSettings.getProtocol(), smsSettings.getHost(), smsSettings.getPort(),
                            smsSettings.getUsername(), smsSettings.getPwd(), smsSettings.getContentField(),
                            smsSettings.getCode(), smsSettings.getMobile(), smsSettings.getTimeContent(), smsSettings.getSign(), smsSettings.getSignValue(), smsSettings.getSignPosition(),
                            smsSettings.getExtend1(), smsSettings.getExtend2(), smsSettings.getExtend3(), smsSettings.getExtend4(), smsSettings.getExtend5(),
                            sms2Priv.getStartTime());
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }
            }
            if (toJson.getMsg().equals("ok")){
                batchAddSms2(contextString.toString(),toJson.getMsg(),mobileString.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return toJson;
    }



    private String SendSmsCR(String mobile, String content, SmsSettings smsSettings) throws UnsupportedEncodingException {
        HttpURLConnection httpconn = null;
        String result="-20";
        String memo = content.trim();
        StringBuilder sb = new StringBuilder();
        sb.append(smsSettings.getProtocol()).append("://").append(smsSettings.getHost()).append("/").append(smsSettings.getPort())
                .append("?");
        //sb.append("http://gateway.woxp.cn:6630/utf8/web_api/?x_eid=");
        sb.append(smsSettings.getUsername());
        sb.append("&").append(smsSettings.getPwd());
        sb.append("&mobile=").append(mobile);
        sb.append("&content=").append(URLEncoder.encode(memo, "utf-8"));
        sb.append("&").append(smsSettings.getSign().split("=")[0]).append("=").append(URLEncoder.encode(smsSettings.getSign().split("=")[1], "utf-8"));//联系短信公司 得到的一个值
        sb.append("&stime=");
        try {
            URL url = new URL(sb.toString());
            httpconn = (HttpURLConnection) url.openConnection();
            httpconn.setRequestMethod("POST");
            InputStream is = url.openStream();
            result = convertStreamToString(is);
            HashMap hashMap = JSON.parseObject(result, HashMap.class);
            if (String.valueOf(hashMap.get("code")).equals("0") && String.valueOf(hashMap.get("msg")).equals("SUCCESS")) {
                result = "1";
            }
            /*BufferedReader rd = new BufferedReader(new InputStreamReader(httpconn.getInputStream()));
            result = rd.readLine();
            rd.close();*/
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally{
            if(httpconn!=null){
                httpconn.disconnect();
                httpconn=null;
            }
        }
        return result;
    }

    public static String convertStreamToString(InputStream is) {
        StringBuilder sb1 = new StringBuilder();
        byte[] bytes = new byte[4096];
        int size = 0;
        try {
            while ((size = is.read(bytes)) > 0) {
                String str = new String(bytes, 0, size, "UTF-8");sb1.append(str);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb1.toString();
    }

    private Integer x_eid=0;
    private String x_uid="username";
    private String x_pwd_md5="md5pass";
    private Integer x_gate_id=300;

    public String SendSms(String mobile,String content, SmsSettings smsSettings) throws UnsupportedEncodingException {

        Integer x_ac=12;//发送信息
        HttpURLConnection httpconn = null;
        String result="-20";
        String[] sign1 = smsSettings.getSign().split("=");
        String memo = sign1[1] + content.trim();
        StringBuilder sb = new StringBuilder();
        sb.append(smsSettings.getProtocol()).append("://").append(smsSettings.getHost()).append("/").append(smsSettings.getPort())
                .append("/?x_eid=");
        //sb.append("http://gateway.woxp.cn:6630/utf8/web_api/?x_eid=");
        sb.append(smsSettings.getExtend2());
        sb.append("&x_uid=").append(smsSettings.getUsername());
        sb.append("&x_pwd_md5=").append(smsSettings.getPwd());
        sb.append("&x_ac=").append(smsSettings.getExtend1());
        sb.append("&x_gate_id=").append(300);//联系短信公司 得到的一个值
        sb.append("&x_target_no=").append(mobile);
        sb.append("&x_memo=").append(URLEncoder.encode(memo, "utf-8"));
        try {
            URL url = new URL(sb.toString());
            httpconn = (HttpURLConnection) url.openConnection();
            BufferedReader rd = new BufferedReader(new InputStreamReader(httpconn.getInputStream()));
            result = rd.readLine();
            rd.close();
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally{
            if(httpconn!=null){
                httpconn.disconnect();
                httpconn=null;
            }

        }
        return result;
    }
    /**
     * 作者 廉立深
     * 日期 2020/10/19
     * 方法介绍  通过手机号发送短信
     * 参数 [contextString:短信内容, mobileArray：要发送的手机号 ，拼接]
     * 返回 java.lang.String
     **/
    @Override
    @Transactional
    public ToJson smsSenderMobiles(StringBuffer contextString,String mobileArray) {
        ToJson toJson = new ToJson(1, "error");
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, String> maps = new HashMap<String, String>();
        // 追加发送时间，可为空，为空为及时发送
        String stime="";
        Sms2Priv sms2Priv = new Sms2Priv();
        sms2Priv.setStartTime(stime);
        if (StringUtils.checkNull(mobileArray)){
            toJson.setMsg("手机号为空");
            return toJson;
        }

        if(",".equals(String.valueOf(mobileArray.charAt(mobileArray.length()-1))) ){
            mobileArray = mobileArray.substring(0,mobileArray.length()-1);
        }

        //根据手机短信权限筛选出被设置了提醒权限的用户不发送短信
        mobileArray = checkSmsAuth(mobileArray);
        try {
            List<SmsSettings> list = smsSettingsMapper.selectSmsSettings(map);
            for(SmsSettings smsSettings:list){
                smsSettings.setSign("sign="+smsSettings.getSign());
            }

            //参数extend_5为必填字段  在页面最下面  用来判断字符集编码格式的  为1是UTF-8  0是GBK
            //如果不填写代码接口不报错误 接口是通的但是不会给你短信内容他解析不出来  会以空的形式去发送短信  短信平台不发送空短信
            for(SmsSettings smsSettings:list){
                if ("湖北移动".equals(smsSettings.getName())){
                    String url = smsSettings.getProtocol()+"://"+smsSettings.getHost()+"/"+smsSettings.getPort();
                    SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMddHHmmss");
                    String[] p = smsSettings.getPwd().split("=");
                    String[] sign1 = smsSettings.getSign().split("=");
                    String str1 = p[1]+sdf.format(new Date());
                    String str2 = Md5Util.getMd5String(str1);
                    maps.put("sign",str2);
                    maps.put("timestamp",sdf.format(new Date()));
                    String[] username1 = smsSettings.getUsername().split("=");
                    maps.put("userName",username1[1]);
                    maps.put("phones",mobileArray);
                    maps.put("msgContent",contextString.toString());
                    String[] extend1 = smsSettings.getExtend1().split("=");
                    maps.put("serviceCode",extend1[1]);
                    maps.put("mhtMsgIds",mobileArray);
                    maps.put("encoding","utf-8");
                    maps.put("priority","5");
                    String msgResult = HttpSend.sendPost(url,maps);
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }else if("云MAS".equals(smsSettings.getName())){
                    String [] mobileStr = mobileArray.split(",");
                    mobileStr = rebuildArry(mobileStr);
                    String s = org.apache.commons.lang3.StringUtils.join(mobileStr, ",");
                    String res = YunMasUtile.LoginGo(s,contextString.toString(),smsSettings);
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }else if("lnsf".equals(smsSettings.getName()) && !StringUtils.checkNull(mobileArray)){ //岭南OA
                    String [] mobileStr = mobileArray.split(",");
                    List<String> mobleList = Arrays.asList(mobileStr);
                    if(!mobleList.isEmpty()){

                        MessageUtil.sendmsg("", contextString.toString(),
                                "ydxy-mobile", new ArrayList(),
                                mobleList, 0, null,smsSettings);
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }
                }else if("东时方".equals(smsSettings.getName())){
                    String[] mobileStr = mobileArray.split(",");
                    List<String> mobleList = Arrays.asList(mobileStr);
                    StringBuilder sb = new StringBuilder();
                    // 分割字符串 70个字符为一组
                    String[] contextStrings = StringUtils.stringToStringArray(contextString.toString(), 55);
                    // 循环发送
                    for (String context : contextStrings) {
                        // 分割电话号码 100个为一组
                        for (int i = 0; i < mobleList.size(); i++) {
                            // 判断是否已经足够100次了 如果够了的话 发送短信 并清空sb
                            if(i!=0&&i%100==0){
                                SendSms(sb.toString(), context, smsSettings);
                                sb = new StringBuilder();
                            }
                            sb.append(mobleList.get(i)).append(",");
                            // 判断是否是最后一次了 如果是的话 发送短信
                            if(i==(mobleList.size()-1)){
                                SendSms(sb.toString(), context, smsSettings);
                                sb = new StringBuilder();
                            }
                        }
                    }

                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }else if("创瑞".equals(smsSettings.getName())){
                    String [] mobileStr = mobileArray.split(",");
                    List<String> mobleList = Arrays.asList(mobileStr);
                    StringBuffer sb = new StringBuffer();
                    for (String list1:mobleList){
                        sb.append(list1).append(",");
                    }
                    String ret = SendSmsCR(sb.toString(), contextString.toString(),smsSettings);
                    if ("0".equals(ret)){
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }
                } else if ("zjqyjt".equals(smsSettings.getName())){
                    SendYjt sendYjt = new SendYjt();
                    String [] mobileStr = mobileArray.split(",");
                    List<String> mobileList = Arrays.asList(mobileStr);
                    StringBuffer url = new StringBuffer();
                    url.append(smsSettings.getProtocol()).append("://").append(smsSettings.getHost()).append("/").append(smsSettings.getPort());

                    String ret = null;
                    for (String mobile:mobileList){
                        ret = sendYjt.sendSms(url.toString(),smsSettings.getUsername(),smsSettings.getPwd(),mobile,contextString.toString());
                    }
                    if ("0".equals(ret)){
                        toJson.setFlag(0);
                        toJson.setMsg("ok");
                    }
                } else if("腾讯短信".equals(smsSettings.getName())){
//                    Credential cred = new Credential(smsSettings.getUsername(), smsSettings.getPwd());
//
//                    HttpProfile httpProfile = new HttpProfile();
//                    httpProfile.setEndpoint(smsSettings.getHost());
//
//                    ClientProfile clientProfile = new ClientProfile(httpProfile.getEndpoint());
//
//                    SmsClient client = new SmsClient(cred, "", clientProfile);
//
//                    SendSmsRequest req = new SendSmsRequest();
//
//                    // 设置字符串类型的模板参数，根据实际情况修改
//                    String[] params = {contextString.toString()};
//
//                    req.setSmsSdkAppid(Long.toString(Long.parseLong(smsSettings.getTimeContent())));
//                    req.setSign(smsSettings.getContentField());
//                    req.setTemplateID(smsSettings.getMobile());
//                    req.setPhoneNumberSet(new String[]{"+86" + mobileArray});
//                    req.setTemplateParamSet(params);
//
//                    SendSmsResponse res = client.SendSms(req);


                    // 设置需要操作的账号信息，包括SecretId、SecretKey等。
                    Credential cred = new Credential(smsSettings.getUsername(), smsSettings.getPwd());

                    String[] params = {contextString.toString()};

                    // 实例化要请求产品(以sms为例)的client对象。
                    HttpProfile httpProfile = new HttpProfile();
                    httpProfile.setEndpoint(smsSettings.getHost());
                    ClientProfile clientProfile = new ClientProfile();
                    clientProfile.setHttpProfile(httpProfile);
                    SmsClient smsClient = new SmsClient(cred, "", clientProfile);

                    // 实例化一个请求对象，并填充请求参数。
                    SendSmsRequest req = new SendSmsRequest();
                    req.setSmsSdkAppid(smsSettings.getMobile());// 短信应用ID。
                    req.setSign(smsSettings.getContentField()); // 签名内容。
                    req.setTemplateID(smsSettings.getSignValue()); // 模板ID。
                    req.setPhoneNumberSet(new String[]{"+86" + mobileArray});
                    req.setTemplateParamSet(params); // 短信模板变量替换内容。

                    // 发起请求，并将返回的结果存储到响应对象中。
                    SendSmsResponse resp = smsClient.SendSms(req);

                    String jsonString = SendSmsResponse.toJsonString(resp);

                    // 将 JSON 字符串转换为 JSONObject 对象
                    JSONObject jsonObject = JSON.parseObject(jsonString);

                    // 从 JSONObject 对象中获取 SendStatusSet 的值
                    JSONArray sendStatusSet = jsonObject.getJSONArray("SendStatusSet");

                    if (sendStatusSet != null && sendStatusSet.size() > 0) {
                        // 获取 SendStatusSet 数组中第一个元素
                        JSONObject sendStatus = sendStatusSet.getJSONObject(0);
                        // 获取 Code 的值
                        String code = sendStatus.getString("Code");
                        // 检查 Code 是否等于 Ok
                        if ("Ok".equals(code)) {
                            toJson.setFlag(0);
                            toJson.setMsg("ok");
                        } else {
                            toJson.setFlag(1);
                            toJson.setMsg(jsonString);
                        }
                    } else {
                        toJson.setFlag(1);
                        toJson.setMsg(jsonString);
                    }

                }
                else {
                    String[] mobileStringStr = null;
                    mobileStringStr = rebuildArry(mobileArray.split(","));
                    StringBuffer mobileString = new StringBuffer("");
                    for(String s : mobileStringStr){
                        mobileString.append(s).append(",");
                    }
                    if(mobileString.length()>0){
                        mobileString.deleteCharAt(mobileString.length() - 1);
                    }
                    send.doPost(mobileString, contextString, smsSettings.getProtocol(), smsSettings.getHost(), smsSettings.getPort(),
                            smsSettings.getUsername(), smsSettings.getPwd(), smsSettings.getContentField(),
                            smsSettings.getCode(), smsSettings.getMobile(), smsSettings.getTimeContent(), smsSettings.getSign(), smsSettings.getSignValue(), smsSettings.getSignPosition(),
                            smsSettings.getExtend1(), smsSettings.getExtend2(), smsSettings.getExtend3(), smsSettings.getExtend4(), smsSettings.getExtend5(),
                            sms2Priv.getStartTime());
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }
            }
            if (toJson.getMsg().equals("ok")){
                batchAddSms2(contextString.toString(),toJson.getMsg(),mobileArray);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

//    /***
//     * 用于选择内部用户发送短信
//     *       发送短信的接口  根据用户ID获取用户的电话号码  发送短信
//     * @param privArray   用戶ID
//     * @param contextString 短信内容
//     * @return
//     */
//    @Override
//    @Transactional
//    public ToJson smsSenderss( StringBuffer contextString,String privArray) {
//        ToJson toJson = new ToJson(1, "error");
//        Map<String, Object> map = new HashMap<String, Object>();
//        Map<String, String> maps = new HashMap<String, String>();
//        // 追加发送时间，可为空，为空为及时发送
//        String stime="";
//        Sms2Priv sms2Priv = new Sms2Priv();
//        sms2Priv.setStartTime(stime);
//        String [] str = privArray.split(",");
//        StringBuffer mobileString=new StringBuffer();
//        for(String uId:str){
//            Users users = usersMapper.findUserByuid(Integer.valueOf(uId));
//            if (users!=null) {
//                String mobile = users.getMobilNo();
//                if(mobile!=null&&!mobile.equals("")){
//                    mobileString.append(mobile+",");
//                }
//            }
//        }
//        StringBuffer mobile1=mobileString.deleteCharAt(mobileString.length()-1);
//        try {
//            List<SmsSettings> list = smsSettingsMapper.selectSmsSettings(map);
//            for(SmsSettings smsSettings:list){
//                smsSettings.setSign("sign="+smsSettings.getSign());
//            }
//            //参数extend_5为必填字段  在页面最下面  用来判断字符集编码格式的  为1是UTF-8  0是GBK
//            //如果不填写代码接口不报错误 接口是通的但是不会给你短信内容他解析不出来  会以空的形式去发送短信  短信平台不发送空短信
//            for(SmsSettings smsSettings:list){
//                String url = smsSettings.getProtocol()+"://"+smsSettings.getHost()+"/"+smsSettings.getPort();
//                SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMddHHmmss");
//                String[] p = smsSettings.getPwd().split("=");
//                String[] sign1 = smsSettings.getSign().split("=");
//                String str1 = p[1]+sdf.format(new Date());
//                String str2 = Md5Util.getMd5String(str1);
//                maps.put("sign",str2);
//                maps.put("timestamp",sdf.format(new Date()));
//                String[] username1 = smsSettings.getUsername().split("=");
//                maps.put("userName",username1[1]);
//                maps.put("phones",mobile1.toString());
//                maps.put("msgContent",contextString.toString());
//                String[] extend1 = smsSettings.getExtend1().split("=");
//                maps.put("serviceCode",extend1[1]);
//               // String[] extend3 = smsSettings.getExtend3().split("=");
//                maps.put("mhtMsgIds",mobile1.toString());
//                maps.put("encoding","utf-8");
//                maps.put("priority","1");
//                HttpSend.sendPost(url,maps);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            toJson.setFlag(1);
//            toJson.setMsg(e.getMessage());
//            e.printStackTrace();
//        }
//        return toJson;
//    }

    @Override
    public String checked(String byName,String overName){
        String message="";
        try {
            //是否有发送权限
            Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();
            if (!StringUtils.checkNull(sms2Priv.getOutPriv())) {
               /* String[] split = sms2Priv.getOutPriv().split(",");
                if (split.length > 0) {*///是否有接受权限
                   /* for (String str : split) {
                        if (str.equals(byName)) {*/
                if(sms2Priv.getOutPriv().contains(byName)) {
                    //是否有被提醒权限
                    /*   String[] split2 = sms2Priv.getRemindPriv().split(",");
                       if (split2.length > 0) {*/
                          /* for (String str2 : split2) {
                               if (str2.equals(overName)) {*/
                    if (sms2Priv.getRemindPriv().contains(overName)) {

                        return message = "发送";
                    }else {
                        return message = "没有被提醒权限";
                    }

                }
            }else {
                return message = "没有发送权限";
            }


            /* }*/
            /*  }*/
            /* return message = "没有发送权限";*/
               /* }

            }*/
        }catch(Exception e){
            e.printStackTrace();
        }
        return message;
    }

    public String[] rebuildArry(String [] arrStr){
        Map<String, Object> map = new HashMap<String, Object>();
        for (String str : arrStr) {
            map.put(str, str);
        }
        //返回一个包含所有对象的指定类型的数组
        String[] newArrStr =  map.keySet().toArray(new String[1]);

        return newArrStr;
    }
    public Boolean MasLogin (SmsSettings smsSettings){
        Boolean flag = false;
        String url = smsSettings.getProtocol() + "://" + smsSettings.getHost() + ":" + smsSettings.getPort();
        String userAccount = smsSettings.getUsername();
        String password = smsSettings.getPwd();
        String ecname = smsSettings.getExtend1();
        flag = Sms2PrivServiceImpl.client.login(url, userAccount, password,ecname);//http://112.35.4.197:15000/app/sdk/login
        Boolean d = Sms2PrivServiceImpl.client.login("http://112.35.4.197:15000", "send1", "s123456","信阳市商务局");
        return flag;
    }


    private void batchAddSms2(String smsContent,String sendFlag,String mobileArray){
        Users users = UserUtil.getUser();
        String[] split = mobileArray.split(",");
        Date date = new Date();
        String flag = "0";
        if("ok".equals(sendFlag)){
            flag = "1";
        }
        for (String phone : split) {
            Sms2 record = new Sms2();
            record.setFromId(users.getUserId());
            record.setContent(smsContent);
            record.setPhone(phone);
            record.setSendFlag(flag);
            record.setSendTime(date);
            sms2Mapper.insertSelective(record);
        }
    }

    //根据手机短信权限筛选出被设置了提醒权限的用户不发送短信
    private String checkSmsAuth(String users){
        Sms2Priv sms2Priv = sms2PrivMapper.selectSms2Priv();

        //去除userIds中设置了被提醒权限的用户
        if(StringUtils.checkNull(sms2Priv.getRemindPriv())){
            return users;
        }

        List<Users> user = usersMapper.selUserByIds(sms2Priv.getRemindPriv().split(","));
        users = "," + users + ",";
        for (Users users1 : user) {
            if(users.contains("," + users1.getUserId() + ",") || users.contains("," + users1.getMobilNo() + ",")){
                users = users.replaceAll(users1.getUserId() + ",","");
                users = users.replaceAll(users1.getMobilNo() + ",","");
            }
        }
        if(users.startsWith(",")){
            users.substring(1);
        }
        return users;
    }
}