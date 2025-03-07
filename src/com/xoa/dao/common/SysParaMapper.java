package com.xoa.dao.common;

import com.xoa.model.common.SysPara;
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
public interface SysParaMapper {

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
    List<SysPara> getIeTitle();
    /**
     * 创建人：马东辉
     * 创建时间：2022/3/31
     * 方法介绍： 查询附件索引开关
     * 参数说明：  List<SysPara>
     */
    List<SysPara> selectAttach();
    /**
     * 创建人：马东辉
     * 创建时间：2022/3/31
     * 方法介绍： 修改附件索引开关
     * 参数说明：
     */
    Integer  updateAttach(Map<String,Object> map);

    SysPara  selectget111();

    public List<SysPara> getIeTitle1();

    /**
     * @throws
     * @Title: updateSysPara
     * @Description: 状态栏修改方法
     * @author(作者): 张丽军
     * @param: @param sysPara
     * @return: void
     */
    int updateSysPara(SysPara sysPara);

    public void updateSysPara1(SysPara sysPara);


    List<SysPara> getTheSysParam(String paraName);

    SysPara  querySysPara(@Param("paraName") String paraName);

    SysPara getStatus();

    public List<SysPara> selEduParam();

    /**
     * @Description: 查询公告通知设置信息(公告类型、审批设置、指定可审批公告人员)
     * @author:  刘新婷
     * @date:  2017-11-20
     * @return
     */
    public List<SysPara> selectNotify();

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

    Integer insertSysPara(SysPara sysPara);

    List<SysPara> getSysParaList(List<String> item);

    List<SysPara> getSysParaByParaNameLike(String paraName);

    //判断是否显示验证码-GXY
    SysPara getSecGraphic();

    List<SysPara> selectAll();

    //列表页修改
    List<SysPara> listSysPara();

    int updateBatch(Map<String,Object> param);

    //在线预览网站添加
    Integer upPreview(SysPara sysPara);

    //用于添加 查询出值在拼接
    SysPara selectPreview();

    //修改是否预览网站
    Integer upPreviewOpen(SysPara sysPara);

    //查询
    SysPara selectPreviewOpen();

    //查询WEB
    SysPara selectWebAddress();

    //查询NTKO授权信息
    SysPara selectNtkoLicense();

    List<SysPara> getVersion();

    List<SysPara> getVersionIos();

    SysPara getSelectPassword();

    SysPara getSelectLoginSecureKey();

	SysPara getEncryption();

    String getEncryptionKey();

    int setEncryptionKey(String key);

    int setEncryptionAes(int aes);

    int setBackupsEncryptionKEY(String backupsKEY);

    SysPara selectSysPCAI(HttpServletRequest request);

    SysPara selectSysPCAI2(HttpServletRequest request);

    SysPara selectSysPCAI3(HttpServletRequest request);

    //获取自定义告示栏内容
    SysPara getSysParaPortal(String paraName);

    //更新自定义告示栏
    Integer setSysParaProtal(SysPara sysPara);

    int updateByParaName(SysPara sysPara);
    SysPara selectByParaNames(String paraName);

    /**
     * 根据paraName和paraValue模糊查询系统参数
     */
    SysPara selectByParas(SysPara sysPara);

    SysPara selectSysPara(@Param("xoa") String xoa, @Param("paraName") String paraName);

    List<SysPara> querySecrecySysPara();
}