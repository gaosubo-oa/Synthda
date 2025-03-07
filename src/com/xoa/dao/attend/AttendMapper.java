package com.xoa.dao.attend;

import com.xoa.model.attend.Attend;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by gsb on 2017/6/8.
 */
public interface AttendMapper {

    int addAttend(Attend attend);

    int insertSelective(Attend attend);

    List<Attend> selectAttend(Map<String, Object> maps);

    Attend selectAttendType(@Param("type") String type);

    List<Attend> selectAttendList(Map<String, Object> maps);

    List<Attend> AttendList(Map<String, Object> maps);

    List<Attend> quertAttendList(Map<String, Object> maps);

    Attend selectAttendAll(@Param("date") String date, @Param("uid") Integer uid, @Param("type") String type);

    //考勤统计 保存时间的集合
    List<Attend> selectAttendCompilations(@Param("date") String date, @Param("uid") String uid, @Param("type") String type);

    List<Attend> selectAttend0(@Param("date") String date, @Param("uid") Integer uid);

    List<Attend> queryCountPhone(Map<String, Object> maps);

    List<Attend> queryAttendPhone(Map<String, Object> maps);

    List<Attend> queryAttendPhoneId(Map<String, Object> maps);

    List<Attend> findByAttendCount(@Param("depId") String depId);

    //查询日期
    List<Date> selectAttendDate(Integer uid);

    //通过ID查询单个人的在位时长
    List<Attend> selectAttendDateExamine(Map<String, Object> map);

    //通过时间查询所有人的在位时长
    List<Attend> AllselectAttendDateExamine(Attend attend);

    //导出考勤信息
    List<Attend> queryExportAttend(Map<String, Object> map);

    //考勤详情
    List<Attend> selectAttendParticulars(Map<String, Object> map);

    Attend getAttendByType(Map<String, Object> map);

    Attend getAttendDetailByType(@Param("uid") String uid, @Param("type") String type, @Param("date") String date);

    List<Attend> getAttendListByUidAndDates(@Param("uid") Integer uid, @Param("beginDate") String beginDate, @Param("endDate") String endDate);

    List<Attend> getAttendByUidDatesType(@Param("uid") Integer uid, @Param("beginDate") String beginDate, @Param("endDate") String endDate);

    /**
     * 条件查找
     */
    List<Attend> getAttendListByMap(Map map);

    Map<String, String> getUserNameAndDeptNameByUid(Integer uid);

    //获取所有有效uid
    List<Integer> getUidAll(@Param("noDutyUser") String noDutyUser);

    //获取当前所属uids 的加班和排班信息
    List<Attend> getJiaBanZhiBanListByUidsAndDate(@Param("uids") List uids, @Param("date") String date);

    //查看用户当天是否有打卡记录
    Integer getUidDateAttend(@Param("date") String date, @Param("uid") Integer uid);

    //根据日期和 用户Uid  查询  打卡信息
    List<Attend> getAttendByUidDate(@Param("date") String date, @Param("uid") Integer uid);

    //批量插入
    int insertAttends(List<Attend> attends);

    int selectMaxId();

    //查询是否这一次打卡
    int selectIsAttend(Map<String, Object> map);

    Map<String, String> selectUserAndDeptName(@Param("uid")String uid,@Param("paraValue") String paraValue);
}
