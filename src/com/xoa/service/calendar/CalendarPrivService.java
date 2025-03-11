package com.xoa.service.calendar;

import com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by 刘建 on 2020/7/30 11:23
 */
public interface CalendarPrivService {
    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 13:31
     * 方法介绍: 创建日程权限记录
     * @param calendarLeaderPriv
     * @return com.xoa.util.ToJson<com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv>
     */
    ToJson<CalendarLeaderPriv> saveCalendarPriv(CalendarLeaderPriv calendarLeaderPriv);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 13:32
     * 方法介绍: 根据主键删除
     * @param privId
     * @return com.xoa.util.ToJson<com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv>
     */
    ToJson<CalendarLeaderPriv> delCalendarPriv(Integer privId);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 13:32
     * 方法介绍: 编辑日程权限
     * @param calendarLeaderPriv
     * @return com.xoa.util.ToJson<com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv>
     */
    ToJson<CalendarLeaderPriv> editCalendarPriv(CalendarLeaderPriv calendarLeaderPriv);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 13:32
     * 方法介绍: 分页查询全部日程权限记录
     * @return com.xoa.util.ToJson<com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv>
     */
    ToJson<CalendarLeaderPriv> selAllCalendarPriv(boolean useFlag ,Integer page, Integer pageSize);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 13:41
     * 方法介绍: 主键查询
     * @param privId
     * @return com.xoa.util.ToJson<com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv>
     */
    ToJson<CalendarLeaderPriv> findCalendarPriv(Integer privId);


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-08-03 9:58
     * 方法介绍: 查询当前用户的领导
     * @param request
     * @return com.xoa.util.ToJson<com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv>
     */
    ToJson<CalendarLeaderPriv> getLeader(HttpServletRequest request);

}
