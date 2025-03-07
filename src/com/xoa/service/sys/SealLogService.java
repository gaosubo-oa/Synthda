package com.xoa.service.sys;

import com.xoa.model.sys.SealLog;
import com.xoa.util.ToJson;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *    创建作者:      高亚峰
 *    创建日期：     2017-08-22 11:12
 *    类介绍：       印章日志处理
 *    构造参数：     无
 *
 */

public interface SealLogService {


    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 制作印章日志
     * @参数说明: @param request
     * @return: json
     **/
    public int addSealLog(SealLog sealLog);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 13:54
     * @函数介绍: 印章日志列表查询接口
     * @参数说明: @param request SealLog
     * @return: json
     **/
    public ToJson<SealLog> getAllSealLog(String startTime,String endTime,HttpServletRequest request,String sealName,SealLog sealLog,Integer page,Integer pageSize,boolean useFlag);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 13:54
     * @函数介绍: 批量删除印章日志
     * @参数说明: @param request SealLog
     * @return: json
     **/
    public ToJson<Object> deleteSealLog(String[] ids);

    public void checkFileMd5(HttpServletRequest request, HttpServletResponse response, MultipartFile file);
}
