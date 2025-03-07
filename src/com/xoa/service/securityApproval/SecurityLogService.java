package com.xoa.service.securityApproval;

import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SecurityLogService {

    /**
     * 新增安全审计日志
     * @param request
     * @param module  操作模块
     * @param content  操作内容
     * @param accessId  操作记录ID
     * @param remarks  备注信息
     */
    //void insertSecurityLog(HttpServletRequest request, String module, String content, String accessId, String remarks);


    /**
     * 查询安全审计日志（保密员和审计员）
     * @param request
     * @return
     */
    ToJson querySecurityLog(HttpServletRequest request, HttpServletResponse response, String type, String userId, String beginTime, String endTime, String export, Integer page, Integer pageSize, boolean useFlag);


    /**
     * 审计日志设置
     * @param request
     * @param retentionTime 日志保存时限
     * @param spaceThreshold 日志占用空间阈值
     * @param processMode 日志处理方式
     * @return
     */
    ToJson editSecadmSetPara(HttpServletRequest request, Integer retentionTime, Integer spaceThreshold, String processMode);


    /**
     * 查询审计日志设置
     * @param request
     * @return
     */
    ToJson querySecadmSetPara(HttpServletRequest request);
}
