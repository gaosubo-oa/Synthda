package com.xoa.dao.attend;


import com.xoa.model.attend.AttendSet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AttendSetMapper {

     AttendSet selectAttendSetSid(@Param("sid") Integer sid);
     /**
      * 添加考勤信息
      * @param attendSet
      * @return
      */
     int addAttendSet(AttendSet  attendSet);
     /**
      * 修改考勤信息
      */
     int updateAttendSet(AttendSet  attendSet);
     /**
      * 删除考勤信息
      */
     int delAttendSet(@Param("sid") Integer sid);
     /**
      * 查找全部考勤信息
      */
     List<AttendSet> selectAttendSet();
     /**
      * 当前用户设置信息
      */
     AttendSet queryAttendSetuId(@Param("uid") Integer uid);

     //根据名称查找考勤类型
     Integer getAttendSetByName(String title);


}