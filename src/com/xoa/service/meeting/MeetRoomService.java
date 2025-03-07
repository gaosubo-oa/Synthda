package com.xoa.service.meeting;
import com.xoa.model.meet.MeetingRoomWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-07-29 12:00
 *    类介绍：       会议会议室管理
 *    构造参数：     无
 *
 */
public interface MeetRoomService {
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午12:01:41
     * 方法介绍:  查询会议室相关信息
     * 参数说明:   map 分页参数
     * @return    HrStaffContract
     */
    public ToJson<MeetingRoomWithBLOBs> getAllMeetRoomInfo(Integer page, Integer pageSize, boolean useFlag);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午12:01:41
     * 方法介绍:  查询会议室详情
     * 参数说明:   sid 自动自增的id
     * @return    MeetingRoomWithBLOBs
     */
    public ToJson<MeetingRoomWithBLOBs> getMeetRoomBySid(HttpServletRequest request,String sid);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午12:01:41
     * 方法介绍:    删除会议室
     * 参数说明:   sid 自动自增的id
     * @return
     */
    public ToJson<Object> deleteMeetRoomBySid(HttpServletRequest request,String sid);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午15:01:41
     * 方法介绍:    添加会议室
     * 参数说明:  meetingRoomWithBLOBs 传的参数
     * @return
     */
    public ToJson<Object> addMeetRoom(HttpServletRequest request,MeetingRoomWithBLOBs meetingRoomWithBLOBs);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午16:01:41
     * 方法介绍:    编辑会议室
     * 参数说明:  meetingRoomWithBLOBs 传的参数
     * @return
     */
    public ToJson<Object> editMeetRoom(HttpServletRequest request,MeetingRoomWithBLOBs meetingRoomWithBLOBs);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年8月1日 上午10:29:41
     * 方法介绍:   查询当前登录人的所有可以使用的会议室
     * 参数说明:    resquest
     * @return    Tojson
     */
    public  ToJson<MeetingRoomWithBLOBs> getAllMeetRoom(HttpServletRequest request, Integer page, Integer pageSize, boolean useFlag);

    /**
     * 各个会议室使用情况
     * 参数：currentDate 要查询的日期
     */
    public ToJson<MeetingRoomWithBLOBs> getUserRoomCondition(String currentDate);

    /**
     * @作者 廉立深
     * @时间 2020-08-12
     * @方法介绍 根据会议名称查询会议ID
     */
    Integer getRoomConditionId(String name);
}
