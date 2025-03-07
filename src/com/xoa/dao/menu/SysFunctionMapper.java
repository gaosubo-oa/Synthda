package com.xoa.dao.menu;

import com.xoa.model.menu.SysFunction;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * 
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-19 下午3:29:08
 * 类介绍  :    子类菜单DAO
 * 构造参数:    无
 *
 */
public interface SysFunctionMapper {
     /**
      * 
      * 创建作者:   王曰岐
      * 创建日期:   2017-4-19 下午3:29:43
      * 方法介绍:   根据菜单Id得到子类菜单
	  * 参数说明:   @param menuId
	  * 参数说明:   @return
      * @return     List<SysFunction>
      */
	 public List<SysFunction> getDatagrid(String menuId);
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:29:54
	 * 方法介绍:   根据二级菜单Id得到子类菜单
	 * 参数说明:   @param id
	 * 参数说明:   @return
	 * @return     List<SysFunction>
	 */
	 public List<SysFunction> childMenu(String id);
	  /**
	   * 
	   * 创建作者:   王曰岐
	   * 创建日期:   2017-4-19 下午3:30:08
	   * 方法介绍:   获取全部子类菜单
	   * 参数说明:   @return
	   * @return     List<SysFunction>
	   */
	 public List<SysFunction> getAll();

    void deleteFunction(String id);


	/**
	 *
	 * 创建作者:   刘佩峰
	 * 创建日期:   2017-6-19 下午3:30:08
	 * 方法介绍:  存入数据库
	 * 参数说明:   @return
	 * @return     List<SysFunction>
	 */
    int addFunctionMenu(SysFunction sysFunction);

    void editSysFunction(SysFunction sysFunction);

    List<SysFunction> findChildMenu(Map<String, String> hashMap);
	/**
	 *
	 * 创建作者:   刘佩峰
	 * 创建日期:   2017-6-19 下午3:30:08
	 * 方法介绍:   获取父类信息
	 * 参数说明:   @return
	 * @return     List<SysFunction>
	 */
    SysFunction getParentFunction(String pfId);
	/**
	 *
	 * 创建作者:   刘佩峰
	 * 创建日期:   2017-6-19 下午3:30:08
	 * 方法介绍:   判断id串是否存在
	 * 参数说明:   @return
	 * @return     List<SysFunction>
	 */
	int checkIdExists(String newId);


	/**
	 * 创建作者:   刘佩峰
	 * 创建日期:   2017-6-20
	 * 方法介绍:   获取最大id
	 */
   public int getMaxId();

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午14:29:22
	 * 方法介绍:   根据子菜单名称进行模糊查询
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return List<SysFunction>  返回子菜单信息
	 */
	public List<SysFunction> getSysFunctionByName(String funName);
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午14:30:12
	 * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return List<SysFunction>  查询数
	 */
	public int getCountSysFunctionByName(String funName);

	SysFunction checkFunctionExits(Integer fid);
	/**
	 * 创建作者:   高亚峰
	 * 创建日期:   2017年6月30日 下午16:55:12
	 * 方法介绍:   根据主菜单id查询它的二三级菜单
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return List<SysFunction>  某主菜单下面的二三级菜单
	 */
	List<SysFunction> getSomeChildMenu(String id);

    SysFunction getSysFunctionByFid(Integer fid);

	List<SysFunction> getUserFunctionByUserId(@Param("userId") String userId);

	@Select("select FUNC_ID from sys_function where FUNC_CODE =#{url} or FUNC_CODE like CONCAT('/',#{url});")
	List<String> getFuncIdByUrl(String url);

	/**
	 * create by:李善澳
	 * description:
	 * create time: 2020-09-24 13:03
	 * 根据funcId获取菜单名称
	 */
	List<String> getFunNameByFuncIds(String[] funcId);

	//@Select("select MENU_ID from sys_function where FUNC_CODE =#{url} or FUNC_CODE like CONCAT('/',#{url});")
	List<SysFunction> getMenuIdByUrl(@Param("urlList") List<String> urlList);

	int updateFuncIdByMenuId(Map<String, Object> map);
}