package com.xoa.dao.sys;

import com.xoa.model.common.Syslog;

import java.util.List;
import java.util.Map;


public interface SysLogMapper {
    List<Syslog> findTotalDay();

    Long findTotalCount();

    Long findYearCount(Map<String, String> hashMap);

    Long findMouthCount(String yearmouth);

    Long findDayCount(String yearmouthday);

    List<Syslog> getTenLog();

    Integer getThisMonthCount(String monthTime);

    Integer getEachDayLogData(String dayTime);

    int getHourLog(String hourTime);

    List<Syslog> findLogOption(Map<String, Object> hashMap);

    void deleteLogOption(Map<String, Object> hashMap);

    String getLogNameByNo(String codeNo);

    void deleteLogById(Integer id);

    void deleteAllLog();

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/6 10:59
     * @函数介绍: 查某账号登录20条日志
     * @参数说明: uid, 用户id
     * @return: List<Syslog>
     **/
    List<Syslog> getUserLoginLogs(String userId);

    List<Syslog> getTenBatchSetLog();

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/8/28 15:40
     * @函数介绍: 获取修改登录密码的日志
     * @参数说明: @param request
     * @return: void
     **/

    List<Syslog> getModifyPwdLog(String userId);

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/13 15:40
     * @函数介绍: 获取登录的日志
     * @参数说明: @param request
     * @return: void
     **/

    List<Syslog> getLoginLog(String userId);


    List<Syslog>  getPassWordErrLog(Map<String,Object> map);

    List<Syslog> getEachMouthUsers();

    int getEachSevenUsers();

    Syslog getFirstLog();

    List<Syslog>  selectSecurityLog(Map<String, Object> params);
}

