package com.xoa.dao.users;

import com.xoa.model.users.RoleManager;
import com.xoa.model.users.UserPriv;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:38:35
 * 类介绍  :    角色权限表
 * 构造参数:   无
 */
public interface UserPrivMapper {

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:38:41
     * 方法介绍:   根据userpriv删除角色
     * 参数说明:   @param userPriv 角色编号
     *
     * @return void  无
     */
    void deleteByPrimaryKey(Integer userPriv);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:38:47
     * 方法介绍:   新增userpriv
     * 参数说明:   @param record 角色信息
     * 参数说明:   @return
     *
     * @return int 插入条数
     */
    int insert(UserPriv record);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:38:53
     * 方法介绍:   新增角色
     * 参数说明:   @param record 角色信息
     *
     * @return void  无
     */
    int insertSelective(UserPriv record);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:38:59
     * 方法介绍:   根据userpriv查询userpriv
     * 参数说明:   @param userPriv  角色
     * 参数说明:   @return
     *
     * @return UserPriv  角色
     */
    UserPriv selectByPrimaryKey(int userPriv);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:39:05
     * 方法介绍:   更新
     * 参数说明:   @param record 角色信息
     * 参数说明:   @return
     *
     * @return int
     */
    int updateByPrimaryKeySelective(UserPriv record);


   /* int updateUserByPriv(UserPriv record);*/

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:39:11
     * 方法介绍:   更新
     * 参数说明:   @param record  角色信息
     * 参数说明:   @return
     *
     * @return int  插入记录
     */
    int updateByPrimaryKey(UserPriv record);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:39:17
     * 方法介绍:   根据userpriv获取privname
     * 参数说明:   @param userPriv  角色
     * 参数说明:   @return
     *
     * @return String 角色名称
     */
    String getPrivNameById(Integer userPriv);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:39:24
     * 方法介绍:   获取所有userpriv
     * 参数说明:   @param maps 集合
     * 参数说明:   @return
     *
     * @return List<UserPriv>  返回角色集合
     */
    List<UserPriv> getAlluserPriv(Map<String, Object> maps);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:39:31
     * 方法介绍:   多条件获取userpriv
     * 参数说明:   @param userPriv  角色信息
     * 参数说明:   @return
     *
     * @return List<UserPriv>  返回角色信息
     */
    List<UserPriv> getPrivByMany(UserPriv userPriv);


    List<UserPriv> getUserPrivNameByFuncId(String fid);


    String getUserPrivfuncIdStr(String id);


    void updateUserPrivFuncIdStr(Map<String, Object> hashMap);

    /**
     * 创建作者:   张勇
     * 创建日期:   2016年6月3日 下午4:02:05
     * 方法介绍:   根据privid串获取privName
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<String>  返回部门串
     */
    public String getPrivNameByPrivId(Integer userPriv);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午15:12:05
     * 方法介绍:   查询超级密码是否正确
     * 参数说明:   @param password
     * 参数说明:   @return 返回匹配条数
     */
    public int checkSuperPass(String password);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午15:12:05
     * 方法介绍:   获取当前的超级密码
     * 参数说明:   @param password
     * 参数说明:   @return 返回匹配条数
     */
    public String getSuperPass();

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午16:00:05
     * 方法介绍:   修改超级密码
     * 参数说明:   @param password
     * 参数说明:   @return void
     */
    public void updateSuperPass(String newPwd);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午15:03:05
     * 方法介绍:   根据角色名称删除权限
     * 参数说明:   @param privName 角色名称
     * 参数说明:   @return void
     */
    public void delPriByName(String privName);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午13:38:05
     * 方法介绍:   给用户修改辅助角色
     */
    void updateFunByUserId(Map<String, Object> hashMap);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午13:51:05
     * 方法介绍:   根据用户的id获取辅助角色
     */
    String getUserFunByUserId(String id);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:29:00
     * 方法介绍:   添加人力资源管理角色规则
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return int 插入条数
     */
    int insertRoleManager(RoleManager roleManager);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:50:00
     * 方法介绍:  根据id进行修改人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return int 进行修改的条数
     */
    int updateRoleManager(RoleManager roleManager);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:55:00
     * 方法介绍:  根据id进行删除人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return int 进行删除的条数
     */
    int deleteRoleManagerById(int roleManagerId);


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:14:00
     * 方法介绍:  根据id进行查询人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return RoleManager 查询出来的结果
     */
    RoleManager getRoleManagerById(int roleManagerId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:14:00
     * 方法介绍:  查询出所有的人力资源角色管理信息
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return RoleManager 查询出来的结果
     */
    List<RoleManager> getAllRoleManager();

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午12:14:00
     * 方法介绍:  根据部门id查部门名称
     * 参数说明:   @param deptId 部门id
     * 参数说明:   @return
     *
     * @return String 部门名称
     */
    String getDeptNameById(int deptId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:  获取主角色主登录数
     * 参数说明:   @param userPriv 角色id
     * 参数说明:   @return
     *
     * @return int
     */
    int getRoleLoginCount(int userPriv);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:  获取角色禁止登录用户数
     * 参数说明:   @param userPriv 角色id
     * 参数说明:   @return
     *
     * @return int
     */
    int getRoleNoLoginCount(int userPriv);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:  获取辅助角色用户数
     * 参数说明:   @param userPriv 角色id
     * 参数说明:   @return
     *
     * @return int
     */
    int getUserRoleCount(int userPriv);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   通过权限id获取权限名称
     * 参数说明:   @param funcId 权限id
     * 参数说明:   @return
     *
     * @return int
     */
    String getFunNameByFunId(String funcId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   通过权限name获取权限id
     * 参数说明:   @param funcName 权限name
     * 参数说明:   @return
     *
     * @return int
     */
    List<String> getFunIdByFunName(String funcName);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午13:30:00
     * 方法介绍:   根据userId查userName
     * 参数说明:   @param funcName 权限name
     * 参数说明:   @return
     *
     * @return int
     */
    String getUserNameByUserId(String userId);

    UserPriv getUserPriv(Integer userPriv);

    /**
     * 根据privName获取
     * @param privName
     * @return
     */
    UserPriv getUserPrivByName(@Param("privName")String privName);
    
    
    public List<String> getUserPNames(Map<String,Object> map);

    public List<UserPriv> getPrivBySearch(Map<String,Object> map);



    UserPriv getUserPrivByUserId(String userId);

    public List<UserPriv> getUserPrivAllByUserId(String userId);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据ids获取角色信息
     */
    List<UserPriv> getUserPrivByIds(@Param("ids")String[] ids);

    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据名称获取信息
     */
    List<UserPriv> getUserPrivsByName(@Param("privName")String privName);


    List<String> getPNameByPriv(String privId);

    List<String> getPrivNameByIds(Map<String,Object> map);

    UserPriv getPrivName(int userPriv);

    UserPriv getPrivName11(Integer integer);

    String getPrivNameByPrivNo(Integer privNo);

    List<UserPriv> getPrivNameByDeptIds(Map<String, Object> maps);

    /**
     * @接口说明: 获取排序号最小的角色
     * @日期: 2020/3/19
     * @作者: 张航宁
     */
    UserPriv getMinNoUserPriv();

    //根据角色名称模糊查询
    List<UserPriv> getUserPrivsByPrivName(String privName);
    @MapKey("FUNC_ID")
    Map<String, HashMap<String,String>> getFunIdAndFunName();

    List<UserPriv>  selectUserPrivByTypeId(@Param("privTypeId")Integer privTypeId);

    List<UserPriv>  selectUserPrivByMaps(Map<String, Object> maps);

    List<UserPriv> queryUserPrivByPrivName(Map<String, Object> map);

    UserPriv findUserPrivAndTypeFuncIdStr(int userPriv);

    List<UserPriv> selectUserPrivByTypeIds(@Param("privTypeIds") Set<Integer> privTypeIds);
}