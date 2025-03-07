package com.xoa.controller.hierarchical;

import com.xoa.model.department.Department;
import com.xoa.service.department.DepartmentService;
import com.xoa.util.ToJson;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017-8-31 上午17:22:15
 * 类介绍:    分级机构设置
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/hierarchical")
public class HSettingController {
	@Resource
	private DepartmentService departmentService;


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月1日 下午10:05:05
	 * 方法介绍:   根据部门id设置分级机构和分级机构管理员
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/setClassifyOrgByDeptId")
	public ToJson<Department> setClassifyOrgByDeptId(String deptIds,String classifyOrgAdmin,int classifyOrg){
		return departmentService.setClassifyOrgByDeptId(deptIds,classifyOrgAdmin,classifyOrg);
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月1日 下午10:14:05
	 * 方法介绍:   获取分级机构信息
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/getAllClassifyOrg")
	public ToJson<Department> getAllClassifyOrg(){
		return departmentService.getAllClassifyOrg();
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年9月1日 下午10:14:05
	 * 方法介绍:   获取分级机构信息
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/getClassifyOrgByAdmin")
	public ToJson<Department> getClassifyOrgByAdmin(HttpServletRequest request){
		return departmentService.getClassifyOrgByAdmin(request);
	}

}
