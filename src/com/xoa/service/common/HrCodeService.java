package com.xoa.service.common;

import com.xoa.model.common.HrCode;
import com.xoa.model.users.OrgManage;
import com.xoa.util.ToJson;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by 张丽军 on 2018/7/23.
 */
public interface HrCodeService {

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017-5-2 下午2:38:16
     * 方法介绍:   根据代码主分类查找信息
     * 参数说明:   @param parentNo
     * 参数说明:   @return
     *
     * @return List<SysCode>
     */
    public ToJson<HrCode> getSysCode(String parentNo);

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年5月3日 下午4:50:09
     * 方法介绍:   获取所有系统代码
     * 参数说明:   @return
     *
     * @return List<SysCode>
     */
    public List<HrCode> getAllSysCode();

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年5月4日 上午10:06:41
     * 方法介绍:   更新系统代码设置表
     * 参数说明:   @param sysCode 系统代码设置表
     *
     * @return void 无
     */
    public void update(HrCode hrCode);

    List<HrCode> getLogType();

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/5/31 16:49
     * @函数介绍: 根据日志的NO, 查询日志TYPENa
     * @参数说明: @param String
     * @return: String
     **/
    String getLogNameByNo(String codeNo);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 13:25
     * @函数介绍: 删除日志
     * @参数说明: @param SysCode sysCode
     * @return: void
     **/
    void deleteSysCode(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 13:41
     * @函数介绍: 增加代码主分类
     * @参数说明: @param SysCode
     * @return: void
     **/
    void addSysMainCode(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:16
     * @函数介绍: 判断系统代码排序是否存在
     * @参数说明: @param SysCOde
     * @return: Boolean
     **/
    Boolean isCodeOrderExits(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:31
     * @函数介绍: 判断系统代码CODE_NO是否存在
     * @参数说明: @param SysCode
     * @return: boolean
     **/
    Boolean isCodeNoExits(HrCode hrCode);
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/27 14:31
     * @函数介绍: 判断系统代码主代码更新时CODE_NO是否存在
     * @参数说明: @param SysCode
     * @return: boolean
     **/
    Boolean iseditCodeNoExits(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:31
     * @函数介绍: 判断系统代码更新时CODE_NO是否存在
     * @参数说明: @param SysCode
     * @参数说明: @param oldCodeNo 未修改时的oid
     * @return: boolean
     **/
    ToJson editisCodeNoExits(HrCode hrCode, String oldCodeNo);



    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/20 11:03
     * @函数介绍: 判断系统代码子代码CODE_NO是否存在
     * @参数说明: @param SysCode
     * @return: boolean
     **/
    Boolean ChildisCodeNoExits(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:41
     * @函数介绍: 增加子代码
     * @参数说明: @param SysCode
     * @return: void
     **/
    void addChildSysCode(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/3 14:45
     * @函数介绍: 查询子代码
     * @参数说明: @param SysCode
     * @return: List<SysCode></SysCode>
     **/
    List<HrCode> getChildSysCode(HrCode hrCode);
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/20 14:45
     * @函数介绍: 查询系统编码相同的对象
     * @参数说明: @param SysCode
     * @return: List<SysCode></SysCode>
     **/
    HrCode getCodeByCodeNo(HrCode hrCode);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/6/30 20:02
     * @函数介绍: 查询错误代码列表
     * @参数说明: @param SysCode
     * @return: List<SysCode></SysCode>
     **/
    ToJson<List<HrCode>>getErrSysCode();
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/04 11:09
     * @函数介绍: 系统代码恢复
     * @参数说明: @param path sql文件的路径
     * @return: ToJson
     **/
    ToJson<Object> recoverCode(HttpServletRequest request, String path);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/04 12:09
     * @函数介绍: 系统代码备份
     * @参数说明: @param request  response
     * @return: ToJson
     **/
    void exportCode(HttpServletRequest request, HttpServletResponse response);
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/11 20:26
     * @函数介绍: 根据codeId查询错误代码信息
     * @参数说明: CodeId
     * @return: Tojson
     * */
    public ToJson<HrCode> getErrInfo(String CodeId);
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/12 10:37
     * @函数介绍: 根据codeId删除错误代码
     * @参数说明: CodeId
     * @return: Tojson
     * */
    public ToJson<HrCode> deleteErrCode(String CodeId);
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/12 13:08
     * @函数介绍: 获取所有正确代码
     * @参数说明:
     * @return: Tojson
     * */
    public ToJson<List<HrCode>> getAllCode();
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 18:16
     * @函数介绍: 获取下拉框
     * @参数说明: CodeId  父类的唯一标识id
     * @return: Tojson
     */
    public JSONObject DropDownBoxs(String CodeId[]);

    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 数据库升级接口
     * @参数说明:
     * @return:
     */
    public ToJson<Object> updateDabase();

    public ToJson<Object> editDabase(HttpServletRequest request,HttpServletResponse response);

    public ToJson<Object> getObjects();

    public ToJson<Object> getObjectdetail();

    List <OrgManage> queryId();
    /**
     * @创建作者: 张丽军
     * @创建日期: 2017/7/19 19:16
     * @函数介绍: 检测版本号大小
     * @参数说明:
     * @return:
     */
    public boolean isAppNewVersion(String localVersion, String onlineVersion);

    public ToJson<Object> updateResource();

    public void downLog(HttpServletResponse response,HttpServletRequest request);
}
