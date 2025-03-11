package com.xoa.dao.attend;

import com.xoa.model.attend.AttendEvection;
import com.xoa.model.attend.AttendEvectionFlowRunPrcs;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AttendEvectionMapper {

   AttendEvection queryAttendEvection(@Param("userId") String userId,@Param("date") String date);

   AttendEvection selectAttendEvection(@Param("userId") String userId,@Param("date") String date);

   List<AttendEvection> selectAttendEvectionModify(@Param("userId") String userId,@Param("date") String date);

   /**
    * 创建作者:   牛江丽
    * 创建日期:   2017-7-14 下午14:45:00
    * 方法介绍:   查询出差登记
    */
   List<AttendEvectionFlowRunPrcs> queryAllAttendEvection(Map<String, Object> objectMap);

   /**
    * 修改
    * @param attendEvection
    * @return
    */
   int updateByExampleSelective(AttendEvection attendEvection);

   /**
    * 添加
    * @param attendEvection
    * @return
    */
   int  insertSelective(AttendEvection attendEvection);

   List<AttendEvectionFlowRunPrcs> backlogAttendEvection(Map<String, Object> maps);

   List<AttendEvectionFlowRunPrcs> haveDoneAttendEvection(Map<String, Object> maps);

   List<AttendEvection> selectAttendEvectionByUserId(String userId);

   //通过条件查询记录
   List<AttendEvection> selectAttendEvectionListByUserDd(@Param("userId") String userId,
                                                      @Param("beginDate")String beginDate,
                                                      @Param("endDate") String endDate);

   //获取当日所属统计
   List<AttendEvection> getAttendLeaveByDateAndUids(Map map);

    List<AttendEvection> getAttendEvectionListByMap(Map<String,Object> map);
}