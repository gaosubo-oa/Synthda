package com.xoa.controller.meeting;

import com.xoa.dao.meet.MeetingAttendConfirmMapper;
import com.xoa.model.common.Syslog;
import com.xoa.model.meet.Meeting;
import com.xoa.model.meet.MeetingAttendConfirm;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.meeting.MeetingService;
import com.xoa.service.sys.SysLogService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.xoa.util.ExcelUtil.createStyle;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/26 18:19
 * 类介绍  :   会议模块
 * 构造参数:
 */
@Controller
@RequestMapping("/meeting")
public class MeetingController {

    @Resource
    private MeetingService meetingService;

    @Resource
    private SysLogService sysLogService;

    @Resource
    private MeetingAttendConfirmMapper meetingAttendConfirmMapper;


    @RequestMapping("/meetingNote")
    public String meetingNote(HttpServletRequest request) {
        return "app/meeting/meetingNote";
    }

    @RequestMapping("/meetingReserve")
    public String meetingReserve(HttpServletRequest request) {
        return "app/meeting/meetingReserve";
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:54:00
     * 方法介绍:  根据条件进行查询会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    @ResponseBody
    @RequestMapping(value = "/queryMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> queryMeeting(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs,Integer page,Integer pageSize,boolean useFlag,String date){
        return meetingService.queryMeeting(request,meetingWithBLOBs,page,pageSize,useFlag,date);
    }

    //我的会议
    @ResponseBody
    @RequestMapping(value = "/MyMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> MyMeeting(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag){
        return meetingService.MyMeeting(request,meetingWithBLOBs,page,pageSize,useFlag);
    }

    @ResponseBody
    @RequestMapping(value = "/v1/MyMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> MyMeetingv1(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag){
        return meetingService.MyMeetingv1(request,meetingWithBLOBs,page,pageSize,useFlag);
    }

    //会议管理
    @ResponseBody
    @RequestMapping(value = "/meetingManage", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> meetingManage(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs,Integer page,Integer pageSize,boolean useFlag,String date){
        return meetingService.meetingManage(request,meetingWithBLOBs,page,pageSize,useFlag,date);
    }

    //会议查询,{export:是否导出}
    @ResponseBody
    @RequestMapping(value = "/meetingQuery", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> meetingQuery(HttpServletRequest request,HttpServletResponse response,MeetingWithBLOBs meetingWithBLOBs,Integer page,Integer pageSize,boolean useFlag,String date,boolean export){
        return meetingService.meetingQuery(request,response,meetingWithBLOBs,page,pageSize,useFlag,date,export);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:58:00
     * 方法介绍:  我的会议
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    @ResponseBody
    @RequestMapping(value = "/getMyMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> getMyMeeting(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag){
        return meetingService.getMyMeeting(request,meetingWithBLOBs,page,pageSize,useFlag);
    }



    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:00:00
     * 方法介绍:  根据id查询会议信息
     * 参数说明:   @param sid会议id
     * 返回值说明:   @return MeetingWithBLOBs
     */
    @ResponseBody
    @RequestMapping(value = "/queryMeetingById", produces = {"application/json;charset=UTF-8"})
    public synchronized ToJson<MeetingWithBLOBs> queryMeetingById(HttpServletRequest request, HttpServletResponse response,String sid,
                                                     @RequestParam(value = "bodyId", required = false) String bodyId){
        return meetingService.queryMeetingById(request,response,sid,0,bodyId);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:02:00
     * 方法介绍:  根据id更新会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 更新条数
     */
    @ResponseBody
    @RequestMapping(value = "/updateMeetingById", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> updateMeetingById(MeetingWithBLOBs meetingWithBLOBs, Integer Status, HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(55); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",修改");
        sysLogService.saveLog(syslog,request);

        return meetingService.updateMeetingById(meetingWithBLOBs, Status, request);
    }

    @ResponseBody
    @RequestMapping(value = "/v1/updateMeetingById", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> updateMeetingByIdv1(MeetingWithBLOBs meetingWithBLOBs, Integer Status, HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        return meetingService.updateMeetingByIdv1(meetingWithBLOBs, Status, request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:04:00
     * 方法介绍:  根据id更新会议状态 （审批）
     * 参数说明:   @param Meeting
     * 返回值说明:   @return int 更新条数
     */
    @ResponseBody
    @RequestMapping(value = "/updMeetStatusById", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> updMeetStatusById(HttpServletRequest request,Meeting meeting){
        return meetingService.updMeetStatusById(request,meeting,false);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:05:00
     * 方法介绍:  申请会议（添加会议信息）
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 插入条数
     */
    @ResponseBody
    @RequestMapping(value = "/insertMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> insertMeeting(MeetingWithBLOBs meetingWithBLOB,HttpServletRequest request){
        return meetingService.insertMeeting(meetingWithBLOB,request);
    }

    @ResponseBody
    @RequestMapping(value = "/v1/insertMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> insertMeetingv1(MeetingWithBLOBs meetingWithBLOB,HttpServletRequest request){

        return meetingService.insertMeetingv1(meetingWithBLOB,request);
    }

    /*
        这个接口是  复制  申请会议（添加会议信息） 过来的普陀教育有用到
     */
    @ResponseBody
    @RequestMapping(value = "/PTinsertMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> PTinsertMeeting(MeetingWithBLOBs meetingWithBLOB,HttpServletRequest request){
        return meetingService.PTinsertMeeting(meetingWithBLOB,request);
    }

    @ResponseBody
    @RequestMapping(value = "/judgeMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> judgeMeeting(MeetingWithBLOBs meetingWithBLOB,HttpServletRequest request){
        return meetingService.judgeMeeting(meetingWithBLOB,request);
    }
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:06:00
     * 方法介绍:  根据id删除会议信息
     * 参数说明:   @param sid
     * 返回值说明:   @return int 删除条数
     */
    @ResponseBody
    @RequestMapping(value = "/delMeetingById", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> delMeetingById(HttpServletRequest request,String sid){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(55); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",删除");
        sysLogService.saveLog(syslog,request);

        return meetingService.delMeetingById(request,sid);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  根据会议id进行查询参会及查阅情况
     * 参数说明:   @param meetingId 会议id
     * 返回值说明:   @return List
     */
    @ResponseBody
    @RequestMapping(value = "/queryAttendConfirm", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingAttendConfirm> queryAttendConfirm(HttpServletRequest request, HttpServletResponse response,boolean export,String meetingId){
        ToJson<MeetingAttendConfirm> meetingAttendConfirmToJson = meetingService.queryAttendConfirm(meetingId);
        try {
            if (export && meetingAttendConfirmToJson.isFlag()){
                List<MeetingAttendConfirm> obj = meetingAttendConfirmToJson.getObj();

                HSSFWorkbook workbook = new HSSFWorkbook();
                HSSFCellStyle styleTitle = createStyle(workbook, (short)16);
                HSSFSheet sheet = workbook.createSheet("参会情况");
                sheet.setDefaultColumnWidth(25);
                CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, 5);
                sheet.addMergedRegion(cellRangeAddress);
                HSSFRow rowTitle = sheet.createRow(0);
                HSSFCell cellTitle = rowTitle.createCell(0);
                // 为标题设置背景颜色
                styleTitle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
                styleTitle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
                cellTitle.setCellValue("参会情况");
                cellTitle.setCellStyle(styleTitle);

                //插入统计数据
                MeetingAttendConfirm meetingAttendConfirm =  meetingAttendConfirmMapper.queryAttendConfirmExport(Integer.valueOf(meetingId));
                String title = "应到人数（" + meetingAttendConfirm.getCountNumber() + "）  准时人数（" + meetingAttendConfirm.getPunctualNumber() + "）、迟到人数（" + meetingAttendConfirm.getLatecomersNumber() + "）、" +
                        "请假人数（" + meetingAttendConfirm.getLeaveNumber() + "）、缺勤人数（" + meetingAttendConfirm.getAbsenceFromDutyNumber() + "）";

                HSSFCellStyle styleTitle1 = createStyle(workbook, (short)16);
                CellRangeAddress cellRangeAddress1 = new CellRangeAddress(1, 1, 0, 5);
                sheet.addMergedRegion(cellRangeAddress1);
                HSSFRow rowTitle1 = sheet.createRow(1);
                HSSFCell cellTitle1 = rowTitle1.createCell(0);
                // 为统计数据设置背景颜色
                styleTitle1.setAlignment(HorizontalAlignment.LEFT);
                styleTitle1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
                styleTitle1.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
                cellTitle1.setCellValue(title);
                cellTitle1.setCellStyle(styleTitle1);

                String[] secondTitles = {  "姓名", "所属部门", "角色", "签到状态", "签到时间" ,"说明"};

                HSSFSheet sheet3 = workbook.getSheetAt(0);
                HSSFRow rowField = sheet3.createRow(2);
                HSSFCellStyle styleField = createStyle(workbook, (short)13);
                for (int i = 0; i < secondTitles.length; i++) {
                    HSSFCell cell = rowField.createCell(i);
                    cell.setCellValue(secondTitles[i]);
                    cell.setCellStyle(styleField);
                }

                String[] beanProperty = {  "attendeeName", "deptName", "userPrivName", "attendFlagStr", "confirmTime" ,"remark" };

                workbook = ExcelUtil.exportExcelDatafirs(workbook, obj, beanProperty, 3);
                ServletOutputStream out = response.getOutputStream();

                String filename = "参会情况.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return meetingAttendConfirmToJson;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:48:00
     * 方法介绍:  根据状态获取会议的数量
     * 参数说明:   @param meeting
     * 返回值说明:   @return int
     */
    @ResponseBody
    @RequestMapping(value = "/queryCountByStatus", produces = {"application/json;charset=UTF-8"})
    public ToJson<Meeting> queryCountByStatus(HttpServletRequest request){
        return meetingService.queryCountByStatus(request);
    }

    //重写根据状态获取会议的数量
    @ResponseBody
    @RequestMapping(value = "/queryCountByStatu", produces = {"application/json;charset=UTF-8"})
    public ToJson<Meeting> queryCountByStatu(HttpServletRequest request){
        return meetingService.queryCountByStatu(request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:00:00
     * 方法介绍:  导出会议信息
     * 参数说明:   @param sid会议id
     * 返回值说明:   @return MeetingWithBLOBs
     */
    @RequestMapping(value = "/outMeetingMsg", produces = {"application/json;charset=UTF-8"})
    public void outMeetingMsg(HttpServletRequest request, HttpServletResponse response,String sid){
        meetingService.queryMeetingById(request,response,sid,1,null);
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  会议----签阅
     * 参数说明:   @param meetingAttendConfirm
     * 返回值说明:   @return int
     */
    @ResponseBody
    @RequestMapping(value = "/readMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> readMeeting(MeetingAttendConfirm meetingAttendConfirm,HttpServletRequest request){
        return meetingService.updateConfirmReadStatusBySId(meetingAttendConfirm,request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  会议----参会
     * 参数说明:   @param meetingAttendConfirm
     * 返回值说明:   @return int
     */
    @ResponseBody
    @RequestMapping(value = "/attendMeeting", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> attendMeeting(MeetingAttendConfirm meetingAttendConfirm,HttpServletRequest request){
           return meetingService.updateConfirmAttendStatusBySId(meetingAttendConfirm,request);
    }

    //会议签到(地址映射)
    @ResponseBody
    @RequestMapping("/MeetingAttend")
    public Map meetingApply(HttpServletRequest request, HttpServletResponse response, String meetingId, Map<String,Object> map) {
        ToJson<MeetingWithBLOBs> toJson=meetingService.queryMeetingById(request,response,meetingId,0,null);
        Map<String,Object> tempMap=new HashedMap();
        tempMap.put("mark","SID_MEETING");
        tempMap.put("toJson",toJson);
        return tempMap;
    }



    @RequestMapping("/checkAttend")
    @ResponseBody
    public ToJson<Users>  checkAttend(HttpServletRequest request){
        ToJson<Users> toJson=new ToJson<>(0,"ok");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        String attendFlag=SessionUtils.getSessionInfo(request.getSession(),"attendFlag",String.class,redisSessionId);
        String avatar=SessionUtils.getSessionInfo(request.getSession(),"avatar",String.class,redisSessionId);
        String photoName=SessionUtils.getSessionInfo(request.getSession(),"photoName",String.class,redisSessionId);
        String userName=SessionUtils.getSessionInfo(request.getSession(),"userName",String.class,redisSessionId);
        String deptName=SessionUtils.getSessionInfo(request.getSession(),"deptName",String.class,redisSessionId);
        String userPrivName=SessionUtils.getSessionInfo(request.getSession(),"userPrivName",String.class,redisSessionId);
        Users users=new Users();
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
     * @param page
     * @param pageSize
     * @param useFlag
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getMeetingNotify", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> getMeetingNotify(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag){
        return meetingService.getMeetingNotify(request,meetingWithBLOBs,page,pageSize,useFlag);
    }

    @ResponseBody
    @RequestMapping(value = "/getMeetingNotifyFirstDesktop", produces = {"application/json;charset=UTF-8"})
    public ToJson<MeetingWithBLOBs> getMeetingNotifyFirstDesktop(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag){
        return meetingService.getMeetingNotify(request,meetingWithBLOBs,page,pageSize,useFlag);
    }


    /**
     * @作者: 张航宁
     * @时间: 2019/9/17
     * @说明: 同步通达升级心通达后的用户userId为uid
     */
    @ResponseBody
    @RequestMapping("/tongBuUid")
    public ToJson tongBuUid(){
        return meetingService.tongBuUid();
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/9/27
     * @说明: 获取审批人
     */
    @ResponseBody
    @RequestMapping("/getManagers")
    public ToJson<Object> getManagers(Integer roomId,String paraName) {
        return meetingService.getManagers(roomId, paraName);
    }

    @RequestMapping("/meetingList")
    public String meetingList(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/meetingList";

    }
    @RequestMapping("/detail")
    public String detail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/detail";

    }


    /**
     * @作者 廉立深
     * @时间 2020-08-12
     * @方法介绍 会议申请导入按钮
     */
    @ResponseBody
    @RequestMapping("/meetingImport")
    public ToJson<Object> meetingImport(HttpServletRequest request, MultipartFile file) {
        return meetingService.meetingImport(request, file);
    }

    /**
    * 创建人: 刘伯儒
    * 创建时间: 2021/7/9 18:48
    * 方法介绍：更新会议状态
    */
    @RequestMapping("/updateStatus")
    @ResponseBody
    public ToJson updateStatus() {
        return meetingService.updateStatus();
    }
    @RequestMapping("/updateCreateQrcodeTimeBySid")
    @ResponseBody
    public ToJson updateCreateQrcodeTimeBySid(Meeting meeting){
        return meetingService.updateCreateQrcodeTimeBySid(meeting);
    }

    /**
     * 创建作者:    金帅强
     * 创建时间:    2022/4/6
     * 方法介绍:    我的会议参会情况里，修改签到状态
     * 参数说明:
     * 返回值说明:
     */
    @RequestMapping("/updateMyMeetingStatus")
    @ResponseBody
    public ToJson updateMyMeetingStatus(String strJson){
        return meetingService.updateMyMeetingStatus(strJson);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/10/18
     * 方法介绍: 会议室预订 查询数据
     * 参数说明: [request, meetRoomId, startDate, endDate]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @RequestMapping("/selectMeetingReserve")
    @ResponseBody
    public ToJson selectMeetingReserve(HttpServletRequest request, Integer meetRoomId, String startDate, String endDate){
        return meetingService.selectMeetingReserve(request, meetRoomId, startDate, endDate);
    }

}


