package com.xoa.model.menu;

/**
 * 
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-18 下午5:46:46
 * 类介绍   :   APP端菜单
 * 构造参数:   无
 *
 */
public class MobileApp {
	/**
	 * 桌面应用的ID
	 */
	private Integer appId;
	/**
	 * 应用的名称
	 */
	private String appName;
	/**
	 * 应用的类型 system是系统内置不允许改变，vip组件为需要购买，custom是用户可以自己定制的
	 */
	private String appType;
	/**
	 * 应用所代表的模块
	 */
	private String appModule;
	/**
	 * 应用的图标
	 */
	private String appIcon;
	/**
	 * 如果应用是打开连接地址的，则不为空
	 */
	private String appUrl;
	/**
	 * 应用的描述
	 */
	private String appDesc;
	/**
	 * 应用权限
	 */
	private String appPriv;
	
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午5:47:31
	 * 方法介绍:   获得桌面应用的ID
	 * 参数说明:   @return
	 * @return     Integer appId(桌面应用的ID)
	 */
	public Integer getAppId() {
		return appId;
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午5:48:02
	 * 方法介绍:   设置桌面应用的ID
	 * 参数说明:   @param appId
	 * @return     void
	 */
	public void setAppId(Integer appId) {
		this.appId = appId;
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午5:48:18
	 * 方法介绍:   获得应用的名称
	 * 参数说明:   @return
	 * @return     String appName(应用的名称)
	 */
	public String getAppName() {
		return appName;
	}

	
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:02:43
	 * 方法介绍:   设置应用的名称
	 * 参数说明:   @param appName
	 * @return     void
	 */
	public void setAppName(String appName) {
		this.appName = appName == null ? null : appName.trim();
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:11:52
	 * 方法介绍:   获得应用的类型 (system是系统内置不允许改变，vip组件为需要购买，custom是用户可以自己定制的)
	 * 参数说明:   @return
	 * @return     String  appType(应用的类型)
	 */
	public String getAppType() {
		return appType;
	}
    /**
     * 
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午6:13:03
     * 方法介绍:   设置应用的类型 (system是系统内置不允许改变，vip组件为需要购买，custom是用户可以自己定制的)
     * 参数说明:   @param appType
     * @return     void
     */
	public void setAppType(String appType) {
		this.appType = appType == null ? null : appType.trim();
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:13:18
	 * 方法介绍:   获得应用所代表的模块
	 * 参数说明:   @return
	 * @return     String  appModule(应用所代表的模块)
	 */
	public String getAppModule() {
		return appModule;
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:13:46
	 * 方法介绍:   设置应用所代表的模块
	 * 参数说明:   @param appModule
	 * @return     void
	 */
	public void setAppModule(String appModule) {
		this.appModule = appModule == null ? null : appModule.trim();
	}
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:14:11
	 * 方法介绍:   获得应用的图标
	 * 参数说明:   @return
	 * @return     String appIcon(应用的图标)
	 */
	public String getAppIcon() {
		return appIcon;
	}
    /**
     * 
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午6:14:44
     * 方法介绍:   设置应用的图标
     * 参数说明:   @param appIcon
     * @return     void
     */
	public void setAppIcon(String appIcon) {
		this.appIcon = appIcon == null ? null : appIcon.trim();
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:15:06
	 * 方法介绍:   获得如果应用是打开连接地址的，则不为空
	 * 参数说明:   @return
	 * @return     String appUrl(应用连接地址)
	 */
	public String getAppUrl() {
		return appUrl;
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:15:40
	 * 方法介绍:   设置如果应用是打开连接地址的，则不为空
	 * 参数说明:   @param appUrl
	 * @return     void
	 */
	public void setAppUrl(String appUrl) {
		this.appUrl = appUrl == null ? null : appUrl.trim();
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:16:01
	 * 方法介绍:   获得应用的描述
	 * 参数说明:   @return
	 * @return     String  appDesc(应用的描述)
	 */
	public String getAppDesc() {
		return appDesc;
	}
 
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:16:21
	 * 方法介绍:   设置应用的描述
	 * 参数说明:   @param appDesc
	 * @return     void
	 */
	public void setAppDesc(String appDesc) {
		this.appDesc = appDesc == null ? null : appDesc.trim();
	}

	
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:16:32
	 * 方法介绍:   获得应用权限
	 * 参数说明:   @return
	 * @return     String appPriv(应用权限)
	 */
	public String getAppPriv() {
		return appPriv;
	}

	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:17:24
	 * 方法介绍:   设置应用权限
	 * 参数说明:   @param appPriv
	 * @return     void
	 */
	public void setAppPriv(String appPriv) {
		this.appPriv = appPriv == null ? null : appPriv.trim();
	}
}