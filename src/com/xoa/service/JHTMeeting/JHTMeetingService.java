package com.xoa.service.JHTMeeting;


import com.xoa.model.JHTMeeting.JHTMeetingWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

public interface JHTMeetingService {

    //查询接口
    ToJson findJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs,Integer page,Integer limit);

    //根据ID查询接口
    ToJson findByMeetingId(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs);

    //编辑接口
    ToJson editJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs, String isop);

    //删除接口
    ToJson delJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs);

    //新增接口
    ToJson insertJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs);
}
