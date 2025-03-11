package com.xoa.dao.IMUser;

import com.xoa.model.users.Users;
import com.xoa.model.users.UsersIm;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

 /**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:33:32
 * 类介绍  :    用户
 * 构造参数:   无
 *
 */
public interface IMUsersMapper {

	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:36:50
	 * 方法介绍:   根据别名查找用户
	 * 参数说明:   @param byname 别名
	 * 参数说明:   @return
	 * @return     Users  用户信息
	 */
	public Users findUserByName(@Param("byname") String byname);

	 public Users selectUserAllInfoByName(@Param("byname") String byname);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:36:57
	 * 方法介绍:   根据uid查找用户姓名
	 * 参数说明:   @param uid  用户uid
	 * 参数说明:   @return
	 * @return     String  用户姓名
	 */
	public String getUsernameById(int uid);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:37:25
	 * 方法介绍:   添加用户
	 * 参数说明:   @param user  用户信息
	 * @return     void  无
	 */
	public Integer addUser(Users user);
	
	
	public Integer insert(Users user);


	 public Integer insertByEdu(Users user);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:37:34
	 * 方法介绍:   修改用户
	 * 参数说明:   @param user  用户信息
	 * @return     void  无
	 */
	public int editUser(Users user);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:37:44
	 * 方法介绍:   删除用户
	 * 参数说明:   @param uid 用户编号
	 * @return     void 无
	 */
	public void deleteUser(String[] uids);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:37:53
	 * 方法介绍:   根据部门id查找部门信息
	 * 参数说明:   @param depId  部门id
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getdepId(Map<String, Object> maps);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:37:59
	 * 方法介绍:   根据userPriv查找用户
	 * 参数说明:   @param userPriv  角色编号
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getRoleId(int userPriv);
	
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:38:08
	 * 方法介绍:   获取所有用户
	 * 参数说明:   @param maps 集合
	 * 参数说明:   @return
	 * @return     List<Users>   返回所有用户
	 */
	public List<Users> getAlluser(Map<String, Object> maps);
		
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:38:15
	 * 方法介绍:   根据uid获取用户
	 * 参数说明:   @param uid 用户编号
	 * 参数说明:   @return
	 * @return     Users  获取所有用户
	 */
	public Users findUserByuid(int uid);


	 /**
	  * 创建作者:   高亚峰
	  * 创建日期:   2017年4月18日 下午6:38:15
	  * 方法介绍:   根据uid获取用户简单查询
	  * 参数说明:   @param uid 用户编号
	  * 参数说明:   @return
	  * @return     Users  获取所有用户
	  */
	 public Users SimplefindUserByuid(int uid);



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
	  * 创建作者:   高亚峰
	  * 创建日期:   2017年5月3日 下午12:48:12
	  * 方法介绍:   根据userId获取用户
	  * 参数说明:   @param userId 用户userId
	  * 参数说明:   @return
	  * @return     Users  用户信息
	  */
	 public Users SimplefindUsersByuserId(String userId);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午6:38:23
	 * 方法介绍:   多条件查询用户
	 * 参数说明:   @param user  用户 信息
	 * 参数说明:   @return
	 * @return     List<Users>  返回所有用户
	 */
	public List<Users> getUserByMany(Users user);


	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月18日 下午7:19:41
	 * 方法介绍:   获取用户信息和部门名称
	 * 参数说明:   @param maps  集合
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getUserAndDept(Map<String, Object> maps);

	 public List<Users> getUserAndDeptBai(Map<String, Object> maps);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月21日 上午10:43:52
	 * 方法介绍:   根据输入条件查找用户信息
	 * 参数说明:   @param maps  集合（封装条件）
	 * 参数说明:   @return
	 * @return     List<Users>  返回用户信息
	 */
	public List<Users> getBySearch(Map<String, Object> maps);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月21日 上午10:56:22
	 * 方法介绍:   根据部门编号查询用户信息
	 * 参数说明:   @param maps 集合（封装部门编号）
	 * 参数说明:   @return
	 * @return     List<Users> 返回部门信息
	 */
	public List<Users> getByDeptId(Map<String, Object> maps);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月25日 上午10:03:52
	 * 方法介绍:   根据uid查询用户姓名、部门、角色信息
	 * 参数说明:   @return
	 * @return     User
	 */
	public Users getByUid(int uid);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月26日 下午6:21:47
	 * 方法介绍:   根据userId串获取用户姓名
	 * 参数说明:   @param userId 用户userId串
	 * 参数说明:   @return
	 * @return     String 返回用户姓名拼接串
	 */
	public String getUsernameByUserId(String userId);

	 /**
	  * 方法介绍:  获取用户的生日，性别，//学历，入职日期
	  * @return
	  */
	public List<Users> getAllInfo();

	public String getUsernameById(String uid);

     List<Users> getUserByDeptId(Users user);

	 List<Users> getUserByDeptIdZero(Users user);

     List<Users> getUserByRoleId(Users user);

     List<Users> getUserOnline();

	 List<Users> getUserbyCondition(Map<String, Object> maps);
     List<Users> getUserNameByFuncId(String fid);

     List<String> getUserByFuncId(String fid);

     List<String> findUsersByIds(Map<String, List> hashMap);

     List<Users> checkPassWord(String userName);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月15日
	  * 方法介绍:   根据deptId获取该部门下的所有用户信息
	  * 参数说明:   @param deptId
	  * 参数说明:   @return  List<Users>
	  */
	 List<Users> getUsersByDeptId(Integer deptId);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月19日
	  * 方法介绍:   查询空密码用户
	  * 参数说明:   @return  List<Users>
	  */
	 List<Users> getNullPwUsers(Integer deptId);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月19日
	  * 方法介绍:   查询新增用户
	  * 参数说明:   @return  List<Users>
	  */
	 List<Users> getNewUsers();

	 /**
	  * 创建作者:   张龙飞
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据deptId获取该部门上级部门下的所有用户信息
	  * 参数说明:   @param deptId
	  * 参数说明:   @return  List<Users>
	  */
	 List<Users> getPUsersByDeptId(Integer deptId);

	 /**
	  * 创建作者:   张龙飞
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据deptId获取该部门下级部门下的所有用户信息
	  * 参数说明:   @param deptId
	  * 参数说明:   @return  List<Users>
	  */
	 List<Users> getCUsersByDeptId(Integer deptId);

	 /**
	  * 创建作者:   张龙飞
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据deptId获取该部门同级部门下的所有用户信息
	  * 参数说明:   @param deptId
	  * 参数说明:   @return  List<Users>
	  */
	 List<Users> getTUsersByDeptId(Integer deptId);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   清空密码
	  * 参数说明:   @param uids
	  */
	 void clearPassword(String[] uids);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   清空在线时间
	  * 参数说明:   @param uids
	  */
	 void clearOnLine(String[] uids);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   设置禁止登陆
	  * 参数说明:   @param uids
	  */
	 void setNotLogin(String[] uids);


	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   批量修改部门
	  * 参数说明:   @param uids
	  */
	 void editUsersDetId(@Param(value = "deptId") Integer deptId, @Param(value = "uids") String[] uids);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据id数组获取用户信息
	  * 参数说明:   @param uids
	  * 参数说明:   @param List<Users>
	  */
	 List<Users> getUsersByUids(@Param(value = "uids") String[] uids);

     /**
      * @创建作者: 韩成冰
      * @创建日期: 2017/6/22 13:30
      * @函数介绍: 根据用户ID查询
      * @参数说明: @param String uid
      * @return: String
      */
     String getUserPrivByuId(Integer uId);

	 /**
	  * @创建作者: 张龙飞
	  * @创建日期: 2017/6/22 17:30
	  * @函数介绍: 根据用户部门排序号获取该部门下是否有用户
	  * @参数说明: @param String deptNO
	  * @return: List<Users>
	  */
	 List<Users> deptHaveUser(String deptNO);

	 /**
	  * @创建作者: 张丽军
	  * @创建日期: 2017/6/22 17:30
	  * @函数介绍: 添加界面信息
	  * @参数说明: @param String deptNO
	  * @return:   return
	  */
	 void addU(Users users);
	 /**
	  * @创建作者: 张丽军
	  * @创建日期: 2017/6/22 17:30
	  * @函数介绍: 查询界面信息
	  * @参数说明: @param String deptNO
	  * @return: List<Users>
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
	 public List<Users> queryUserByUserId(String userName, char[] chars);

	 /**
	  * 创建作者:   高亚峰
	  * 创建日期:   2018年3月27日 下午10:32:22
	  * 方法介绍:   根据userId进行模糊查询
	  * 参数说明:   @param userId
	  * 参数说明:
	  * @return List<SUsers>  返回用户信息
	  */
	 public List<Users> queryUserByUserIds(Map<String, Object> map);

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
	  * 创建作者:   牛江丽
	  * 创建日期:   2017年6月27日 下午10:32:22
	  * 方法介绍:   根据userId进行模糊查询
	  * 参数说明:   @param userName
	  * 参数说明:
	  * @return List<SUsers>  返回用户信息
	  */
	 public List<Users> queryUserByUserName(String userName);

	 /**
	  * 创建作者:   牛江丽
	  * 创建日期:   2017年6月27日 下午10:35:22
	  * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
	  * 参数说明:   @param  userName
	  * 参数说明:
	  * @return List<SUsers>  返回用户信息
	  */
	 public int queryCountByUserName(String userName);

     int getUserCount();

     int updatePwd(Map<String, String> hashMap);

     Integer getLoginUserCount();

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年7月1日
	  * 方法介绍:   根据uid查询单个信息
	  * 参数说明:   @param  uid
	  * 参数说明:
	  * @return Users 返回用户信息
	  */
	 Users getUserByUid(@Param(value = "uid") int uid);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年7月3日
	  * 方法介绍:   查询和导出接口
	  * 参数说明:   @param  map
	  * 参数说明:
	  * @return List<SUsers>  返回用户信息
	  */
	 List<Users> queryExportUsers(Map<String, Object> map);
    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/7/3 11:16
    *@函数介绍:  修改用户主题
    *@参数说明:  @param users
    *@return:   void
    **/
     void updateUserTheme(Users users);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年月4日
	  * 方法介绍:   批量修改用户信息
	  * 参数说明:   @param user  用户信息
	  * 参数说明:   @return
	  *
	  * @return ToJson<Users>  返回显示信息
	  */
     void editUserBatch(@Param(value = "uids") List<String> uids, @Param(value = "user") Users user);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年月4日
	  * 方法介绍:   根据部门id获取所属用户信息
	  * 参数说明:   @param user  用户信息
	  * 参数说明:   @return
	  *
	  * @return ToJson<Users>  返回显示信息
	  */
     List<Users> getUsersByDeptIds(@Param(value = "deptIds") String[] deptIds);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年月4日
	  * 方法介绍:   根据角色id获取用户信息
	  * 参数说明:   @param user  用户信息
	  * 参数说明:   @return
	  *
	  * @return ToJson<Users>  返回显示信息
	  */
	 List<Users> getUsersByPrivIds(@Param(value = "privIds") String[] privIds);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年月4日
	  * 方法介绍:   根据部门id和角色id获取用户信息
	  * 参数说明:   @param user  用户信息
	  * 参数说明:   @return
	  *
	  * @return ToJson<Users>  返回显示信息
	  */
	 List<Users> getUsersByDeptAndPriv(@Param(value = "deptIds") String[] deptIds, @Param(value = "privIds") String[] privIds);

	 /**
	  * 创建作者:   高亚峰
	  * 创建日期:   2017年7月5日
	  * 方法介绍:   根据用户userID查询用户
	  * 参数说明:   @param userId
	  * 参数说明:   @return
	  * @return ToJson<Users>
	  */
	 Users getUsersByuserId(String userId);

	 Users getUsersByuserIdBai(Map map);
	 /**
	  * 查阅情况未读
	  * @param maps
	  * @return
	  */
	 List<Users>  unreadConsultTheSituationNotify(Map<String, Object> maps);
	 /**
	  * 查阅情况已读
	  * @param maps
	  * @return
	  */
	 List<Users>  readConsultTheSituationNotify(Map<String, Object> maps);

	 /**
	  * 查阅情况未读
	  * @param maps
	  * @return
	  */
	 List<Users>  unreadConsultTheSituationNew(Map<String, Object> maps);
	 /**
	  * 查阅情况已读
	  * @param maps
	  * @return
	  */
	 List<Users>  readConsultTheSituationNew(Map<String, Object> maps);

	/**
	 * 创建作者:   杨 胜
	 * 创建日期:   2017-7-11 下午2:31:05
	 * 方法介绍:
	 * 参数说明:   @return
	 * @return     List<Users>
	 */
	public List<Users> selectFileUserSignerAll();

	/**
	 * 创建作者:   杨 胜
	 * 创建日期:   2017-7-11 下午2:31:09
	 * 方法介绍:
	 * 参数说明:   @param mapUser
	 * 参数说明:   @return
	 * @return     List<Users>
	 */
	public List<Users> selectFileUserSigner(Map<String, Object> mapUser);

	 /**
	  * 创建作者:   高亚峰
	  * 创建日期:   2017-7-17 上午11:31:09
	  * 方法介绍:    通过byname查询对应的用户
	  * 参数说明:   @param byname
	  * 参数说明:   @return
	  * @return     Users
	  */
	 public Users getUsersBybyname(String byname);
	 /**
	  * 创建作者:   高亚峰
	  * 创建日期:   2017-7-17 上午11:31:09
	  * 方法介绍:    通过name查询对应的用户
	  * 参数说明:   @param name
	  * 参数说明:   @return
	  * @return     Users
	  */
	 public Users getUsersByname(String name);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年7月17日
	  * 参数说明:   @param user  用户信息
	  * 参数说明:   @return
	  *
	  * @return ToJson<Users>  返回显示信息
	  */
	 List<Users> singleSearch(@Param(value = "searchData") String searchData);

/*	 *//**
	  * 创建作者:   高亚峰
	  * 创建日期:   2017-7-18 上午11:35:09
	  * 方法介绍:    通过userName修改对应user信息的角色
	  * 参数说明:   Users
	  * 参数说明:   @return
	  * @return     Users
	  *//*
	 public void updateUsersByuserName(Users users);*/


	 /**
	  * 创建作者:   牛江丽
	  * 创建日期:   2017-7-19 上午18:08:09
	  * 方法介绍:    获取指定部门下的用户数
	  * 参数说明:   deptId
	  * 参数说明:   @return
	  * @return     int
	  */
	 public int judgeHashUser(String deptId);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据userid数组获取用户信息
	  * 参数说明:   @param userIds
	  * 参数说明:   @param List<Users>
	  */
	 List<Users> getUsersByUserIds(@Param(value = "userIds") String[] userIds);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年7月27日
	  * 方法介绍:   根据userid数组获取用户信息
	  * 参数说明:   @param userIds
	  * 参数说明:   @param List<Users>
	  */
	 List<Users> getUsersByBynames(@Param(value = "bynames") String[] bynames);

	 Users getUserByUserName(String userName);

	 void deleteUserByDeptId(String deptId);

	/**
	 * 创建作者:   杨 胜
	 * 创建日期:   2017-8-1 下午9:11:46
	 * 方法介绍:
	 * 参数说明:   @param mapParam
	 * 参数说明:   @return
	 * @return     List<String>
	 */
	public List<String> getUserNames(Map<String, Object> mapParam);

	 List<Users> getUsersByMaps(Map<String, Object> mapParam);

	 public String getMaxUserId();

	 public Users getUserByName(String userName);

	 Users selectUserByUId(Integer uid);


	 public void updateUserByName(Users users);

	 public Users getUserByIdNumber(String idNumber);

	 public Users importUserByName(String byName);

	 /**
	  * 创建作者:   刘新婷
	  * 创建日期:   2017-11-21
	  * 方法介绍:   根据用户id数组获取部门主管信息
	  * 参数说明:   @param uids
	  * 参数说明:   @return List<Users>
	  */
	 List<Users> getUserByUids(@Param(value = "uids") String[] uids, @Param("userIds") String[] userIds);

	 public void updateLoginTime(Users users);


	 /**
	  * 创建作者:   刘新婷
	  * 创建日期:   2017-11-22
	  * 方法介绍:   根据用户名数组获取部门主管信息
	  * 参数说明:   @param uids
	  * 参数说明:   @return List<Users>
	  */
	 List<Users> getUserByUserIds(@Param("userIds") String[] userIds);


    	 List<Users> LoginUserList();

    	 List<Users> selUserOrder(String[] uidArr);

	 /**
	  * 创建作者:  牛江丽
	  * 创建日期:   2017-11-22
	  * 方法介绍:   根据用户名字和用户名拼音进行模糊查询
	  * 参数说明:   @param name
	  * 参数说明:   @return List<Users>
	  */
	 List<Users> getByName(String name);
	 /**
	  * 创建作者:  郭富强
	  * 创建日期:   2018-1-16
	  * * 方法介绍: 根据部门deptId查询当前部门用户姓名
	  * 参数说明:   @param deptId
	  * 参数说明:   @return List<String>
	  */
	 List<Users>  getuserNameByDeptId(Integer deptId);

	 List<Integer> selectuidByName(String userName);
	  List<Users>  getUserDepartmentUserexe(Map<String, Object> map);

	  Users getUsersByUid(Integer uid);

	  String UsersByUidCorrection1(@Param("depId") Integer depId);
	  String UsersByUidCorrection2(@Param("depId") Integer depId);
	  String UsersByUidCorrection3(@Param("depId") Integer depId);
	  String UsersByUidCorrection4(@Param("depId") Integer depId);

	 List<Users> getListByName(String userName);

	 List<Users> getUsersByPId(int pId);

	 //根据多个用户Id查找电话
	 List<Users> getUserByListUId(List<Integer> uidlist);

	 int isUserSameDept(Map<String, Object> map);

	 List<Users>  selectUserByTime();

	 int batchUpdatePwd(Map<String, Object> map);

	 int updateMobile(Users users);


	int getUserCountBySql(String databaseName);



	 List<Users> getUsersByUserPriv(String userPriv);

	 List<Users> getUsersByUSER_PRIV_OTHER(String userPriv);
	 List<Users> getUsersByUSER_PRIV_OTHERMAP(Map map);

	 List<Users> getUsersByUSER_PRIV_OTHERORG(Map<String, Object> map);

	 List<Users> selectAllUsers();

	 List<Users> getAllUser(Map<String, Object> map);


	 public List<String> getAllNameByUserId(String[] userIds);

	 public List<String> getAllUPNameByUserId(String[] userIds);


	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据id数组获取用户信息 根据传进来顺序的排序
	  * 参数说明:   @param uids
	  * 参数说明:   @param List<Users>
	  */
	 List<Users> getUsersByUidsOrder(@Param(value = "uids") String uids);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年6月20日
	  * 方法介绍:   根据userid数组获取用户信息 根据传进来顺序的排序
	  * 参数说明:   @param userIds
	  * 参数说明:   @param List<Users>
	  */
	 List<Users> getUsersByUserIdsOrder(@Param(value = "userIds") String[] userIds);

	 List<Users> getUsersByUserIdsOrderBai(Map map);

	 /**
	  * 创建作者:   张航宁
	  * 创建日期:   2017年7月27日
	  * 方法介绍:   根据userid数组获取用户信息 根据传进来顺序的排序
	  * 参数说明:   @param userIds
	  * 参数说明:   @param List<Users>
	  */
	 List<Users> getUsersByBynamesOrder(@Param(value = "bynames") String[] bynames);

	 List<Users> selectUserByDeptIds(@Param(value = "deptIds") String[] deptIds);

	 String selUserPhoneByName(String userName);
	 List<Users> selUserByIds(@Param("userIds") String[] userIds);

	 List<Users> getAllByDeptId(Map<String, Object> map);

	 Users getUserId(String userId);
	//获取所有符合userId、deptId、userPriv权限的用户
	 List<Users> getAllPrivUser(Map<String, Object> map);

	 //im通讯得到user
	 List<Users> selectImFriend(List list);

	 List<Users>  unreadConsultTheSituationMeet(Map<String, Object> maps);

	 List<Users>  readConsultTheSituationMeet(Map<String, Object> maps);

	 List<String> selectMobileByUserId(String[] userIds);

	 List<Users> selectUserByDeptIdsBai(Map map);
	 public List<Users> getBySearchBai(Map<String, Object> maps);

	 public List<Users> getBySearchBaiOrg(Map<String, Object> maps);

	 List<Users> getUsersByUserPrivBai(Map map);

	 String getDeptParentByUserId(String userId);

	 public List<Users> queryUserByUserIdsBai(Map<String,Object>map);

	 public List<Users> getUserByUserPrivBaiOrg(Map<String,Object>map);

	 public List<Users> getUserByUserPrivOtherBaiOrg(Map<String,Object>map);

	 List<UsersIm> getUserAndDeptIm(Map<String, Object> maps);

     List<Users> selectPowerUserByDeptIdsBai(Map map);

	 List<Users> getUserByDept(Map map);
 }

