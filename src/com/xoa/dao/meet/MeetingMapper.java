package com.xoa.dao.meet;

import com.xoa.model.meet.Meeting;
import com.xoa.model.meet.MeetingWithBLOBs;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MeetingMapper {
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:54:00
     * 方法介绍:  根据条件进行查询会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    List<MeetingWithBLOBs> queryMeeting(Map<String,Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午13:58:00
     * 方法介绍:  我的会议
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return List
     */
    List<MeetingWithBLOBs> getMyMeeting(Map<String,Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:00:00
     * 方法介绍:  根据id查询会议信息
     * 参数说明:   @param sid会议id
     * 返回值说明:   @return MeetingWithBLOBs
     */
    MeetingWithBLOBs queryMeetingById(String sid);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:02:00
     * 方法介绍:  根据id更新会议信息
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 更新条数
     */
    int updateMeetingById(MeetingWithBLOBs meetingWithBLOBs);
    int updateMeetingByIdV1(MeetingWithBLOBs meetingWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:04:00
     * 方法介绍:  根据id更新会议状态
     * 参数说明:   @param Meeting
     * 返回值说明:   @return int 更新条数
     */
    int updMeetStatusById(Meeting meeting);

    /**
     * 创建作者:   廉立深
     * 方法介绍:  根据id更新服务端会议室Id
     * 参数说明:   @param Meeting
     * 返回值说明:   @return int 更新条数
     */
    int updMeetVideoById(Meeting meeting);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:05:00
     * 方法介绍:  申请会议（添加会议信息）
     * 参数说明:   @param MeetingWithBLOBs
     * 返回值说明:   @return int 插入条数
     */
    int insertMeeting(MeetingWithBLOBs meetingWithBLOBs);
    int insertMeetingv1(MeetingWithBLOBs meetingWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月29日 下午14:06:00
     * 方法介绍:  根据id删除会议信息
     * 参数说明:   @param sid
     * 返回值说明:   @return int 删除条数
     */
    int delMeetingById(String sid);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月31日 下午10:48:00
     * 方法介绍:  根据状态获取会议的数量
     * 参数说明:   @param meeting
     * 返回值说明:   @return int
     */
    int queryCountByStatus(Map map);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 上午10:47:00
     * 方法介绍:  查询会议纪要
     * 参数说明:   map
     * 返回值说明:
     */
    List<MeetingWithBLOBs>  getMeetSummary(Map<String,Object>map);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午14:50:00
     * 方法介绍:  根据id更新会议状态
     * 参数说明:   @param meetingWithBLOBs
     * 返回值说明:   @return int 更新条数
     */
    int editMeetSummary(MeetingWithBLOBs meetingWithBLOBs);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年8月3日 下午11:27:00
     * 方法介绍:  申请会议的时间和已申请会议的时间（不冲突）的数量
     * 参数说明:   @param meetingWithBLOBs
     * 返回值说明:   @return int 更新条数
     */
    int selCountRoomNoConflict(Map<String,Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年8月17日 上午10:15:00
     * 方法介绍:  会议室当天使用情况
     * 参数说明:   map
     * 返回值说明:
     */
    List<MeetingWithBLOBs>  queryCurrentRoomUserCondition(Map<String,Object>map);

    List<MeetingWithBLOBs> getMeetingNotify(Map<String,Object>map);


    MeetingWithBLOBs queryMeetingByIdInt(Integer sid);

    int getMettingByTime(Map<String,Object> map);
    int getPTMettingByTime(Map<String,Object> map);

    int updateMettingById(MeetingWithBLOBs meetingWithBLOBs);

    /**
     * @作者: 张航宁
     * @时间: 2019/9/19
     * @说明: 查询待审批的周期性会议
     */
    List<MeetingWithBLOBs> getCycleMeeting(Map<String,Object> map);

    /**
     * @作者: 张航宁
     * @时间: 2019/9/19
     * @说明: 根据周期性会议no查询所有会议
     */
    List<MeetingWithBLOBs> getCycleMeetingByNo(Map<String,Object> map);

    /**
     * @作者: 张航宁
     * @时间: 2019/9/20
     * @说明: 获取周期会议最大的周期id
     */
    int getMaxCycleNo();

    List<MeetingWithBLOBs> MyMeeting(Map<String, Object> map);

    List<MeetingWithBLOBs> meetingManage(Map<String, Object> map);

    List<MeetingWithBLOBs> meetingQuery(Map<String, Object> map);

    Integer queryCountByStatu(Map paraMeeting);

    List<MeetingWithBLOBs> getApp(Map<String, Object> maps);

    List<Meeting> selectAll();

    List<MeetingWithBLOBs> queryMeetingByRoomIds(Map<String,Object> map);

    //查询某个角色下所有用户
    String selectOwner(@Param("i") Integer i);

    List<MeetingWithBLOBs> MyMeetingv1(Map<String, Object> map);

    int updatePowerChinaMeet(String sid);

    List<MeetingWithBLOBs> selectTimeWithStatus();
    int updateCreateQrcodeTimeBySid(Meeting meeting);

    List<MeetingWithBLOBs> selectMeetingReserve(Map<String, Object> map);
}