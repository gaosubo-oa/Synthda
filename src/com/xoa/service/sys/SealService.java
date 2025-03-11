package com.xoa.service.sys;

import com.xoa.model.sys.SealLog;
import com.xoa.model.sys.SealWithBLOBs;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/17 16:29
 * 类介绍  :   印章管理
 * 构造参数:
 */
public interface SealService {

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 19:54
     * @函数介绍: 添加印章信息
     * @参数说明: @param request
     * @return: json
     **/
    public ToJson<Object> addSealObject(HttpServletRequest request,SealWithBLOBs seal);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 19:54
     * @函数介绍: 设置印章权限
     * @参数说明: @param request
     * @return: json
     **/
    public ToJson<Object> editSealObject(HttpServletRequest request,SealWithBLOBs seal);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/17 19:54
     * @函数介绍: 根据当前登录人查询印章信息
     * @参数说明: @param request
     * @return: json
     **/
    public List<SealWithBLOBs> getSealByUser(HttpServletRequest request);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/18 14:54
     * @函数介绍: 印章列表展示
     * @参数说明: @param request
     * @return: json
     **/
    public ToJson<SealWithBLOBs> getAllSealInfo(HttpServletRequest request,SealWithBLOBs sealWithBLOBs,String startTime,String endTime);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/18 14:54
     * @函数介绍: 查询印章权限详情
     * @参数说明: @param request
     * @return: json
     **/
    public ToJson<SealWithBLOBs> getSealById(String id);

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 批量删除印章信息
     * @参数说明: @param request
     * @return: json
     **/

    public ToJson<Object> deleteSeal(HttpServletRequest request,String [] ids);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 获取印章编号
     * @参数说明: @param request String id
     * @return: json
     **/
    public ToJson<Object> getSealIdById(HttpServletRequest request,String id);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/8/19 14:54
     * @函数介绍: 获取印章编号是否重复
     * @参数说明: @param request String sealId
     * @return: json
     **/
    public ToJson<SealWithBLOBs> getSealBySealId(HttpServletRequest request,String sealId);


    String querySealById(HttpServletRequest request, Integer sealId);

    String parseAllSeal(String sealData);

    String parseAppSeal(HttpServletRequest request, String sealData,Integer sealW,Integer sealY,String sealName,String sealPosition,String sealH,String sealX,String oriData);

    String parseSealToWebsign(HttpServletRequest request, String sealData, String psw, String sealName, String sealPosition, String sealX, String sealY, String oriData);

    ToJson<Object> updateSeal(HttpServletRequest request, SealWithBLOBs seal, SealLog sealLog);
}
