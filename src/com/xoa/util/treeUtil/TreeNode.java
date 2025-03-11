package com.xoa.util.treeUtil;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 
 * @ClassName (类名):  TreeNode
 * @Description(简述): 树形结构类
 * @author(作者):      ys
 * @date(日期):        2017-4-17 下午4:34:07
 *
 */
public class TreeNode {
	private String id;
	
	private String dataId;
	
	private String text;
	private String deptNames;
	private String roleNames;
	private String userNames;
	private String url;
	
	private String state;//value closed,open
	
	private boolean checked; //
	
	private String parentId;//父节点ID
	
	private Map<String,Object> attributes = new HashMap<String, Object>();
	
	private List<TreeNode>  children;
	
	

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

	

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public  String getParentId() {
		return parentId;
	}

	public void setParentId( String parentId) {
		this.parentId = parentId;
	}

	public String getDataId() {
		return dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public List<TreeNode> getChildren() {
		return children;
	}

	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}

	public Map<String, Object> getAttributes() {
		return attributes;
	}

	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
}
