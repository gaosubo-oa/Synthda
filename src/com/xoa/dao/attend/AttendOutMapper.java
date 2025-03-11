package com.xoa.dao.attend;

import com.xoa.model.attend.AttendOut;
import com.xoa.model.attend.AttendOutFlowRunPrcs;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AttendOutMapper {

    List<AttendOut> queryAttendOut(@Param("userId") String userId,@Param("date") String date);

       AttendOut selectAttendOut(@Param("userId") String userId,@Param("date") String date);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-14 下午14:45:00
     * 方法介绍:   查询外出登记
     */
    List<AttendOutFlowRunPrcs> queryAllAttendOut(Map<String, Object> objectMap);

    /**
     * 添加
     * @param attendOut
     * @return
     */
    int  insertSelective(AttendOut attendOut);

    /**
     * 修改
     * @param attendOut
     * @return
     */
    int updateByExampleSelective(AttendOut attendOut);


    List<AttendOutFlowRunPrcs> backlogAttendOut(Map<String, Object> maps);

    List<AttendOutFlowRunPrcs> haveDoneAttendOut(Map<String, Object> maps);
    /**
     * 创建作者:   季佳伟
     * 创建日期:   2017-11-21 下午16:56:00
     * 方法介绍:   根据userId查询外出登记
     */
    List<AttendOut> queryAttendOutByUserId(String userId);

    List<AttendOut> selectAttendOverList(@Param("userId") String userId,
                         @Param("beginDate")String beginDate,
                         @Param("endDate") String endDate);

    //获取当日所属统计
    List<AttendOut> getAttendLeaveByDateAndUids(Map map);

    List<AttendOut> getAttendOutListByMap(Map<String,Object> map);
}