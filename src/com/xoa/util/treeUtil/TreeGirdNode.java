package com.xoa.util.treeUtil;

import java.util.List;


/**
 * 
 * @ClassName (类名):  TreeNode
 * @Description(简述): 树形结构类
 * @author(作者):      ys
 * @date(日期):        2017-4-17 下午4:34:07
 *
 */
public class TreeGirdNode {
	private String id;
	
	
	private String text;
	private String deptNames;
	private String roleNames;
	private String userNames;
	private String parentId;
	private List<TreeGirdNode>  children;


	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	/**
	 * @return the deptNames
	 */
	public String getDeptNames() {
		return deptNames;
	}

	/**
	 * @param deptNames the deptNames to set
	 */
	public void setDeptNames(String deptNames) {
		this.deptNames = deptNames;
	}

	/**
	 * @return the roleNames
	 */
	public String getRoleNames() {
		return roleNames;
	}

	/**
	 * @param roleNames the roleNames to set
	 */
	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}

	/**
	 * @return the userNames
	 */
	public String getUserNames() {
		return userNames;
	}

	/**
	 * @param userNames the userNames to set
	 */
	public void setUserNames(String userNames) {
		this.userNames = userNames;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	


	

	public List<TreeGirdNode> getChildren() {
		return children;
	}

	public void setChildren(List<TreeGirdNode> children) {
		this.children = children;
	}

	/**
	 * @return the text
	 */
	public String getText() {
		return text;
	}

	/**
	 * @param text the text to set
	 */
	public void setText(String text) {
		this.text = text;
	}

	
	
}
