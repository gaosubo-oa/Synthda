package com.xoa.service.affair;

import com.xoa.dao.affair.AffairMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.securityApproval.SecurityContentApprovalMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.affair.AffairWithBLOBs;
import com.xoa.model.calender.Calendar;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.securityApproval.SecurityContentApproval;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @author 左春晖
 * @date 2018/6/4 15:44
 * @desc 周期性事务的增删改差实现
 */
@Service
public class AffairServiceImpl {

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private AffairMapper affairMapper;

    @Resource
    SmsService smsService;

    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    SysCodeMapper sysCodeMapper;

    @Resource
    SecurityContentApprovalService securityContentApprovalService;
    @Resource
    SysParaMapper sysParaMapper;
    @Resource
    SecurityContentApprovalMapper securityContentApprovalMapper;


    /**
     * 添加周期事务
     *
     * @return
     */
    public ToJson insertAffair(HttpServletRequest request, AffairWithBLOBs affairWithBLOBs, String smsRemind) {
        ToJson json = new ToJson();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        try {
            affairWithBLOBs.setAllday(1);
            // 转换时间
            affairWithBLOBs.setBeginTime(DateFormat.getDateTime(affairWithBLOBs.getBeginTimes()));
            if(!StringUtils.checkNull(affairWithBLOBs.getEndTimes())){
                affairWithBLOBs.setEndTime(DateFormat.getDateTime(affairWithBLOBs.getEndTimes()));
            }else{
                affairWithBLOBs.setEndTime(0);
            }
            // 设置创建用户
            affairWithBLOBs.setUserId(user.getUserId());
            // 设置创建时间
            affairWithBLOBs.setAddTime(new Date());
            if(StringUtils.checkNull(affairWithBLOBs.getTaker())){
                affairWithBLOBs.setTaker("");
            }
            if (StringUtils.checkNull(affairWithBLOBs.getSms2Remind())){
                affairWithBLOBs.setSms2Remind("");
            }
            if (StringUtils.checkNull(affairWithBLOBs.getCalType())){
                affairWithBLOBs.setCalType("");
            }
            if (StringUtils.checkNull(affairWithBLOBs.getManagerId())){
                affairWithBLOBs.setManagerId("");
            }
            int temp = affairMapper.insertSelective(affairWithBLOBs);
            // 判断是否开启 系统参数：模块数据显示密级字段
            SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())&&affairWithBLOBs.getTaker()!=null&&!"".equals(affairWithBLOBs.getTaker())) {
                // 新增内容安全审核数据
                securityContentApprovalService.insert("affair", String.valueOf(affairWithBLOBs.getAffId()), "日程安排-周期性事务", affairWithBLOBs.getContent(),
                        "", "0", affairWithBLOBs.getContentSecrecy(), request);
            }
            if (temp > 0) {
                json.setFlag(0);
                json.setMsg("success");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("false");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 修改周期事务
     */
    public ToJson updateAffair(HttpServletRequest request, AffairWithBLOBs affairWithBLOBs, String smsRemind) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson json = new ToJson();
        if (!StringUtils.checkNull(affairWithBLOBs.getBeginTimes())) {
            affairWithBLOBs.setBeginTime(DateFormat.getDateTime(affairWithBLOBs.getBeginTimes()));
        }
        if (!StringUtils.checkNull(affairWithBLOBs.getEndTimes())) {
            affairWithBLOBs.setEndTime(DateFormat.getDateTime(affairWithBLOBs.getEndTimes()));
        }else{
            affairWithBLOBs.setEndTime(0);
        }
        int temp = affairMapper.updateAffair(affairWithBLOBs);
        SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
        if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
            // 修改内容安全审核数据
            SecurityContentApproval securityContentApproval = securityContentApprovalMapper.selectByModuleTableAndRecordId("affair", String.valueOf(affairWithBLOBs.getAffId()));
            if(securityContentApproval!=null){
                if(affairWithBLOBs.getContent()!=null){
                    securityContentApproval.setDataSubject(affairWithBLOBs.getContent());// 数据标题
                }
                securityContentApproval.setOperationUserId(user.getUserId());// 操作人USER_ID
                securityContentApproval.setOperationTime(new Date());// 操作时间
                securityContentApproval.setOperationType("1");// 操作类型:0新建，1编辑，2删除
                if(affairWithBLOBs.getContentSecrecy()!=null){
                    securityContentApproval.setContentSecrecy(affairWithBLOBs.getContentSecrecy());// 密级：系统代码
                }
                securityContentApprovalService.update(request, securityContentApproval);
            }
        }
        if (temp > 0) {
            json.setFlag(0);
            json.setMsg("success");
        }
        return json;
    }

    /**
     * 刪除周期性事務
     */
    public ToJson delete(HttpServletRequest request, Integer affId) {
        ToJson json = new ToJson();
        int temp = affairMapper.deleteByPrimaryKey(affId);
        if (temp > 0) {
            json.setFlag(0);
            json.setMsg("success");
        } else {
            json.setFlag(1);
            json.setMsg("false");
        }
        return json;
    }

    /**
     * 查詢周期性事務
     */
    @SuppressWarnings("all")
    public ToJson<AffairWithBLOBs> select(HttpServletRequest request, AffairWithBLOBs affairWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<AffairWithBLOBs> json = new ToJson<>();
        Map<String, Object> map = new HashMap<String, Object>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);

        String userPrivOther = user.getUserPrivOther();
        String userOherPriv = null;
        if (userPrivOther != null) {
            if (userPrivOther.contains(",")) {
                String[] userOherPrivs = userPrivOther.split(",");
                for (String a : userOherPrivs) {
                    if ("1".equals(a)) {
                        userOherPriv = "1";
                        break;
                    }
                }
            } else {
                userOherPriv = userPrivOther;
            }
        }
        boolean isManager = false;
//        管理员，辅助角色为管理员 可以查看全部
        if (user.getUserPriv() == 1 || "1".equals(userOherPriv)) {
            isManager = true;
        } else {
            map.put("userId", user.getUserId());
            map.put("taker", user.getUserId());
        }

        if (affairWithBLOBs.getAffId() != null) {
            map.put("affId", affairWithBLOBs.getAffId());
        }

        if (!StringUtils.checkNull(affairWithBLOBs.getBeginTimes())) {
            int beginTime1 = DateFormat.getDateTime(affairWithBLOBs.getBeginTimes());

            map.put("beginTime",beginTime1);
        }

        if (!StringUtils.checkNull(affairWithBLOBs.getEndTimes())) {
            int endTime1 = DateFormat.getDateTime(affairWithBLOBs.getEndTimes());
            map.put("endTime", endTime1);
        }

        if (!StringUtils.checkNull(affairWithBLOBs.getContent())) {
            map.put("content", affairWithBLOBs.getContent());
        }

        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        map.put("page", pageParams);
        SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
        if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
            map.put("isShowSecret", true);
            map.put("scaOperationUserId", user.getUserId());
            map.put("securityRestriction",securityContentApprovalService.securityRestriction());
        }
        List<AffairWithBLOBs> list = affairMapper.selectAll(map);


        for (AffairWithBLOBs withBLOBs : list) {
            if ("1".equals(isShowSecret.getParaValue())) {
                if (withBLOBs.getContentSecrecy() != null) {
                    SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", withBLOBs.getContentSecrecy());
                    if (sysCode != null) {
                        withBLOBs.setContentSecrecy("【" + sysCode.getCodeName() + "】");
                    }
                }
            }else {
                withBLOBs.setContentSecrecy("");
            }
            withBLOBs.setBeginTimes(DateFormat.getDateStrTime(withBLOBs.getBeginTime()));
            if(!withBLOBs.getEndTime().equals(0)){
                withBLOBs.setEndTimes(DateFormat.getDateStrTime(withBLOBs.getEndTime()));
            }else{
                withBLOBs.setEndTimes("");
            }
            if (isManager) {
                withBLOBs.setManagerStatus(true);
            } else if (withBLOBs.getUserId().equals(user.getUserId())) {
                withBLOBs.setManagerStatus(true);
            } else {
                withBLOBs.setManagerStatus(false);
            }
            //用户名
            if (!StringUtils.checkNull(withBLOBs.getUserId())) {
                String[] userId = withBLOBs.getUserId().split(",");
                StringBuffer takeName = new StringBuffer();
                for (int i = 0; i < userId.length; i++) {
                    if (!StringUtils.checkNull(userId[i])) {
                        String userName = usersMapper.getUsernameByUserId(userId[i]);
                        takeName.append(userName).append(",");
                    }
                }
                withBLOBs.setUserName(takeName.toString());
            }
        }

        //处理  参与人和所属者  姓名
        if (list.size() > 0) {
            for (AffairWithBLOBs aff : list) {
                if (!StringUtils.checkNull(aff.getTaker())) {
                    String[] takerArr = aff.getTaker().split(",");
                    StringBuffer takeName = new StringBuffer();
                    for (int i = 0; i < takerArr.length; i++) {
                        if (!StringUtils.checkNull(takerArr[i])) {
                            String userName = usersMapper.getUsernameByUserId(takerArr[i]);
                            takeName.append(userName).append(",");
                        }
                    }
                    aff.setTakerName(takeName.toString());
                }
                if (!StringUtils.checkNull(aff.getOwner())) {
                    String[] owerArr = aff.getOwner().split(",");
                    StringBuffer owerName = new StringBuffer();
                    for (int i = 0; i < owerArr.length; i++) {
                        if (!StringUtils.checkNull(owerArr[i])) {
                            String userName = usersMapper.getUsernameByUserId(owerArr[i]);
                            owerName.append(userName).append(",");
                        }
                    }
                    aff.setOwnerName(owerName.toString());
                }
            }
        }

        json.setMsg("OK");
        json.setObj(list);
        json.setTotleNum(pageParams.getTotal());
        json.setFlag(0);
        return json;
    }

    /**
     * 左春晖
     * 2018-6-11
     * 按类型显示
     */
//    public ToJson<Affair> selectType( String beginTime,String endTime ,String content,String type,String calType){
//        ToJson<Affair> json = new ToJson<>();
//        try {
//            Map<String,Object> map = new HashMap<>();
//
//            if (beginTime!=null){
//                int beginTime1 = DateFormat.getDateTime(beginTime);
//                map.put("beginTime",beginTime1);}
//
//            if (endTime!=null){
//                int endTime1 = DateFormat.getDateTime(endTime);
//                map.put("endTime",endTime1);}
//
//            if (content!=null){
//                map.put("content",content);
//            }
//            List<Affair> list = affairMapper.selectAll(map);
//            for (int i = 0; i<list.size();i++){
//                list.get(i).setBeginTimes(DateFormat.getDateStrTime(list.get(i).getBeginTime()));
//                list.get(i).setEndTimes(DateFormat.getDateStrTime(list.get(i).getEndTime())) ;
//            }
//
//            json.setMsg("OK");
//            json.setFlag(0);
//            json.setObj(list);
//        }catch (Exception e){
//            e.printStackTrace();
//            json.setFlag(1);
//            json.setMsg("false");
//        }
//        return json;
//    }

    /**
     * 日程安排 添加事务提醒
     *
     * @param calendar
     * @param request
     */
    @Async
    @SuppressWarnings("all")
    public void addAffairs(final Calendar calendar, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        final Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(calendar.getUserId());
                smsBody.setContent(" 日程安排通知！主题：" + calendar.getContent());
                smsBody.setSendTime(calendar.getCalTime());
                SysCode sysCode = new SysCode();
                sysCode.setCodeName("日程安排");
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                String toUserId = "";
                if (!StringUtils.checkNull(calendar.getOwner())) {
                    toUserId = calendar.getOwner();
                }
                if (!StringUtils.checkNull(calendar.getTaker())) {
                    toUserId += calendar.getTaker();
                }
                toUserId = StringUtils.getRemoveStr(toUserId);
                smsBody.setRemindUrl("/schedule/index?id=" + calendar.getCalId());
                String title = users.getUserName() + "：日程安排提醒！";
                String context = "主题:" + calendar.getContent();
                smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
            }
        });

    }

}
