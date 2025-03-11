package com.xoa.service.sys.impl;

import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.sys.SealLogMapper;
import com.xoa.dao.sys.SealMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.sys.Seal;
import com.xoa.model.sys.SealLog;
import com.xoa.model.users.Users;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.service.sys.SealLogService;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.MD5Utils;
import com.xoa.util.ToJson;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/22 11:20
 * 类介绍  :   印章日志处理
 * 构造参数:
 */
@Service
public class SealLogServiceImpl implements SealLogService {

    @Resource
    private SealLogMapper sealLogMapper;

    @Resource
    private SealMapper sealMapper;

    @Resource
    private UsersMapper usersMapper;


    @Resource
    private SysTasksService sysTasksService;

    @Resource
    private EnclosureService enclosureService;

    @Override
    public int addSealLog(SealLog sealLog) {
       return sealLogMapper.insertSelective(sealLog);
    }

    @Override
    public ToJson<SealLog> getAllSealLog(String startTime,String endTime,HttpServletRequest request,String sealName,SealLog sealLog,Integer page,Integer pageSize,boolean useFlag) {
        ToJson<SealLog> json =new ToJson<SealLog>(1,"err");
        try {
            if(startTime==""){
                startTime=null;
            }
            if(endTime==""){
                endTime=null;
            }
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            map.put("startTime",startTime);
            map.put("endTime",endTime);
            map.put("sealName",sealName);
            map.put("logType",sealLog.getLogType());
            map.put("userId",sealLog.getUserId());
            List<SealLog> allSealLogInfo = sealLogMapper.selectAllSealLogInfo(map);
            if(allSealLogInfo!=null){
                for(SealLog sealLog1:allSealLogInfo){
                    if("onlyofficesign".equals(sealLog1.getLogType()) || sealLog1.getLogType().contains("XSign")){

                    } else {
                        Seal sealLogBySealId = sealMapper.getSealLogBySealId(sealLog1.getsId());
                        if(sealLogBySealId!=null){
                            sealLog1.setSealName(sealLogBySealId.getSealName());
                        }else{
                            sealLog1.setSealName("印章已删除");
                        }
                    }

                    Users usersByuserId = usersMapper.getUsersByuserId(sealLog1.getUserId());
                    if(usersByuserId!=null){
                        sealLog1.setUserName(usersByuserId.getUserName());
                    }
                    //操作日志类型
                    if(sealLog1.getLogType().equals("makeseal")){
                       sealLog1.setLogTypeName("制作印章");
                    }
                    else if(sealLog1.getLogType().equals("setseal")){
                        sealLog1.setLogTypeName("印章授权");
                    }
                    else if(sealLog1.getLogType().equals("deleteseal")){
                        sealLog1.setLogTypeName("删除印章");
                    }
                    else if(sealLog1.getLogType().equals("onlyofficesign")){
                        sealLog1.setLogTypeName("OnlyOffice盖章");
                    }
                    else if(sealLog1.getLogType().equals("makeXSign")){
                        sealLog1.setLogTypeName("制作电子签章");
                    }
                    else if(sealLog1.getLogType().equals("deleteXSign")){
                        sealLog1.setLogTypeName("删除电子签章");
                    }
                    else if(sealLog1.getLogType().equals("setXSign")){
                        sealLog1.setLogTypeName("电子签章授权");
                    }
                    else if(sealLog1.getLogType().equals("sealXSign")){
                        sealLog1.setLogTypeName("电子签章盖章");
                    }

                    if(!StringUtils.checkNull(sealLog1.getInfoExt())){
                        sealLog1.setInfoExtObj(JSONObject.parseObject(sealLog1.getInfoExt()));
                    }
                }
            }
            json.setFlag(0);
            json.setMsg("ok");
            json.setObj(allSealLogInfo);
            json.setTotleNum(pageParams.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> deleteSealLog(String[] ids) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            sealLogMapper.deleteSealLog(ids);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public void checkFileMd5(HttpServletRequest request, HttpServletResponse response, MultipartFile file) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        ToJson<Object>  toJson = new ToJson<>();
        File file1 = FileUploadUtil.MultipartFileToFile(file);
        String fileMd5Code = "";
        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();
        if (encryption) {
            //全路径（去掉未修改的文件夹）
            String path = file1.getAbsolutePath();
            String filePath = path.substring(0, path.lastIndexOf(File.separator));
            String fileName = path.substring(path.lastIndexOf(File.separator));
            File file2 = AESUtil.encryption(file, filePath, fileName, enclosureService.getCompany(sqlType));
            fileMd5Code = MD5Utils.getFileMd5Code(file2);
            file2.delete();
        }else {
            fileMd5Code = MD5Utils.getFileMd5Code(file1);
        }
        SealLog sealLog = sealLogMapper.selectByMd5(fileMd5Code);
        file1.delete();
        if(sealLog!=null){
            Users usersByuserId = usersMapper.getUsersByuserId(sealLog.getUserId());
            if(usersByuserId!=null){
                sealLog.setUserName(usersByuserId.getUserName());
            }
            if(!StringUtils.checkNull(sealLog.getInfoExt())){
                sealLog.setInfoExtObj(JSONObject.parseObject(sealLog.getInfoExt()));
            }
            toJson.setObject(sealLog);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        } else {
            toJson.setMsg("没有查询到该文件Md5");
            toJson.setFlag(1);
        }

        response.setHeader("content-type", "text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        try (ServletOutputStream out = response.getOutputStream();
             OutputStreamWriter ow = new OutputStreamWriter(out, StandardCharsets.UTF_8);) {

            ow.write(JSONObject.toJSONString(toJson));
            ow.flush();
            ow.close();
        } catch (Exception e){
            e.printStackTrace();
        }

    }


}
