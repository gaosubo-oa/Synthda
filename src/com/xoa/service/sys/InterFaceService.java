package com.xoa.service.sys;

import com.xoa.model.sys.InterfaceModel;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.json.JSONException;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/6/2 18:09
 * @类介绍: 软件界面设置处理类
 * @构造参数: 无
 **/
public interface InterFaceService {
    List<InterfaceModel> getStaTusText();

    void editStatusText(InterfaceModel interfaceModel);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 18:08
     * @函数介绍: 系统界面设置
     * @参数说明: @param void
     * @return: List<InterfaceModel></InterfaceModel>
     **/
    List<InterfaceModel> getInterfaceInfo(HttpServletRequest request);

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/19 10:39
     * @函数介绍: 修改界面设置
     * @参数说明: @param InterfaceModel 界面设置信息的实体类
     * @return: void
     **/
    void updateInterfaceInfo(InterfaceModel interfaceModel);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/16 19:32
     * @函数介绍: 界面信息的添加
     * @参数说明: @param InterfaceModel 界面设置信息的实体类
     * @return: void
     **/

    public void insertInterfaceInfo(InterfaceModel interfaceModel);


    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许设置主题
     * @参数说明: @param
     */
    InterfaceModel getThemeSelect();

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许上传头像
     * @参数说明: @param
     */
    InterfaceModel getAvatarUpload();

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询使用什么登陆模板
     * @参数说明: @param
     */
    InterfaceModel getTemplate();

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 主界面信息
     * @参数说明: @param
     */
    InterfaceModel getIndexInfo();

     InterfaceModel getInterfaceParam();


    public BaseWrapper pushMessage(String userId, String app,HttpServletRequest request,String title,String content) throws JSONException;

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/15 14:24
     * 方法介绍:   查询是否开启移动端水印
     * 参数说明:   @param :
     * 返回值说明: InterfaceModel
     */
    public ToJson getMobileWatermark(String userId);

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/3/3
     * 方法介绍: 查询是否开启黑色主题 黑色主题（0-关，1-开）
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.sys.InterfaceModel>
     **/
    ToJson<Object> getBlackTheme(HttpServletRequest request);
}
