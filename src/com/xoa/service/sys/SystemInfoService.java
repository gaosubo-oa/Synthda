package com.xoa.service.sys;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.Map;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/5/31 19:26
 * @类介绍: 系统信息
 * @构造参数: 无
 **/
public interface SystemInfoService {
    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/27 11:09
     * @函数介绍: 获取系统信息
     * @参数说明: path 授权文件路径
     * @参数说明: path locale 获取选择语言环境
     * @return: map
     **/
    Map<String, String> getSystemInfo(String path, Object locale,HttpServletRequest request) throws ParseException;

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/26 16:36
     * @函数介绍: 从授权文件中获取授权信息
     * @参数说明: @param path 授权文件路径
     * @return: Map<String, String></String,>
     **/
    Map<String, String> getAuthInfo(String path);
    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/26 16:36
     * @函数介绍: 从授权文件中获取授权时间结束信息
     * @参数说明: @param path 授权文件路径
     * @return: Map<String, String></String,>
     **/
    Map<String, String> getAuthInfo(HttpServletRequest request);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/29 11:29
    *@函数介绍:  验证本机的机器码和给的机器吗是否一致
    *@参数说明:  @param authMachineCode
    *@return:   boolean ,true 表示一致
    **/
    boolean checkMachineCode(String authMachineCode) throws Exception;

    /**
     *@创建作者:  韩成冰
     *@创建日期:  2017/6/29 18:17
     *@函数介绍:  用户人数是否超过授权
     *@参数说明:  无
     *@return:   boolean
     **/

    public int getAuthUser(HttpServletRequest request);

    public int getOrgManage(HttpServletRequest request);

    Map<String, String> getEndLecDate(HttpServletRequest request) throws ParseException;



    Map<String, String> getAPPMessage();

    Map<String, String> getAuthorization( HttpServletRequest request);

    /**
     *
     * @return
     */
    public Map checkModule(HttpServletRequest request,String moustr);
    public String getAuthModule(HttpServletRequest request);

    public String getMachineCode16();

    Map<String, String> getSystemInfoDefault(String path, Object locale,HttpServletRequest request);
}
