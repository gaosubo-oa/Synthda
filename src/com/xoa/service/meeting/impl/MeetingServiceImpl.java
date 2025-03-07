package com.xoa.service.meeting.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.meet.MeetingAttendConfirmMapper;
import com.xoa.dao.meet.MeetingMapper;
import com.xoa.dao.meet.MeetingRoomMapper;
import com.xoa.dao.meet.VideoConfMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.calender.Calendar;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.meet.*;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.model.users.Users;
import com.xoa.service.calendar.CalendarService;
import com.xoa.service.meeting.MeetEquuipmentService;
import com.xoa.service.meeting.MeetRoomService;
import com.xoa.service.meeting.MeetingService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.http.HttpUtils;
import com.xoa.util.http.SSLClient;
import com.xoa.util.page.PageParams;
import net.sf.json.JSONObject;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.*;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/26 18:28
 * 类介绍  :
 * 构造参数:
 */
@Service
public class MeetingServiceImpl implements MeetingService {

    @Resource
    private MeetingMapper meetingMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private MeetingRoomMapper meetingRoomMapper;

    @Resource
    private MeetingAttendConfirmMapper meetingAttendConfirmMapper;

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private UserPrivMapper userPrivMapper;

    @Resource
    private CalendarService calendarService;

    @Resource
    private SmsService smsService;

    @Resource
    private Sms2PrivService sms2PrivService;

    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private SmsMapper smsMapper;

    @Resource
    private SysParaService sysParaService;

    @Autowired
    private VideoConfMapper videoConfMapper;

    @Autowired
    private UsersService usersService;

    @Resource
    private MeetRoomService meetRoomService;

    @Resource
    private MeetEquuipmentService meetEquuipmentService;

    @Resource
    private SysParaMapper sysParaMapper;

    //视频会议类型
    private static final String CONF_TYPE2 = "2";

    //服务地址
    public static String videourl(VideoConf videoConf) {
        if (videoConf != null && CONF_TYPE2.equals(videoConf.getConfType()) && !StringUtils.checkNull(videoConf.getServer()) ) {
            return "http://" + videoConf.getServer() + "/le.req";
        }
        return "";
    }
    //业务层分页 yyl
    public List getPageList(Integer page, Integer limit, List list) {
        if(page!=null&&limit!=null&&page>0&&limit>0){
            List list1 = new ArrayList();
            if (page == 1 && list.size() <= limit) {
                return list;
            } else if (page == 1 && list.size() > limit) {
                for (int i = 0; i < limit; i++) {
                    list1.add(list.get(i));
                }
                return list1;

            } else if (page > 1) {
                if (list.size() / limit >= page) {
                    for (int i = 0; i < limit; i++) {
                        list1.add(list.get(limit * (page - 1) + i));

                    }
                    return list1;
                } else {
                    for (int i = 0; i < list.size()%limit; i++) {
                        list1.add(list.get(limit * (page - 1) + i));
                    }
                }
                return list1;

            } else {
                return null;
            }
        }else{
            return list;
        }
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:54:00
     * 方法介绍:  根据条件进行查询会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    @Override
    public ToJson<MeetingWithBLOBs> queryMeeting(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag, String nowDate) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {

            Map<String, Object> map = new HashMap<String, Object>();
            //分页
         /*   PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(10);
            pageParams.setUseFlag(useFlag);
            map.put("pageParams", pageParams);*/

            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            if (meetingWithBLOBs.getStatus() != null) {
                if (meetingWithBLOBs.getStatus() == 3 || meetingWithBLOBs.getStatus() == 5) {
                    meetingWithBLOBs.setCurrentTime(DateFormat.getStrDate(date));
                }
            } else {
                if (!StringUtils.checkNull(nowDate)) {
                    meetingWithBLOBs.setStartTime(DateFormat.getMonthStart(Integer.parseInt(nowDate.substring(0, 4)), Integer.parseInt(nowDate.substring(5, 7))));
                    meetingWithBLOBs.setEndTime(DateFormat.getMonthEnd(Integer.parseInt(nowDate.substring(0, 4)), Integer.parseInt(nowDate.substring(5, 7))));
                }
            }

            //查询会议室
            Map<String,Object> maps =new HashMap<String,Object>();
            maps.put("uid",user.getUid());
            maps.put("deptId",user.getDeptId());
            List<MeetingRoomWithBLOBs> someMeetRoom = meetingRoomMapper.getSomeMeetRoom(maps);
            StringBuffer str=new StringBuffer();
            for (MeetingRoomWithBLOBs meetingRoom:someMeetRoom) {
                str.append(meetingRoom.getSid()).append(",");
            }

            //获取url信息,这里只差ID等于1，如果不等于1就不进行请求访问提高查询速度
            String videourl = "";
            String userpost = "";
            VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
            if ( videoConf != null ){
                videourl = videourl(videoConf);
                //视频会议获取登录认证
                userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");
            }

            //登陆人有使用哪些会议室的权限。只显示出有权限会议室的会议
            map.put("meetingRoom",StringUtils.checkNull(str.toString()) ? null: str.toString().split(","));
            map.put("meetingWithBLOBs", meetingWithBLOBs);
            List<MeetingWithBLOBs> meetingList = meetingMapper.queryMeetingByRoomIds(map);
            for (MeetingWithBLOBs meeting : meetingList) {

                if (meeting.getUid() != null) {
                    meeting.setUserName(usersMapper.getUsernameById(meeting.getUid()));
                }

                if (meeting.getManagerId() != null) {
                    meeting.setManagerName(usersMapper.getUsernameById(meeting.getManagerId()));
                }

                if (meeting.getMeetRoomId() != null && !meeting.getMeetRoomId().equals(0)) {
                    meeting.setMeetRoomName( meetingRoomMapper.getRoomName(meeting.getMeetRoomId()) );
                } else if (meeting.getMeetRoomId().equals(0)) {
                    meeting.setMeetRoomName("视频会议");
                }

                if (videoConf != null && !StringUtils.checkNull(meeting.getVideoConfFlag()) && meeting.getVideoConfFlag().equals("1")) {
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meeting.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meeting, user, PostprepareLoginConf);
                    }
                }

                //设置会议的状态
                if (meeting.getStatus() != null) {
                    switch (meeting.getStatus()) {
                        case 0:
                            meeting.setStatusName("待审批");
                            break;
                        case 1:
                            meeting.setStatusName("待审批");
                            break;
                        case 2:
                            meeting.setStatusName("已审批");
                            meeting.setStatus(2);
                            break;
                        case 3:
                            meeting.setStatusName("进行中");
                            break;
                        case 4:
                            meeting.setStatusName("未批准");
                            break;
                        case 5:
                            meeting.setStatusName("已结束");
                            break;
                    }
                }

                if (!StringUtils.checkNull(meeting.getStartTime())) {
                    meeting.setStartTime(meeting.getStartTime().substring(0, meeting.getStartTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getEndTime())) {
                    meeting.setEndTime(meeting.getEndTime().substring(0, meeting.getEndTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getCreateTime())) {
                    meeting.setCreateTime(meeting.getCreateTime().substring(0, meeting.getCreateTime().length() - 2));
                }


            }

            json.setObj(getPageList(page,pageSize,meetingList));
            json.setTotleNum(meetingList.size());
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryMeeting:" + e);
        }
        return json;
    }


    //会议查询
    @Override
    public ToJson<MeetingWithBLOBs> meetingQuery(HttpServletRequest request, HttpServletResponse response, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag, String nowDate, boolean export) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            Map<String, Object> map = new HashMap<String, Object>();

            //分页
            Integer type = meetingWithBLOBs.getStatus();
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page", pageParams);

            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long currentTime = Long.valueOf(DateFormat.getTime(sdf.format(date)));
            List<MeetingWithBLOBs> meetingList = new ArrayList<MeetingWithBLOBs>();
            if (meetingWithBLOBs.getStatus() != null) {
                if (meetingWithBLOBs.getStatus() == 3 || meetingWithBLOBs.getStatus() == 5) {
                    meetingWithBLOBs.setCurrentTime(sdf.format(date));
                }
            } else {
                if (!StringUtils.checkNull(nowDate)) {
                    meetingWithBLOBs.setStartTime(DateFormat.getMonthStart(Integer.parseInt(nowDate.substring(0, 4)), Integer.parseInt(nowDate.substring(5, 7))));
                    meetingWithBLOBs.setEndTime(DateFormat.getMonthEnd(Integer.parseInt(nowDate.substring(0, 4)), Integer.parseInt(nowDate.substring(5, 7))));
                }
            }
            meetingWithBLOBs.setUserPriv(user.getUserPriv());//人员角色  管理原查看所有
            if (meetingWithBLOBs.getUserPriv().equals(1)){
                map.put("meetingWithBLOBs", meetingWithBLOBs);
                meetingList = meetingMapper.meetingQuery(map);
            }else {
                meetingWithBLOBs.setUid(user.getUid()); //申请人
                map.put("meetingWithBLOBs", meetingWithBLOBs);
                meetingList = meetingMapper.meetingQuery(map);
            }

            //获取url信息
            VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
            String videourl = videourl(videoConf);
            //视频会议获取登录认证
            String userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");


            for (MeetingWithBLOBs meeting : meetingList) {
                if (Optional.ofNullable(meeting.getUid()).isPresent()) {
                    meeting.setUserName(usersMapper.getUsernameById(meeting.getUid()));
                }
                if (Optional.ofNullable(meeting.getManagerId()).isPresent()) {
                    meeting.setManagerName(usersMapper.getUsernameById(meeting.getManagerId()));
                }
                if (Optional.ofNullable(meeting.getMeetRoomId()).isPresent() && !(meeting.getMeetRoomId()==0)) {
                    MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(meeting.getMeetRoomId());
                    meeting.setMeetRoomName(meetRoomBySid == null ? "" : meetRoomBySid.getMrName());
                } else if (Optional.ofNullable(meeting.getMeetRoomId()).orElse(0)==0){
                    meeting.setMeetRoomName("视频会议");
                }

                if (!StringUtils.checkNull(meeting.getVideoConfFlag()) && meeting.getVideoConfFlag().equals("1")) {
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meeting.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meeting, user, PostprepareLoginConf);
                    }
                }

                //设置会议的状态
                if (Optional.ofNullable(meeting.getStatus()).isPresent()) {
                    switch (meeting.getStatus()) {
                        case 0:
                            meeting.setStatusName("待审批");
                            break;
                        case 1:
                            meeting.setStatusName("待审批");
                            break;
                        case 2:
                            meeting.setStatusName("已审批");
                            meeting.setStatus(2);
                            break;
                        case 3:
                            //更新状态  进行中的如果结束  设置为结束
                            meeting.setStatusName("进行中");
                            break;
                        case 4:
                            meeting.setStatusName("未批准");
                            break;
                        case 5:
                            meeting.setStatusName("已结束");
                            break;
                    }
                }
                //}
                if (!StringUtils.checkNull(meeting.getStartTime())) {
                    meeting.setStartTime(meeting.getStartTime().substring(0, meeting.getStartTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getEndTime())) {
                    meeting.setEndTime(meeting.getEndTime().substring(0, meeting.getEndTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getCreateTime())) {
                    meeting.setCreateTime(meeting.getCreateTime().substring(0, meeting.getCreateTime().length() - 2));
                }
            }

            json.setObj(meetingList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
            if (meetingWithBLOBs.getStatus() != null) {
                if (type == 2) {
                    json.setTotleNum(meetingList.size());
                } else {
                    if (pageParams.getTotal() == null) {
                        json.setTotleNum(0);
                    } else {
                        json.setTotleNum(pageParams.getTotal());
                    }
                }
            }

            //判断是否需要导出
            if (export) {
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("会议查询导出", 6);
                String[] secondTitles = {"会议名称", "申请人", "开始时间", "结束时间", "会议状态", "会议室"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"meetName", "userName", "startTime", "endTime", "statusName", "meetRoomName"};
                HSSFWorkbook workbook = null;
                workbook = ExcelUtil.exportExcelData(workbook2, meetingList, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "会议查询导出表.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryMeeting:" + e);
        }
        return json;
    }

    //会议管理
    @Override
    public ToJson<MeetingWithBLOBs> meetingManage(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag, String nowDate) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            Map<String, Object> map = new HashMap<String, Object>();

            //分页
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page", pageParams);

            //获取当前时间的时间戳，判断当前会议是否正在进行
            if (meetingWithBLOBs.getStatus() != null) {
                if (meetingWithBLOBs.getStatus() == 3 || meetingWithBLOBs.getStatus() == 5) {
                    meetingWithBLOBs.setCurrentTime(DateFormat.getStrDate(new Date()));
                }
            } else {
                if (!StringUtils.checkNull(nowDate)) {
                    meetingWithBLOBs.setStartTime(DateFormat.getMonthStart(Integer.parseInt(nowDate.substring(0, 4)), Integer.parseInt(nowDate.substring(5, 7))));
                    meetingWithBLOBs.setEndTime(DateFormat.getMonthEnd(Integer.parseInt(nowDate.substring(0, 4)), Integer.parseInt(nowDate.substring(5, 7))));
                }
            }

//            meetingWithBLOBs.setUid(user.getUid()); //申请人
            meetingWithBLOBs.setUserPriv(user.getUserPriv());//人员角色  管理原查看所有

            map.put("meetingWithBLOBs", meetingWithBLOBs);

            //获取url信息
            String videourl = "";
            String userpost = "";
            VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
            if (videoConf != null){
                videourl = videourl(videoConf);
                //视频会议获取登录认证
                userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");
            }


            List<MeetingWithBLOBs> meetingList = meetingMapper.meetingManage(map);
            for (MeetingWithBLOBs meeting : meetingList) {

                if (meeting.getUid() != null) {
                    meeting.setUserName(usersMapper.getUsernameById(meeting.getUid()));
                }

                if (meeting.getManagerId() != null) {
                    meeting.setManagerName(usersMapper.getUsernameById(meeting.getManagerId()));
                }

                if (meeting.getMeetRoomId() != null && !meeting.getMeetRoomId().equals(0)) {
                    meeting.setMeetRoomName( meetingRoomMapper.getRoomName(meeting.getMeetRoomId()) );
                }
                else if (meeting.getMeetRoomId() != null &&meeting.getMeetRoomId().equals(0)) {
                    meeting.setMeetRoomName("视频会议");
                }

                //放入视频会议信息
                if (videoConf != null && !StringUtils.checkNull(meeting.getVideoConfFlag()) && meeting.getVideoConfFlag().equals("1")) {
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meeting.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meeting, user, PostprepareLoginConf);
                    }
                }


                //设置会议的状态
                if (meeting.getStatus() != null) {
                    switch (meeting.getStatus()) {
                        case 0:
                            meeting.setStatusName("待审批");
                            break;
                        case 1:
                            meeting.setStatusName("待审批");
                            break;
                        case 2:
                            meeting.setStatusName("已审批");
                            meeting.setStatus(2);
                            break;
                        case 3:
                            meeting.setStatusName("进行中");
                            break;
                        case 4:
                            meeting.setStatusName("未批准");
                            break;
                        case 5:
                            meeting.setStatusName("已结束");
                            break;
                    }
                }

                if (!StringUtils.checkNull(meeting.getStartTime())) {
                    meeting.setStartTime(meeting.getStartTime().substring(0, meeting.getStartTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getEndTime())) {
                    meeting.setEndTime(meeting.getEndTime().substring(0, meeting.getEndTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getCreateTime())) {
                    meeting.setCreateTime(meeting.getCreateTime().substring(0, meeting.getCreateTime().length() - 2));
                }


            }
            json.setObj(meetingList);
            json.setFlag(0);
            json.setMsg("ok");
            json.setTotleNum(pageParams.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryMeeting:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:58:00
     * 方法介绍:  我的会议
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    @Override
    public ToJson<MeetingWithBLOBs> getMyMeeting(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            //分页
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);

            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            meetingWithBLOBs.setUid(user.getUid());
            map.put("meetingWithBLOBs", meetingWithBLOBs);
            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long currentTime = Long.valueOf(DateFormat.getTime(sdf.format(date)));
            List<MeetingWithBLOBs> meetingList = meetingMapper.getMyMeeting(map);

            //获取url信息
            VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
            String videourl = videourl(videoConf);
            //视频会议获取登录认证
            String userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");


            for (MeetingWithBLOBs meeting : meetingList) {
                if (meeting.getUid() != null) {
                    meeting.setUserName(usersMapper.getUsernameById(meeting.getUid()));
                }


                if (meeting.getMeetRoomId() != null && !meeting.getMeetRoomId().equals(0)) {
                    MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(meeting.getMeetRoomId());
                    meeting.setMeetRoomName(meetRoomBySid == null ? "" : meetRoomBySid.getMrName());
                } else if (new Integer(0).equals(meeting.getMeetRoomId())) {
                    meeting.setMeetRoomName("视频会议");
                }

                if (!StringUtils.checkNull(meeting.getVideoConfFlag()) && meeting.getVideoConfFlag().equals("1")) {
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meeting.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meeting, user, PostprepareLoginConf);
                    }
                }

                long startTime = 0;
                long endTime = 0;
                if (!StringUtils.checkNull(meeting.getStartTime())) {
                    startTime = DateFormat.getTime(meeting.getStartTime());
                }
                if (!StringUtils.checkNull(meeting.getEndTime())) {
                    endTime = DateFormat.getTime(meeting.getEndTime());
                }

                if (meeting.getStatus() != null) {
                    switch (meeting.getStatus()) {
                        case 1:
                            meeting.setStatusName("待审批");
                            break;
                        case 2:
                            // 2020/5/19  因为此接口没有用到更新状态
                            meeting.setStatusName("已审批");
                            break;
                        case 4:
                            meeting.setStatusName("未批准");
                            break;
                        case 5:
                            meeting.setStatusName("已结束");
                            break;
                    }
                }
                if (!StringUtils.checkNull(meeting.getStartTime())) {
                    meeting.setStartTime(meeting.getStartTime().substring(0, meeting.getStartTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getEndTime())) {
                    meeting.setEndTime(meeting.getEndTime().substring(0, meeting.getEndTime().length() - 2));
                }
                if (!StringUtils.checkNull(meeting.getCreateTime())) {
                    meeting.setCreateTime(meeting.getCreateTime().substring(0, meeting.getCreateTime().length() - 2));
                }
            }
            json.setObj(meetingList);
            json.setFlag(0);
            json.setMsg("ok");
            if (pageParams.getTotal() == null) {
                json.setTotleNum(0);
            } else {
                json.setTotleNum(pageParams.getTotal());
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl getMyMeeting:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:00:00
     * 方法介绍:  根据id查询会议信息
     * 参数说明:   @param sid会议id
     * 返回值说明:   @return MeetingWithBLOBs
     */
    @Override
    public ToJson<MeetingWithBLOBs> queryMeetingById(HttpServletRequest request, HttpServletResponse response, String sid, int output, String bodyId) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String state=request.getParameter("state");
      /*  java.util.Calendar calendar= java.util.Calendar.getInstance();
        //calendar.setTime(new Date());
        long one=calendar.getTimeInMillis()/1000;
        Meeting meeting1=meetingMapper.queryMeetingById(sid);
        java.util.Calendar calendar1= java.util.Calendar.getInstance();
        calendar1.setTime(meeting1.getCreateQrcodeTime());
        long two=calendar1.getTimeInMillis()/1000;
        int i1=(int)(one-two);*/
      if(!StringUtils.checkNull(state)) {
          if(state.equals("qr_code")){
              Date date = new Date();
              long timeOne = date.getTime() / 1000;
              SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
              MeetingWithBLOBs meeting = meetingMapper.queryMeetingById(sid);
              long timeTwo = 0;
              try {
                  timeTwo = sdf.parse(meeting.getCreateQrcodeTime()).getTime() / 1000;
              } catch (ParseException e) {
                  e.printStackTrace();
              }
              long second = timeOne - timeTwo;
              if (second > 30) {
                  json.setMsg("二维码过期");
                  json.setFlag(1);
                  return json;
              }

              return queryMeetingByQrCode(request,meeting);
          }
      }
        try {
            //2022-06-13,修改为通过url消除提醒
            smsMapper.setReadByUrl(user.getUserId(), "/meeting/detail?meetingId=" + sid);

            MeetingWithBLOBs meetingWithBLOBs = meetingMapper.queryMeetingById(sid);
            if(Objects.isNull(meetingWithBLOBs)){
                json.setMsg("当前会议已删除");
                json.setFlag(0);
                return json;
            }
            meetingWithBLOBs.setUserId(user.getUserId());

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

            //会议议程
            if (!StringUtils.checkNull(meetingWithBLOBs.getAgendaName()) && !StringUtils.checkNull(meetingWithBLOBs.getAgendaId())) {
                List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingWithBLOBs.getAgendaName(), meetingWithBLOBs.getAgendaId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_MEETING);
                meetingWithBLOBs.setAgendaList(atts);
            }

            //出席人员（内部）
            if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                StringBuffer userId = new StringBuffer();
                StringBuffer userName = new StringBuffer();
                List<Users> usersByUids = usersService.getUsersByUids(meetingWithBLOBs.getAttendee());
                for ( Users us :usersByUids) {
                    userId.append(us.getUserId()).append(",");
                    userName.append(us.getUserName()).append(",");
                }
                meetingWithBLOBs.setAttendeeName(userName.toString());
                meetingWithBLOBs.setAttendeeUserId(userId.toString());
            }

            //会议纪要员
            if (meetingWithBLOBs.getRecorderId() != null) {
                Users userByuid = usersService.getByUid(meetingWithBLOBs.getRecorderId());
                meetingWithBLOBs.setRecorderName(userByuid.getUserName());
                meetingWithBLOBs.setRecorderUserId(userByuid.getUserId());
            }

            //前台服务人员
            if (!StringUtils.checkNull(meetingWithBLOBs.getServiceUser())) {
                StringBuffer userId = new StringBuffer();
                StringBuffer userName = new StringBuffer();
                List<Users> usersByUids = usersService.getUsersByUids(meetingWithBLOBs.getServiceUser());
                for ( Users us :usersByUids) {
                    userId.append(us.getUserId()).append(",");
                    userName.append(us.getUserName()).append(",");
                }
                meetingWithBLOBs.setServiceUserName(userName.toString());
                meetingWithBLOBs.setServiceUserUserId(userId.toString());
            }

            if (meetingWithBLOBs.getManagerId() != null) {
                meetingWithBLOBs.setManagerName(usersMapper.getUsernameById(meetingWithBLOBs.getManagerId()));
            }

            if (meetingWithBLOBs.getUid() != null) {
                meetingWithBLOBs.setUserName(usersMapper.getUsernameById(meetingWithBLOBs.getUid()));
            }

            if (meetingWithBLOBs.getMeetRoomId() != null && !meetingWithBLOBs.getMeetRoomId().equals(0)) {
                meetingWithBLOBs.setMeetRoomName(meetingRoomMapper.getRoomName(meetingWithBLOBs.getMeetRoomId()));
            } else if (meetingWithBLOBs.getMeetRoomId().equals(0)) {
                meetingWithBLOBs.setMeetRoomName("视频会议");
            }

            //配置视频会议参数
            if (!StringUtils.checkNull(meetingWithBLOBs.getVideoConfFlag()) && meetingWithBLOBs.getVideoConfFlag().equals("1")) {
                //获取url信息
                VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
                if (videoConf != null){
                    String videourl = videourl(videoConf);
                    //视频会议获取登录认证
                    String userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meetingWithBLOBs.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meetingWithBLOBs, user, PostprepareLoginConf);
                    }
                }
            }

            if (!StringUtils.checkNull(meetingWithBLOBs.getStartTime())) {
                meetingWithBLOBs.setStartTime(meetingWithBLOBs.getStartTime().substring(0, meetingWithBLOBs.getStartTime().length() - 2));
            }
            if (!StringUtils.checkNull(meetingWithBLOBs.getEndTime())) {
                meetingWithBLOBs.setEndTime(meetingWithBLOBs.getEndTime().substring(0, meetingWithBLOBs.getEndTime().length() - 2));
            }
            if (!StringUtils.checkNull(meetingWithBLOBs.getCreateTime())) {
                meetingWithBLOBs.setCreateTime(meetingWithBLOBs.getCreateTime().substring(0, meetingWithBLOBs.getCreateTime().length() - 2));
            }


            //获取当前时间的时间戳，判断当前会议是否正在进行
            if (meetingWithBLOBs.getStatus() != null) {
                switch (meetingWithBLOBs.getStatus()) {
                    case 1:
                        meetingWithBLOBs.setStatusName("待审批");
                        meetingWithBLOBs.setStatus(1);
                        break;
                    case 2:
                        String str = String.valueOf( new Date().getTime() );
                        long currentTime = Long.valueOf(str.substring(0, 10)); //当前时间
                        long endTime = DateFormat.getTime(meetingWithBLOBs.getEndTime()); //结束时间
                        long startTime = DateFormat.getTime(meetingWithBLOBs.getStartTime()); //开始时间

                        if (startTime <= currentTime && currentTime < endTime) {
                            meetingWithBLOBs.setStatusName("进行中");
                            meetingWithBLOBs.setStatus(3);
                        } else if (startTime <= currentTime && currentTime >= endTime) {
                            meetingWithBLOBs.setStatusName("已结束");
                            meetingWithBLOBs.setStatus(5);
                        } else {
                            meetingWithBLOBs.setStatusName("已审批");
                            meetingWithBLOBs.setStatus(2);
                        }
                        break;
                    case 4:
                        meetingWithBLOBs.setStatusName("未批准");
                        meetingWithBLOBs.setStatus(4);
                        break;
                    case 5:
                        meetingWithBLOBs.setStatusName("已结束");
                        meetingWithBLOBs.setStatus(5);
                        break;
                }
            }

            //我的签到（当前登陆人）
            Map<String, Object> map = new HashedMap();
            map.put("meetingId", sid);
            map.put("attendeeId", user.getUid());
            MeetingAttendConfirm meetingAttendConfirm1 = meetingAttendConfirmMapper.queryMyAttend(map);
            if (meetingAttendConfirm1 != null && meetingAttendConfirm1.getAttendFlag().equals(1) ) {
                meetingWithBLOBs.setMyAttend("已签到");
                meetingWithBLOBs.setMyAttendStatus(1);
            }
            else {
                meetingWithBLOBs.setMyAttend("未签到");
                meetingWithBLOBs.setMyAttendStatus(0);
            }

            /*if (!StringUtils.checkNull(bodyId)) {
                smsMapper.setRead(user.getUserId(), Integer.valueOf(bodyId));
            }*/

            if (output == 1) {
                //查询参会人员
                List<MeetingAttendConfirm> meetingAttendConfirmList = meetingAttendConfirmMapper.queryAttendByMeetId(sid);
                StringBuffer realAttendName = new StringBuffer();
                for (MeetingAttendConfirm meetingAttendConfirm : meetingAttendConfirmList) {
                    if (meetingAttendConfirm.getAttendeeId() != null) {
                        if (!StringUtils.checkNull(usersMapper.getUsernameById(meetingAttendConfirm.getAttendeeId()))) {
                            realAttendName.append(usersMapper.getUsernameById(meetingAttendConfirm.getAttendeeId()) + ",");
                        }
                    }
                }
                if (!StringUtils.checkNull(realAttendName.toString())) {
                    meetingWithBLOBs.setRealAttendeeName(realAttendName.toString().substring(0, realAttendName.length() - 1));
                }
                //导出数据
                response.setContentType("text/html");
                response.setCharacterEncoding("utf-8");
                response.setHeader("Cache-control", "private");
                response.setContentType("application/octet-stream");
                response.setHeader("Accept-Ranges", "bytes");
                response.setHeader("Cache-Control", "maxage=3600");
                response.setHeader("Pragma", "public");

                response.setHeader(
                        "Content-disposition",
                        "attachment; filename=\""
                                + URLEncoder.encode("会议信息导出.html", "UTF-8") + "\"");
                StringBuilder sb = new StringBuilder();
                PrintWriter out = response.getWriter();
                out.write("<html>");
                out.write("<head>");
                out.write("<title>会议信息导出</title>");
                out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
                out.write("</head>");
                out.write("<body>");
                out.write("<table><tr>");
                out.write("<td><span>会议名称:</span></td>");
                out.write("<td><span>" + meetingWithBLOBs.getMeetName() + "</span></td>");
                out.write("</tr>");
                out.write("<tr>");
                out.write("<td><span>会议主题:</span></td>");
                out.write("<td><span>" + meetingWithBLOBs.getSubject() + "</span></td>");
                out.write("</tr>");
                out.write("<tr>");
                out.write("<td><span>会议时间:</span></td>");
                out.write("<td><span>" + meetingWithBLOBs.getStartTime() + "</span><span>至</span><span>" + meetingWithBLOBs.getEndTime() + "</span></td>");
                out.write("</tr>");
                out.write("<tr>");
                out.write("<td><span>参会人:</span></td>");
                out.write("<td><span>" + meetingWithBLOBs.getRealAttendeeName() + "</span></td>");
                out.write("</tr>");
                out.write("<tr>");
                out.write("<td><span>会议描述:</span></td>");
                out.write("<td><span>" + meetingWithBLOBs.getMeetDesc() + "</span></td>");
                out.write("</tr>");
                out.write("<tr>");
                out.write("<td>会议纪要:</td>");
                out.write("<td><span>" + meetingWithBLOBs.getSummary() + "</span></td>");
                out.write("</tr>");
                out.write("</table>");
                out.write("</body>");
                out.write("</html>");
            }

            json.setObject(meetingWithBLOBs);
            //更改会议状态
            meetingStatus();
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryMeetingById:" + e);
        }
        return json;
    }


    /**
     * 方法介绍:  根据id查询会议信息（app扫码查询用）
     * 参数说明:   @param sid会议id
     * 返回值说明:   @return MeetingWithBLOBs
     */
    public ToJson<MeetingWithBLOBs> queryMeetingByQrCode(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String state=request.getParameter("state");

        try {
            meetingWithBLOBs.setUserId(user.getUserId());
            //扫码签到 usersMap.get(meetingWithBLOBs.getUid()).getUserName()获取不到申请人名称所以添加 meetingWithBLOBs.getUid()+","
            String uids = meetingWithBLOBs.getUid()+","+ meetingWithBLOBs.getManagerId() + "," + meetingWithBLOBs.getMeetRoomId();
            List<Users> usersByUids = usersService.getUsersByUids(uids);
            Map<Integer,Users> usersMap = new HashMap<>();
            for (Users usersByUid : usersByUids) {
                usersMap.put(usersByUid.getUid(),usersByUid);
            }

            if (meetingWithBLOBs.getManagerId() != null) {
                meetingWithBLOBs.setManagerName(usersMap.get(meetingWithBLOBs.getManagerId()).getUserName());
            }

            if (meetingWithBLOBs.getUid() != null) {
                meetingWithBLOBs.setUserName(usersMap.get(meetingWithBLOBs.getUid()).getUserName());
            }

            if (meetingWithBLOBs.getMeetRoomId() != null && !meetingWithBLOBs.getMeetRoomId().equals(0)) {
                meetingWithBLOBs.setMeetRoomName(meetingRoomMapper.getRoomName(meetingWithBLOBs.getMeetRoomId()));
            } else if (meetingWithBLOBs.getMeetRoomId().equals(0)) {
                meetingWithBLOBs.setMeetRoomName("视频会议");
            }

            //配置视频会议参数
            if (!StringUtils.checkNull(meetingWithBLOBs.getVideoConfFlag()) && meetingWithBLOBs.getVideoConfFlag().equals("1")) {
                //获取url信息
                VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
                if (videoConf != null){
                    String videourl = videourl(videoConf);
                    //视频会议获取登录认证
                    String userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meetingWithBLOBs.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meetingWithBLOBs, user, PostprepareLoginConf);
                    }
                }
            }

            if (!StringUtils.checkNull(meetingWithBLOBs.getStartTime())) {
                meetingWithBLOBs.setStartTime(meetingWithBLOBs.getStartTime().substring(0, meetingWithBLOBs.getStartTime().length() - 2));
            }
            if (!StringUtils.checkNull(meetingWithBLOBs.getEndTime())) {
                meetingWithBLOBs.setEndTime(meetingWithBLOBs.getEndTime().substring(0, meetingWithBLOBs.getEndTime().length() - 2));
            }
            if (!StringUtils.checkNull(meetingWithBLOBs.getCreateTime())) {
                meetingWithBLOBs.setCreateTime(meetingWithBLOBs.getCreateTime().substring(0, meetingWithBLOBs.getCreateTime().length() - 2));
            }

            //获取当前时间的时间戳，判断当前会议是否正在进行
            if (meetingWithBLOBs.getStatus() != null) {
                switch (meetingWithBLOBs.getStatus()) {
                    case 1:
                        meetingWithBLOBs.setStatusName("待审批");
                        meetingWithBLOBs.setStatus(1);
                        break;
                    case 2:
                        String str = String.valueOf( new Date().getTime() );
                        long currentTime = Long.valueOf(str.substring(0, 10)); //当前时间
                        long endTime = DateFormat.getTime(meetingWithBLOBs.getEndTime()); //结束时间
                        long startTime = DateFormat.getTime(meetingWithBLOBs.getStartTime()); //开始时间

                        if (startTime <= currentTime && currentTime < endTime) {
                            meetingWithBLOBs.setStatusName("进行中");
                            meetingWithBLOBs.setStatus(3);
                        } else if (startTime <= currentTime && currentTime >= endTime) {
                            meetingWithBLOBs.setStatusName("已结束");
                            meetingWithBLOBs.setStatus(5);
                        } else {
                            meetingWithBLOBs.setStatusName("已审批");
                            meetingWithBLOBs.setStatus(2);
                        }
                        break;
                    case 4:
                        meetingWithBLOBs.setStatusName("未批准");
                        meetingWithBLOBs.setStatus(4);
                        break;
                    case 5:
                        meetingWithBLOBs.setStatusName("已结束");
                        meetingWithBLOBs.setStatus(5);
                        break;
                }
            }

            //2022-06-13,修改为通过url消除提醒
            try {
                this.threadPoolTaskExecutor.execute(new Runnable() {
                    @Override
                    public void run() {
                        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                        ContextHolder.setConsumerType("xoa" + sqlType);
                        smsMapper.setReadByUrl(user.getUserId(), "/meeting/detail?meetingId=" + meetingWithBLOBs.getSid());
                    }});
            }catch (Exception e){
                e.printStackTrace();
            }

            json.setObject(meetingWithBLOBs);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("MeetingServiceImpl queryMeetingByQrCode:" + e);
        }
        return json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:02:00
     * 方法介绍:  根据id更新会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 更新条数
     */
    @Transactional
    @Override
    public ToJson<MeetingWithBLOBs> updateMeetingById(MeetingWithBLOBs meetingWithBLOBs, Integer Status, HttpServletRequest request) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = sdf.format(date);
            meetingWithBLOBs.setCreateTime(format);
            int count = meetingMapper.updateMeetingById(meetingWithBLOBs);
            if (null!=Status && 1==Status){
                addAffairs(meetingWithBLOBs, request);
            }

            if (count > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl updateMeetingById:" + e);
        }
        return json;
    }

    @Transactional
    @Override
    public ToJson<MeetingWithBLOBs> updateMeetingByIdv1(MeetingWithBLOBs meetingWithBLOBs, Integer Status, HttpServletRequest request) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingWithBLOBs.setCreateTime(sdf.format(date));
            int count = meetingMapper.updateMeetingByIdV1(meetingWithBLOBs);
            if (count > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl updateMeetingById:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:04:00
     * 方法介绍:  根据id更新会议状态
     * 参数说明:   @param Meeting
     * 返回值说明:   @return int 更新条数
     */
    @Transactional
    @Override
    public ToJson<MeetingWithBLOBs> updMeetStatusById(HttpServletRequest request, Meeting meeting, boolean is) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        int count = 0;
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

            if (meeting.getStatus() == 2) {
                //通过url消除提醒
                smsMapper.setReadByUrl(user.getUserId(), "/MeetingCommon/selectMeetingMange?flag=" + meeting.getSid());

                //批准会议时，进行判断该会议室是否被占用
                MeetingWithBLOBs meetingWithBLOBs = meetingMapper.queryMeetingById(meeting.getSid().toString());//先根据id进行会议要修改会议状态的会议信息
                Map<String, Object> map = new HashedMap();
                map.put("startTime", meetingWithBLOBs.getStartTime());
                map.put("endTime", meetingWithBLOBs.getEndTime());
                map.put("roomId", meetingWithBLOBs.getMeetRoomId());
                int nums = meetingMapper.getMettingByTime(map);
                if (nums > 1) {
                    json.setMsg("会议室已被占用,请重新修改时间");
                    json.setFlag(1);
                    return json;
                } else {
                    //会议室没有被占用，可以使用
                    Date date = new Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    MeetingAttendConfirm meetingAttendConfirm = new MeetingAttendConfirm();
                    meetingAttendConfirm.setAttendFlag(0);
                    meetingAttendConfirm.setCreateTime(sdf.format(date));
                    meetingAttendConfirm.setMeetingId(meetingWithBLOBs.getSid());
                    meetingAttendConfirm.setReadFlag(0);
                    meetingAttendConfirm.setRemark("");
                    /*Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                    Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);*/
                    meetingAttendConfirm.setCreateUser(user.getUid());
                    if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                        String[] attendArray = meetingWithBLOBs.getAttendee().split(",");
                        if (attendArray.length > 0) {
                            for (String attendId : attendArray) {
                                meetingAttendConfirm.setAttendeeId(Integer.valueOf(attendId));
                                count += meetingAttendConfirmMapper.insertConfirm(meetingAttendConfirm);
                            }
                        }
                    }
                    //将批准后的会议添加到日程中
                    if(meetingWithBLOBs.getIsWriteCalednar().equals(1)){
                        Calendar calendar = new Calendar();
                        calendar.setContent("会议：" + meetingWithBLOBs.getSubject());//日程内容
                        calendar.setCalType("1");//日程类型：工作事务
                        if (!StringUtils.checkNull(meetingWithBLOBs.getStartTime())) {
                            calendar.setCalTime(DateFormat.getTime(meetingWithBLOBs.getStartTime()));
                        }
                        if (!StringUtils.checkNull(meetingWithBLOBs.getEndTime())) {
                            calendar.setEndTime(DateFormat.getTime(meetingWithBLOBs.getEndTime()));
                        }
                        calendar.setAddTime(date);
                        //calendar.setUserId(user.getUserId());
                        calendar.setCalLevel("1");
                        calendar.setBeforeRemaind("0|" + meetingWithBLOBs.getResendHour() + "|" + meetingWithBLOBs.getResendMinute());
                        String[] takerArray = meetingWithBLOBs.getAttendee().split(",");
                        StringBuffer takerStr = new StringBuffer();
                        if (!StringUtils.checkNull(String.valueOf(meetingWithBLOBs.getRecorderId()))) {//会议纪要员也要计入参会
                            takerStr.append(meetingWithBLOBs.getRecorderId() + ",");
                        }
                        for (String uid : takerArray) {//参会人
                            if (!StringUtils.checkNull(uid)) {
                                Users userTemp = usersMapper.findUserByuid(Integer.valueOf(uid));
                                if (userTemp != null) {
                                    if (!StringUtils.checkNull(userTemp.getUserId())) {
                                        takerStr.append(userTemp.getUserId() + ",");
                                    }
                                }
                            }
                        }
                        // 设置分享人
                        calendar.setTaker(takerStr.toString());

                        // 设置创建人
                        Users users = usersMapper.SimplefindUserByuid(meetingWithBLOBs.getUid());
                        if (users != null) {
                            calendar.setUserId(users.getUserId());
                        }
                        // 插入日程
                        calendar.setCalId(null);
                        calendarService.insertSelective(calendar, request);

                        String sqlType = "xoa" + (String) request.getSession().getAttribute(
                                "loginDateSouse");
                        this.addAffairs1(meetingWithBLOBs, request);


                    }
                }

            }
            //审批成功
            meeting.setApproveName(user.getUserId());
            count += meetingMapper.updMeetStatusById(meeting);
            if (count > 0) {
                //通过id查询出当前需要发送短信的数据
                MeetingWithBLOBs meetingWithBLOBs = meetingMapper.queryMeetingByIdInt(meeting.getSid());
                Users userTemp = usersMapper.findUserByuid(Integer.valueOf(meetingWithBLOBs.getUid()));

                //审批成功后判断是否是视频会议
                if (meeting.getStatus() == 2 && meetingWithBLOBs != null && !StringUtils.checkNull(meetingWithBLOBs.getVideoConfFlag()) && meetingWithBLOBs.getVideoConfFlag().equals("1")) {
                    VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
                    if (videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId())) {
                        String videourl = videourl(videoConf);
                        //获取用户登录认证
                        Map map = new HashMap();
                        Map maplemeeting = new HashMap();
                        Map mapconf_room = new HashMap();
                        maplemeeting.put("req_type", "1");
                        maplemeeting.put("org_id", videoConf.getCompanyId());
                        maplemeeting.put("user", "admin"); //暂时弄成admin,后期修改其他用户
                        maplemeeting.put("pass", "21232f297a57a5a743894a0e4a801fc3");
                        map.put("lemeeting", maplemeeting);
                        String s = PostVideoUrl.map2Xml(map);
                        String userpost = PostVideoUrl.respost(videourl, s);
                        if (!StringUtils.checkNull(userpost)) {
                            Map<String, Object> stringObjectMap = PostVideoUrl.xmlToMap(userpost);

                            //添加会议室信息
                            map.clear();
                            maplemeeting.clear();
                            maplemeeting.put("req_type", "20");
                            maplemeeting.put("token", stringObjectMap.get("token"));
                            mapconf_room.put("conf_name", meetingWithBLOBs.getMeetName());
                            mapconf_room.put("conf_type", "0");
                            mapconf_room.put("group_id", "1");
                            mapconf_room.put("server_id", "0");
                            mapconf_room.put("world_id", stringObjectMap.get("world_id"));
                            mapconf_room.put("start_time", meetingWithBLOBs.getStartTime());
                            mapconf_room.put("end_time", meetingWithBLOBs.getEndTime());
                            mapconf_room.put("conf_password", "d41d8cd98f00b204e9800998ecf8427e");
                            mapconf_room.put("manage_password", "d41d8cd98f00b204e9800998ecf8427e");
                            mapconf_room.put("max_speaker_count", "10");
                            mapconf_room.put("max_user_count", "100");
                            mapconf_room.put("conf_flag", "0");
                            List<String> listOut = new ArrayList<>();
                            listOut.add(userTemp.getUserId());
                            Map map2 = new HashMap();
                            map2.put("Admin", listOut);
                            String str = JSON.toJSONString(map2);
                            mapconf_room.put("setting_json", str);
                            maplemeeting.put("conf_room", mapconf_room);
                            map.put("lemeeting", maplemeeting);
                            String s2 = PostVideoUrl.map2Xml(map);
                            String addConfRoom = PostVideoUrl.respost(videourl, s2);
                            Map<String, Object> addConfRoomInfo = PostVideoUrl.xmlToMap(addConfRoom);
                            Map codemaps = json != null ? (Map) JSON.parse(addConfRoomInfo.get("setting_json").toString()) : new HashMap();


                            //创建完直接退出登录
                            map.clear();
                            maplemeeting.clear();
                            mapconf_room.clear();
                            maplemeeting.put("req_type", "2");
                            maplemeeting.put("org_id", videoConf.getCompanyId());
                            maplemeeting.put("user", "admin");
                            maplemeeting.put("token", stringObjectMap.get("token"));
                            map.put("lemeeting", maplemeeting);
                            String s3 = PostVideoUrl.map2Xml(map);
                            String userLogout = PostVideoUrl.respost(videourl, s3);

                            //修改服务端会议室ID
                            meeting.setVideoConfId(addConfRoomInfo.get("conf_id").toString());
                            meeting.setMeetCode(codemaps.get("code_id").toString()); //会议验证码
                            meetingMapper.updMeetVideoById(meeting);
                        }
                    }
                } else if (meeting.getStatus() == 5 && meetingWithBLOBs != null) {
                    //结束会议
                    VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
                    if (videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId())) {
                        String videourl = videourl(videoConf);
                        //获取用户登录认证
                        Map map = new HashMap();
                        Map maplemeeting = new HashMap();
                        Map mapconf_room = new HashMap();
                        maplemeeting.put("req_type", "1");
                        maplemeeting.put("org_id", videoConf.getCompanyId());
                        maplemeeting.put("user", "admin"); //暂时弄成admin,后期修改其他用户
                        maplemeeting.put("pass", "21232f297a57a5a743894a0e4a801fc3");
                        map.put("lemeeting", maplemeeting);
                        String s = PostVideoUrl.map2Xml(map);
                        String userpost = PostVideoUrl.respost(videourl, s);
                        if (!StringUtils.checkNull(userpost)) {
                            Map<String, Object> stringObjectMap = PostVideoUrl.xmlToMap(userpost);

                            //删除会议室
                            map.clear();
                            maplemeeting.clear();
                            maplemeeting.put("req_type", "21");
                            maplemeeting.put("token", stringObjectMap.get("token"));
                            mapconf_room.put("conf_id", meetingWithBLOBs.getVideoConfId());
                            maplemeeting.put("conf_room", mapconf_room);
                            map.put("lemeeting", maplemeeting);
                            String s2 = PostVideoUrl.map2Xml(map);
                            String deleteConfRoom = PostVideoUrl.respost(videourl, s2);

                            //退出登录
                            map.clear();
                            maplemeeting.clear();
                            mapconf_room.clear();
                            maplemeeting.put("req_type", "2");
                            maplemeeting.put("org_id", videoConf.getCompanyId());
                            maplemeeting.put("user", "admin");
                            maplemeeting.put("token", stringObjectMap.get("token"));
                            map.put("lemeeting", maplemeeting);
                            String s3 = PostVideoUrl.map2Xml(map);
                            String userLogout = PostVideoUrl.respost(videourl, s3);


                        }
                    }
                    /*try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            BudgetLog log = new BudgetLog();
                            log.setBudgetId(meeting.getSid());
                            log.setUserId(user.getUserName());
                            log.setTime(sdf.format(new Date()));// 现在时间
                            try {
                                log.setIp("meeting.getStartTime()");
                            }catch (Exception e){

                            }
                            log.setType(String.valueOf(meeting.getStatus()));
                            log.setRemark("ip==开始时间，，budgetItemName==结束时间"+1314);
                            log.setBudgetItemName("sdf.parse(meeting.getEndTime()).toString()");
                            try {
                                //log.setBudgetInputTime();
                            }catch (Exception e){

                            }
                            budgetLogMapper.insertSelective(log);

                    }catch (Exception e){
                        e.printStackTrace();
                    }*/



                }


                //发送短信短信
                Sms2Priv sms2Priv = new Sms2Priv();
                StringBuffer contextString = null;
                //是否内部短信通知出席人员，使用内部短信提醒
                if (meetingWithBLOBs.getSmsRemind().equals("0") && !meetingWithBLOBs.getSubject().equals("")) {
                    sms2Priv.setResendHour(meetingWithBLOBs.getResendHour());
                    sms2Priv.setResendMinute(meetingWithBLOBs.getResendMinute());
                    sms2Priv.setUserId(meetingWithBLOBs.getAttendee());
                    contextString = new StringBuffer(meetingWithBLOBs.getSubject());

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String StartTime = meetingWithBLOBs.getStartTime();
                    Date date = sdf.parse(StartTime);
                    date.setHours((date.getHours()) - meetingWithBLOBs.getResendHour());
                    date.setMinutes((date.getMinutes()) - meetingWithBLOBs.getResendMinute());
                    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    meetingWithBLOBs.setStartTime(sdf1.format(date));
                    sms2Priv.setStartTime(meetingWithBLOBs.getStartTime());
                }
                sms2PrivService.selSenderMobile(meetingWithBLOBs.getSmsRemind(), sms2Priv, contextString, request);

                //批准后向申请人、会议室管理员发送事务提醒,未批准提醒申请人
                if (meetingWithBLOBs.getStatus() == 2 && !StringUtils.checkNull(meetingWithBLOBs.getManagerIds())) {
                    String[] managerIds = meetingWithBLOBs.getManagerIds().split(",");
                    StringBuffer stringBuffer = new StringBuffer();
                    Users users = usersMapper.selectUserByUId(meetingWithBLOBs.getUid());
                    stringBuffer.append(users.getUserId()).append(",");
                    List<Users> usersByUids = usersMapper.getUsersByUids(managerIds);
                    for (Users u : usersByUids) {
                        stringBuffer.append(u.getUserId()).append(",");
                    }
                    String content = "“" + meetingWithBLOBs.getMeetName() + "”预订成功，审批通过";
                    this.addAffairs2(request, meetingWithBLOBs, stringBuffer.toString(), content);
                } else if (meetingWithBLOBs.getStatus() == 4 && !StringUtils.checkNull(meetingWithBLOBs.getManagerIds())) {
                    Users users = usersMapper.selectUserByUId(meetingWithBLOBs.getUid());
                    String content = "“" + meetingWithBLOBs.getMeetName() + "”预订失败，审批不通过";
                    this.addAffairs2(request, meetingWithBLOBs, users.getUserId(), content);
                }

                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl updMeetStatusById:" + e);
        }
        return json;
    }

    private void goToParent(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs) {
        Map<String,String> param =new HashMap();
        MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(meetingWithBLOBs.getMeetRoomId());
        Users usersByUid = usersMapper.getUsersByUid(meetingWithBLOBs.getUid());
        param.put("account","admin");
        param.put("password","21232F297A57A5A743894A0E4A801FC3");
        param.put("roomName",meetRoomBySid.getMrName());
        param.put("roomCode",meetRoomBySid.getRoomCode());
        param.put("roomAddress",meetRoomBySid.getRoomAddress());
        param.put("beginTime",DateFormat.getStrDate(DateFormat.getDate(meetingWithBLOBs.getStartTime())));
        param.put("endTime",DateFormat.getStrDate(DateFormat.getDate(meetingWithBLOBs.getEndTime())));
        param.put("speaker",usersByUid.getUserName());
        param.put("subject",meetingWithBLOBs.getSubject());
        //param.put("booker","陈东虎:\"\";17630412790;\r\n杨衡:\"\";13588745939;");
        param.put("booker",usersByUid.getUserName()+";"+usersByUid.getMobilNo()+";"+";");

        StringBuffer sb = new StringBuffer();
        List<Users> usersByUids = usersMapper.getUsersByUids(meetingWithBLOBs.getAttendee().split(","));
        for (Users user:usersByUids){
            sb.append(user.getUserName()+";"+user.getMobilNo()+";"+";"+user.getUserId()+"\\r\\n");
        }
        //param.put("attendance",";;\\r\\陈东虎;17630412790;");
        if (!StringUtils.checkNull(meetingWithBLOBs.getAttendeeOut())){
            sb.append(meetingWithBLOBs.getAttendeeOut()+";"+";"+";"+"\\r\\n");
        }
        param.put("attendance",sb.toString());
        param.put("signUrl","{\"mark\":\"SID_MEETING\",\"sid\":"+meetingWithBLOBs.getSid()+"}");

        try {
            this.threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    String para = com.alibaba.fastjson.JSONObject.toJSONString(param);
                    HttpResponse response = null;
                    try {
                        response = HttpUtils.doPost("http://10.191.10.247:1080", "/services/api/BookingService.aspx", "", param, param, para);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    HttpEntity entity = response.getEntity();
                    if (entity != null) {
                        JSONObject object = null;
                        String result = null;
                        try {
                            result = EntityUtils.toString(entity, "UTF-8");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        object = JSONObject.fromObject(result);
                        System.out.println(object);
                    }
                }});
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:05:00
     * 方法介绍:  申请会议（添加会议信息）
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 插入条数
     */
    @Transactional
    @Override
    public ToJson<MeetingWithBLOBs> insertMeeting(MeetingWithBLOBs meetingWithBLOBs, HttpServletRequest request) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        //视频会议不进行判断时间交叉可以重复申请
        //不是视频会议，不是周期性会议。进行 查询会议是否有冲突
        if (!StringUtils.checkNull(meetingWithBLOBs.getVideoConfFlag()) && meetingWithBLOBs.getVideoConfFlag().equals("0")
                && !StringUtils.checkNull(meetingWithBLOBs.getCycle()) && meetingWithBLOBs.getCycle().equals("0")) {
            Map<String, Object> maps = new HashMap<>();
            maps.put("startTime", meetingWithBLOBs.getStartTime());
            maps.put("endTime", meetingWithBLOBs.getEndTime());
            maps.put("roomId", meetingWithBLOBs.getMeetRoomId());
            int counts = meetingMapper.getMettingByTime(maps);
            if (counts > 0) {
                json.setMsg("会议室已被占用,请重新修改时间！");
                return json;
            }
        }
        if(Objects.isNull(meetingWithBLOBs.getUid())){
            json.setMsg("申请人不能为空！");
            return json;
        }
        try {
            //判断打卡时间不能超过会议结束时间
            if(!StringUtils.checkNull(meetingWithBLOBs.getSignInTime()) && !StringUtils.checkNull(meetingWithBLOBs.getEndTime())
                    && DateFormat.getDate(meetingWithBLOBs.getSignInTime()).getTime() >= DateFormat.getDate(meetingWithBLOBs.getEndTime()).getTime()){
                json.setMsg("打卡时间不能大于会议结束时间");
                return json;
            }

            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingWithBLOBs.setCreateTime(sdf.format(date));
            //判断是否是视频会议室，如果室直接审批
//            if (meetingWithBLOBs.getMeetRoomId().equals(0)) {
//                meetingWithBLOBs.setStatus(2); //状态2已审批
//            } else {
//                meetingWithBLOBs.setStatus(1);
//            }

            //获取会议室的审批设置
            String isApprove;
            MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(meetingWithBLOBs.getMeetRoomId());
            if (meetRoomBySid == null){
                json.setMsg("会议室为空");
                return json;
            }else {
                isApprove = meetRoomBySid.getIsApprove();
            }

            //判断是否是视频会议室，或者是否不需要审批，或者是否超过三小时需要审批但没有超过三个小时，如果是直接审批
            if (meetingWithBLOBs.getMeetRoomId().equals(0) || isApprove.equals("1")
                    || (isApprove.equals("3") && DateFormat.getTime(meetingWithBLOBs.getEndTime())
                    - DateFormat.getTime(meetingWithBLOBs.getStartTime()) <= 10800)){
                meetingWithBLOBs.setStatus(2); //状态2已审批
                if(meetingWithBLOBs.getIsWriteCalednar().equals(1)){
                    Calendar calendar = new Calendar();
                    calendar.setContent("会议：" + meetingWithBLOBs.getSubject());//日程内容
                    calendar.setCalType("1");//日程类型：工作事务
                    if (!StringUtils.checkNull(meetingWithBLOBs.getStartTime())) {
                        calendar.setCalTime(DateFormat.getTime(meetingWithBLOBs.getStartTime()));
                    }
                    if (!StringUtils.checkNull(meetingWithBLOBs.getEndTime())) {
                        calendar.setEndTime(DateFormat.getTime(meetingWithBLOBs.getEndTime()));
                    }
                    calendar.setAddTime(date);
                    //calendar.setUserId(user.getUserId());
                    calendar.setCalLevel("1");
                    calendar.setBeforeRemaind("0|" + meetingWithBLOBs.getResendHour() + "|" + meetingWithBLOBs.getResendMinute());
                    String[] takerArray = meetingWithBLOBs.getAttendee().split(",");
                    StringBuffer takerStr = new StringBuffer();
                    if (!StringUtils.checkNull(String.valueOf(meetingWithBLOBs.getRecorderId()))) {//会议纪要员也要计入参会
                        takerStr.append(meetingWithBLOBs.getRecorderId() + ",");
                    }
                    for (String uid : takerArray) {//参会人
                        if (!StringUtils.checkNull(uid)) {
                            Users userTemp = usersMapper.findUserByuid(Integer.valueOf(uid));
                            if (userTemp != null) {
                                if (!StringUtils.checkNull(userTemp.getUserId())) {
                                    takerStr.append(userTemp.getUserId() + ",");
                                }
                            }
                        }
                    }
                    // 设置分享人
                    calendar.setTaker(takerStr.toString());

                    // 设置创建人
                    Users users = usersMapper.SimplefindUserByuid(meetingWithBLOBs.getUid());
                    if (users != null) {
                        calendar.setUserId(users.getUserId());
                    }
                    // 插入日程
                    calendar.setCalId(null);
                    calendarService.insertSelective(calendar, request);
                }
            }else {
                meetingWithBLOBs.setStatus(1);
            }

            if ("1".equals(meetingWithBLOBs.getCycle())) {
                List<String> appointDates = new ArrayList<String>();

                if (StringUtils.checkNull(meetingWithBLOBs.getCycleWeek())) {
                    appointDates = DateFormat.getAppointDates(meetingWithBLOBs.getCycleStartDate(), meetingWithBLOBs.getCycleEndDate(), null);
                } else {
                    String[] split = meetingWithBLOBs.getCycleWeek().split(",");
                    for (String week : split) {
                        appointDates.addAll(DateFormat.getAppointDates(meetingWithBLOBs.getCycleStartDate(), meetingWithBLOBs.getCycleEndDate(), Integer.valueOf(week)));
                    }
                }

                int maxCycleNo = meetingMapper.getMaxCycleNo();
                meetingWithBLOBs.setCycleNo(++maxCycleNo);
                //先进行判断周期性会议，周期时间内是否会议冲突
                for (int i = 0, size = appointDates.size(); i < size; i++) {
                    String s = appointDates.get(i);
                    Map<String, Object> maps = new HashMap<>();
                    maps.put("startTime", s + " " + meetingWithBLOBs.getCycleStartTime());
                    maps.put("endTime", s + " " + meetingWithBLOBs.getCycleEndTime());
                    maps.put("roomId", meetingWithBLOBs.getMeetRoomId());
                    int counts = meetingMapper.getMettingByTime(maps);
                    if (counts > 0) {
                        json.setMsg(s + " " + meetingWithBLOBs.getCycleStartTime() + "到" + s + " " + meetingWithBLOBs.getCycleEndTime() + "，会议室已被占用,请重新修改时间！");
                        return json;
                    }
                }
                //因为事务提醒放到for循环里面，会导致一个提醒url地址最后没有sid，一个提醒有
                //所以放到外面，单独循环
                List<Integer> sidList = new ArrayList<>();
                for (int i = 0, size = appointDates.size(); i < size; i++) {
                    meetingWithBLOBs.setSid(null);
                    String s = appointDates.get(i);
                    meetingWithBLOBs.setStartTime(s + " " + meetingWithBLOBs.getCycleStartTime());
                    meetingWithBLOBs.setEndTime(s + " " + meetingWithBLOBs.getCycleEndTime());
                    int count = meetingMapper.insertMeeting(meetingWithBLOBs);
                    if (count > 0 && meetingWithBLOBs.getSid() != null) {
                        sidList.add(meetingWithBLOBs.getSid());
                    }
                }
                if (!CollectionUtils.isEmpty(sidList)) {
                    addAffairs3(meetingWithBLOBs, sidList, appointDates, request);
                    //判断是否自动审批通过，如果自动审批通过给参会人发送事务提醒
                    if (meetingWithBLOBs.getStatus() != null && meetingWithBLOBs.getStatus() == 2) {
                        addAffairs4(meetingWithBLOBs, sidList, appointDates, request);
                        //审批通过自动存入会议参会及查阅情况表
                        Date date1 = new Date();
                        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        for (Integer sId : sidList) {
                            MeetingAttendConfirm meetingAttendConfirm = new MeetingAttendConfirm();
                            meetingAttendConfirm.setAttendFlag(0);
                            meetingAttendConfirm.setCreateTime(sdf1.format(date1));
                            meetingAttendConfirm.setMeetingId(sId);
                            meetingAttendConfirm.setReadFlag(0);
                            meetingAttendConfirm.setRemark("");
                            meetingAttendConfirm.setCreateUser(meetingWithBLOBs.getUid());
                            if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                                String[] attendArray = meetingWithBLOBs.getAttendee().split(",");
                                if (attendArray.length > 0) {
                                    for (String attendId : attendArray) {
                                        meetingAttendConfirm.setAttendeeId(Integer.valueOf(attendId));
                                        meetingAttendConfirmMapper.insertConfirm(meetingAttendConfirm);
                                    }
                                }
                            }

                        }
                    }
                }
                json.setMsg("申请成功");
                json.setFlag(0);
            } else {
                int count = meetingMapper.insertMeeting(meetingWithBLOBs);
                addAffairs(meetingWithBLOBs, request);
                //判断是否自动审批通过，如果自动审批通过给参会人发送事务提醒
                if (meetingWithBLOBs.getStatus() != null && meetingWithBLOBs.getStatus() == 2) {
                    addAffairs1(meetingWithBLOBs, request);
                //审批通过自动存入会议参会及查阅情况表
                    Date date1 = new Date();
                    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    MeetingAttendConfirm meetingAttendConfirm = new MeetingAttendConfirm();
                    meetingAttendConfirm.setAttendFlag(0);
                    meetingAttendConfirm.setCreateTime(sdf1.format(date1));
                    meetingAttendConfirm.setMeetingId(meetingWithBLOBs.getSid());
                    meetingAttendConfirm.setReadFlag(0);
                    meetingAttendConfirm.setRemark("");
                    meetingAttendConfirm.setCreateUser(meetingWithBLOBs.getUid());
                    if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                        String[] attendArray = meetingWithBLOBs.getAttendee().split(",");
                        if (attendArray.length > 0) {
                            for (String attendId : attendArray) {
                                meetingAttendConfirm.setAttendeeId(Integer.valueOf(attendId));
                                meetingAttendConfirmMapper.insertConfirm(meetingAttendConfirm);
                            }
                        }
                    }

                }
                if (count > 0) {
                    if (meetingWithBLOBs.getMeetRoomId().equals(0)) {
                        //暂时不考虑周期性，创建完视频会议直接审批
                        Meeting meeting = new Meeting();
                        meeting.setSid(meetingWithBLOBs.getSid()); //会议室Id
                        meeting.setStatus(meetingWithBLOBs.getStatus()); //状态2已审批
                        this.updMeetStatusById(request, meeting, true);
                    }
                    json.setMsg("申请成功");
                    json.setFlag(0);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl insertMeeting:" + e);
        }
        return json;
    }

    /**
     * 普陀教育用到   这个是复制  申请会议（添加会议信息）   改的
     * @param meetingWithBLOBs
     * @param request
     * @return
     */
    @Transactional
    @Override
    public ToJson<MeetingWithBLOBs> PTinsertMeeting(MeetingWithBLOBs meetingWithBLOBs, HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        user = usersService.getUsersByuserId(user.getUserId());

        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");

        if( meetingWithBLOBs.getMeetRoomId() == null ){
            json.setMsg("教室不存在！");
            return json;
        }

        Map<String, Object> maps = new HashMap<>();
        maps.put("startTime", meetingWithBLOBs.getStartTime());
        maps.put("endTime", meetingWithBLOBs.getEndTime());
        maps.put("roomId", meetingWithBLOBs.getMeetRoomId());
        int counts = meetingMapper.getPTMettingByTime(maps);
        if (counts > 0) {
            json.setMsg("该教室已被占用,请重新修改时间！");
            return json;
        }

        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingWithBLOBs.setCreateTime(sdf.format(date));
            //判断是否是视频会议室，如果室直接审批
            if (meetingWithBLOBs.getStatus() == null){
                if (meetingWithBLOBs.getMeetRoomId().equals(0)) {
                    meetingWithBLOBs.setStatus(2); //状态2已审批
                } else {
                    meetingWithBLOBs.setStatus(1);
                }
            }

            Map<String, Object> map = new HashedMap();
            map.put("meetRoomId", meetingWithBLOBs.getMeetRoomId());
            int useRommTotalCount = meetingMapper.selCountRoomNoConflict(map);//使用要申请的会议室的会议总数
            map.put("startTime", meetingWithBLOBs.getStartTime());
            map.put("endTime", meetingWithBLOBs.getEndTime());
            int useRommNoConflictCount = meetingMapper.selCountRoomNoConflict(map);//使用要申请会议室和已申请会议室不冲突的数量

            if (!StringUtils.checkNull(meetingWithBLOBs.getVideoConfFlag()) && meetingWithBLOBs.getVideoConfFlag().equals("1")) {
                useRommNoConflictCount = 0;
                useRommTotalCount = 0;
            }

            if (useRommTotalCount != useRommNoConflictCount) {
                json.setMsg("该教室已被占用");
                json.setFlag(1);
                return json;
            }

            //判断是否是周期性会议
            if ("1".equals(meetingWithBLOBs.getCycle())) {
                List<String> appointDates = new ArrayList<String>();

                if (StringUtils.checkNull(meetingWithBLOBs.getCycleWeek())) {
                    appointDates = DateFormat.getAppointDates(meetingWithBLOBs.getCycleStartDate(), meetingWithBLOBs.getCycleEndDate(), null);
                } else {
                    String[] split = meetingWithBLOBs.getCycleWeek().split(",");
                    for (String week : split) {
                        appointDates.addAll(DateFormat.getAppointDates(meetingWithBLOBs.getCycleStartDate(), meetingWithBLOBs.getCycleEndDate(), Integer.valueOf(week)));
                    }
                }

                int maxCycleNo = meetingMapper.getMaxCycleNo();
                meetingWithBLOBs.setCycleNo(++maxCycleNo);
                for (int i = 0, size = appointDates.size(); i < size; i++) {
                    String s = appointDates.get(i);
                    meetingWithBLOBs.setStartTime(s + " " + meetingWithBLOBs.getCycleStartTime());
                    meetingWithBLOBs.setEndTime(s + " " + meetingWithBLOBs.getCycleEndTime());
                    meetingMapper.insertMeeting(meetingWithBLOBs);
                    addAffairs(meetingWithBLOBs, request);

                    //创建日程 IS_WRITE_CALEDNAR  1.是  0.否
                    this.addCalendar(request,meetingWithBLOBs);
                }
                json.setMsg("申请成功");
                json.setFlag(0);
            }
            else {

                MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(meetingWithBLOBs.getMeetRoomId());
                List<String> Equipment = new ArrayList();
                if (meetRoomBySid != null && !StringUtils.checkNull(meetRoomBySid.getEquipmentNames())){
                    Equipment = Arrays.asList(meetRoomBySid.getEquipmentNames().split(","));
                }

                //判断是同步还是本地建立教室
                if ( Equipment.contains("B楼") ){
                    //预约roomis云空间
                    if (StringUtils.checkNull(meetRoomBySid.getMrPlace()) || StringUtils.checkNull(user.getTelNoDept())){
                        json.setMsg("未绑定教室 或 用户");
                        json.setFlag(1);
                        return json;
                    }

                    Date StartTime = DateFormat.getDate(meetingWithBLOBs.getStartTime());
                    Date EndTime = DateFormat.getDate(meetingWithBLOBs.getEndTime());
                    SimpleDateFormat sdfHm = new SimpleDateFormat("HH:mm");


                    Map map1 = new HashMap();
                    map1.put("organizerUid",user.getTelNoDept());
                    map1.put("spaceName",meetRoomBySid.getMrPlace());
                    map1.put("date",DateFormat.getDatestr(StartTime));
                    map1.put("topic",meetingWithBLOBs.getSubject());
                    map1.put("startTime",sdfHm.format(StartTime));
                    map1.put("endTime",sdfHm.format(EndTime));
                    String s = doPost("http://10.92.231.249:8080/api/v3/booking/events", map1, "utf-8");
                    if (StringUtils.checkNull(s)) {
                        json.setMsg("该教室已被占用");
                        json.setFlag(1);
                        return json;
                    }

                    Map mapTypes = JSON.parseObject(s);
                    if (!mapTypes.containsKey("eventId")) {
                        json.setObject(mapTypes);
                        json.setMsg("该教室已被占用");
                        json.setFlag(1);
                        return json;
                    }

                    //创建教室
                    meetingMapper.insertMeeting(meetingWithBLOBs);
                    //发送事务提醒
                    addAffairs(meetingWithBLOBs, request);
                    //创建日程 IS_WRITE_CALEDNAR  1.是  0.否
                    this.addCalendar(request,meetingWithBLOBs);

                    json.setMsg("申请成功");
                    json.setFlag(0);

                }
                else{
                    //创建教室
                    meetingMapper.insertMeeting(meetingWithBLOBs);
                    //发送事务提醒
                    addAffairs(meetingWithBLOBs, request);
                    //创建日程 IS_WRITE_CALEDNAR  1.是  0.否
                    this.addCalendar(request,meetingWithBLOBs);
                    json.setMsg("申请成功");
                    json.setFlag(0);
                }
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl insertMeeting:" + e);
        }
        return json;
    }

    public static String doPost(String url, Map<String, String> map, String charset) {
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            L.w("url is", url, "and param is ", map);
            //设置参数
            JSONObject jsonObject = new JSONObject();
            Iterator iterator = map.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, String> elem = (Map.Entry<String, String>) iterator.next();
                jsonObject.put(elem.getKey(), elem.getValue());
            }
            if (!StringUtils.checkNull(jsonObject.toString())) {
                StringEntity stringEntity = new StringEntity(jsonObject.toString(),"utf-8");
                stringEntity.setContentType("application/json");
                stringEntity.setContentEncoding("utf-8");
                httpPost.setEntity(stringEntity);
            }
            httpPost.addHeader("Content-type","application/json");
            httpPost.setHeader("Accept", "application/json");
            httpPost.setHeader("X-Consumer-Custom-ID", "ptjyxy");
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, charset);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            L.w("response exception", ex);
        }
        return result;
    }



    public void addCalendar(HttpServletRequest request , MeetingWithBLOBs meetingWithBLOBs){
        if (meetingWithBLOBs.getIsWriteCalednar() == 1){
            Calendar calendar = new Calendar();
            //日程类型：工作事务
            calendar.setCalType("2");
            //开始时间
            if (!StringUtils.checkNull(meetingWithBLOBs.getStartTime())) {
                calendar.setCalTime(DateFormat.getTime(meetingWithBLOBs.getStartTime()));
            }
            //结束时间
            if (!StringUtils.checkNull(meetingWithBLOBs.getEndTime())) {
                calendar.setEndTime(DateFormat.getTime(meetingWithBLOBs.getEndTime()));
            }
            //日程内容 时间+会议+会议室
            calendar.setContent( "会议：" + meetingWithBLOBs.getSubject() + " 会议室：" + meetingWithBLOBs.getMeetRoomName() );
            calendar.setAddTime(new Date());
            calendar.setCalLevel("1");
            calendar.setBeforeRemaind("0|" + meetingWithBLOBs.getResendHour() + "|" + meetingWithBLOBs.getResendMinute());


            // 设置创建人
            Users users = usersMapper.SimplefindUserByuid(meetingWithBLOBs.getUid());
            if (users != null) {
                calendar.setUserId(users.getUserId());

                //所属者 个人工作
                /*String s = meetingMapper.selectOwner(59);
                calendar.setOwner( s != null ? s+"," : "" );*/
                calendar.setOwner( users.getUserId() );
            }

            // 参与者
            //calendar.setTaker("ALL_USERID");
            calendar.setTaker("");

            // 插入日程
            calendar.setCalId(null);
            calendarService.insertSelective(calendar,request);

        }
    }

    @Override
    public ToJson<MeetingWithBLOBs> judgeMeeting(MeetingWithBLOBs meetingWithBLOBs, HttpServletRequest request) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        Map<String, Object> maps = new HashMap<>();
        maps.put("startTime", meetingWithBLOBs.getStartTime());
        maps.put("endTime", meetingWithBLOBs.getEndTime());
        maps.put("roomId", meetingWithBLOBs.getMeetRoomId());
        int counts = meetingMapper.getMettingByTime(maps);
        if (counts > 0) {
            json.setMsg("会议室已被占用,请重新修改时间");
            json.setFlag(1);
            json.setCode("1");
            return json;
        }
        json.setMsg("会议室可以使用");
        json.setFlag(0);
        json.setCode("0");
        return json;
    }



    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:06:00
     * 方法介绍:  根据id删除会议信息
     * 参数说明:   @param sid
     * 返回值说明:   @return int 删除条数
     */
    @Transactional
    @Override
    public ToJson<MeetingWithBLOBs> delMeetingById(HttpServletRequest request,String sid) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            int count = meetingMapper.delMeetingById(sid);
            if (count > 0) {
                meetingAttendConfirmMapper.delConfirmById(sid);

                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl delMeetingById:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  根据会议id进行查询参会及查阅情况
     * 参数说明:   @param meetingId 会议id
     * 返回值说明:   @return List
     */
    @Override
    public ToJson<MeetingAttendConfirm> queryAttendConfirm(String meetingId) {
        ToJson<MeetingAttendConfirm> json = new ToJson<MeetingAttendConfirm>(1, "error");
        try {
            List<MeetingAttendConfirm> meetingAttendConfirmList = meetingAttendConfirmMapper.queryAttendConfirm(meetingId);
            for (MeetingAttendConfirm meetingAttendConfirm : meetingAttendConfirmList) {

                if (meetingAttendConfirm.getAttendFlag() != null) {
                    switch (meetingAttendConfirm.getAttendFlag()) {
                        case 0:
                            meetingAttendConfirm.setAttendFlagStr("未签到");
                            break;
                        case 1:
                            meetingAttendConfirm.setAttendFlagStr("已签到");
                            break;
                        case 2:
                            meetingAttendConfirm.setAttendFlagStr("迟到");
                            break;
                        case 3:
                            meetingAttendConfirm.setAttendFlagStr("请假");
                            break;
                        case 4:
                            meetingAttendConfirm.setAttendFlagStr("缺勤");
                            break;
                    }
                }

                if (meetingAttendConfirm.getReadFlag() != null) {
                    switch (meetingAttendConfirm.getReadFlag()) {
                        case 0:
                            meetingAttendConfirm.setReadFlagStr("待阅读");
                            break;
                        case 1:
                            meetingAttendConfirm.setReadFlagStr("已签阅");
                            break;
                    }
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
            }
            json.setObj(meetingAttendConfirmList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryAttendConfirm:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:48:00
     * 方法介绍:  根据状态获取会议的数量
     * 参数说明:   @param meeting
     * 返回值说明:   @return int
     */
    public ToJson<Meeting> queryCountByStatu(HttpServletRequest request) {
        ToJson<Meeting> json = new ToJson<Meeting>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            Meeting meeting = new Meeting(); //返回的
            Map paraMeeting = new HashMap(); //条件

            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            paraMeeting.put("uid", user.getUid());
            paraMeeting.put("userPriv", user.getUserPriv());
            paraMeeting.put("status", 1);//待批
            meeting.setPendingCount(meetingMapper.queryCountByStatu(paraMeeting));

            /*//已批
            MeetingWithBLOBs meetingWithBLOBs=new MeetingWithBLOBs();
            meetingWithBLOBs.setStatus(2);
            meetingWithBLOBs.setManagerId(user.getUid());
            List<MeetingWithBLOBs> meetingWithBLOBsList=approveMeeting(meetingWithBLOBs,1,0,false);
            meeting.setApprovedCount(meetingWithBLOBsList.size());*/
            paraMeeting.put("status", 2);//已批
            meeting.setApprovedCount(meetingMapper.queryCountByStatu(paraMeeting));

            paraMeeting.put("status", 4);//未批
            meeting.setNotApprovedCount(meetingMapper.queryCountByStatu(paraMeeting));

            paraMeeting.put("status", 3);//进行中
            //paraMeeting.put("currentTime",sdf.format(date));
            meeting.setProcessingCount(meetingMapper.queryCountByStatu(paraMeeting));

            paraMeeting.put("status", 5);//已结束
            //paraMeeting.put("currentTime",sdf.format(date));
            meeting.setOverCount(meetingMapper.queryCountByStatu(paraMeeting));

            paraMeeting.put("status", 1);//周期性会议待批
            paraMeeting.put("cycle", "1");
            meeting.setCyclePendingCount(meetingMapper.queryCountByStatu(paraMeeting));

            json.setObject(meeting);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryCountByStatus:" + e);
        }
        return json;
    }

    @Override
    public ToJson<MeetingWithBLOBs> getApp(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, String userId, String sqlType) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        //meetingStatus();//更改有的会议已经结束
        maps.put("page", pageParams);
        maps.put("userId", userId);
        List<MeetingWithBLOBs> app = meetingMapper.getApp(maps);
        json.setObj(app);
        return json;
    }

    public void meetingStatus() {
        List<Meeting> meetings = meetingMapper.selectAll();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        long currentTime = date.getTime();
        for (Meeting meeting : meetings) {
            long startTime = 0;
            long endTime = 0;
            if (!StringUtils.checkNull(meeting.getStartTime()) && ".0".equals(meeting.getStartTime().substring(meeting.getStartTime().length() -2,meeting.getStartTime().length()))){
                meeting.setStartTime(meeting.getStartTime().substring(0,meeting.getStartTime().length()-2));
            }

            if (!StringUtils.checkNull(meeting.getEndTime()) &&".0".equals(meeting.getEndTime().substring(meeting.getEndTime().length() -2,meeting.getEndTime().length()))){
                meeting.setEndTime(meeting.getEndTime().substring(0,meeting.getEndTime().length()-2));
            }
            if (null!=meeting.getStartTime()) {
                try {
                    startTime = sdf.parse(meeting.getStartTime()).getTime();
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            if (null!=meeting.getEndTime()) {
                try {
                    endTime = sdf.parse(meeting.getEndTime()).getTime();
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            //设置会议的状态
            if (meeting.getStatus() != null) {
                switch (meeting.getStatus()) {
                    case 0:
                        meeting.setStatusName("待审批");
                        break;
                    case 1:
                        meeting.setStatusName("待审批");
                        break;
                    case 2:
                        /*meeting.setStatusName("已审批");
                        meeting.setStatus(2);*/
                        if (startTime <= currentTime && currentTime < endTime) {
                            meeting.setStatusName("进行中");
                            meeting.setStatus(3);
                        } else if (startTime <= currentTime && currentTime >= endTime) {
                            meeting.setStatusName("已结束");
                            meeting.setStatus(5);
                            //会议结束时整理签到图片
                            try {
                                registerPhoto(meeting);
                            }catch (Exception e){

                            }
                        } else {
                            meeting.setStatusName("已审批");
                            meeting.setStatus(2);
                        }
                        //更新状态
                        int i = meetingMapper.updMeetStatusById(meeting);

                        break;
                    case 3:
                        if (startTime <= currentTime && currentTime >= endTime) {
                            meeting.setStatusName("已结束");
                            meeting.setStatus(5);
                            //会议结束时整理签到图片
                            try {
                                registerPhoto(meeting);
                            }catch (Exception e){

                            }
                        }
                        //更新状态  进行中的如果结束  设置为结束
                        int i1 = meetingMapper.updMeetStatusById(meeting);
                        break;
                    case 4:
                        meeting.setStatusName("未批准");
                        break;
                    case 5:
                        meeting.setStatusName("已结束");
                        break;
                }
            }
        }
    }

    private void registerPhoto(Meeting meeting) {
        List<MeetingAttendConfirm> meetingByMeetingId = meetingAttendConfirmMapper.getMeetingByMeetingId(meeting.getSid());


        MeetingWithBLOBs meetingWithBLOBs = meetingMapper.queryMeetingById(meeting.getSid().toString());
        meetingWithBLOBs.setRegisterPhotoId("");
        meetingWithBLOBs.setRegisterPhotoName("");
        meetingMapper.updateMeetingByIdV1(meetingWithBLOBs);
    }

    /**
     * @param fileUrl 文件绝对路径或相对路径
     * @return 读取到的缓存图像
     * @throws IOException 路径错误或者不存在该文件时抛出IO异常
     */
    public static BufferedImage getBufferedImage(String fileUrl) throws IOException {
        File f = new File(fileUrl);
        return ImageIO.read(f);
    }

    /**
     * 远程图片转BufferedImage
     * @param destUrl    远程图片地址
     * @return
     */
    public static BufferedImage getBufferedImageDestUrl(String destUrl) {
        HttpURLConnection conn = null;
        BufferedImage image = null;
        try {
            URL url = new URL(destUrl);
            conn = (HttpURLConnection) url.openConnection();
            if (conn.getResponseCode() == 200) {
                image = ImageIO.read(conn.getInputStream());
                return image;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.disconnect();
        }
        return image;
    }


    /**
     * 输出图片
     * @param buffImg  图像拼接叠加之后的BufferedImage对象
     * @param savePath 图像拼接叠加之后的保存路径
     */
    public static void generateSaveFile(BufferedImage buffImg, String savePath) {
        int temp = savePath.lastIndexOf(".") + 1;
        try {
            File outFile = new File(savePath);
            if(!outFile.exists()){
                outFile.createNewFile();
            }
            ImageIO.write(buffImg, savePath.substring(temp), outFile);
            System.out.println("ImageIO write...");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public ToJson<Meeting> queryCountByStatus(HttpServletRequest request) {
        ToJson<Meeting> json = new ToJson<Meeting>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            Meeting meeting = new Meeting(); //返回的
            Map paraMeeting = new HashMap(); //条件

            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            paraMeeting.put("uid", user.getUid());
            paraMeeting.put("status", 1);//待批
            meeting.setPendingCount(meetingMapper.queryCountByStatus(paraMeeting));

            //已批
            MeetingWithBLOBs meetingWithBLOBs = new MeetingWithBLOBs();
            meetingWithBLOBs.setStatus(2);
            meetingWithBLOBs.setManagerId(user.getUid());
            List<MeetingWithBLOBs> meetingWithBLOBsList = approveMeeting(meetingWithBLOBs, 1, 0, false);
            meeting.setApprovedCount(meetingWithBLOBsList.size());

            paraMeeting.put("status", 4);//未批
            meeting.setNotApprovedCount(meetingMapper.queryCountByStatus(paraMeeting));

            paraMeeting.put("status", 3);//进行中
            paraMeeting.put("currentTime", sdf.format(date));
            meeting.setProcessingCount(meetingMapper.queryCountByStatus(paraMeeting));

            paraMeeting.put("status", 5);//已结束
            paraMeeting.put("currentTime", sdf.format(date));
            meeting.setOverCount(meetingMapper.queryCountByStatus(paraMeeting));

            paraMeeting.put("status", 1);//周期性会议待批
            paraMeeting.put("cycle", 1);
            meeting.setCyclePendingCount(meetingMapper.queryCountByStatus(paraMeeting));

            json.setObject(meeting);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryCountByStatus:" + e);
        }
        return json;
    }

    public List<MeetingWithBLOBs> approveMeeting(MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", pageParams);
        meetingWithBLOBs.setStatus(2);
        map.put("meetingWithBLOBs", meetingWithBLOBs);
        List<MeetingWithBLOBs> allApproveMeetList = meetingMapper.queryMeeting(map);

        map.remove("page");
        meetingWithBLOBs.setStatus(3);
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        meetingWithBLOBs.setCurrentTime(sdf.format(date));
        map.put("meetingWithBLOBs", meetingWithBLOBs);
        List<MeetingWithBLOBs> doingMeetList = meetingMapper.queryMeeting(map);
        meetingWithBLOBs.setStatus(5);
        map.put("meetingWithBLOBs", meetingWithBLOBs);
        List<MeetingWithBLOBs> endingMeetList = meetingMapper.queryMeeting(map);
        List<MeetingWithBLOBs> meetingWithBLOBsTemp = new ArrayList<MeetingWithBLOBs>();//已结束和进行中的会议
        meetingWithBLOBsTemp.addAll(doingMeetList);
        meetingWithBLOBsTemp.addAll(endingMeetList);
        List<MeetingWithBLOBs> approveMeetList = new ArrayList<MeetingWithBLOBs>();//去除后的已审批会议
        for (MeetingWithBLOBs meeting : allApproveMeetList) {//删除正在进行的会议
            int count = 0;
            for (MeetingWithBLOBs temp : meetingWithBLOBsTemp) {
                if (meeting.getSid() == temp.getSid()) {
                    count++;
                    break;
                }
            }
            if (count == 0) {
                approveMeetList.add(meeting);
            }
        }
        return approveMeetList;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  修改参会人员的签阅
     * 参数说明:   @param meetingAttendConfirm
     * 返回值说明:   @return int
     */
    @Override
    @Transactional
    public ToJson<MeetingWithBLOBs> updateConfirmReadStatusBySId(MeetingAttendConfirm meetingAttendConfirm, HttpServletRequest request) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meetingAttendConfirm.setAttendeeId(user.getUid());
            meetingAttendConfirm.setReadingTime(sdf.format(date));
            meetingAttendConfirm.setReadFlag(1);
            meetingAttendConfirmMapper.updateStatusBySId(meetingAttendConfirm);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl updateConfirmReadStatusBySId:" + e);
        }
        return json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  修改参会人员参会状态，并返回签到人员的相关信息
     * 参数说明:   @param meetingAttendConfirm
     * 返回值说明:   @return int
     */
    @Override
    @Transactional
    public ToJson<Users> updateConfirmAttendStatusBySId(MeetingAttendConfirm meetingAttendConfirm, HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            //需求：签到时间（在会议开始时间的当天到会议结束都可以可以签到）
            //根据会议id查找会议，获取会议的开始时间
            MeetingWithBLOBs meetingWithBLOBs = new MeetingWithBLOBs();
            if (meetingAttendConfirm.getMeetingId() != null) {
                meetingWithBLOBs = meetingMapper.queryMeetingById(meetingAttendConfirm.getMeetingId().toString());
                if (meetingWithBLOBs != null) {
                    String currentDay = meetingWithBLOBs.getStartTime().substring(0, 10) + " 00:00:00";
                    long currentDayTime = DateFormat.getTime(currentDay);//会议开始当天的起始时间(可以开始签到时间)
                    long endDayTime = DateFormat.getTime(meetingWithBLOBs.getEndTime());//会议的结束时间
                    long currentTime = DateFormat.getTime(DateFormat.getStrDate(new Date()));//要签到的当前时间
                    if (currentTime < currentDayTime) {//如果签到时间<可以开始签到时间，表示签到时间还未到
                        json.setMsg("未到签到时间");
                        return json;
                    }
                    if (currentTime > endDayTime) {//如果签到时间大于结束时间，签到时间已过，会议已结束
                        json.setMsg("签到时间已过，会议已结束");
                        return json;
                    }
                    //当前签到人不是出席会议人员时，不能进行签到
                    if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                        if (!meetingWithBLOBs.getAttendee().contains(user.getUid() + ",") && !meetingWithBLOBs.getAttendee().contains("," + user.getUid() + ",")) {
                            json.setMsg("您没有签到权限");
                            return json;
                        }
                    } else {
                        json.setMsg("您没有签到权限");
                        return json;
                    }
                    //不可重复签到
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("meetingId", meetingAttendConfirm.getMeetingId());
                    map.put("attendeeId", meetingAttendConfirm.getAttendeeId());
                    MeetingAttendConfirm temp = meetingAttendConfirmMapper.queryMyAttend(map);
                    if (temp != null) {
                        if (temp.getAttendFlag() == 1) {
                            json.setMsg("不能重复签到");
                            return json;
                        }
                    }
                    //可以进行签到
                    Date date = new Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    meetingAttendConfirm.setAttendeeId(user.getUid());
                    meetingAttendConfirm.setConfirmTime(sdf.format(date));
                    if (!StringUtils.checkNull(meetingWithBLOBs.getSignInTime())){
                        long signInTime = DateFormat.getTime(meetingWithBLOBs.getSignInTime());//会议的签到时间
                        //判断是否签到迟到
                        if (currentTime > currentDayTime && currentTime < signInTime){
                            meetingAttendConfirm.setAttendFlag(1);
                        }else if (currentTime < endDayTime && currentTime > signInTime){
                            meetingAttendConfirm.setAttendFlag(2);
                        }
                    }else {
                        meetingAttendConfirm.setAttendFlag(1);
                    }
                    int count = meetingAttendConfirmMapper.updateStatusBySId(meetingAttendConfirm);
                    //将该签到人的相关信息反显回去，包括人事档案中的照片
                    //查看该签到人是否有人事档案，有则获取其人事档案中的头像
                    if (count > 0) {
                        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
                        HttpSession session = request.getSession();
                        Map<String, Object> paraMap = new HashedMap();
                        paraMap.put("attendFlag", true);
                        SessionUtils.putSession(session, paraMap, redisSessionCookie);

                        json.setMsg("ok");
                        json.setFlag(0);
                        json.setObject(user);
                    }
                }
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl updateConfirmAttendStatusBySId:" + e);
        }
        return json;
    }

    private void thirdAttendMeeting(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Users user) {
        Map<String,String> param =new HashMap();
        MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(meetingWithBLOBs.getMeetRoomId());
        Users usersByUid = usersMapper.getUsersByUid(user.getUid());
        param.put("method","sign");
        param.put("roomId",meetRoomBySid.getRoomAddress());
        param.put("userId",user.getUserId());
        param.put("phone",usersByUid.getMobilNo());

        try {
            this.threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    String para = com.alibaba.fastjson.JSONObject.toJSONString(param);
                    HttpResponse response = null;
                    try {
                        response = HttpUtils.doPost("http://10.191.10.247:1080", "/services/api/BookingService.aspx", "", param, param, para);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    HttpEntity entity = response.getEntity();
                    if (entity != null) {
                        JSONObject object = null;
                        String result = null;
                        try {
                            result = EntityUtils.toString(entity, "UTF-8");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        object = JSONObject.fromObject(result);
                        System.out.println(object);
                    }
                }});
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public ToJson<Users> checkAttend(HttpServletRequest request) {
        ToJson<Users> toJson = new ToJson<>(0, "ok");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");

        String attendFlag = SessionUtils.getSessionInfo(request.getSession(), "attendFlag", String.class, redisSessionId);
        String avatar = SessionUtils.getSessionInfo(request.getSession(), "avatar", String.class, redisSessionId);
        String photoName = SessionUtils.getSessionInfo(request.getSession(), "photoName", String.class, redisSessionId);
        String userName = SessionUtils.getSessionInfo(request.getSession(), "userName", String.class, redisSessionId);
        String deptName = SessionUtils.getSessionInfo(request.getSession(), "deptName", String.class, redisSessionId);
        String userPrivName = SessionUtils.getSessionInfo(request.getSession(), "userPrivName", String.class, redisSessionId);
        Users users = new Users();
        users.setMyStatus(attendFlag);
        users.setAvatar(avatar);
        users.setPhotoName(photoName);
        users.setUserName(userName);
        users.setDeptName(deptName);
        users.setUserPrivName(userPrivName);
        toJson.setObject(users);
        return toJson;
    }


    /**
     * 方法介绍:  门户会议通知列表查询（状态为已批准、进行中的会议申请，所有人可见）
     * 创建作者:   刘新婷
     * 创建日期:   2018-01-29
     *
     * @param page
     * @param pageSize
     * @param useFlag
     * @return
     */
    @Override
    public ToJson<MeetingWithBLOBs> getMeetingNotify(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            meetingWithBLOBs.setUid(user.getUid());
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("meetingWithBLOBs", meetingWithBLOBs);
            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long currentTime = Long.valueOf(DateFormat.getTime(sdf.format(date)));
            List<MeetingWithBLOBs> meetingList = meetingMapper.getMeetingNotify(map);
            for (MeetingWithBLOBs meetingWithBLOBs1 : meetingList) {
                //判断该会议是否在进行中
                Long startDate = Long.valueOf(DateFormat.getTime(meetingWithBLOBs1.getStartTime()));
                Long endDate = Long.valueOf(DateFormat.getTime(meetingWithBLOBs1.getEndTime()));
                if (2 == meetingWithBLOBs1.getStatus() && currentTime >= startDate && currentTime <= endDate) {
                    meetingWithBLOBs1.setStatus(3);
                    meetingWithBLOBs1.setStatusName("进行中");
                } else if (2 == meetingWithBLOBs1.getStatus() && currentTime > endDate) {
                    meetingWithBLOBs1.setStatusName("已结束");
                } else if (2 == meetingWithBLOBs1.getStatus()) {
                    meetingWithBLOBs1.setStatusName("已批准");
                } else if (3 == meetingWithBLOBs1.getStatus()) {
                    meetingWithBLOBs1.setStatusName("进行中");
                }

                if (meetingWithBLOBs1.getUid() != null) {
                    meetingWithBLOBs1.setUserName(usersMapper.getUsernameById(meetingWithBLOBs1.getUid()));
                }
                if (meetingWithBLOBs1.getManagerId() != null) {
                    meetingWithBLOBs1.setManagerName(usersMapper.getUsernameById(meetingWithBLOBs1.getManagerId()));
                }
                if (meetingWithBLOBs1.getMeetRoomId() != null) {
                    try {
                        MeetingRoom meetingRoom = meetingRoomMapper.getMeetRoomBySid((int) meetingWithBLOBs1.getMeetRoomId());
                        if (meetingRoom != null) {
                            meetingWithBLOBs1.setMeetRoomName(meetingRoom.getMrName());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (meetingWithBLOBs1.getMeetRoomId() == 0) {
                            meetingWithBLOBs1.setMeetRoomName("视频会议");
                        }
                    }

                }

                if (!StringUtils.checkNull(meetingWithBLOBs1.getStartTime())) {
                    meetingWithBLOBs1.setStartTime(meetingWithBLOBs1.getStartTime().substring(0, meetingWithBLOBs1.getStartTime().length() - 2));
                }
                if (!StringUtils.checkNull(meetingWithBLOBs1.getEndTime())) {
                    meetingWithBLOBs1.setEndTime(meetingWithBLOBs1.getEndTime().substring(0, meetingWithBLOBs1.getEndTime().length() - 2));
                }
                if (!StringUtils.checkNull(meetingWithBLOBs1.getCreateTime())) {
                    meetingWithBLOBs1.setCreateTime(meetingWithBLOBs1.getCreateTime().substring(0, meetingWithBLOBs1.getCreateTime().length() - 2));
                }
            }
            json.setObj(meetingList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryMeeting:" + e);
        }
        return json;
    }

    /**
     * @author 程叶同
     * @date 2018/7/25 20:01
     * @desc 首页会议通知模块显示接口
     */

    @Override
    public ToJson<MeetingWithBLOBs> getMeetingNotifyFirstDesktop(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        try {
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("meetingWithBLOBs", meetingWithBLOBs);
            //获取当前时间的时间戳，判断当前会议是否正在进行
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long currentTime = Long.valueOf(DateFormat.getTime(sdf.format(date)));
            List<MeetingWithBLOBs> meetingList = meetingMapper.getMeetingNotify(map);
            Iterator<MeetingWithBLOBs> iterator = meetingList.iterator();
            while (iterator.hasNext()) { //进行迭代删除 排除已结束的会议
                MeetingWithBLOBs meetting = iterator.next();
                Long startDate = Long.valueOf(DateFormat.getTime(meetting.getStartTime()));
                Long endDate = Long.valueOf(DateFormat.getTime(meetting.getEndTime()));
                if (currentTime > endDate) {
                    iterator.remove();
                }
            }
            for (MeetingWithBLOBs meetingWithBLOBs1 : meetingList) {
                //判断该会议是否在进行中
                Long startDate = Long.valueOf(DateFormat.getTime(meetingWithBLOBs1.getStartTime()));
                Long endDate = Long.valueOf(DateFormat.getTime(meetingWithBLOBs1.getEndTime()));
                if (2 == meetingWithBLOBs1.getStatus() && currentTime >= startDate && currentTime <= endDate) {
                    meetingWithBLOBs1.setStatus(3);
                    meetingWithBLOBs1.setStatusName("进行中");
                    meetingWithBLOBs1.setMeetName(meetingWithBLOBs1.getMeetName() + "(进行中)");
                } else if (2 == meetingWithBLOBs1.getStatus()) {
                    meetingWithBLOBs1.setStatusName("已批准");
                } else if (3 == meetingWithBLOBs1.getStatus()) {
                    meetingWithBLOBs1.setStatusName("进行中");
                    meetingWithBLOBs1.setMeetName(meetingWithBLOBs1.getMeetName() + "(进行中)");
                }

                if (meetingWithBLOBs1.getUid() != null) {
                    meetingWithBLOBs1.setUserName(usersMapper.getUsernameById(meetingWithBLOBs1.getUid()));
                }
                if (meetingWithBLOBs1.getManagerId() != null) {
                    meetingWithBLOBs1.setManagerName(usersMapper.getUsernameById(meetingWithBLOBs1.getManagerId()));
                }
                if (meetingWithBLOBs1.getMeetRoomId() != null) {
                    MeetingRoom meetingRoom = meetingRoomMapper.getMeetRoomBySid((int) meetingWithBLOBs1.getMeetRoomId());
                    if (meetingRoom != null) {
                        meetingWithBLOBs1.setMeetRoomName(meetingRoom.getMrName());
                    }
                }

                if (!StringUtils.checkNull(meetingWithBLOBs1.getStartTime())) {
                    meetingWithBLOBs1.setStartTime(meetingWithBLOBs1.getStartTime().substring(0, meetingWithBLOBs1.getStartTime().length() - 2));
                }
                if (!StringUtils.checkNull(meetingWithBLOBs1.getEndTime())) {
                    meetingWithBLOBs1.setEndTime(meetingWithBLOBs1.getEndTime().substring(0, meetingWithBLOBs1.getEndTime().length() - 2));
                }
                if (!StringUtils.checkNull(meetingWithBLOBs1.getCreateTime())) {
                    meetingWithBLOBs1.setCreateTime(meetingWithBLOBs1.getCreateTime().substring(0, meetingWithBLOBs1.getCreateTime().length() - 2));
                }
            }
            json.setObj(meetingList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl queryMeeting:" + e);
        }
        return json;
    }

    @Override
    public ToJson tongBuUid() {
        ToJson json = new ToJson();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("meetingWithBLOBs", new MeetingWithBLOBs());
        List<MeetingWithBLOBs> meetingWithBLOBs = meetingMapper.queryMeeting(map);
        for (int i = 0, size = meetingWithBLOBs.size(); i < size; i++) {
            MeetingWithBLOBs meetingWithBLOBs1 = meetingWithBLOBs.get(i);
            if (!StringUtils.checkNull(meetingWithBLOBs1.getmProposer())) {
                Users usersByuserId = usersMapper.getUsersByuserId(meetingWithBLOBs1.getmProposer());
                if (usersByuserId != null && usersByuserId.getUid() != null) {
                    meetingWithBLOBs1.setUid(usersByuserId.getUid());
                }
            }
            if (!StringUtils.checkNull(meetingWithBLOBs1.getmManager())) {
                Users usersByuserId = usersMapper.getUsersByuserId(meetingWithBLOBs1.getmManager());
                if (usersByuserId != null && usersByuserId.getUid() != null) {
                    meetingWithBLOBs1.setManagerId(usersByuserId.getUid());
                }
            }
            meetingMapper.updateMeetingById(meetingWithBLOBs1);
        }

        List<MeetingRoomWithBLOBs> allMeetRoomInfo = meetingRoomMapper.getAllMeetRoomInfo(null);
        for (int i = 0, size = allMeetRoomInfo.size(); i < size; i++) {

            MeetingRoomWithBLOBs meetingRoomWithBLOBs = allMeetRoomInfo.get(i);

            if (!StringUtils.checkNull(meetingRoomWithBLOBs.getOperator())) {
                String operator = meetingRoomWithBLOBs.getOperator();
                String[] operators = operator.split(",");
                StringBuilder operatorSb = new StringBuilder();
                for (int j = 0, length = operators.length; j < length; j++) {
                    if (!StringUtils.checkNull(operators[0])) {
                        Users usersByuserId = usersMapper.getUsersByuserId(operators[0]);
                        if (usersByuserId != null && usersByuserId.getUid() != null) {
                            operatorSb.append(usersByuserId.getUid()).append(",");
                        }
                    }
                }
                meetingRoomWithBLOBs.setManagerids(operatorSb.toString());
            }


            if (!StringUtils.checkNull(meetingRoomWithBLOBs.getSecretToId())) {
                String secretToId = meetingRoomWithBLOBs.getSecretToId();
                String[] secretToIds = secretToId.split(",");
                StringBuilder secretToIdSb = new StringBuilder();
                for (int j = 0, length = secretToIds.length; j < length; j++) {
                    if (!StringUtils.checkNull(secretToIds[0])) {
                        Users usersByuserId = usersMapper.getUsersByuserId(secretToIds[0]);
                        if (usersByuserId != null && usersByuserId.getUid() != null) {
                            secretToIdSb.append(usersByuserId.getUid()).append(",");
                        }
                    }
                }
                meetingRoomWithBLOBs.setMeetroomperson(secretToIdSb.toString());
            }
            meetingRoomMapper.updateByPrimaryKeySelective(meetingRoomWithBLOBs);

        }

        json.setFlag(0);
        return json;
    }

    @Override
    public ToJson<Object> getManagers(Integer roomId, String paraName) {
        ToJson<Object> json = new ToJson<Object>();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        MeetingRoomWithBLOBs meetRoomBySid = null;
        if (roomId != null) {
            meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(roomId);
        }
        if (meetRoomBySid != null && !StringUtils.checkNull(meetRoomBySid.getManagerids())) {
            List<Users> usersByUidsOrder = usersMapper.getUsersByUids(meetRoomBySid.getManagerids().split(","));
            dataMap.put("usersList", usersByUidsOrder);
        } else {
            ToJson<SysPara> userName = sysParaService.getUserName(paraName);
            SysPara object = (SysPara) userName.getObject();
            dataMap.put("usersList", object.getUsersList());
        }

        json.setObject(dataMap);
        json.setFlag(0);
        return json;
    }

    @Override
    public ToJson<MeetingWithBLOBs> MyMeeting(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingWithBLOBs> json = new ToJson<MeetingWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            Map<String, Object> map = new HashMap<String, Object>();

            //分页
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page", pageParams);

            meetingWithBLOBs.setUid(user.getUid());
            map.put("meetingWithBLOBs", meetingWithBLOBs);

            //获取url信息
            String videourl = "";
            String userpost = "";
            VideoConf videoConf = videoConfMapper.selectByConfType(CONF_TYPE2);
            if ( videoConf != null ){
                videourl = videourl(videoConf);
                //视频会议获取登录认证
                userpost = PostVideoUrl.userpost(videourl, videoConf != null && !StringUtils.checkNull(videoConf.getCompanyId()) ? videoConf.getCompanyId() : "");
            }

            //获取当前时间的时间戳，判断当前会议是否正在进行
            List<MeetingWithBLOBs> meetingList = meetingMapper.MyMeeting(map);
            for (MeetingWithBLOBs meeting : meetingList) {

                if (meeting.getUid() != null) {
                    meeting.setUserName(usersMapper.getUsernameById(meeting.getUid()));
                }

                if (meeting.getMeetRoomId() != null && !meeting.getMeetRoomId().equals(0)) {
                    meeting.setMeetRoomName( meetingRoomMapper.getRoomName(meeting.getMeetRoomId()) );
                } else if (Optional.ofNullable(meeting.getMeetRoomId()).orElse(0)==0) {
                    meeting.setMeetRoomName("视频会议");
                }

                if (videoConf != null && !StringUtils.checkNull(meeting.getVideoConfFlag()) && meeting.getVideoConfFlag().equals("1")) {
                    String PostprepareLoginConf = PostVideoUrl.postprepareLoginConf(videourl, userpost, meeting.getVideoConfId());
                    if (!StringUtils.checkNull(PostprepareLoginConf)) {
                        PostVideoUrl.content(meeting, user, PostprepareLoginConf);
                    }
                }

                if (meeting.getStatus() != null) {
                    switch (meeting.getStatus()) {
                        case 1:
                            meeting.setStatusName("待审批");
                            break;
                        case 2:
                            meeting.setStatusName("已审批");
                            meeting.setStatus(2);
                            break;
                        case 3:
                            meeting.setStatusName("进行中");
                            break;
                        case 4:
                            meeting.setStatusName("未批准");
                            break;
                        case 5:
                            meeting.setStatusName("已结束");
                            break;
                    }
                }

                if (!StringUtils.checkNull(meeting.getStartTime())) {
                    meeting.setStartTime(meeting.getStartTime().substring(0, meeting.getStartTime().length() - 2));
                }

                if (!StringUtils.checkNull(meeting.getEndTime())) {
                    meeting.setEndTime(meeting.getEndTime().substring(0, meeting.getEndTime().length() - 2));
                }

                if (!StringUtils.checkNull(meeting.getCreateTime())) {
                    meeting.setCreateTime(meeting.getCreateTime().substring(0, meeting.getCreateTime().length() - 2));
                }

                Map maps = new HashMap();
                maps.put("meetingId", meeting.getSid());
                maps.put("attendeeId", user.getUid());
                MeetingAttendConfirm meetingAttendConfirm1 = meetingAttendConfirmMapper.queryMyAttend(map);
                if (null != meetingAttendConfirm1) {
                    //会议签到照片
                    if (!StringUtils.checkNull(meetingAttendConfirm1.getSignId()) && !StringUtils.checkNull(meetingAttendConfirm1.getSignName())) {
                        List<Attachment> atts = GetAttachmentListUtil.returnAttachment(meetingAttendConfirm1.getSignName(), meetingAttendConfirm1.getSignId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_MEETING);
                        meetingAttendConfirm1.setSignImage(atts);
                    }
                }
            }
            json.setObj(meetingList);
            json.setFlag(0);
            json.setMsg("ok");
                 map.remove("page");
                json.setTotleNum(meetingMapper.MyMeeting(map).size());
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("MeetingServiceImpl getMyMeeting:" + e);
        }
        return json;
    }

    /**
     * 给会议添加提醒事务（给审批人添加事务）
     *
     * @param meetingWithBLOBs
     */
    @Async
    public void addAffairs(final MeetingWithBLOBs meetingWithBLOBs, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        final String userName = users.getUserName();

        final String remind = meetingWithBLOBs.getSmsRemind();//事务提醒
        final String smsRemind = meetingWithBLOBs.getSms2Remind();//短信提醒


        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                String content = "";
                String url = "";

                DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                DateTimeFormatter dateTimeFormatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm");
                TemporalAccessor temporalAccessor = dateTimeFormatter1.parse(meetingWithBLOBs.getStartTime());

                if (meetingWithBLOBs.getStatus() != null && meetingWithBLOBs.getStatus() == 2){
                    content = "会议：“" + meetingWithBLOBs.getSubject() + "” 时间：" + dateTimeFormatter2.format(temporalAccessor) + "已自动审批通过";
                    url = "/meeting/detail?meetingId=" + meetingWithBLOBs.getSid();
                } else {
                    content = "请审批我的会议！主题：“" + meetingWithBLOBs.getSubject() + "” 时间：" + dateTimeFormatter2.format(temporalAccessor);
                    url = "/MeetingCommon/selectMeetingMange?flag=" + meetingWithBLOBs.getSid();
                }
                ContextHolder.setConsumerType("xoa" + sqlType);
                Users users = usersMapper.getUserByUid(meetingWithBLOBs.getUid());
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(users.getUserId());
                smsBody.setContent(content);

                smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                SysCode sysCode = new SysCode();
                sysCode.setCodeName("会议");
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(meetingWithBLOBs.getAttachmentId()) && !StringUtils.checkNull(meetingWithBLOBs.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                //toUserId
                String toUserId = "";
                if (meetingWithBLOBs.getManagerId() != null) {
                    Users temp = usersMapper.getUserByUid(meetingWithBLOBs.getManagerId());
                    if (temp != null) {
                        toUserId = temp.getUserId();
                    }
                }
                smsBody.setRemindUrl(url);
                String title = userName + "：" + content;
                String context = "主题：" + meetingWithBLOBs.getSubject();
                smsService.saveSms(smsBody, toUserId, remind, smsRemind, title, context, sqlType);
            }
        });
    }

    /**
     * 给会议添加提醒事务（给参加会议的人添加事务提醒）
     *
     * @param meetingWithBLOBs
     */
    @Async
    public void addAffairs1(final MeetingWithBLOBs meetingWithBLOBs, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        final String userName = users.getUserName();
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                Users users = usersMapper.getUserByUid(meetingWithBLOBs.getUid());
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(users.getUserId());

                DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                DateTimeFormatter dateTimeFormatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm");
                TemporalAccessor temporalAccessor = dateTimeFormatter1.parse(meetingWithBLOBs.getStartTime());
                smsBody.setContent("会议通知：“" + meetingWithBLOBs.getMeetName() + "” 时间：" + dateTimeFormatter2.format(temporalAccessor));

//                if(!StringUtils.checkNull(meetingWithBLOBs.getStartTime())){
//                    smsBody.setSendTime(DateFormat.getDateTime(meetingWithBLOBs.getStartTime()));
//                }
                smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                String toUid = "";
                if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                    toUid += meetingWithBLOBs.getAttendee();
                }
                if (meetingWithBLOBs.getRecorderId() != null && !StringUtils.checkNull(meetingWithBLOBs.getRecorderId().toString())) {
                    toUid += meetingWithBLOBs.getRecorderId();
                }
                if (meetingWithBLOBs.getServiceUser() != null && !StringUtils.checkNull(meetingWithBLOBs.getServiceUser())) {
                    toUid += meetingWithBLOBs.getServiceUser();
                }
                String toUserId = "";
                List<Users> usersList = usersMapper.getUsersByUids(toUid.split(","));
                if (!CollectionUtils.isEmpty(usersList)) {
                    StringBuffer userIds = new StringBuffer();
                    for (Users user : usersList) {
                        userIds.append(user.getUserId()).append(",");
                    }
                    toUserId = userIds.toString();
                }

                SysCode sysCode = new SysCode();
                sysCode.setCodeName("会议");
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(meetingWithBLOBs.getAttachmentId()) && !StringUtils.checkNull(meetingWithBLOBs.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                smsBody.setRemindUrl("/meeting/detail?meetingId=" + meetingWithBLOBs.getSid());
                String title = userName + "：会议通知！";
                String context = "主题：" + meetingWithBLOBs.getSubject();
                smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
            }
        });

    }


    /**
     * 给会议室管理员发送事务提醒
     *
     * @param meetingWithBLOBs
     * @param request
     * @param toUserId         发送人ID串
     */
    @Async
    public void addAffairs2(HttpServletRequest request, final MeetingWithBLOBs meetingWithBLOBs, final String toUserId, String content) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), CookiesUtil.getCookieByName(request, "redisSessionId"));
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(users.getUserId());
                smsBody.setContent("会议通知：" + content);
                smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));

                SysCode sysCode = new SysCode();
                sysCode.setCodeName("会议");
                sysCode.setParentNo("SMS_REMIND");
                SysCode codeNoByNameAndParentNo = sysCodeMapper.getCodeNoByNameAndParentNo(sysCode);
                if (codeNoByNameAndParentNo != null && !StringUtils.checkNull(codeNoByNameAndParentNo.getCodeNo())) {
                    smsBody.setSmsType(codeNoByNameAndParentNo.getCodeNo());
                }
                if (!StringUtils.checkNull(meetingWithBLOBs.getAttachmentId()) && !StringUtils.checkNull(meetingWithBLOBs.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                smsBody.setRemindUrl("/meeting/detail?meetingId=" + meetingWithBLOBs.getSid());
                String title = users.getUserName() + "：会议通知！";
                String context = "主题:" + meetingWithBLOBs.getSubject();
                smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
            }
        });

    }

    @Async
    public void addAffairs3(final MeetingWithBLOBs meetingWithBLOBs, List<Integer> sidList, List<String> appointDates, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        final String userName = users.getUserName();

        final String remind = meetingWithBLOBs.getSmsRemind();//事务提醒
        final String smsRemind = meetingWithBLOBs.getSms2Remind();//短信提醒

        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                if (!CollectionUtils.isEmpty(sidList)) {
                    for (int i = 0; i < sidList.size(); i++) {
                        String content = "";
                        String url = "";

                        meetingWithBLOBs.setSid(sidList.get(i));
                        String s = appointDates.get(i);
                        meetingWithBLOBs.setStartTime(s + " " + meetingWithBLOBs.getCycleStartTime());

                        DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        DateTimeFormatter dateTimeFormatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm");
                        TemporalAccessor temporalAccessor = dateTimeFormatter1.parse(meetingWithBLOBs.getStartTime());

                        if (meetingWithBLOBs.getStatus() != null && meetingWithBLOBs.getStatus() == 2){
                            content = "会议：“" + meetingWithBLOBs.getSubject() + "” 时间：" + dateTimeFormatter2.format(temporalAccessor) + "已自动审批通过";
                            url = "/meeting/detail?meetingId=" + meetingWithBLOBs.getSid();
                        } else {
                            content = "请审批我的会议！主题：“" + meetingWithBLOBs.getSubject() + "” 时间：" + dateTimeFormatter2.format(temporalAccessor);
                            url = "/MeetingCommon/selectMeetingMange?flag=" + meetingWithBLOBs.getSid();
                        }
                        ContextHolder.setConsumerType("xoa" + sqlType);
                        Users users = usersMapper.getUserByUid(meetingWithBLOBs.getUid());
                        SmsBody smsBody = new SmsBody();
                        smsBody.setFromId(users.getUserId());
                        smsBody.setContent(content);

                        smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                        SysCode sysCode = new SysCode();
                        sysCode.setCodeName("会议");
                        sysCode.setParentNo("SMS_REMIND");
                        if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                            smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                        }
                        if (!StringUtils.checkNull(meetingWithBLOBs.getAttachmentId()) && !StringUtils.checkNull(meetingWithBLOBs.getAttachmentName())) {
                            smsBody.setIsAttach("1");
                        }
                        //toUserId
                        String toUserId = "";
                        if (meetingWithBLOBs.getManagerId() != null) {
                            Users temp = usersMapper.getUserByUid(meetingWithBLOBs.getManagerId());
                            if (temp != null) {
                                toUserId = temp.getUserId();
                            }
                        }
                        smsBody.setRemindUrl(url);
                        String title = userName + "：" + content;
                        String context = "主题：" + meetingWithBLOBs.getSubject();
                        smsService.saveSms(smsBody, toUserId, remind, smsRemind, title, context, sqlType);
                    }
                }
            }
        });
    }

    @Async
    public void addAffairs4(final MeetingWithBLOBs meetingWithBLOBs, List<Integer> sidList, List<String> appointDates, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        final String userName = users.getUserName();
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                Users users = usersMapper.getUserByUid(meetingWithBLOBs.getUid());

                if (!CollectionUtils.isEmpty(sidList)) {
                    for (int i = 0; i < sidList.size(); i++) {
                        SmsBody smsBody = new SmsBody();
                        smsBody.setFromId(users.getUserId());
                        meetingWithBLOBs.setSid(sidList.get(i));
                        String s = appointDates.get(i);
                        meetingWithBLOBs.setStartTime(s + " " + meetingWithBLOBs.getCycleStartTime());

                        DateTimeFormatter dateTimeFormatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        DateTimeFormatter dateTimeFormatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm");
                        TemporalAccessor temporalAccessor = dateTimeFormatter1.parse(meetingWithBLOBs.getStartTime());
                        smsBody.setContent("会议通知：“" + meetingWithBLOBs.getMeetName() + "” 时间：" + dateTimeFormatter2.format(temporalAccessor));

                        smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                        String toUid = "";
                        if (!StringUtils.checkNull(meetingWithBLOBs.getAttendee())) {
                            toUid += meetingWithBLOBs.getAttendee();
                        }
                        if (meetingWithBLOBs.getRecorderId() != null && !StringUtils.checkNull(meetingWithBLOBs.getRecorderId().toString())) {
                            toUid += meetingWithBLOBs.getRecorderId();
                        }
                        if (meetingWithBLOBs.getServiceUser() != null && !StringUtils.checkNull(meetingWithBLOBs.getServiceUser())) {
                            toUid += meetingWithBLOBs.getServiceUser();
                        }
                        String toUserId = "";
                        List<Users> usersList = usersMapper.getUsersByUids(toUid.split(","));
                        if (!CollectionUtils.isEmpty(usersList)) {
                            StringBuffer userIds = new StringBuffer();
                            for (Users user : usersList) {
                                userIds.append(user.getUserId()).append(",");
                            }
                            toUserId = userIds.toString();
                        }

                        SysCode sysCode = new SysCode();
                        sysCode.setCodeName("会议");
                        sysCode.setParentNo("SMS_REMIND");
                        if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                            smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                        }
                        if (!StringUtils.checkNull(meetingWithBLOBs.getAttachmentId()) && !StringUtils.checkNull(meetingWithBLOBs.getAttachmentName())) {
                            smsBody.setIsAttach("1");
                        }
                        smsBody.setRemindUrl("/meeting/detail?meetingId=" + meetingWithBLOBs.getSid());
                        String title = userName + "：会议通知！";
                        String context = "主题：" + meetingWithBLOBs.getSubject();
                        smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
                    }
                }
            }
        });

    }

    /**
     * @作者 廉立深
     * @时间 2020-08-12
     * @方法介绍 会议导入功能
     */
    @Override
    public ToJson<Object> meetingImport(HttpServletRequest request, MultipartFile file) {
        ToJson toJson = new ToJson(1,"false");
        try {
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), CookiesUtil.getCookieByName(request, "redisSessionId"));
            if (file.isEmpty()) {
                toJson.setMsg("请上传文件！");
                toJson.setFlag(1);
                return toJson;
            }

            List msg = new ArrayList();

            String fileName = file.getOriginalFilename();
            if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")){

                InputStream in =  file.getInputStream();
                HSSFWorkbook excelObj = new HSSFWorkbook(in);
                HSSFSheet sheetObj = excelObj.getSheetAt(0);
                int lastRowNum = sheetObj.getPhysicalNumberOfRows();  //行

                Row row = sheetObj.getRow(0); //列头
                int colNum = row.getPhysicalNumberOfCells();

                for (int i = 1; i<lastRowNum ; i++){
                    row = sheetObj.getRow(i);

                    MeetingWithBLOBs meetingWithBLOBs = new MeetingWithBLOBs();
                    meetingWithBLOBs.setStatus(1); //待批
                    meetingWithBLOBs.setUid(users.getUid()); //申请人
                    meetingWithBLOBs.setVideoConfFlag("0"); //0不是视频会议
                    meetingWithBLOBs.setCycle("0"); // 是否是周期性事务

                    for (int j = 0; j < colNum; j++) {
                        Cell cell = row.getCell(j);
                        if (cell != null){
                            String stringCellValue = cell.getStringCellValue();
                            if (!StringUtils.checkNull(stringCellValue)){
                                switch (j){
                                    case 0:
                                        //主题名称
                                        meetingWithBLOBs.setMeetName(stringCellValue);
                                        meetingWithBLOBs.setSubject(stringCellValue);
                                        break;
                                    case 1:
                                        //联系电话
                                        meetingWithBLOBs.setMobileNo(stringCellValue);
                                        break;
                                    case 2:
                                        //会议纪要员
                                        Users userByUserName = usersService.getUserByUserName(stringCellValue);
                                        if (userByUserName != null){
                                            meetingWithBLOBs.setRecorderId(userByUserName.getUid());
                                        }
                                        break;
                                    case 3:
                                        //会议室
                                        Integer roomConditionId = meetRoomService.getRoomConditionId(stringCellValue);
                                        if (roomConditionId != null){
                                            meetingWithBLOBs.setMeetRoomId(roomConditionId);
                                        }else{
                                            break;
                                        }
                                        break;
                                    case 4:
                                        //开始时间
                                        meetingWithBLOBs.setStartTime(stringCellValue);

                                        break;
                                    case 5:
                                        //结束时间
                                        meetingWithBLOBs.setEndTime(stringCellValue);
                                        break;
                                    case 6:
                                        //审批管理员
                                        Users userByUserName2 = usersService.getUserByUserName(stringCellValue);
                                        if (userByUserName2 != null){
                                            meetingWithBLOBs.setManagerId(userByUserName2.getUid());

                                        }
                                        break;
                                    case 7:
                                        //出席人员（外部）
                                        meetingWithBLOBs.setAttendeeOut(usersService.fundUserIdByUserName(stringCellValue));
                                        break;
                                    case 8:
                                        //出席人员（内部）
                                        Users userByUserName1 = usersService.getUserByUserName(stringCellValue);
                                        meetingWithBLOBs.setAttendee(userByUserName1.getUid().toString());
                                      /*  meetingWithBLOBs.setAttendee(usersService.fundUserIdByUserName(stringCellValue));*/

                                        break;
                                    case 9:
                                        //会议室设备
                                        meetingWithBLOBs.setEquipmentIds(meetEquuipmentService.getEquietId(stringCellValue));
                                        meetingWithBLOBs.setEquipmentNames(stringCellValue);
                                        break;
                                    case 10:
                                        //是否写入日程安排
                                        if ("是".equals(stringCellValue)){
                                            meetingWithBLOBs.setIsWriteCalednar(1);
                                        }else{
                                            meetingWithBLOBs.setIsWriteCalednar(0);
                                        }
                                        break;
                                    case 11:
                                        meetingWithBLOBs.setMeetDesc(stringCellValue);
                                        break;
                                }
                            }
                        }

                    }



                    //新增会议
                    Map map = new HashedMap();
                    map.put("msg",this.PTinsertMeeting(meetingWithBLOBs, request));
                    map.put("row",i+1);
                    msg.add(map);
                }


            }else{
                toJson.setMsg("请上传 .xls 或 .xlsx 的文件！");
                return toJson;
            }

            toJson.setObj(msg);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<MeetingWithBLOBs> insertMeetingv1(MeetingWithBLOBs meetingWithBLOB, HttpServletRequest request) {
        ToJson toJson = new ToJson(1,"false");
        try {
            Date date = new Date();
            long time = date.getTime();
            String s = String.valueOf(time);
            String substring = s.substring(s.length() - 6, s.length());
            meetingWithBLOB.setVideoConfId(substring);
            meetingWithBLOB.setStatus(2);

            toJson.setObject( meetingMapper.insertMeetingv1(meetingWithBLOB));
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<MeetingWithBLOBs> MyMeetingv1(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingWithBLOBs> toJson = new ToJson<MeetingWithBLOBs>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            Map<String, Object> map = new HashMap<String, Object>();

            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            map.put("page", pageParams);
            map.put("uid",user.getUid());
            List<MeetingWithBLOBs> meetingList = meetingMapper.MyMeetingv1(map);
            for (MeetingWithBLOBs meeting : meetingList) {

                if (meeting.getUid() != null) {
                    meeting.setUserName(usersMapper.getUsernameById(meeting.getUid()));
                }

                if ( !StringUtils.checkNull(meeting.getAttendee()) ) {
                    meeting.setAttendeeName(usersService.findUsersByuid(meeting.getAttendee()));
                }

            }
            toJson.setMsg("ok");
            toJson.setFlag(0);
            toJson.setObj(meetingList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Object> updatePowerChinaMeet(HttpServletRequest request, String sid) {
        ToJson json = new ToJson();

        return json;
    }

    @Override
    public ToJson<Object> addAttendee(HttpServletRequest request, String sid, String attendee) {
        ToJson json = new ToJson();
        try {
            MeetingWithBLOBs meetingWithBLOBs = meetingMapper.queryMeetingById(sid);
            meetingWithBLOBs.setAttendee(meetingWithBLOBs.getAttendee()+attendee);
            meetingMapper.updateMeetingByIdV1(meetingWithBLOBs);
        }catch (Exception e){
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<Object> getAttendPhoto(HttpServletRequest request, String sid) {
        ToJson json = new ToJson();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        try {
            List result = new ArrayList();
            List<MeetingAttendConfirm> attendPhoto = meetingAttendConfirmMapper.getAttendPhoto(sid);
            for (MeetingAttendConfirm list:attendPhoto){
                if (!StringUtils.checkNull(list.getSignId()) && !StringUtils.checkNull(list.getSignName())) {
                    List<Attachment> atts = GetAttachmentListUtil.returnAttachment(list.getSignName(), list.getSignName(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_MEETING);
                    result.add(atts);
                }
            }
            json.setData(result);
        }catch (Exception e){
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    public ToJson updateStatus() {
       ToJson toJson = new ToJson();
        try {
            // 获取当前时间戳
            long currentTime = System.currentTimeMillis();
            // 日期格式化对象
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            // Mapper的参数对象
            MeetingWithBLOBs paramMeeting = new MeetingWithBLOBs();
            List<MeetingWithBLOBs> meetingWithBLOBs = meetingMapper.selectTimeWithStatus();

            for (MeetingWithBLOBs meeting :meetingWithBLOBs ) {
                // 日期转换为时间戳
                if (Optional.ofNullable(meeting.getEndTime()).isPresent()) {
                    long endTime = simpleDateFormat.parse(meeting.getEndTime()).getTime();
                    long startTime = simpleDateFormat.parse(meeting.getStartTime()).getTime();
                    if (currentTime >= endTime) {
                        // 会议已结束
                        paramMeeting.setStatus(5);
                        paramMeeting.setSid(meeting.getSid());
                        meetingMapper.updMeetStatusById(paramMeeting);
                    } else if (currentTime >= startTime){
                        // 会议进行中
                        paramMeeting.setStatus(3);
                        paramMeeting.setSid(meeting.getSid());
                        meetingMapper.updMeetStatusById(paramMeeting);
                    }
                }

            }
            toJson.setMsg("ok");
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }
       return toJson;
    }

    @Override
    public ToJson updateCreateQrcodeTimeBySid(Meeting meeting) {
        ToJson json=new ToJson();
        try {
            Date date = new Date();
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            meeting.setCreateQrcodeTime(simpleDateFormat.format(date));
            meetingMapper.updateCreateQrcodeTimeBySid(meeting);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson updateMyMeetingStatus(String strJson) {
        ToJson json =new ToJson(1, "err");
        try {
            if (!StringUtils.checkNull(strJson)){
                List<MeetingAttendConfirm> list = JSONArray.parseArray(strJson, MeetingAttendConfirm.class);
                for (MeetingAttendConfirm meetingAttendConfirm : list){
                    if (meetingAttendConfirm.getMeetingId() != null && meetingAttendConfirm.getAttendeeId() != null && meetingAttendConfirm.getAttendFlag() != null){
                        meetingAttendConfirmMapper.updateStatusBySId(meetingAttendConfirm);
                    }
                }
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson selectMeetingReserve(HttpServletRequest request, Integer meetRoomId, String startDate, String endDate) {
        ToJson json = new ToJson<>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            Map<String, Object> map = new HashMap<>();
            map.put("meetRoomId", meetRoomId);
            map.put("startDate", startDate);
            map.put("endDate", endDate);
            List<MeetingWithBLOBs> list = meetingMapper.selectMeetingReserve(map);
            if (!CollectionUtils.isEmpty(list)){
                for (MeetingWithBLOBs meetingWithBLOBs : list) {
                    if (!StringUtils.checkNull(meetingWithBLOBs.getStartTime())){
                        Long startTimeLong = DateFormat.getDate(meetingWithBLOBs.getStartTime()).getTime();
                        Long startDateLong = DateFormat.getDate(startDate).getTime();
                        String startTime = DateFormat.getFormatByUse("yyyy-MM-dd HH:mm:ss", new Date(startTimeLong < startDateLong ? startDateLong : startTimeLong));
                        meetingWithBLOBs.setStartTime(startTime);
                    }

                    if (!StringUtils.checkNull(meetingWithBLOBs.getEndTime())){
                        Long endTimeLong = DateFormat.getDate(meetingWithBLOBs.getEndTime()).getTime();
                        Long endDateLong = DateFormat.getDate(endDate).getTime();
                        String endTime = DateFormat.getFormatByUse("yyyy-MM-dd HH:mm:ss", new Date(endTimeLong > endDateLong ? endDateLong : endTimeLong));
                        meetingWithBLOBs.setEndTime(endTime);
                    }

                    if (meetingWithBLOBs.getStatus() != null && meetingWithBLOBs.getStatus() == 4){
                        meetingWithBLOBs.setStatus(3);
                    }

                }

                json.setFlag(0);
                json.setMsg("ok");
                json.setObj(list);
            } else {
                json.setFlag(0);
                json.setMsg("暂无数据");
            }
        } catch (Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }
}
