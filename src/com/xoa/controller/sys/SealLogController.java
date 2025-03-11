package com.xoa.controller.sys;

import com.xoa.model.sys.SealLog;
import com.xoa.service.sys.SealLogService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/22 15:35
 * 类介绍  :  印章日志处理
 * 构造参数:
 */
@Controller
@RequestMapping("/SealLog")
public class SealLogController {
    @Resource
    private SealLogService sealLogService;

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 13:54
     * @函数介绍: 印章日志列表查询接口
     * @参数说明: @param request SealLog
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/getAllSealLog")
    public ToJson<SealLog> getAllSealLog(String startTime,String endTime,HttpServletRequest request,String sealName,SealLog sealLog,Integer page,Integer pageSize,boolean useFlag){
     return sealLogService.getAllSealLog(startTime,endTime,request,sealName,sealLog,page,pageSize,useFlag);
    }
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 13:54
     * @函数介绍: 印章日志批量删除接口
     * @参数说明: @param id[]
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/deleteSealLog")
    public ToJson<Object> deleteSealLog(@RequestParam("ids[]")String[] ids){
        return sealLogService.deleteSealLog(ids);
    }

    @ResponseBody
    @RequestMapping("/checkFileMd5")
    public void checkFileMd5(HttpServletRequest request, HttpServletResponse response, MultipartFile file){
        sealLogService.checkFileMd5(request,response,file);
    }




}
