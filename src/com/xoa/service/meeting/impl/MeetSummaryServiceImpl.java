package com.xoa.service.meeting.impl;

import com.xoa.dao.meet.MeetingAttendConfirmMapper;
import com.xoa.dao.meet.MeetingMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.meet.MeetingAttendConfirm;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.meeting.MeetSummaryService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/31 10:29
 * 类介绍  :   会议纪要展示
 * 构造参数:
 */
@Service
public class MeetSummaryServiceImpl implements MeetSummaryService {

    @Resource
    private MeetingMapper meetingMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private MeetingAttendConfirmMapper meetingAttendConfirmMapper;

    @Override
    public ToJson<MeetingWithBLOBs> getAllInfo(Integer page, Integer pageSize, boolean useFlag,HttpServletRequest request) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        ToJson<MeetingWithBLOBs> json =new ToJson<MeetingWithBLOBs>();
        //设置分页
        Map<String,Object> map =new HashMap<String,Object>();
        PageParams pageParams =new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        map.put("page", pageParams);
        //从session中获取用户信息
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        //获得用户id
        Integer uid = sessionInfo.getUid();
        map.put("userPriv",sessionInfo.getUserPriv());
        map.put("id",uid);
        try {
            List<MeetingWithBLOBs> meetSummary = meetingMapper.getMeetSummary(map);
            if(meetSummary!=null){
            //遍历
            for(MeetingWithBLOBs meetingWithBLOBs:meetSummary){
                //得到会议读者Id
                String readPeopleId = meetingWithBLOBs.getReadPeopleId();
                // 拆分
                if(readPeopleId!="" && readPeopleId!=null){
                String[] split = readPeopleId.split(",");
                StringBuffer sb =new StringBuffer();
                for(String s:split){
                    String usernameById = usersMapper.getUsernameById(s);
                    if(usernameById!=null && usernameById!=""){
                        sb.append(usernameById+",");
                    }
                }

                //给纪要读者附上姓名
                meetingWithBLOBs.setReadPeopleNames(sb.toString());
                }
                //时间处理
                if(!StringUtils.checkNull(meetingWithBLOBs.getStartTime())){
                    meetingWithBLOBs.setStartTime(meetingWithBLOBs.getStartTime().substring(0,meetingWithBLOBs.getStartTime().length()-2));
                }
                if(!StringUtils.checkNull(meetingWithBLOBs.getEndTime())){
                    meetingWithBLOBs.setEndTime(meetingWithBLOBs.getEndTime().substring(0,meetingWithBLOBs.getEndTime().length()-2));
                }
                if(meetingWithBLOBs.getUid()!=null){
                String usernameById = usersMapper.getUsernameById(meetingWithBLOBs.getUid());
                meetingWithBLOBs.setUserName(usernameById);
                }
                if(meetingWithBLOBs.getSummaryAttachmentId()!=null && meetingWithBLOBs.getSummaryAttachmentId()!=""){
                    meetingWithBLOBs.setIsuploadsummary("已上传");
                }else{
                    meetingWithBLOBs.setIsuploadsummary("未上传");
                }

            }
            }
            if (pageParams.getTotal() == null) {
                json.setTotleNum(0);
            } else {
                json.setTotleNum(pageParams.getTotal());
            }
           json.setObj(meetSummary);
           json.setFlag(0);
           json.setMsg("ok");
        } catch (Exception e) {
            json.setObj(null);
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json ;
    }

    @Override
    public ToJson<MeetingWithBLOBs> getMeetSummarydetail(HttpServletRequest request,String sid) {
        ToJson<MeetingWithBLOBs> json =new ToJson<MeetingWithBLOBs>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        try {
            if(sid!=null){
                MeetingWithBLOBs meetingWithBLOBs = meetingMapper.queryMeetingById(sid);

                //会议照片
                if (!StringUtils.checkNull(meetingWithBLOBs.getPhotoId()) && !StringUtils.checkNull(meetingWithBLOBs.getPhotoName())) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingWithBLOBs.getPhotoName(), meetingWithBLOBs.getPhotoId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_SUMMARY_MEET);
                    meetingWithBLOBs.setPhotoList(atts);
                }

                //会议录像
                if (!StringUtils.checkNull(meetingWithBLOBs.getVideoId()) && !StringUtils.checkNull(meetingWithBLOBs.getVideoName())) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingWithBLOBs.getVideoName(), meetingWithBLOBs.getVideoId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_SUMMARY_MEET);
                    meetingWithBLOBs.setVideoList(atts);
                }

                //会议录音
                if (!StringUtils.checkNull(meetingWithBLOBs.getRecordId()) && !StringUtils.checkNull(meetingWithBLOBs.getRecordName())) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingWithBLOBs.getRecordName(), meetingWithBLOBs.getRecordId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_SUMMARY_MEET);
                    meetingWithBLOBs.setRecordList(atts);
                }

                //会议纪要
                if (!StringUtils.checkNull(meetingWithBLOBs.getSummaryAttachmentName()) && !StringUtils.checkNull(meetingWithBLOBs.getSummaryAttachmentId())) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingWithBLOBs.getSummaryAttachmentName(), meetingWithBLOBs.getSummaryAttachmentId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_SUMMARY_MEET);
                    meetingWithBLOBs.setSummaryAttachmentList(atts);
                }

                //相关附件
                if (!StringUtils.checkNull(meetingWithBLOBs.getAttachmentName()) && !StringUtils.checkNull(meetingWithBLOBs.getAttachmentId())) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingWithBLOBs.getAttachmentName(), meetingWithBLOBs.getAttachmentId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_SUMMARY_MEET);
                    meetingWithBLOBs.setAttachmentList(atts);
                }

                //得到会议读者Id
                String readPeopleId = meetingWithBLOBs.getReadPeopleId();
                // 拆分
                if(readPeopleId!="" && readPeopleId!=null){
                    String[] split = readPeopleId.split(",");
                    StringBuffer sb =new StringBuffer();
                    for(String s:split){
                        String usernameById = usersMapper.getUsernameById(s);
                        if(usernameById!=null && usernameById!=""){
                            sb.append(usernameById+",");
                        }
                    }
                    //给纪要读者附上姓名
                    meetingWithBLOBs.setReadPeopleNames(sb.toString());
                }else{
                    meetingWithBLOBs.setReadPeopleId("");
                }
                json.setFlag(0);
                json.setMsg("ok");
                json.setObject(meetingWithBLOBs);
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;

    }

    @Override
    public ToJson<Object> editMeetSummarydetail(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs) {
        if(meetingWithBLOBs.getResendHour()==null){
            meetingWithBLOBs.setResendHour(0);
        }
        if(meetingWithBLOBs.getResendMinute()==null){
            meetingWithBLOBs.setResendMinute(0);
        }
        if(meetingWithBLOBs.getResendSeveral()==null){
            meetingWithBLOBs.setResendSeveral(0);
        }
        if(meetingWithBLOBs.getStatus()==null){
            meetingWithBLOBs.setStatus(0);
        }
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            int i = meetingMapper.updateMettingById(meetingWithBLOBs);
            if(i>0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> addSign(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingAttendConfirm.setCreateTime(sdf.format(date));
            meetingAttendConfirm.setConfirmTime(sdf.format(date));
            meetingAttendConfirm.setReadingTime(sdf.format(date));
            Map map = new HashMap();
            map.put("meetingId", meetingAttendConfirm.getMeetingId());
            map.put("attendeeId", user.getUid());
            MeetingAttendConfirm meetingAttendConfirm1 = meetingAttendConfirmMapper.queryMyAttend(map);
            if (null != meetingAttendConfirm1){
                meetingAttendConfirm.setCreateUser(user.getUid());
                meetingAttendConfirm.setAttendeeId(user.getUid());
                meetingAttendConfirmMapper.updateByPrimaryKeySelective(meetingAttendConfirm);
            }else {
                meetingAttendConfirm.setCreateUser(user.getUid());
                meetingAttendConfirm.setAttendeeId(user.getUid());
                meetingAttendConfirmMapper.insertSelective(meetingAttendConfirm);
            }
            if (!StringUtils.checkNull(meetingAttendConfirm.getCreateTime())) {
                meetingAttendConfirm.setCreateTime(meetingAttendConfirm.getCreateTime().substring(0, meetingAttendConfirm.getCreateTime().length() - 2));
            }
            if (!StringUtils.checkNull(meetingAttendConfirm.getReadingTime())) {
                meetingAttendConfirm.setReadingTime(meetingAttendConfirm.getReadingTime().substring(0, meetingAttendConfirm.getReadingTime().length() - 2));
            }
            if (!StringUtils.checkNull(meetingAttendConfirm.getConfirmTime())) {
                meetingAttendConfirm.setConfirmTime(meetingAttendConfirm.getConfirmTime().substring(0, meetingAttendConfirm.getConfirmTime().length() - 2));
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> meetNotes(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingAttendConfirm.setCreateTime(sdf.format(date));
            meetingAttendConfirm.setConfirmTime(sdf.format(date));
            meetingAttendConfirm.setReadingTime(sdf.format(date));
            Map map = new HashMap();
            map.put("meetingId", meetingAttendConfirm.getMeetingId());
            map.put("attendeeId", user.getUid());
            MeetingAttendConfirm meetingAttendConfirm1 = meetingAttendConfirmMapper.queryMyAttend(map);
            if (null != meetingAttendConfirm1){
                json.setData(meetingAttendConfirm1);
            }else {
                meetingAttendConfirm.setCreateUser(user.getUid());
                meetingAttendConfirm.setAttendeeId(user.getUid());
                meetingAttendConfirmMapper.insertSelective(meetingAttendConfirm);
                json.setData(meetingAttendConfirm);
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> updateMeetNotes(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingAttendConfirm.setCreateTime(sdf.format(date));
            meetingAttendConfirm.setConfirmTime(sdf.format(date));
            meetingAttendConfirm.setReadingTime(sdf.format(date));
            meetingAttendConfirmMapper.updateByPrimaryKeySelective(meetingAttendConfirm);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }
}
