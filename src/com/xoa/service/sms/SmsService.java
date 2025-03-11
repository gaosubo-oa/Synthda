package com.xoa.service.sms;


import com.xoa.model.sms.Sms;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @作者：张航宁
 * @时间：2017/7/28
 * @介绍：事务提醒
 */
public interface SmsService {

    /**
     * @作者：张航宁
     * @时间：2017/7/28
     * @介绍：保存事务提醒
     * @参数：smsBody toIDs
     */
    ToJson<SmsBody> saveSms(SmsBody smsBody, String toIds,String remind,String tuisong,String title,String context,String sqlType);

    /**
     * @作者：张航宁
     * @时间：2017/7/28
     * @介绍：提醒类型查询
     * @参数：queryType 1 未确认提醒 2已接收提醒 3已发送提醒
     */
    ToJson<SmsBody> getSmsBodies(HttpServletRequest request,Integer queryType,Integer page,Integer pageSize);
    ToJson classification(HttpServletRequest request,Integer classification);

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：更新删除状态（即页面中的删除操作）
     * @参数：request
     */
    ToJson<Sms> updateDeleteFlag(HttpServletRequest request,String deleteFlag,String smsIds);

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：更新阅读状态
     * @参数：request
     */
    ToJson<Sms> updateRemindFlag(HttpServletRequest request,String remindFlag,String smsIds);

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：删除所有已读
     * @参数：toId
     */
    ToJson<Sms> deleteByRemind(HttpServletRequest request,String deleteType);

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：删除所有收信人已删除的
     * @参数：request
     */
    ToJson<Sms> deleteByDelFlag(HttpServletRequest request);

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：设置已读
     * @参数：request bodyId
     */
    ToJson<Sms> setRead(HttpServletRequest request,Integer bodyId);

    /**
     * @作者：张航宁
     * @时间：2017/8/3
     * @介绍：多条件查询
     * @参数：orderBy 排序字段 sortType 升序或降序 opeType 查询类型 1是查询 2是导出
     */
    ToJson<SmsBody> querySmsBody(HttpServletRequest request, HttpServletResponse response, String toIds, String fromIds, String smsType, String beginDate, String endDate, String content, String orderBy, String sortType, String opeType, Integer page,
                                 Integer pageSize, boolean useFlag);

    /**
     * @作者：张航宁
     * @时间：2017/8/18
     * @介绍：根据路径设置已读
     * @参数：HttpServletRequest request,String url
     */
    void setRead(HttpServletRequest request,String url);

    void updatequerySmsByType(String type,String userId,String id);

    void updateEndTimeList(HttpServletRequest request,String userId);

    void querySmsByTypeUpdateRunId(String type, String runId, Map<String,String> map);

    Integer getSmsId(HttpServletRequest request,String visitUrl);

    int getRemidFlagById(int id);

    void querySmsByTypeBathchUpdateRunId (String type,String[]runId);

    /**
     * 将事务提醒未读改为已读
     * @param request
     * @param bodyId
     */
    public void setSmsReadStatus(HttpServletRequest request,Integer bodyId);

    public void setSmsRead(String smsType,String remindUrl,Users users);
    public void setSmsFileRead(String bodyId,String smsType,String remindUrl,Users users);

    public void setSmsReadAll(String smsType,String remindUrl);

    /**
     * 将事务提醒未读改为已读
     * @param request
     * @param bodyId
     */
    public void setSmsReadByBodyId(HttpServletRequest request,Integer bodyId);
    Integer selectSmsId(HttpServletRequest request,String visitUrl);

    Integer selectSmsId(String toUserId,String url);

}