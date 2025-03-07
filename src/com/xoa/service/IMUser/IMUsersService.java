package com.xoa.service.IMUser;

import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:29:57
 * 类介绍  :    用户service层接口
 * 构造参数:   
 *
 */
public interface IMUsersService {
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午4:25:08
	 * 方法介绍:   添加用户
	 * 参数说明:   @param user
	 * @return     void
	 */
	public ToJson<Users> addUser(Users user, UserExt userExt, ModulePriv modulePriv, HttpServletRequest request);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午5:25:14
	 * 方法介绍:   修改用户
	 * 参数说明:   @param user
	 * @return     ToJson<Users>
	 */
	public ToJson<Users> editUser(HttpServletRequest request, Users user, UserExt userExt, ModulePriv modulePriv);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月22日 下午1:28:01
	 * 方法介绍:   修改
	 * 参数说明:   @param uid 主键
	 * 参数说明:   @param userName 用户名
	 * 参数说明:   @param sex 性别
	 * 参数说明:   @param birthday 生日
	 * 参数说明:   @param email 邮箱
	 * 参数说明:   @param oicqNo qq号
	 * 参数说明:   @param mobilNo 电话号码
	 * 参数说明:   @param telNoDept 工作号码
	 * 参数说明:   @param avatar 头像
	 * @return     void 无
	 */
	public ToJson<Users> edit(Integer uid, String userName, String sex, Date birthday, String email, String oicqNo, String mobilNo, String telNoDept, String avatar);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午5:25:20
	 * 方法介绍:   删除用户
	 * 参数说明:   @param uid
	 * @return     void
	 */
	public void deleteUser(String uids, HttpServletRequest request);

	 /**
	  * 创建作者:   张龙飞
	  * 创建日期:   2017年4月21日 上午10:27:07
	  * 方法介绍:   根据输入条件进行查询
	  * 参数说明:   @param maps 集合
	  * 参数说明:   @param page 当前页面
	  * 参数说明:   @param pageSize  页面大小
	  * 参数说明:   @param useFlag  是否开启分页
	  * 参数说明:   @return
	  * @return     List<Users>   返回用户信息
	  */
	public List<Users> getAlluser(Map<String, Object> maps, Integer page,
                                  Integer pageSize, boolean useFlag);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午5:29:25
	 * 方法介绍:   多条件查询用户
	 * 参数说明:   @param user 用户信息
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getUserByMany(Users user);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午5:17:43
	 * 方法介绍:   获取用户信息和部门信息
	 * 参数说明:   @param maps  集合
	 * 参数说明:   @param page  当前页面
	 * 参数说明:   @param pageSize  页面大小
	 * 参数说明:   @param useFlag  是否开启分页
	 * 参数说明:   @return
	 * @return     List<Users>   返回用户信息
 	 */
	public List<Users> getUserAndDept(Map<String, Object> maps, Integer page,
                                      Integer pageSize, boolean useFlag);

	public List<Users> getUserAndDeptBai(Map<String, Object> maps, Integer page,
                                         Integer pageSize, boolean useFlag, Users users);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午5:00:12
	 * 方法介绍:   格局uid查询用户
	 * 参数说明:   @param uid 用户uid
	 * 参数说明:   @return
	 * @return     Users  返回用户信息
	 */
	public Users findUserByuid(int uid);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午5:18:08
	 * 方法介绍:   根据别名查找用户
	 * 参数说明:   @param byname  别名
	 * 参数说明:   @return
	 * @return     Users  返回用户信息
	 */
//	@DynDatasource
    public Users findUserByName(String byname, HttpServletRequest req);
	/**
	 * 创建作者：季佳伟
	 * 方法介绍：根据别名查询用户所有信息
	 * @param
	 * @param
	 * @return
	 */
	public Users selectUserAllInfoByName(String byname, HttpServletRequest req, String loginId, String userPassword, Integer h5Login);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 下午6:40:15
	 * 方法介绍:   根据查询条件查找用户0
	 * 参数说明:   @param maps  集合
	 * 参数说明:   @param page  当前页面
	 * 参数说明:   @param pageSize  页面大小
	 * 参数说明:   @param useFlag  是否开启分页
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getBySearch(Map<String, Object> maps);

	public List<Users> getBySearchBai(Map<String, Object> maps);

	public List<Users> getBySearchBaiOrg(Map<String, Object> maps);

	public ToJson<UserPriv> getUserByUserPrivBaiOrg(HttpServletRequest request, String userPriv,String deptNo);


	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月21日 上午11:00:05
	 * 方法介绍:   根据部门id查询用户信息
	 * 参数说明:   @param maps  集合
	 * 参数说明:   @param page  当前页面
	 * 参数说明:   @param pageSize  页面大小
	 * 参数说明:   @param useFlag  是否开启分页
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getByDeptId(Map<String, Object> maps, Integer page,
                                   Integer pageSize, boolean useFlag);


	/**
	 * 根据部门Id查询部门下所有人员
	 * 王禹萌
	 * 2018-07-25 11：10
	 * @param maps
	 * @param page
	 * @param pageSize
	 * @param useFlag
	 * @return
	 */
	public List<Users> getAllByDeptId(Map<String, Object> maps, Integer page,
                                      Integer pageSize, boolean useFlag);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月25日 上午10:06:33
	 * 方法介绍:   根据uid查询用户姓名、部门、角色信息
	 * 参数说明:   @param uid 用户uid
	 * 参数说明:   @return
	 * @return     Users 返回用户信息
	 */
	public Users getByUid(int uid);
		/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月25日 上午10:06:33
	 * 方法介绍:   根据uid串查询用户姓名、部门、角色信息
	 * 参数说明:   @param uid 用户uid
	 * 参数说明:   @return
	 * @return     Users 返回用户信息
	 */
	public List<Users> getAllByUid(String uids);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月21日 上午11:00:05
	 * 方法介绍:   根据userid串获取用户姓名
	 * 参数说明:   @param userIds 用户userid串
	 * 参数说明:   @return
	 * @return     List<String>  返回用户姓名集合
	 */
	public String getUserNameById(String userIds);

	public String getUserPrivById(String userIds);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月21日 上午11:00:05
	 * 方法介绍:   根据userid串获取用户姓名
	 * 参数说明:   @param userIds 用户userid串
	 * 参数说明:   @return
	 * @return     List<String>  返回用户姓名集合
	 */
	public String getUserNameById(String userIds, String flag);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月3日 下午12:48:12
	 * 方法介绍:   根据uid串获取用户姓名
	 * 参数说明:   @param uid 用户uid串
	 * 参数说明:   @return
	 * @return     String 用户姓名串
	 */
	public String findUsersByuid(int... uid);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月3日 下午12:48:12
	 * 方法介绍:   根据uid串获取用户姓名
	 * 参数说明:   @param uid 用户uid串
	 * 参数说明:   @return
	 * @return     String 用户姓名串
	 */
	public String findUsersByuid(String uids);


	public String findUsersByuidReturn(String uids);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月3日 下午12:48:12
	 * 方法介绍:   根据userId获取用户
	 * 参数说明:   @param userId 用户userId
	 * 参数说明:   @return
	 * @return     Users  用户信息
	 */
	public Users findUsersByuserId(String userId);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/5/30 9:40
    *@函数介绍:   根据User的角色或部门id, 查询用户，其他条件可在serverce层扩展 【已修改，现在查询结果不包括禁止登录用户】
    *@参数说明:  @param Users
    *@return:   List<Users></Users>
    **/
    List<Users> getUsersByCondition(Users users);

    /**
     * 作者: 张航宁
     * 日期: 2018/7/27
     * 说明: 根据User的角色或部门id, 查询用户 用于用户管理模块树结构遍历 查询所有用户
     */
	List<Users> getUserByConditionExt(Integer deptId, Integer userPriv);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/5/30 11:10
    *@函数介绍:  查询在线用户
    *@参数说明:  @param paramname paramintroduce
    *@return:   List<User></User>
    **/
    List<Users> getUsersOnline();

    List<Users>  getUserbyCondition(Map<String, Object> maps);
    /**
     *@创建作者:  韩成冰
     *@创建日期:  2017/6/6 21:15
     *@函数介绍:  验证密码是否正确
     *@参数说明:  @param userName 用户名
     *@参数说明:  @param password 密码
     *@return:   Boolean 密码是否正确
     **/
    Boolean checkPassWord(String userName, String password);


    Boolean checkPassWordUser(String userName, String password, String userPassword);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/7 10:47
    *@函数介绍:  加密一个字符串，MD5加密，EncryptSalt类产生一个字符串作为加盐加密。
    *@参数说明:  @param String 要加密的字符串
    *@return:   String 加密过后的字符串
    **/
    String getEncryptString(String pwssword);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月15日
	 * 方法介绍:   根据deptId获取该部门下的所有用户信息
	 * 参数说明:   @param deptId
	 * 参数说明:   @return  List<Users>
	 */
	List<Users> getUsersByDeptId(Integer deptId);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午5:20:05
	 * 方法介绍:   根据传入参数串获取用户信息
	 * 参数说明:   @param conditions 参数
	 * 参数说明:   @return
	 * @return List<SUsers>  返回用户信息
	 */
	public List<Users> getUserByDeptIds(String conditions, Integer flag);

	public List<Users> getUserByuserId(String userIds);

	public List<Users> getUserByuserIdBai(Map map);

		/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月19日
	 * 方法介绍:   查询空密码用户
	 * 参数说明:   @return  List<Users>
	 */
	List<Users> getNullPwUsers(Integer deptId);


	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   根据deptId获取该部门下级部门下的所有用户信息
	 * 参数说明:   @param deptId
	 * 参数说明:   @return  List<Users>
	 */
	public List<Users> getCUsersByDeptId(Integer deptId);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   根据deptId获取该部门同级部门下的所有用户信息
	 * 参数说明:   @param deptId
	 * 参数说明:   @return  List<Users>
	 */
	public List<Users> getTUsersByDeptId(Integer deptId);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   根据deptId获取该部门上级部门下的所有用户信息
	 * 参数说明:   @param deptId
	 * 参数说明:   @return  List<Users>
	 */
	public List<Users> getPUsersByDeptId(Integer deptId);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   清空密码
	 * 参数说明:   @param uid
	 */
	void clearPassword(String uids);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   清空在线时间
	 * 参数说明:   @param uid
	 */
	void clearOnLine(String uids);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   设置禁止登陆
	 * 参数说明:   @param uid
	 */
	void setNotLogin(String uids);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   批量修改部门
	 * 参数说明:   @param uids
	 */
	void editUsersDetId(Integer deptId, String uids);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年6月20日
	 * 方法介绍:   根据id数组获取用户信息
	 * 参数说明:   @param uids
	 * 参数说明:   @param List<Users>
	 */
	List<Users> getUsersByUids(String uids);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午5:20:05
	 * 方法介绍:   根据uid串获取用户信息
	 * 参数说明:   @param uids  用户uid串
	 * 参数说明:   @return
	 * @return List<SUsers>  返回用户信息
	 */
	public List<Users> getUserByuId(String uIds);
    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/22 13:30
     * @函数介绍: 根据用户ID查询
     * @参数说明: @param String uid
     * @return: String
     **/
    String getUserPrivByuId(Integer s);

	/**
	 * @创建作者: 张龙飞
	 * @创建日期: 2017/6/22 17:30
	 * @函数介绍: 根据用户部门排序号获取该部门下是否有用户
	 * @参数说明: @param String deptNO
	 * @return: List<Users>
	 */
	List<Users> deptHaveUser(String deptNO);
	/**
	 * 创建作者:   张丽军
	 * 创建日期:   2017年6月21日 下午5:20:05
	 * 方法介绍:   添加方法
	 * 参数说明:   @param
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	public void addU(Users users);
	/**
	 * 创建作者:   张丽军
	 * 创建日期:   2017年6月21日 下午5:20:05
	 * 方法介绍:   查询方法
	 * 参数说明:   @param
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	public List<Users> selectList(Users users);


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午10:32:22
	 * 方法介绍:   根据userId进行模糊查询
	 * 参数说明:   @param userId
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	public ToJson<Users> queryUserByUserId(String userName);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午10:35:22
	 * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
	 * 参数说明:   @param  userId
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	public int queryCountByUserId(String userName);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/28 14:23
    *@函数介绍:  查询用户数
    *@参数说明:  无
    *@return:   int
    **/
    int getUserCount();

	int getUserCountBySql(String databaseName);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/28 18:04
    *@函数介绍:  修改密码
    *@参数说明:  @param request
    *@参数说明:  @param Users
    *@return:   XXType(value introduce)
    **/
    String editPwd(HttpServletRequest request, Users user, String newPwd);

    Users getLoginUser(HttpServletRequest request);



    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/29 18:17
    *@函数介绍:  用户人数是否超过授权
    *@参数说明:  无
    *@return:   boolean
    **/

    public boolean isUserToMany(HttpServletRequest request);

	/**
	 *@创建作者:  张航宁
	 *@创建日期:  2017/6/30
	 *@函数介绍:  查询新增加的用户
	 *@参数说明:  无
	 **/
    ToJson<Users> getNewUsers();

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/7/1 9:34
    *@函数介绍:  获取可以void
    *@return:   int
    **/
    int getCanLoginUser();

	/**
	 * 通过uid获取用户信息
	 * @param uid
	 * @return
	 */
	Users getUserByUid(int uid);

	/**
	 *@创建作者:  韩成冰
	 *@创建日期:  2017/7/3 11:11
	 *@函数介绍:  修改用户界面主题
	 *@参数说明:  @param Users
	 *@参数说明:  @param request
	 *@return:   void
	 **/
	void updateUserTheme(Users users, HttpServletRequest request);

	/**
	 *@创建作者:  韩成冰
	 *@创建日期:  2017/7/3 14:38
	 *@函数介绍:  获取登录用户
	 *@参数说明:  @param request
	 *@return:   User
	 **/
	Users getLoginUserTheme(HttpServletRequest request);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年7月3日
	 * 方法介绍:   查询和导出接口
	 * 参数说明:   @param  user,sortType,isExport
	 * 参数说明:
	 * @return ToJson 返回用户信息
	 */
	ToJson<Users> queryExportUsers(HttpServletRequest request, HttpServletResponse response, Users user, String sortType, String isExport, String notLogin, Integer page, Integer pageSize, Boolean useFlag,String deptNo);

	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年7月3日
	 * 方法介绍:   插入和导入接口
	 * 参数说明:   @param  file
	 * 参数说明:
	 * @return ToJson 返回用户信息
	 */
	ToJson<Users> insertImportUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String psWord, String userPriv);


	/**
	 * 创建作者:   zlf
	 * 创建日期:   2017年7月3日
	 * 方法介绍:   插入和导入接口（由航宁接口修改）
	 * 参数说明:   @param  file
	 * 参数说明:
	 * @return ToJson 返回用户信息
	 */
	AjaxJson insertImportUsersByEdu(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String pw, String userPriv, String rule);


	/**
	 * 创建作者:   张航宁
	 * 创建日期:   2017年月4日
	 * 方法介绍:   批量修改用户
	 * 参数说明:   @param user  用户信息
	 * 参数说明:   @return
	 * @return ToJson<Users>  返回显示信息
	 */
	ToJson<Users> editUserBatch(Users user, UserExt userExt, String modulePrivIds, String PrivIds, String deptIds, String userIds, HttpServletRequest request);
	 /**
	 * 创建作者:   高亚峰
	 * 创建日期:   2017年7月5日
	 * 方法介绍:   根据用户userID查询用户
	 * 参数说明:   @param userId
	 * 参数说明:   @return
	 * @return ToJson<Users>
	 */
	 Users getUsersByuserId(String userId);

	/**
	 * 创建作者:   杨 胜
	 * 创建日期:   2017-7-11 下午2:30:01
	 * 方法介绍:
	 * 参数说明:   @return
	 * @return     List<Users>
	 */
	public List<Users> selectFileUserSignerAll();

	/**
	 * 创建作者:   杨 胜
	 * 创建日期:   2017-7-11 下午2:30:07
	 * 方法介绍:
	 * 参数说明:   @param mapUser
	 * 参数说明:   @return
	 * @return     List<Users>
	 */
	public List<Users> selectFileUserSigner(Map<String, Object> mapUser);

	/**
	 * 作者：张航宁
	 * 日期：2017-07-17
	 * @param searchData
	 * @return
	 */
	public ToJson<Users> singleSearch(String searchData);


	public Users getUserByUserName(String userName);



	public void deleteUserByDeptId(String deptId);

	/**
	 * 作者: 杨超
	 * 日期：2017-08-12
	 * @param type
	 * @return
	 */
	public ToJson<Object> userAnalysis(String type);

	/**
	 * 创建作者：牛江丽
	 * 方法介绍：修改扩展信息，包括昵称、用户名片图片、讨论区签名档
	 * @param request
	 * @param users
	 * @return
	 */
	public ToJson<Users> editUserExt(HttpServletRequest request, MultipartFile imageFile, Users users, UserExt userExt)throws IllegalStateException, IOException;

	ToJson editUserSign(HttpServletRequest request, String sign);

	public  void insetErrLog(String userName);

	public List<Users> reAllPrivUser(String privUser, String privDept, String privRole);

	//返回所有用户的名字
	public String reAllName(List<Users> list);

	public void updateLoginTime(Users users);

	List<Users> LoginUserList();

	BaseWrapper uploadImg(HttpServletRequest request, MultipartFile file);

	ToJson<Users> editUserExtNew(HttpServletRequest request, Users users, UserExt userExt);

	/**
	 * 创建作者:  牛江丽
	 * 创建日期:   2017-11-22
	 * 方法介绍:   根据用户名字和用户名拼音进行模糊查询
	 * 参数说明:   @param name
	 * 参数说明:   @return List<Users>
	 */
	ToJson<Users> getByName(String name);


	/**
	 * 创建作者:  郭富强
	 * 创建日期:   2018-1-16
	 * 方法介绍:   根据部门deptId查询当前部门用户姓名
	 * 参数说明:   @param deptId
	 * 参数说明:   @return List<String>
	 */

	ToJson<Users> getuserNameByDeptId(Integer deptId);
	ToJson<Integer> selectuidByName(String userName);

	ToJson<Users> getUserDepartmentUserexe(String deptId, String dutyType,
                                           String uids);
	public BaseWrapper checkUserCount(HttpServletRequest request);

	public BaseWrapper UsersByUidCorrection();

	/**
	 * 作者: 张航宁
	 * 日期: 2018/3/26
	 * 说明:修正用户
	 */
	public ToJson<Users> correctUsers(HttpServletRequest request);

	List<Users> getUsersByPId(int pId);

	public ToJson<Map> getPwRule();

	public ToJson<Object> getOnlineCount(HttpServletRequest request);

	public ToJson<Object> getOnlineMap(HttpServletRequest request);

	public ToJson<Users> getOnlinePeople(HttpServletRequest request);

	public ToJson<Users> getOnlinePeopleBai(HttpServletRequest request);
	public ToJson<Object> updatePassword();
	public ToJson<Users> updatemobile();

	/**
	 * 作者: 张航宁
	 * 日期: 2018/5/16
	 * 说明: 获取当前用户所在部门的所有用户信息
	 */
	public ToJson<Users> selNowUsers(HttpServletRequest request);

	/**
	 * 作者: 张航宁
	 * 日期: 2018/5/16
	 * 说明: 获取当前用户所在部门的所有用户信息
	 */
	public ToJson<Object> selectIsExistUser(String byname);

	/**
	 * 作者: 高亚峰
	 * 日期: 2018/7/10
	 * 说明: 获取当前用户所在部门以及子部门用户信息
	 */
	public ToJson<Users> selNewNowUsers(HttpServletRequest request);

	public ToJson<Users> queryUserByUserIdBai(HttpServletRequest request,String userName);

	/**
	 * 作者: 高亚峰
	 * 日期: 2018/7/10
	 * 说明: 获取点击部门下的用户以及子部门用户
	 */
	public ToJson<Users> getNewChDept(HttpServletRequest request, Integer deptId);

	public ToJson<Users> getNewChDeptBai(HttpServletRequest request, Integer deptId);

	/**
	 * 作者: 高亚峰
	 * 日期: 2018/7/10
	 * 说明: 获取点击部门下的用户以及子部门下用户
	 */
	public ToJson<Department> getNewChAllDept(HttpServletRequest request, Integer deptId);

	/**
	 * 作者: 高亚峰
	 * 日期: 2018/7/10
	 * 说明: 获取角色下的用户以及辅助角色下用户
	 */
	public ToJson<UserPriv> getUserByUserPriv(HttpServletRequest request, Integer userPriv);
	public ToJson<UserPriv> getUserByUserPrivBai(HttpServletRequest request, Integer userPriv);


	public ToJson<Object> getUsersByUserPriv(HttpServletRequest request, String userPriv);


	public List<Users> getAllUser(Map<String, Object> map);
    //通讯录查询
	//ToJson<Users> queryUsers(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, Users user, String isExport);

	public ToJson<Users> selNewNowUsersBai(HttpServletRequest request);



}


