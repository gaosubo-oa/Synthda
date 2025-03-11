package com.xoa.service.department;

import com.xoa.model.department.Department;
import com.xoa.model.users.UserDeptOrder;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.util.LimsJson;
import com.xoa.util.ToJson;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月19日 上午9:36:46
 * 类介绍  :    部门
 * 构造参数:    无
 *
 */
public interface DepartmentService {
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 下午2:51:12
	 * 方法介绍:   根据部门id串获取部门名称
	 * 参数说明:   @param deptIds  部门id数组
	 * 参数说明:   @return
	 * @return     List<String>  部门名称集合
	 */
	public List<String> getDeptNameById(int... deptIds);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月3日 上午11:39:25
	 * 方法介绍:   根据部门id串获取部门名称串
	 * 参数说明:   @param deptIds
	 * 参数说明:   @return
	 * @return     String 部门名称串
	 */
	public String getDpNameById(int... deptIds);

	//根据部门id串获取部门名称串,这两个方法传递参数不一样都可以获取
	public String getDpNameById(String deptIds);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 上午9:37:25
	 * 方法介绍:   获取所有部门
	 * 参数说明:   @return
	 * @return     List<Department>  所有部门的集合
	 */
    public List<Department> getDatagrid(HttpServletRequest request);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 上午9:37:39
	 * 方法介绍:   根据部门id获取
	 * 参数说明:   @param deptId  部门id
	 * 参数说明:   @return
	 * @return     Department  部门信息
	 */
	public Department getDeptById(Integer deptId);

	//根据部门id获取 返回Map
	public Map<String,Object> getDeptMapById(Integer deptId);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 上午9:40:51
	 * 方法介绍:   删除部门
	 * 参数说明:   @param deptId  部门id
	 * @return     void   无返回值
	 */
	public void deleteDept(Integer deptId);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 上午9:41:02
	 * 方法介绍:   插入部门
	 * 参数说明:   @param department  部门信息
	 * @return     void  无返回值
	 */
	public void insertDept(Department department);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 上午9:41:21
	 * 方法介绍:   修改部门
	 * 参数说明:   @param department  部门信息
	 * @return     void  无返回值
	 */
	public void editDept(Department department);

	//修改部门 传递map
	public void editDeptMap(Map map);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月19日 上午9:41:31
	 * 方法介绍:   多条件查询部门信息
	 * 参数说明:   @param department 部门信息
	 * 参数说明:   @return
	 * @return     List<Department>  部门信息集合
	 */
	public List<Department> getDeptByMany(Department department);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月20日 下午5:46:02
	 * 方法介绍:   获取子级目录
	 * 参数说明:   @param maps  
	 * 参数说明:   @param page  当前页面
	 * 参数说明:   @param pageSize  页面显示数据条数
	 * 参数说明:   @param useFlag  是否开启分页
	 * 参数说明:   @return
	 * @return     List<Department>  部门集合
	 */
	public List<Department> getChDept(int deptId);

	List<Department> getChDept(Map<String,Object> map);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月21日 下午1:12:18
	 * 方法介绍:   获得上级部门
	 * 参数说明:   @return
	 * @return     List<Department> 返回上级部门信息
	 */
	public List<Department> getFatherDept(int deptParent,List<Department> list);

	public Department getFatherDept(int deptParent);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月24日 下午8:59:24
	 * 方法介绍:   根据部门排序号获得部门信息接口
	 * 参数说明:   @param deptNo 部门编号
	 * 参数说明:   @param list 部门信息
	 * 参数说明:   @return  
	 * @return     List<Department>  部门信息
	 */
	public List<Department> getChDeptByNo(String deptNo);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年4月25日 下午2:13:28
	 * 方法介绍:   获取当前部门下子部门与部门人员
	 * 参数说明:   @param deptId 部门id
	 * 参数说明:   @return
	 * @return     List<Department> 返回部门信息
	 */
	public List<Department> getChDeptUser(int deptId);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月2日 下午3:52:49
	 * 方法介绍:   获取部门人员
	 * 参数说明:   @param deptId 部门id
	 * 参数说明:   @return
	 * @return     List<Department> 返回部门信息
	 */
	public List<Department> getChDtUser(int deptId);
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
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年7月4日 上午9:04:34
	 * 方法介绍:   按层级获取所有部门
	 */
	public List<Department> listDept();

	List<Department> listDept(Map<String,Object> maps);

    List<Department> getFatherChildDept();

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2016年6月3日 下午4:02:05
	 * 方法介绍:   根据dept串获取用户姓名
	 * 参数说明:   @param uids  用户uid串
	 * 参数说明:   @return
	 *
	 * @return List<String>  返回用户姓名串
	 */
	public String getDeptNameByDeptId(String deptId,String flag);

	public String getDeptNoByDeptId(String deptId, String flag);

	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月2日 下午3:52:49
	 * 方法介绍:   获取一级部门
	 * 参数说明:   @param deptNo获取一级部门
	 * 参数说明:   @return
	 * @return     List<Department> 返回部门信息
	 */
	public Department getFirstDept(String deptNo);

	public String longDepName(int deptId);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月3日 下午19:21:05
	 * 方法介绍:   根据部门id进行批量修改部门主管和部门助理
	 * 参数说明:   @param departments
	 * 参数说明:   @return int 修改条数
	 *
	 * @return List<String>  返回用户姓名串
	 */
	public ToJson<Department> batchUpdateDeptById(String departments);



	public ToJson<Department> selByLikeDeptNameAndDeptNo(String deptName,String deptNo);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月3日 下午19:21:05
	 * 方法介绍:   修正部门级次（排序号）
	 * 参数说明:   @param departments
	 * @return ToJson
	 */
	public void updateDeptNo(Integer deptParent,String deptParentNo);


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月5日 下午10:07:50
	 * 方法介绍:   部门信息导出
	 */
	public  ToJson<Department> outputDepartment(HttpServletRequest request, HttpServletResponse response);


	public List<Department> getAllDep(int deptId,int deptParent, List<Department> allDep);

	public boolean checkDep(Department department,int edit);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月4日 下午18:00:05
	 * 方法介绍:   获取所有部门信息
	 * @return List<Department>
	 */
	public ToJson<Department> getAllDepartment();

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月19日 下午18:00:05
	 * 方法介绍:   判断该部门是否有人
	 * @return ToJson<Department>
	 */
	public int judgeHashUser(String deptId);
	
	/**
	 * @作者：张航宁
	 * @时间：2017/7/25
	 * @介绍：获取所有的部分和人员信息，主要对应PC端使用
	 * @参数：无
	 */
	public ToJson<Department> getAllDepartAndUsers(HttpServletRequest request, HttpServletResponse response);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月1日 下午10:05:05
	 * 方法介绍:   根据部门id设置分级机构和分级机构管理员
	 * @return String
	 */
	public ToJson<Department> setClassifyOrgByDeptId(String deptIds,String classifyOrgAdmin,int classifyOrg);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月1日 下午10:14:05
	 * 方法介绍:   获取分级机构信息
	 * @return String
	 */
	public ToJson<Department> getAllClassifyOrg();

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月1日 下午16:57:05
	 * 方法介绍:   根据权限获取分级机构信息(分级机构管理员)
	 * @return String
	 */
	public ToJson<Department> getClassifyOrgByAdmin(HttpServletRequest request);

	public List<Department> getDepartmentByParet();

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月28日 下午11:25:05
	 * 方法介绍:   根据父部门id判断是否有分级机构
	 * @return String
	 */
	public int selClaNumByParentId(int deptId);


	public List<Department> getDepByNo(String deptNo);

	public List<Department> getDepByCode(String deptCode);

	
	/**
	 * 作者: 张航宁
	 * 日期: 2017/10/20
	 * 说明: 导入
	 */
	public ToJson<Department> importDepartment(HttpServletRequest request,HttpServletResponse response,MultipartFile file);


	/**
	 * 根据父部门查询其子部门编号是否重复
	 * @param deptParent
	 * @return
	 */
	public ToJson<Department> selDeptNoByDeptParent(String deptParent,String deptNo,int editFlag,String proDeptNo);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年11月4日 下午10:22:51
	 * 方法介绍:   获取根据部门名称模糊查询
	 * 参数说明:   @return
	 * @return     List<Department> 返回部门信息
	 */
	public ToJson<Department> selByLikeDeptName(String deptName);

	/**
	 * 牛江丽，获取所有子部门
	 */
	public ToJson<Department>  getAllChildDept(Integer deptId);

	public ToJson<Department> getDepartmentYj();

	public ToJson<Department> settingInfoList();

	public ToJson settingAdd(String deptId,String smsGateAccount);

	public ToJson settingDel(String deptId);

	String getDpNameByIds(String s,String flag);

	String getDParentNameByIds(String s, String s1);

	Department queryDeptParent(Integer deptId);

	public ToJson getDepartment(Integer deptId);

	public String getByDeptName(Integer deptId,String resultStr);

	String getByDeptName(Integer deptParentId,String deptNo,String resultName);

	public List<Integer> getDeptByDeptNoStr(String[] deptNo);

	public List<Department>  getDepartmentByClassifyOrg(Users user, boolean flag,boolean deptIdOtherFlag);


	/**
	 *  返回值为0，则系统没有开启分级机构
	 *  返回值为1，系统开启了分级机构并且用户为管理员或是拥有全局查看权限
	 *  返回值为2，系统开启了分级机构但用户不是管理员并且没有全局查看权限
	 */
	public int checkOrgFlag(Users user);

	LimsJson<Department> userDeptOrder(Integer userId);

	LimsJson<Department> userUpdata();

	LimsJson<UserDeptOrder> deptOrder(String userId);

	LimsJson<UserDeptOrder> updeptOrder(String userDeptOrders);
	//查询是否存在未分配部门
	public ToJson<Department> selectUnallocated();
	//将部门设置未未分配部门
	public ToJson updateDept(Integer deptId);

	String longDepNames(Integer deptId);

    ToJson getDeptTop(HttpServletRequest request);

	ToJson getChildDept(HttpServletRequest request,Integer deptId);

	/**
	 * 创建作者: 金帅强
	 * 创建时间: 2022/10/11
	 * 方法介绍: 查询本部门的所有上级
	 * 参数说明: [request, deptId]
	 * 返回值说明: com.xoa.util.ToJson
	 **/
	ToJson<Department> selectDepartmentTop(Integer deptId);

	//获取部门类型的判断
	public ToJson getDeptByType(HttpServletRequest request,Department department);
	//导出部门信息 树形结构
	ToJson exportDeptInfo(HttpServletRequest request, HttpServletResponse response);

	List<Map<String, Object>> getDeptByManyMap(Map map);

	//更改人员权限控制
	ToJson ifJurisdiction(HttpServletRequest request, String updateUserId, Integer deptId, String deptIdOther);

	// 获取当前用户，管理的分支机构（包含管理范围）
    List<Department> getDepartmentByClassifyOrg1(Users users, boolean flag);

    ToJson<UserPriv> addOtherDeptByUserIds(String userId, String deptIds);

	ToJson<UserPriv> deleteOtherDeptByUserIds(String userId, String deptIds);

	// 获取用户的部门使用权限
    List<Department> getUseDepartmentByUser(Users users);

	ToJson<Department> getUseDepartmentByUser(HttpServletRequest request);

	ToJson selectDeptOther(HttpServletRequest request,String userId);
}
