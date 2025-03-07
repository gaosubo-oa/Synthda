package com.xoa.service.users;

import com.xoa.model.users.RoleManager;
import com.xoa.model.users.UserPriv;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:30:48
 * 类介绍  :    角色权限service层接口
 * 构造参数:   无
 */
public interface UsersPrivService {

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:31:24
     * 方法介绍:   根据角色编号数组获取角色
     * 参数说明:   @param privId
     * 参数说明:   @return
     *
     * @return String
     */
    public String getPrivNameById(int... privId);

    //根据角色id串获取角色名称
    public String getPrivNameById(String privId);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:31:32
     * 方法介绍:    根据主键获取角色
     * 参数说明:   @param up
     * 参数说明:   @return
     *
     * @return UserPriv
     */
    public UserPriv selectByPrimaryKey(int up);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:31:39
     * 方法介绍:   根据主键删除角色
     * 参数说明:   @param userPriv
     *
     * @return void
     */
    public void deleteByPrimaryKey(int userPriv);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:31:45
     * 方法介绍:    角色插入
     * 参数说明:   @param record
     *
     * @return void
     */
    public int insertSelective(UserPriv record);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:31:53
     * 方法介绍:   获取所有角色
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag   是否开启分页
     * 参数说明:   @return
     *
     * @return List<UserPriv>  返回所有角色
     */
    public List<UserPriv> getAllPriv(Map<String, Object> maps, Integer page,
                                     Integer pageSize, boolean useFlag);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:32:00
     * 方法介绍:   多条件查询角色
     * 参数说明:   @param priv  角色信息
     * 参数说明:   @return
     *
     * @return List<UserPriv>  所有角色信息
     */
    public List<UserPriv> getPrivByMany(UserPriv priv);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 10:45
     * @函数介绍: 查询所有用户Priv
     * @return: List<UserPriv></UserPriv>
     **/
    List<UserPriv> getAllUserPriv();

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 13:54
     * @函数介绍: 根据funcIdStr查询角色名称
     * @参数说明: @param fid, 某个功能的id,对应sys_function表中的FUNC_ID
     * @return: List<UserPriv></UserPriv>
     **/
    List<UserPriv> getUserPrivNameByFuncId(String fid);


    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/1 19:43
    *@函数介绍:  修改角色权限（serPriv 的funcIdStr）
    *@参数说明:  String privids
    *@参数说明:  String funcId
    *@return:   void
    **/
    void updateUserPrivfuncIdStr(String privids, String funcId);

    /**
     *@创建作者:  韩成冰
     *@创建日期:  2017/6/1 19:43
     *@函数介绍:  修改角色权限（serPriv 的funcIdStr）
     *@参数说明:  String privids
     *@参数说明:  String funcId
     *@return:   void
     **/
    void deleteUserPriv(String privids, String funcIds);

    /**
     * 创建作者:   张勇
     * 创建日期:   2016年6月3日 下午4:02:05
     * 方法介绍:   格局privid串获取privName
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<String>  返回部门串
     */
    public String getPrivNameByPrivId(String privId,String flag);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午11：39：00
     * 方法介绍:   根据privid修改角色信息
     * 参数说明    @param record
     * @return void
     */
    public int updateUserPriv(UserPriv record);
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午13：41：00
     * 方法介绍:   克隆操作
     * 参数说明    @param record
     * @return void
     */
    public void copyUserPriv(UserPriv record);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午15:15:05
     * 方法介绍:   查询超级密码是否正确
     * 参数说明:   @param password
     * 参数说明:   @return 返回匹配条数
     */
    public int checkSuperPass(String password);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午16:03:05
     * 方法介绍:   修改超级密码
     * 参数说明:   @param password
     * 参数说明:   @return void
     */
    public void updateSuperPass(String newPwd);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/7 10:47
     * @函数介绍: 加密一个字符串，MD5加密，EncryptSalt类产生一个字符串作为加盐加密
     * 注意业务需要，空字符串要得到固定的加密结果（tVHbkPWW57Hw.）
     * @参数说明: @param String 要加密的字符串
     * @return: String 加密过后的字符串
     */
    public String getEncryptString(String password);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午17:30:05
     * 方法介绍:   根据角色名称删除权限
     * 参数说明:   @param privName 角色名称
     * 参数说明:   @return void
     */
    public void delPriByName(String privName);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午19:16:05
     * 方法介绍:   根据id修改排序号
     * 参数说明:   @param userPriv
     * 参数说明:   @return void
     */
    public ToJson<UserPriv> updNoByPrivId(UserPriv userPriv);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午13:38:05
     * 方法介绍:   给用户添加辅助角色
     */
    ToJson addUserFunByUID(String userId, String funcIds);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午14:09:10
     * 方法介绍:   给用户删除辅助角色
     */
    public void deleteUserFunByUID(String userId, String funcIds);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:29:00
     * 方法介绍:   添加人力资源管理角色规则
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     int 插入条数
     */
   public int insertRoleManager(RoleManager roleManager);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:50:00
     * 方法介绍:  根据id进行修改人力资源角色
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     int 进行修改的条数
     */
   public int updateRoleManager(RoleManager roleManager);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:55:00
     * 方法介绍:  根据id进行删除人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     int 进行删除的条数
     */
   public int deleteRoleManagerById(int roleManagerId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:15:00
     * 方法介绍:  根据id进行查询人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     RoleManager 查询出来的结果
     */
    public RoleManager getRoleManagerById(int roleManagerId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:14:00
     * 方法介绍:  查询出所有的人力资源角色管理信息
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     * @return     RoleManager 查询出来的结果
     */
    public List<RoleManager> getAllRoleManager();

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   通过权限id获取权限名称
     * 参数说明:   @param funcId 权限id
     * 参数说明:   @return
     * @return     int
     */
   public String getFunNameByFunId(String funcId);
   public Map<String, HashMap<String,String>> getFunIdAndFunName();
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   通过权限name获取权限id
     * 参数说明:   @param funcName 权限name
     * 参数说明:   @return
     * @return     int
     */
    public List<String> getFunIdByFunName(String funcName);
    /**
     *@创建作者:  韩成冰
     *@创建日期:  2017/6/22 13:02
     *@函数介绍:  查询UserPriv
     *@参数说明:  @param userPriv
     *@return:   XXType(value introduce)
     **/
    UserPriv getUserPriv(Integer userPriv);

    public List<UserPriv> getPrivBySearch(Map<String, Object> maps);

    /**
     * 根据角色设置权限
     */
    public void getFuncByuserPrivOther(String userPriv,String userId);


    ToJson<UserPriv> getUserPrivName(HttpServletRequest request, int userPriv);

    public Map getUsersByUserPriv( String userPriv);

    //根据角色名称模糊查询
    public ToJson selectUserPrivsByPrivName(String privName);

    ToJson<UserPriv> selectIsZhongGaoGuan(HttpServletRequest request);

    ToJson selectHavePriv();

    ToJson selectHaveDept(HttpServletRequest request);

    ToJson selectPriv(String userId);

    UserPriv findUserPrivAndTypeFuncIdStr(int userPriv);
}
