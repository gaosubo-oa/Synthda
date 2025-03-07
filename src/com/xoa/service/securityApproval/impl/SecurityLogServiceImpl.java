package com.xoa.service.securityApproval.impl;
import java.io.OutputStream;
import java.util.Date;

import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.securityApproval.SecurityLogMapper;
import com.xoa.dao.sys.SysLogMapper;
import com.xoa.dao.sys.TableStatisticsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.securityApproval.SecurityLog;
import com.xoa.model.sys.TableStatistics;
import com.xoa.model.users.Users;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.securityApproval.SecurityLogService;
import com.xoa.util.*;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.netdisk.ZipUtils;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SecurityLogServiceImpl implements SecurityLogService {

    @Resource
    private SecurityLogMapper securityLogMapper;

    @Resource
    private SecurityApprovalService securityApprovalService;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private TableStatisticsMapper tableStatisticsMapper;

    @Resource
    private SysLogMapper sysLogMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SysCodeMapper sysCodeMapper;

    /**
     * 新增安全审计日志
     * @param request
     * @param module  操作模块
     * @param content  操作内容
     * @param accessId  操作记录ID
     * @param remarks  备注信息
     */
    public void insertSecurityLog(HttpServletRequest request,String module,String content,String accessId,String remarks){
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);

            //拼装日志
            SecurityLog securityLog = new SecurityLog();
            if(!Objects.isNull(user) && !StringUtils.checkNull(user.getUserId())) {
                securityLog.setUserId(user.getUserId());
                securityLog.setUserPriv(user.getUserPriv().toString());
            }
            securityLog.setModule(module);
            securityLog.setContent(content);
            securityLog.setAccessId(accessId);
            securityLog.setRemarks(remarks);

            String userAgent = request.getParameter("userAgent");
            if ("pc".equals(userAgent)) {
                securityLog.setClientType("PC端: " + IpAddr.getIpAddress(request));
            } else {
                securityLog.setClientType("WEB: " + IpAddr.getIpAddress(request));
            }

            if(!request.getParameterMap().isEmpty()){
                securityLog.setParameters(JSONObject.toJSONString(request.getParameterMap()));
            }
            securityLog.setOperateTime(new Date());
            securityLogMapper.insertSelective(securityLog);
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    /**
     * 查询安全审计日志（保密员和审计员）
     * @param request
     * @return
     */
    @Override
    public ToJson querySecurityLog(HttpServletRequest request, HttpServletResponse response, String type, String userId, String beginTime, String endTime, String export, Integer page, Integer pageSize, boolean useFlag) {
        ToJson toJson = new ToJson();
        try {
            //判断当前用户是保密员还是审计员
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
            String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
            Users secrecyPriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");//保密员
            Users auditPriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_AUDIT_PRIV");//审计员
            Users managePriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_MANAGE_PRIV");//管理员

            if(!user.getUserId().equals(secrecyPriv.getUserId()) && !user.getUserId().equals(auditPriv.getUserId()) && !"admin".equals(user.getUserId())){
                toJson.setFlag(0);
                toJson.setMsg("无权限查询");
                return toJson;
            }

            Map<String,Object> params = new HashMap<>();
            List notQueryUserIds = new ArrayList<>();
            List queryUserIds = new ArrayList<>();
            if(!"admin".equals(user.getUserId())){
                notQueryUserIds.add("admin");
            }

            //系统安全保密员（除了保密员自己以外的所有用户的日志）
            if(user.getUserId().equals(secrecyPriv.getUserId())){
                notQueryUserIds.add(user.getUserId());
            }

            //系统安全审计员（查看“系统安全管理员”和“系统安全保密员”的登录登出和操作日志）
            if(user.getUserId().equals(auditPriv.getUserId())){
                queryUserIds.add(managePriv.getUserId());
                queryUserIds.add(secrecyPriv.getUserId());
            }

            params.put("notQueryUserIds",notQueryUserIds);
            params.put("queryUserIds",queryUserIds);
            params.put("type",type);
            if(!StringUtils.checkNull(userId) && !"undefined".equals(userId)) {
                params.put("userId", userId.replace(",", ""));
            }
            if(!StringUtils.checkNull(beginTime) && !StringUtils.checkNull(endTime)){
                params.put("beginTime",beginTime + " 00:00:00");
                params.put("endTime",endTime + " 23:59:59");
            }
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            params.put("page", pageParams);
            List<Syslog> syslogs = sysLogMapper.selectSecurityLog(params);

            if(!Objects.isNull(syslogs) && syslogs.size() > 0){
                //获取涉及到的用户信息
                String userIds = syslogs.stream().map(Syslog::getUserId).filter(id -> !StringUtils.checkNull(id)).collect(Collectors.joining(","));
                Map<String,String> userMap = new HashMap<>();
                if(!StringUtils.checkNull(userIds)){
                    List<Users> users = usersMapper.selUserByIds(userIds.split(","));
                    for (Users u : users) {
                        userMap.put(u.getUserId(),u.getUserName());
                    }
                }

                List<SysCode> logType = sysCodeMapper.getLogType("SYS_LOG");
                Map<String, String> logTypeMap = logType.stream().collect(Collectors.toMap(SysCode::getCodeNo, SysCode::getCodeName,(oldValue, newValue) -> {return oldValue;}));
                for (Syslog syslog : syslogs) {
                    syslog.setUserName(userMap.get(syslog.getUserId()));
                    syslog.setTypeName(logTypeMap.get(syslog.getType() + ""));
                    syslog.setTimeStr(DateFormat.getStrDate(syslog.getTime()));

                    if(syslog.getRemark().contains("附件ID")){
                        String remark = syslog.getRemark();
                        String attachId = remark.substring(remark.indexOf("附件ID：") + 5, remark.indexOf("，附件名称："));
                        String attachName = remark.substring(remark.indexOf("，附件名称：") + 6);
                        if(!StringUtils.checkNull(attachId) && !StringUtils.checkNull(attachName)) {
                            syslog.setAttachmentList(GetAttachmentListUtil.returnAttachment(attachName, attachId, sqlType, GetAttachmentListUtil.MODULE_SYS));
                        }
                    }
                }
            }
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setObj(syslogs);
            toJson.setMsg("success");
            toJson.setFlag(0);

            //导出{
            if ("1".equals(export)) {
                OutputStream out = response.getOutputStream();
                try {
                    HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("系统审计日志", 8);
                    String[] secondTitles = {"日志ID", "用户ID","用户姓名", "时间", "IP地址", "日志类型", "备注", "设备类型", "版本号"};
                    HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                    String[] beanProperty = {"logId", "userId", "userName", "timeStr", "ip", "typeName", "remark", "clientTypeName", "clientVersion"};
                    HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, toJson.getObj(), beanProperty);
                    String filename = "系统安全审计日志.xls";
                    filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                    response.setHeader("content-disposition", "attachment;filename=" + filename);
                    workbook.write(out);
                }catch (Exception e){
                    e.printStackTrace();
                }finally {
                    out.close();
                }
            }


        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 审计日志设置
     * @param request
     * @param retentionTime 日志保存时限
     * @param spaceThreshold 日志占用空间阈值
     * @param processMode 日志处理方式
     * @return
     */
    @Override
    public ToJson editSecadmSetPara(HttpServletRequest request, Integer retentionTime, Integer spaceThreshold, String processMode) {
        ToJson toJson = new ToJson();
        try {
            //判断当前用户是否为保密员
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
            Users secrecyPriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");//保密员
            if(!user.getUserId().equals(secrecyPriv.getUserId()) && !"admin".equals(user.getUserId())){
                toJson.setFlag(0);
                toJson.setMsg("无权限设置");
                return toJson;
            }

            JSONObject jsonObject = new JSONObject();
            //日志保存时限设置
            jsonObject.put("retentionTime",retentionTime);
            //日志占用空间阈值设置
            jsonObject.put("spaceThreshold",spaceThreshold);
            //日志处理方式设置
            jsonObject.put("processMode",processMode);
            //空间预警阈值
            jsonObject.put("thresholdPercentage",request.getParameter("thresholdPercentage"));

            SysPara sysPara = sysParaMapper.querySysPara("BAOMIYUAN_SET_PARA");
            if(Objects.isNull(sysPara)){
                sysPara = new SysPara();
                sysPara.setParaName("BAOMIYUAN_SET_PARA");
                sysPara.setParaValue(jsonObject.toJSONString());
                sysParaMapper.insertSysPara(sysPara);
            }else {
                sysPara.setParaValue(jsonObject.toJSONString());
                sysParaMapper.updateSysPara(sysPara);
            }

            toJson.setObject(sysPara);
            toJson.setMsg("success");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }



    /**
     * 查询审计日志设置
     * @param request
     * @return
     */
    @Override
    public ToJson querySecadmSetPara(HttpServletRequest request) {
        ToJson toJson = new ToJson();
        try {
            //判断当前用户是否为保密员
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
            Users secrecyPriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");//保密员
            if(!user.getUserId().equals(secrecyPriv.getUserId()) && !"admin".equals(user.getUserId())){
                toJson.setFlag(0);
                toJson.setMsg("无权限查询");
                return toJson;
            }

            //查询日志表占用空间
            TableStatistics securityLogSpace = tableStatisticsMapper.select("sys_log");
            securityLogSpace.setDatalength((int)ZipUtils.getM(ZipUtils.getKB(Double.valueOf(securityLogSpace.getDatalength()))));
            securityLogSpace.setRows(Math.toIntExact(sysLogMapper.findTotalCount()));
            SysPara sysPara = sysParaMapper.querySysPara("BAOMIYUAN_SET_PARA");
            toJson.setObject(sysPara.getParaValue());
            toJson.setData(securityLogSpace);
            toJson.setMsg("success");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }
}
