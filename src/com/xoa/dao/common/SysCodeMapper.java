package com.xoa.dao.common;

import com.xoa.model.common.SysCode;
import com.xoa.util.ToJson;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 *
 * 创建作者:   张丽军
 * 创建日期:   2017-4-19 下午4:10:16
 * 类介绍  :   公告类型接口
 * 构造参数:   无
 *
 */
public interface SysCodeMapper {
    /**
     *
     * 创建作者:  张丽军
     * 创建日期:   2017-4-19 下午6:35:53
     * 方法介绍:   get方法
     * 参数说明:   @return
     * @return    String
     */
    public List<SysCode> getSysCode(String parentNo);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月3日 下午5:03:15
     * 方法介绍:   获取所有系统代码设置表主分类
     * 参数说明:   @return
     * @return     List<SysCode> 返回所有系统代码设置表主分类
     */
    public List<SysCode> getAllSysCode();
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月4日 上午10:06:41
	 * 方法介绍:   更新系统代码设置表
	 * 参数说明:   @param sysCode 系统代码设置表
	 * @return     void 无
	 */
	public void update(SysCode sysCode);

    List<SysCode> getLogType(String parent_no);

    String getLogNameByNo(String codeNo);

    String  getNewsNameByNo(String newsType);

    String  getNotifyNameByNo(String notifyType);

    void delete(SysCode sysCode);

    void addSysMainCode(SysCode sysCode);

    List<SysCode> isSysCodeOrderExits(SysCode sysCode);

    List<SysCode> isChildCodeNoExits(SysCode sysCode);

    void addSysChildCode(SysCode sysCode);

    List<SysCode> isSysCodeNoExits(SysCode sysCode);

    List<SysCode>  iseditSysCodeNoExits(SysCode sysCode);

    List<SysCode> isChildCodeOrderExits(SysCode sysCode);

    SysCode getCodeByCodeNo(SysCode sysCode);

    String getCodeByCodeId(Integer sysCode);

    SysCode getCodeByCodeIds(Integer codeId);

    void deleteChild(SysCode sysCode);

    List<SysCode> getMainCode();

    List<SysCode> getChildCode(String CodeNo);

    List<SysCode> getAllCode();

    void deleteErrCode(Integer codeId);

    SysCode getSingleCode(@Param("parentNo") String parentNo,@Param("codeNo") String codeNo);

    SysCode getCodeNoByNameAndParentNo(SysCode sysCode);

    /**
     * @Description: 查询公告类型
     * @author:  刘新婷
     * @date:  2017-11-24
     * @return
     */
    List<SysCode> getNotifyType();

  //根据codeid查询codeName
    String getCodeName(Integer codeId);


    //根据codeName查询codeid
    Integer getCodeId(String codeName);

    /**
     * 查询事务提醒开关状态
     * @return
     */
    List<SysCode> getCodeRemind();

    /**
     * 查询事务提醒开关状态
     * @return
     */
    SysCode getSmsIsRemind(String codeNo);

    SysCode selectById(Integer codeId);

    String selectMaxNoCode(@Param("parentNo") String parentNo);

    int editServerVersion(@Param("versionMap")Map<String,String> versionMap);
    void deleteMinToMax(@Param("minId")Integer minId,@Param("maxId")Integer maxId);
    SysCode getByName(@Param("parentNo") String parentNo,@Param("codeName") String codeName);
    List<SysCode> selectBT();


    List<SysCode> getLeaderBox(Map<String,Object> map);

    SysCode selectCodeTypeName(String codeTyepNo);

    //根据代码主类型查询故障分类维修方式维修等级
    List<SysCode> selectAllCommonCode(String parentTyepNo);

    List<SysCode> selectByCommonCode(String parentTyepNo);

    List<SysCode> searchList(Map map);

    /*模糊查询*/
    List<SysCode> searchLike(String codeTypeName);

    List<SysCode> getSysCodeDesc(String codeNo);

    // 查询
    List<SysCode> getCodesByMap(Map<String,Object> map);

    //自定义公告查询类型
    List<SysCode> getMyNotifyType(String mynoticeType);

    List<SysCode> selectLike(String codeName);


    SysCode getcodeByCOdeIdSByParm(@Param("codeId") Integer codeId,@Param("parentNo") String parentNo);

    List<SysCode> getcodebyparentNo(String parentNo);

    String selectcodeName(String contentSecrecy);
}
