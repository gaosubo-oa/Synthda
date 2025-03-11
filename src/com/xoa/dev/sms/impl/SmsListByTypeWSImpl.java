package com.xoa.dev.sms.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.casContrast.dao.Oa2SsoMapper;
import com.xoa.dev.sms.SmsListByTypeWS;
import com.xoa.model.daiban.DaiBanModel;
import com.xoa.model.sms.SmsBodyExtend;
import com.xoa.model.users.Users;
import com.xoa.service.users.UsersService;
import com.xoa.util.DateFormat;
import com.xoa.util.DateFormatUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.util.*;

/**
 * @作者 廉立深
 * @创建日期 12:06 2019/10/23
 * @类介绍 代办事项
 */

@Service
public class SmsListByTypeWSImpl implements SmsListByTypeWS {

    @Autowired
    private UsersService usersService;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private SmsBodyMapper smsBodyMapper;

    @Autowired
    private Oa2SsoMapper oa2SsoMapper;

    private final static int VOTELTEM_ID = 11;
    private final static int EMAIL_ID = 2;
    private final static int NOTIFY_ID = 1;
    private final static int EMAILPLUS_ID = 25;
    private final static int FLOWRUNPRCS_ID = 7;
    private final static int NEWS_ID = 14;
    private final static int DOCTMENT_ID = 70;
    private final static int SUPERVISION_ID = 71;
    private final static int MEETING_ID=72;
    private final static int CALENDAR_ID=5;
    private final static int DIARY_ID=13;
    private final static int PUBLIC_FILE_ID=16;
    private final static int SCHEDULE_ID=23;
    private final static int NETDISK_ID=17;
    private final  static int ZNIBANGUANLI=3;
    private final static int BANGONGSHEN=24;
    private final static int BBSBOARD_ID=19;
    private final static int DISPATCHER=29;
    private final static int THIRD_SYSTEM=200;
    private final static int LEADER_SYSTM=27;
    private final static int PLAN_APPROVAL = 64;
    private final static int ADD_PLANAPPROVAL = 83;//培训计划

    //事务提醒
    @Override
    public String smsListByType(String userId, String type,String selKey) {
        if(StringUtils.checkNull(selKey)||!selKey.equals("xtdoa888")){
            return "密钥不正确";
        }
        String json=null;
        BaseWrapper baseWrapper=new BaseWrapper();
        Users user= usersService.findUsersByuserId(userId);
        if(StringUtils.checkNull(userId)){
            userId=user.getUserId();
        }
        DaiBanModel daiBanModel=new DaiBanModel();
        List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list2 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list3 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list4 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list5 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list6 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list7 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list8 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list9 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list10 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list11 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list12 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list111 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list13 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list14=new ArrayList<>();
        List<SmsBodyExtend> list15=new ArrayList<>();
        List<SmsBodyExtend> list16=new ArrayList<>();
        List<SmsBodyExtend> list17=new ArrayList<>();
        List<SmsBodyExtend> list18=new ArrayList<>();
        List<SmsBodyExtend> list19=new ArrayList<>();
        List<SmsBodyExtend> list20=new ArrayList<>();

        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "1");
            Date date = new Date();
            try {
                String s = DateFormatUtils.formatDate(date);
                Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
                map.put("remindTime", nowDateTime);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsBaseInfoListByType(map);
            Iterator iter = smsBodyExtendList.iterator();


            while (iter.hasNext()) {
                SmsBodyExtend smsBodyExtend = (SmsBodyExtend) iter.next();
                SmsBodyExtend smsBodyExtend1 = smsBodyMapper.selBodyAndUserInfo(smsBodyExtend.getBodyId());
                if(smsBodyExtend1==null)
                    continue;
                if(!Objects.isNull(smsBodyExtend.getRemindUrl())) {
                    if (!smsBodyExtend.getRemindUrl().contains("?")) {
                        smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "?");
                    }
                    smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "&bodyId=" + smsBodyExtend.getBodyId());
                }
                // 设置发送用户信息
                smsBodyExtend.setAvater(smsBodyExtend1.getAvater());
                smsBodyExtend.setUid(smsBodyExtend1.getUid());
                smsBodyExtend.setUserName(smsBodyExtend1.getUserName());
                // 设置body信息
                smsBodyExtend.setFromId(smsBodyExtend1.getFromId());
                smsBodyExtend.setSmsType(smsBodyExtend1.getSmsType());
                smsBodyExtend.setContent(smsBodyExtend1.getContent());
                smsBodyExtend.setSendTime(smsBodyExtend1.getSendTime());
                smsBodyExtend.setRemindUrl(smsBodyExtend1.getRemindUrl());
                smsBodyExtend.setIsAttach(smsBodyExtend1.getIsAttach());

                // 这两行代码不知道是什么意思 from设置为了当前用户的id和name 因为是以前别人写的代码 所以暂时不删除 -张航宁
                smsBodyExtend.setFromUid(user.getUid());
                smsBodyExtend.setFromName(user.getUserName());
                //--------------------
                if (!StringUtils.checkNull(smsBodyExtend.getSmsType())) {
                    switch (Integer.parseInt(smsBodyExtend.getSmsType())) {
                        case EMAIL_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("email");
                            String size1 = smsBodyExtend.getRemindUrl();
                            String[] aStrings = size1.split("\\?");
                            for (int i = 0; i < aStrings.length; i++) {
                                if (aStrings[i].contains("id")) {
                                    String[] s = aStrings[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStrings[i].contains("EMAIL_ID")) {
                                    String[] s =null;
                                    if(aStrings[i].contains("&")){
                                        String[] str = null;
                                        str = aStrings[i].split("&");
                                        if(str[i].contains("=")){
                                            s = str[i].split("=");
                                        }
                                    }else{
                                        s = aStrings[i].split("=");
                                    }
                                    break;
                                }
                            }
                            list.add(smsBodyExtend);
                            break;
                        case EMAILPLUS_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("emailPlus");
                            String size11 = smsBodyExtend.getRemindUrl();
                            String[] aStringss = size11.split("\\?");
                            for (int i = 0; i < aStringss.length; i++) {
                                if (aStringss[i].contains("id")) {
                                    String[] s = aStringss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStringss[i].contains("EMAILPLUS_ID")) {
                                    String[] s = aStringss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list11.add(smsBodyExtend);
                            break;
                        case NOTIFY_ID:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("notify");
                            String size2 = smsBodyExtend.getRemindUrl();
                            String[] aStrings2 = size2.split("\\?");
                            for (int i = 0; i < aStrings2.length; i++) {
                                if (aStrings2[i].contains("notifyId")) {
                                    String[] s = aStrings2[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStrings2[i].contains("NOTIFY_ID")) {
                                    String[] s = aStrings2[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list1.add(smsBodyExtend);

                            break;
                        case FLOWRUNPRCS_ID:
                            break;
                        case NEWS_ID:
                            smsBodyExtend.setImg("/img/workflow/news.png");
                            smsBodyExtend.setType("news");
                            String size3 = smsBodyExtend.getRemindUrl();
                            String[] aStrings3 = size3.split("\\?");
                            for (int i = 0; i < aStrings3.length; i++) {
                                if (aStrings3[i].contains("newsId")) {
                                    String[] s = aStrings3[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list3.add(smsBodyExtend);
                            break;
                        case DOCTMENT_ID:
                            break;
                        case VOTELTEM_ID:
                            smsBodyExtend.setImg("/img/workflow/publish.png");
                            smsBodyExtend.setType("toupiao");
                            String size6 = smsBodyExtend.getRemindUrl();
                            String[] aStrings6 = size6.split("\\?");
                            for (int i = 0; i < aStrings6.length; i++) {
                                if (aStrings6[i].contains("resultId")) {
                                    String[] s = aStrings6[i].split("=");
                                    String[] s1 = s[i].split("&");
                                    smsBodyExtend.setQid(Integer.parseInt(s1[0]));
                                    break;
                                }
                            }
                            list5.add(smsBodyExtend);
                            break;
                        case SUPERVISION_ID:
                            smsBodyExtend.setImg("/img/supervision/remind.png");
                            smsBodyExtend.setType("supervision");
                            list6.add(smsBodyExtend);
                            break;
                        case MEETING_ID:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("meeting");
                            list7.add(smsBodyExtend);
                            break;
                        case CALENDAR_ID:
                            smsBodyExtend.setImg("/img/calendar/remind.png");
                            smsBodyExtend.setType("calendar");
                            list8.add(smsBodyExtend);
                            break;
                        case DIARY_ID:
                            smsBodyExtend.setImg("/img/diary/remind.png");
                            smsBodyExtend.setType("diary");
                            list9.add(smsBodyExtend);
                            break;
                        case PUBLIC_FILE_ID:
                            smsBodyExtend.setImg("/img/file/publicRemind.png");
                            smsBodyExtend.setType("publicFile");
                            list10.add(smsBodyExtend);
                            break;
                        case SCHEDULE_ID:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("schedule");
                            list111.add(smsBodyExtend);
                            break;
                        case NETDISK_ID:
                            smsBodyExtend.setImg("/img/netdisk/remind.png");
                            smsBodyExtend.setType("netdisk");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "&bodyId=" + smsBodyExtend.getBodyId());
                            list12.add(smsBodyExtend);
                            break;
                        case ZNIBANGUANLI:
                            smsBodyExtend.setImg("/img/zhiban2.png");
                            smsBodyExtend.setType("zhibanguanli");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list13.add(smsBodyExtend);
                            break;
                        case BANGONGSHEN:
                            smsBodyExtend.setImg("/img/bangong/bangongyongpinsl_info.png");
                            smsBodyExtend.setType("bangongshen");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list14.add(smsBodyExtend);
                            break;

                        case BBSBOARD_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("bbsBoard");
                            String size111 = smsBodyExtend.getRemindUrl();
                            String[] aStringsss = size111.split("\\?");
                            for (int i = 0; i < aStringsss.length; i++) {
                                if (aStringsss[i].contains("boardId")) {
                                    String[] s = aStringsss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStringsss[i].contains("BOARD_ID")) {
                                    String[] s = aStringsss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list15.add(smsBodyExtend);
                            break;
                        case DISPATCHER:
                            smsBodyExtend.setImg("/img/dispatcher/dispatcher.png");
                            smsBodyExtend.setType("dispatcher");
                            list16.add(smsBodyExtend);
                            break;
                        case THIRD_SYSTEM:
                            smsBodyExtend.setImg("/img/thirdSystem/thirdSystem.png");
                            smsBodyExtend.setType("thirdSystem");
                            list17.add(smsBodyExtend);
                            break;
                        case LEADER_SYSTM:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("leaderSystm");
                            list18.add(smsBodyExtend);
                            break;
                        case PLAN_APPROVAL:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("planApproval");
                            list19.add(smsBodyExtend);
                            break;
                        case ADD_PLANAPPROVAL:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("addPlanApproval");
                            list20.add(smsBodyExtend);
                            break;
                    }
                }
            }
            daiBanModel.setDocumentList(list4);
            daiBanModel.setEmail(list);
            daiBanModel.setNewsList(list3);
            daiBanModel.setEmailPlus(list11);
            daiBanModel.setNotify(list1);
            daiBanModel.setWorkFlow(list2);
            daiBanModel.setToupiao(list5);
            daiBanModel.setSupervisions(list6);
            daiBanModel.setMeeting(list7);
            daiBanModel.setCalendars(list8);
            daiBanModel.setDiarys(list9);
            daiBanModel.setPublicFiles(list10);
            daiBanModel.setSchedules(list111);
//            for (SmsBodyExtend smsBodyExtend:list12) {
//                String[] array = smsBodyExtend.getRemindUrl().split("basePath");
//                String path =array[0]+CheckAll.encryptBasedDes(array[1]);
//                smsBodyExtend.setRemindUrl(path);
//            }
            daiBanModel.setNetDisk(list12);
            daiBanModel.setZhiBan(list13);
            daiBanModel.setBangong(list14);
            daiBanModel.setBbsBoard(list15);
            daiBanModel.setDispatcher(list16);
            daiBanModel.setThirdSystem(list17);
            daiBanModel.setSchedules(list18);
//            daiBanModel.setPlanApproval(list19);
            daiBanModel.setAddPlanApproval(list20);
            baseWrapper.setData(daiBanModel);
        }catch (Exception e){
            baseWrapper.setMsg(e.getMessage());
            baseWrapper.setFlag(false);
            json=JSON.toJSONString(baseWrapper);
            return json;
        }
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        json=JSON.toJSONString(baseWrapper);
        return json;
    }
}
