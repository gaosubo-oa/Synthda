package com.xoa.dao.attendance;

import com.xoa.model.attendance.LeaveStatistics;

import java.util.List;
import java.util.Map;

public interface LeaveStatisticsMapper {

    public List<LeaveStatistics> leaveStatisticsHeadTeacherQuery(Map map);

    public List<LeaveStatistics> leaveStatisticsNoHeadTeacherQuery(Map map);

    public List<LeaveStatistics> leaveStatisticsGeneralLogisticsQuery(Map map);

    public List<LeaveStatistics> leaveStatisticsAdministrativeQuery(Map map);


}
