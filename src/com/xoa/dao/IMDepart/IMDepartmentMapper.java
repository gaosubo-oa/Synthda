package com.xoa.dao.IMDepart;

import com.xoa.model.department.Department;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午8:22:35
 * 类介绍  :    部门
 * 构造参数:   无
 *
 */
public interface IMDepartmentMapper {


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:22:51
     * 方法介绍:   获取所有部门
     * 参数说明:   @return
     * @return     List<Department> 返回部门信息
     */
    public List<Department> getDatagrid();

    /**
     * 根据dept_id获取dept_no
     * 王禹萌
     * 2018-07-25 13：41
     * @param map
     * @return
     */
    public String getAllByDeptId(Map map);
    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:23:02
     * 方法介绍:   根据部门id获取部门
     * 参数说明:   @param deptId 部门deptid
     * 参数说明:   @return
     * @return     String  返回部门名称
     */
    public String getDeptNameById(int deptId);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:23:21
     * 方法介绍:   根据部门id获取部门
     * 参数说明:   @param deptId 部门编号
     * 参数说明:   @return
     * @return     Department  返回部门信息
     */
    public Department getDeptById(int deptId);


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:23:42
     * 方法介绍:   根据部门id删除部门
     * 参数说明:   @param deptId  部门编号
     * @return     void  无
     */
    public void deleteDept(int deptId);


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:23:56
     * 方法介绍:   新增部门
     * 参数说明:   @param department  部门信息
     * @return     void  无
     */
    public void insertDept(Department department);


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:24:17
     * 方法介绍:   修改部门
     * 参数说明:   @param department  部门信息
     * @return     void  无
     */
    public void editDept(Department department);


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:24:35
     * 方法介绍:   多条件获取部门
     * 参数说明:   @param department 部门信息
     * 参数说明:   @return
     * @return     List<Department>  返回部门集合
     */
    public List<Department> getDeptByMany(Department department);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月20日 下午5:47:07
     * 方法介绍:   获取子目录
     * 参数说明:   @param maps  集合
     * 参数说明:   @return
     * @return     List<Department>  返回部门集合
     */
    public List<Department> getChDept(int deptId);

    List<Department> getChDeptByDisplay(@Param("deptId")int deptId,@Param("deptDisplay")Integer deptDisplay);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 下午1:10:00
     * 方法介绍:   获得上级部门
     * 参数说明:   @param deptId 下级部门编号
     * 参数说明:   @return
     * @return     Department 返回部门信息
     */
    public Department getFatherDept(int deptId);

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月24日 下午8:46:01
 * 方法介绍:   获得部门
 * 参数说明:   @param deptNo 部门排序号
 * 参数说明:   @return
 * @return     List<Department> 返回部门信息
 */
//public List<Department> getChDeptByNo(String deptNo);



    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月25日 下午2:13:28
     * 方法介绍:   获取当前部门下子部门与部门人员
     * 参数说明:   @param deptId 部门id
     * 参数说明:   @return
     * @return     List<Department> 返回部门编号
     */
    public List<Department> getChDeptUser(int deptId);


    public List<Department> getChDeptUserBai(Map map);
    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月3日 上午9:04:34
     * 方法介绍:   获取部门下人数
     * 参数说明:   @param deptNo 部门排序号
     * 参数说明:   @return
     * @return     int 数量
     */
    public int getCountChDeptUser(String deptNo);

    /**
     * 创建作者:   张勇
     * 创建日期:   2016年6月3日 下午4:02:05
     * 方法介绍:   根据dept串获取用户姓名
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<String>  返回用户姓名串
     */
    public  String getDeptNameByDeptId(Integer deptId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午11:56:05
     * 方法介绍:   根据部门名称获取部门id
     * 参数说明:   @param deptName 部门名称
     * 参数说明:   @return String 部门id
     *
     * @return List<String>  返回用户姓名串
     */
    public  List<String> getDeptIdByDeptName(String deptName);

    List<Department> getDepartmentByUid(Integer uid);

    List<Department>  getDepartmentByParet();

    public Department getFirstDept(String deptNo);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月3日 下午19:21:05
     * 方法介绍:   根据部门id进行批量修改部门主管和部门助理
     * 参数说明:   @param departments
     * 参数说明:   @return int 修改条数
     *
     * @return List<String>  返回用户姓名串
     */
    public int batchUpdateDeptById(Department department);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午14:53:05
     * 方法介绍:   根据部门id修改部门排序好
     * 参数说明:   @param departments
     * 参数说明:   @return int 修改条数
     *
     * @return List<String>  返回用户姓名串
     */
    public int updateDeptNoByDeptId(Department department);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午14:53:05
     * 方法介绍:   根据上级部门id获取当前部门id
     * 参数说明:   @param departments
     * 参数说明:   @return int 修改条数
     *
     * @return List<String>  返回用户姓名串
     */
    public List<Integer> getDeptIdByParent(int deptParent);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午18:00:05
     * 方法介绍:   获取所有部门信息
     * @return List<Department>
     */
    public List<Department>  getAllDepartment();


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午18:38:05
     * 方法介绍:   根据父部门id获取部门名称
     * @return String
     */
    public String getFatherDeptName(Integer deptParent);
    public List<Department> checkDep(String deptName);
    public List<String> getDeptNames(Map<String, Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月1日 下午10:05:05
     * 方法介绍:   根据部门id设置分级机构和分级机构管理员
     * @return String
     */
    public int setClassifyOrgByDeptId(Department department);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月1日 下午10:14:05
     * 方法介绍:   获取分级机构信息
     * @return String
     */
    public List<Department> getAllClassifyOrg();

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月1日 下午10:14:05
     * 方法介绍:    根据权限获取分级机构信息(分级机构管理员)
     * @return String
     */
    public List<Department> getClassifyOrgByAdmin(Map<String, Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年9月28日 下午11:25:05
     * 方法介绍:   根据父部门id判断是否有分级机构
     * @return String
     */
    public int selClaNumByParentId(int deptId);

    public List<Department> getBydeptNo(String deptNo);


    public List<Department> getDepByNo(String deptNo);


    /**
     * 方法说明:根据ID查询部门名称
     * 创建时间：2017-10-24
     * 创建人：陈志才
     * @param deptId
     * @return
     */
    public String departmentOneSelect(Integer deptId);


    /**
     * 牛江丽
     * 根据父部门id查询排序号后三位
     * @return deptParent
     */
    public List<String> selDeptNoByDeptParent(Map<String, Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年11月4日 下午10:22:51
     * 方法介绍:   获取根据部门名称模糊查询
     * 参数说明:   @return
     * @return     List<Department> 返回部门信息
     */
    public List<Department> selByLikeDeptName(String deptName);


    public String getDeptManagerIdByDeptId(Integer deptId);

    /**
     * 作者: 张航宁
     * 日期: 2018/1/31
     * 说明: 根据名称获取部门信息
     */
    List<Department> getDeptByName(@Param("deptName") String deptName);
    //钉钉
    Integer getParentDingdingId(Integer deptId);

    Integer getDingdingIdByDeptId(Integer deptId);

    //企业微信
    Integer getParentEnterpriseWeChatId(Integer deptId);

    Integer getEnterpriseWeChatIdByDeptId(Integer deptId);







    /**
     * 作者: 张航宁
     * 日期: 2018/2/28
     * 说明: 根据部门ids获取信息
     */
    List<Department> selDeptByIds(@Param("ids") String[] ids);
    List<Department> selDeptByListIds(@Param("ids") List ids);


    List<Department> selByNameAndParent(Map<String, Object> map);

    List<Department> selDeptByCode(String deptCode);

    public List<String> getDNameByIds(String deptId);

    public List<String> getDNoByIds(String deptId);
    List<Department> getDeptNameByIds(Map<String, Object> map);

    List<Department>selectObjectByParent(Integer departParent);

    public List<Department> getDepartmentYj();

    int selectDeptNum();

    List<Department> getPowerUsers(Map map);
}