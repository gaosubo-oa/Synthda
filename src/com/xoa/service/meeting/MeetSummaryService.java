package com.xoa.service.meeting;

import com.xoa.model.meet.MeetingAttendConfirm;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-07-31 10:21
 *    类介绍：       会议纪要
 *    构造参数：     无
 *
 */
public interface MeetSummaryService {
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午13:30:41
     * 方法介绍:   会议纪要信息展示
     * 参数说明:   request
     * @return    ToJson
     */
    public ToJson<MeetingWithBLOBs> getAllInfo(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午14:30:41
     * 方法介绍:   会议纪要信息查询
     * 参数说明:   request
     * @return    ToJson
     */
    public ToJson<MeetingWithBLOBs> getMeetSummarydetail(HttpServletRequest request,String sid);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午14:40:41
     * 方法介绍:   编辑会议纪要
     * 参数说明:   request
     * @return    ToJson
     */
    public ToJson<Object> editMeetSummarydetail(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs);

    ToJson<Object> addSign(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm);

    ToJson<Object> meetNotes(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm);

    ToJson<Object> updateMeetNotes(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm);
}
