package com.xoa.dao.myNotify;


import com.xoa.model.myNotify.MySysPara;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-18 下午6:18:03
 * 类介绍    :   APP对应DAO
 * 构造参数:   无
 */
public interface MySysParaMapper {

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午6:18:48
     * 方法介绍:   得到APP端对应的菜单
     * 参数说明:   @return
     *
     * @return String 返回APP对应的菜单串
     */
    public String getSysPara();

    /**
     * @throws
     * @Title: getIeTitle
     * @Description: 状态栏查询方法
     * @author(作者): 张丽军
     * @param: @return
     * @return: List<com.xoa.model.common.SysPara>
     */
    List<MySysPara> getIeTitle();

    MySysPara  selectget111();

    public List<MySysPara> getIeTitle1();

    /**
     * @throws
     * @Title: updateMySysPara
     * @Description: 状态栏修改方法
     * @author(作者): 张丽军
     * @param: @param sysPara
     * @return: void
     */
    int updateSysPara(MySysPara sysPara);

    public void updateSysPara1(MySysPara sysPara);


    List<MySysPara> getTheSysParam(String paraName);

    MySysPara  querySysPara(@Param("paraName") String paraName);

    MySysPara getStatus();

    public List<MySysPara> selEduParam();

    /**
     * @Description: 查询公告通知设置信息(公告类型、审批设置、指定可审批公告人员)
     * @author:  刘新婷
     * @date:  2017-11-20
     * @return
     */
    public List<MySysPara> selectNotify();

    /**
     * @Description: 查询公告审批设置中审批公告时审批人是否可进行编辑（0：否， 1：是）
     * @author:  刘新婷
     * @date:  2017-11-22
     * @return
     */
    public String getEditFlag();

    /**
     * @Description: 查询公告审批设置中的审批设置
     * @author:  刘新婷
     * @date:  2017-11-22
     * @return
     */
    public String selectNotifySingleNew();

    /**
     * @Description: 查询指定可审批公告人员的USER_ID串
     * @author:  刘新婷
     * @date:  2017-11-21
     * @return
     * @return
     */
    public String getAutidingUsers();

    Integer insertSysPara(MySysPara sysPara);

    List<MySysPara> getSysParaList(List<String> item);

    List<MySysPara> getSysParaByParaNameLike(String paraName);

    //判断是否显示验证码-GXY
    MySysPara getSecGraphic();

    List<MySysPara> selectAll();

    //列表页修改
    List<MySysPara> listSysPara();

    int updateBatch(Map<String, Object> param);

    //在线预览网站添加
    Integer upPreview(MySysPara sysPara);

    //用于添加 查询出值在拼接
    MySysPara selectPreview();

    //修改是否预览网站
    Integer upPreviewOpen(MySysPara sysPara);

    //查询
    MySysPara selectPreviewOpen();

    //查询WEB
    MySysPara selectWebAddress();

    List<MySysPara> getVersion();

    List<MySysPara> getVersionIos();

    MySysPara getSelectPassword();

    MySysPara getSelectLoginSecureKey();

	MySysPara getEncryption();

    String getEncryptionKey();

    int setEncryptionKey(String key);

    int setEncryptionAes(int aes);

    int setBackupsEncryptionKEY(String backupsKEY);

    MySysPara selectSysPCAI(HttpServletRequest request);

    MySysPara selectSysPCAI2(HttpServletRequest request);

    MySysPara selectSysPCAI3(HttpServletRequest request);

    MySysPara selectByParaName(MySysPara sysPara);

    List<MySysPara> selectMyNotify(MySysPara sysPara);

    String selectMyNotifySingleNew(String mynotice_type_approval);
}