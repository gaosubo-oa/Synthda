package com.xoa.dao.sys;

import com.xoa.model.sys.InterfaceModel;

import java.util.List;
/**
 *
 */

public interface SysInterfaceMapper {


    List<InterfaceModel> getStatusText();

    void editStatusText(String statusText);

    List<InterfaceModel> getInterfaceInfo();

    void updateInterfaceInfo(InterfaceModel interfaceModel);

    public void insertInterfaceInfo(InterfaceModel interfaceModel);

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 获取主界面信息
     * @参数说明: @param
     */
    InterfaceModel getIndexInfo();

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/19
     * @函数介绍: 查询是否允许选择主题
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
     * @函数介绍:  查询用应该使用什么登页面模板主题
     * @参数说明: @param
     */
    InterfaceModel getTemplate();

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/15 14:22
     * 方法介绍:   查询是否开启移动端水印
     * 参数说明:   @param :
     * 返回值说明: InterfaceModel
     */
    InterfaceModel getMobileWatermark();

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/3/3
     * 方法介绍: 查询是否开启黑色主题 黑色主题（0-关，1-开）
     * 参数说明: []
     * 返回值说明: com.xoa.model.sys.InterfaceModel
     **/
    InterfaceModel getBlackTheme();
}