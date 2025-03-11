package com.xoa.util.page;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午11:05:46
 * 类介绍  :   分页插件工具
 * 构造参数:   
 *
 */
public class PageParams {
	/**
	 * 当前页
	 */
	private Integer page;
	
	/**
	 * 每页限制条数
	 */
	private Integer pageSize;
	/**
	 * 是否启动插件，如果不启动，则不作分页
	 */
	private Boolean useFlag;
	/**
	 * 是否检测页码的有效性，如果为true，而页码大于最大页数，则抛出异常 默认为false
	 */
	private Boolean checkFlag;
	/**
	 * 是否清除最后order by 后面的语句
	 */
	private Boolean cleanOrderBy;
	/**
	 *  总条数
	 */
	private Integer total; 
	/**
	 * 总页数
	 */
	private Integer totalPage;

	public PageParams(){
	}

	public PageParams(boolean useFlag ,Integer page, Integer pageSize){
		this.useFlag = useFlag;
		this.page = page;
		this.pageSize = pageSize;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:05:56
	 * 方法介绍:   当前页
	 * 参数说明:   @return
	 * @return     Integer
	 */
	public Integer getPage() {
		return page;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:06:07
	 * 方法介绍:   当前页
	 * 参数说明:   @param page
	 * @return     void
	 */
	public void setPage(Integer page) {
		this.page = page;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:06:15
	 * 方法介绍:   每页限制条数
	 * 参数说明:   @return
	 * @return     Integer
	 */
	public Integer getPageSize() {
		return pageSize;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:06:27
	 * 方法介绍:   每页限制条数
	 * 参数说明:   @param pageSize
	 * @return     void
	 */
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:06:37
	 * 方法介绍:   是否启动插件，如果不启动，则不作分页
	 * 参数说明:   @return
	 * @return     Boolean
	 */
	public Boolean getUseFlag() {
		return useFlag;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:06:48
	 * 方法介绍:   是否启动插件，如果不启动，则不作分页
	 * 参数说明:   @param useFlag
	 * @return     void
	 */
	public void setUseFlag(Boolean useFlag) {
		this.useFlag = useFlag;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:06:57
	 * 方法介绍:   是否检测页码的有效性，如果为true，而页码大于最大页数，则抛出异常
	 * 参数说明:   @return
	 * @return     Boolean
	 */
	public Boolean getCheckFlag() {
		return checkFlag;
	}

	/**
	 * 是否检测页码的有效性，如果为true，而页码大于最大页数，则抛出异常
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:07:09
	 * 方法介绍:   
	 * 参数说明:   @param checkFlag
	 * @return     void
	 */
	public void setCheckFlag(Boolean checkFlag) {
		if(checkFlag == null){
			this.checkFlag = false;
		}else{
		this.checkFlag = checkFlag;
		}
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:07:22
	 * 方法介绍:   是否清除最后order by 后面的语句
	 * 参数说明:   @return
	 * @return     Boolean
	 */
	public Boolean getCleanOrderBy() {
		return cleanOrderBy;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:07:31
	 * 方法介绍:   是否清除最后order by 后面的语句
	 * 参数说明:   @param cleanOrderBy
	 * @return     void
	 */
	public void setCleanOrderBy(Boolean cleanOrderBy) {
		this.cleanOrderBy = cleanOrderBy;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:07:41
	 * 方法介绍:   总条数
	 * 参数说明:   @return
	 * @return     Integer
	 */
	public Integer getTotal() {
		return total;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:07:50
	 * 方法介绍:   总条数
	 * 参数说明:   @param total
	 * @return     void
	 */
	public void setTotal(Integer total) {
		this.total = total;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:07:59
	 * 方法介绍:   总页数
	 * 参数说明:   @return
	 * @return     Integer
	 */
	public Integer getTotalPage() {
		return totalPage;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-20 上午11:08:08
	 * 方法介绍:   总页数
	 * 参数说明:   @param totalPage
	 * @return     void
	 */
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

}
