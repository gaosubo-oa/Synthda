package com.xoa.service.meeting;/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/26 18:26
 * 类介绍  :
 * 构造参数:
 */

import com.xoa.model.meet.Meeting;
import com.xoa.model.meet.MeetingAttendConfirm;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Map;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-07-26 18:26
 *    类介绍：       会议模块
 *    构造参数：     无
 *
 */
public interface MeetingService {

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午13:40:41
     * 方法介绍:   查询所有会议设备
     * 参数说明:   map 分页参数
     * @return    HrStaffContract
     */
    /*public ToJson<Meeting> getMyMeeting(HttpServletRequest request,Integer page,Integer pageSize,boolean useFlag);*/

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:54:00
     * 方法介绍:  根据条件进行查询会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    public ToJson<MeetingWithBLOBs> queryMeeting(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag, String nowDate);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:58:00
     * 方法介绍:  我的会议
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    public ToJson<MeetingWithBLOBs> getMyMeeting(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:00:00
     * 方法介绍:  根据id查询会议信息
     * 参数说明:   @param sid会议id
     * 返回值说明:   @return MeetingWithBLOBs
     */
    public ToJson<MeetingWithBLOBs> queryMeetingById(HttpServletRequest request, HttpServletResponse response,String sid, int output,String bodyId);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:02:00
     * 方法介绍:  根据id更新会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 更新条数
     */
    public ToJson<MeetingWithBLOBs> updateMeetingById(MeetingWithBLOBs meetingWithBLOBs, Integer Status, HttpServletRequest request);
    public ToJson<MeetingWithBLOBs> updateMeetingByIdv1(MeetingWithBLOBs meetingWithBLOBs, Integer Status, HttpServletRequest request);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:04:00
     * 方法介绍:  根据id更新会议状态
     * 参数说明:   @param Meeting
     * 返回值说明:   @return int 更新条数
     */
    public ToJson<MeetingWithBLOBs> updMeetStatusById(HttpServletRequest request,Meeting meeting,boolean is);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:05:00
     * 方法介绍:  申请会议（添加会议信息）
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 插入条数
     */
    public ToJson<MeetingWithBLOBs> insertMeeting(MeetingWithBLOBs meetingWithBLOBs,HttpServletRequest request);

    /*
       这个接口是复制过来的普陀教育有用到
    */
    ToJson<MeetingWithBLOBs> PTinsertMeeting(MeetingWithBLOBs meetingWithBLOB, HttpServletRequest request);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:06:00
     * 方法介绍:  根据id删除会议信息
     * 参数说明:   @param sid
     * 返回值说明:   @return int 删除条数
     */
    public ToJson<MeetingWithBLOBs> delMeetingById(HttpServletRequest request,String sid);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  根据会议id进行查询参会及查阅情况
     * 参数说明:   @param meetingId 会议id
     * 返回值说明:   @return List
     */
    public ToJson<MeetingAttendConfirm> queryAttendConfirm(String meetingId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:48:00
     * 方法介绍:  根据状态获取会议的数量
     * 参数说明:   @param meeting
     * 返回值说明:   @return int
     */
    public ToJson<Meeting> queryCountByStatus(HttpServletRequest request);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  修改参会人员的签阅状态
     * 参数说明:   @param meetingAttendConfirm
     * 返回值说明:   @return int
     */
    public ToJson<MeetingWithBLOBs> updateConfirmReadStatusBySId(MeetingAttendConfirm meetingAttendConfirm,HttpServletRequest request);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:00:00
     * 方法介绍:  修改参会人员参会状态，并返回签到人员的相关信息
     * 参数说明:   @param meetingAttendConfirm
     * 返回值说明:   @return int
     */
    public ToJson<Users> updateConfirmAttendStatusBySId(MeetingAttendConfirm meetingAttendConfirm, HttpServletRequest request);


    /**
     * 方法介绍:  门户会议通知列表查询（状态为已批准、进行中的会议申请，所有人可见）
     * 创建作者:   刘新婷
     * 创建日期:   2018-01-29
     * @param page
     * @param pageSize
     * @param useFlag
     * @return
     */
    public ToJson<MeetingWithBLOBs> getMeetingNotify(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag);
    public ToJson<MeetingWithBLOBs> getMeetingNotifyFirstDesktop(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag);

    /**
     * @作者: 张航宁
     * @时间: 2019/9/17
     * @说明: 同步通达升级心通达后的用户userId为uid
     */
    public ToJson tongBuUid();

    /**
     * @作者: 张航宁
     * @时间: 2019/9/27
     * @说明: 获取会议申请的审批人
     */
    ToJson<Object> getManagers(Integer roomId,String paraName);

    ToJson<MeetingWithBLOBs> MyMeeting(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag);

    ToJson<MeetingWithBLOBs> meetingManage(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag, String date);

    ToJson<MeetingWithBLOBs> meetingQuery(HttpServletRequest request,HttpServletResponse response, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag, String date, boolean export);

    ToJson<Meeting> queryCountByStatu(HttpServletRequest request);

    ToJson<MeetingWithBLOBs> getApp(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, String userId, String sqlType);

    ToJson<MeetingWithBLOBs> judgeMeeting(MeetingWithBLOBs meetingWithBLOB, HttpServletRequest request);

    /**
     * @作者 廉立深
     * @时间 2020-08-12
     * @方法介绍 会议导入功能
     */
    ToJson<Object> meetingImport(HttpServletRequest request, MultipartFile file);

    ToJson<MeetingWithBLOBs> insertMeetingv1(MeetingWithBLOBs meetingWithBLOB, HttpServletRequest request);

    ToJson<MeetingWithBLOBs> MyMeetingv1(HttpServletRequest request, MeetingWithBLOBs meetingWithBLOBs, Integer page, Integer pageSize, boolean useFlag);

    ToJson<Object> updatePowerChinaMeet(HttpServletRequest request, String sid);

    ToJson<Object> addAttendee(HttpServletRequest request, String sid, String attendee);

    ToJson<Object> getAttendPhoto(HttpServletRequest request, String sid);

    ToJson updateStatus();
    ToJson updateCreateQrcodeTimeBySid(Meeting meeting);

    ToJson updateMyMeetingStatus(String strJson);

    ToJson selectMeetingReserve(HttpServletRequest request, Integer meetRoomId, String startDate, String endDate);
}
