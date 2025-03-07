package com.xoa.service.menu;

import com.xoa.model.common.SysParaExtend;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.menu.SysMenu;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-19 下午3:43:43
 * 类介绍  :    菜单Service
 * 构造参数:
 */
public interface MenuService {

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:43:57
     * 方法介绍:   获取全部菜单
     * 参数说明:   @param request 登录用户
     * 参数说明:   @return
     *
     * @return List<SysMenu>
     */
    public List<SysMenu> getAll(HttpServletRequest request, String locale);

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:43:57
     * 方法介绍:   获取全部菜单
     * 参数说明:   @param request 登录用户
     * 参数说明:   @return
     *
     * @return List<SysMenu>
     */
    public List<SysMenu> getAll2(HttpServletRequest request, String locale);



    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:43:57
     * 方法介绍:   获取全部菜单
     * 参数说明:   @param request 登录用户
     * 参数说明:   @return
     *
     * @return List<SysMenu>
     */
    public List<SysMenu> getAllWithEmpty(HttpServletRequest request, String locale);




    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-19 下午3:44:08
     * 方法介绍:   获取子类菜单
     * 参数说明:   @param menuId
     * 参数说明:   @return
     *
     * @return List<SysFunction>
     */
    public List<SysFunction> getDadMenu(String menuId, String locale);


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 12:50
     * @函数介绍: 修改一级菜单
     * @参数说明: @param sysMenu
     * @return: void
     **/
    int updateSysMenu(SysMenu sysMenu);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:03
     * @函数介绍: 添加一级菜单
     * @参数说明: @param paramname paramintroduce
     * @return: void
     **/
    void addSysMenu(SysMenu sysMenu);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:16
     * @函数介绍: 删除菜单
     * @参数说明: @param paramname paramintroduce
     * @return: void
     **/
    void deleteSysMenu(String id);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 13:59
     * @函数介绍: 添加二级菜单
     * @参数说明: @param SysFunctioni
     * @return: void
     **/
    ToJson<SysFunction> addFunctionMenu(SysFunction sysFunction,String pfId);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 19:38
     * @函数介绍: 编辑一级菜单
     * @参数说明: @param SysFunction
     * @return: void
     **/
    void editSysFunction(SysFunction sysFunction);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 19:37
     * @函数介绍: 查询子菜单
     * @参数说明: @param id
     * @参数说明: @param locale 国际化
     * @return: List<SysFunction></SysFunction>
     **/
    List<SysFunction> findChildMenu(String id, String locale);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 19:37
     * @函数介绍: 根据id查一级菜单
     * @参数说明: @param Stirng
     * @参数说明: @param locale 国际化
     * @return: List<SysMenu></SysMenu>
     **/
    List<SysMenu> getTheFirstMenu(String id, String locale);


    /*
    *  @创建作者: 刘佩峰
     * @创建日期: 2017/6/20
    * */
    ToJson<Integer> findMaxId();

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/5/26 19:37
     * @函数介绍: 查询菜单根据用户权限
     * @参数说明: @param request
     * @参数说明: @param locale 国际化
     * @return: List<SysFunction></>
     **/
    List<SysFunction> getMenus(HttpServletRequest request, String parentId, String locale);

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/6/26 14:06
    *@函数介绍:  查询所有菜单，不考虑权限
    *@参数说明:  @param request
    *@参数说明:  @param zh_cn 国际化
    *@return:   XXType(value introduce)
    **/
    List<SysMenu> getAllMenu(HttpServletRequest request, String zh_cn);

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
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-6-27 下午17:43:57
     * 方法介绍:   根据当前登录用户查询15个菜单应用
     * 参数说明:  locale 国际化
     *
     * @return List<SysFunction>
     */
    public List<SysFunction> getPriMenu(HttpServletRequest request, String locale);
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-6-30 下午16:43:57
     * 方法介绍:   获取错误子菜单列表
     * 参数说明:
     * @return json
     */
    public ToJson<List<SysFunction>> getErrMenu();
    /**
     * 创建作者:    韩成冰
     * 创建日期:   2017-7-3 上午10:32
     * 方法介绍:  菜单恢复
     * 参数说明: path sql文件的路径
     * @return json
     */
    public ToJson<Object> recoverMenu(HttpServletRequest request,String path);
    /**
     * 创建作者:    韩成冰
     * 创建日期:   2017-7-3 上午10:32
     * 方法介绍:  菜单备份
     * 参数说明: request response
     * @return json
     */
    public void exportMenu(HttpServletRequest request,HttpServletResponse response);

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/4 15:25
     * @函数介绍: 菜单设置
     * @参数说明: TOP_MENU_NUM 快捷菜单栏每行显示的个数
     *            MENU_GROUP 菜单快捷组
     *            MENU_WINEXE 显示windows 快捷组
     *            MENU_URL    显示常用地址
     *            MENU_EXPAND_SINGLE  同时只能展开一个菜单
     * @return: json
     */
    ToJson<Object> editMenuPara( SysParaExtend sysParaExtend);
    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/4 17:22
     *@函数介绍: 查询菜单设置内容
     * @参数说明:
     * @return: json
     */
    ToJson<SysParaExtend> getParaInfo();

    /**
    *@创建作者:  韩成冰
    *@创建日期:  2017/7/11 13:22
    *@函数介绍: 根据fid查Sysfuntion
    *@参数说明:  fid
    *@return:   SysFunction
    **/
    SysFunction getSysFunctionByFid(Integer fid);


    ToJson<SysFunction> getUsuallyMenu(HttpServletRequest request);

    ToJson<SysMenu> queryAllMenu(HttpServletRequest request, String locale);

}
