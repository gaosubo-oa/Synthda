package com.xoa.controller.hierarchical;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017-8-31 上午17:22:15
 * 类介绍:    分级机构管理
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/hierarchical")
public class HCommonController {

	@RequestMapping("/common/setting")
	public String setting() {
		return "app/hierarchical/setting";
	}

	@RequestMapping("/common/deptManager")
	public String deptManager() {
		return "app/hierarchical/deptManager";
	}

	@RequestMapping("/common/userManager")
	public String userManager() {
		return "app/hierarchical/userManager";
	}

	@RequestMapping("/common/roleManager")
	public String roleManager() {
		return "app/hierarchical/roleManager";
	}
	@RequestMapping("/common/modifyThePermissions")
	public String modifyThePermissions() {
		return "app/hierarchical/modifyThePermissions";
	}

	//分支机构角色与权限管理
	@RequestMapping("/common/permission")
	public String permission() {
		return "app/hierarchical/permission";
	}

	//角色克隆
	@RequestMapping("/common/character")
	public String character() {
		return "app/hierarchical/character";
	}

	//辅助角色批量设置
	@RequestMapping("/userPriv/batchSetAuxiliaryRole")
	public String batchSetAuxiliaryRole() {
		return "app/UserPriv/batchSetAuxiliaryRole";
	}
}
