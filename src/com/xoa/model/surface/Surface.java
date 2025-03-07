package com.xoa.model.surface;

public class Surface {
	/**
	 * IE浏览器窗口标题
	 */
    private String ieTitle;
    /**
     * 主界面顶部大标题文字
     */
    private String bannerText;
    /**
     *  字体
     */
    private String bannerFont;
    /**
     * 主界面顶部图标ID
     */
    private String attachmentId;
    /**
     * 主界面顶部图标NAME
     */
    private String attachmentName;
    /**
     * 主界面顶部图标宽度
     */
    private Integer imgWidth;
    /**
     * 主界面顶部图标高度
     */
    private Integer imgHeight;
    /**
     * 登录界面图片ID
     */
    private String attachmentId1;
    /**
     * 登录界面图片NAME
     */
    private String attachmentName1;
    /**
     * 允许用户上传头像(1-允许,0-不允许)
     */
    private String avatarUpload;
    /**
     * 用户上传头像最大宽度
     */
    private Integer avatarWidth;
    /**
     * 用户上传头像最大高度
     */
    private Integer avatarHeight;
    /**
     * 选择界面布局
     */
    private String loginInterface;
    /**
     * 默认界面布局
     */
    private String ui;
    /**
     *是否允许用户选择界面主题(1-允许,0-不允许)
     */
    private String themeSelect;
    /**
     * 默认界面主题
     */
    private String theme;
    /**
     * 登录界面模板
     */
    private String template;
    /**
     * 
     */
    private String weatherCity;
    /**
     * 允许用户使用今日资讯
     */
    private String showRss;
    /**
     * 在设置顶部图标时增加是否应用到tos
     */
    private Boolean imgTos;
    /**
     * 主界面底部状态栏置中文字
     */
    private String statusText;
    /**
     * 紧急通知内容
     */
    private String notifyText;
    /**
     * 
     * @Title: getStatusText
     * @Description: 获取主界面底部状态栏置中文字
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getStatusText() {
        return statusText;
    }
    /**
     * 
     * @Title: setStatusText
     * @Description: 设置主界面底部状态栏置中文字并做判断
     * @author(作者): 张丽军
     * @param: @param statusText   
     * @return: void   
     * @throws
     */
    public void setStatusText(String statusText) {
        this.statusText = statusText == null ? null : statusText.trim();
    }
    /**
     * 
     * @Title: getNotifyText
     * @Description: 获取紧急通知内容
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getNotifyText() {
        return notifyText;
    }
    /**
     * 
     * @Title: setNotifyText
     * @Description: 设置紧急通知内容
     * @author(作者): 张丽军
     * @param: @param notifyText   
     * @return: void   
     * @throws
     */
    public void setNotifyText(String notifyText) {
        this.notifyText = notifyText == null ? null : notifyText.trim();
    }
    /**
     * 
     * @Title: getIeTitle
     * @Description: 获取IE浏览器窗口标题
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getIeTitle() {
        return ieTitle;
    }
    /**
     * 
     * @Title: setIeTitle
     * @Description: 设置IE浏览器窗口标题
     * @author(作者): 张丽军
     * @param: @param ieTitle   
     * @return: void   
     * @throws
     */
    public void setIeTitle(String ieTitle) {
        this.ieTitle = ieTitle == null ? null : ieTitle.trim();
    }
    /**
     * 
     * @Title: getBannerText
     * @Description: 获取主界面顶部大标题文字
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getBannerText() {
        return bannerText;
    }
    /**
     * 
     * @Title: setBannerText
     * @Description: 设置主界面顶部大标题文字
     * @author(作者): 张丽军
     * @param: @param bannerText   
     * @return: void   
     * @throws
     */
    public void setBannerText(String bannerText) {
        this.bannerText = bannerText == null ? null : bannerText.trim();
    }
    /**
     * 
     * @Title: getBannerFont
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getBannerFont() {
        return bannerFont;
    }
    /**
     * 
     * @Title: setBannerFont
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param bannerFont   
     * @return: void   
     * @throws
     */
    public void setBannerFont(String bannerFont) {
        this.bannerFont = bannerFont == null ? null : bannerFont.trim();
    }
    /**
     * 
     * @Title: getAttachmentId
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getAttachmentId() {
        return attachmentId;
    }
    /**
     * 
     * @Title: setAttachmentId
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param attachmentId   
     * @return: void   
     * @throws
     */
    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId == null ? null : attachmentId.trim();
    }
    /**
     * 
     * @Title: getAttachmentName
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getAttachmentName() {
        return attachmentName;
    }
    /**
     * 
     * @Title: setAttachmentName
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param attachmentName   
     * @return: void   
     * @throws
     */
    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName == null ? null : attachmentName.trim();
    }
    /**
     * 
     * @Title: getImgWidth
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: Integer   
     * @throws
     */
    public Integer getImgWidth() {
        return imgWidth;
    }
    /**
     * 
     * @Title: setImgWidth
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param imgWidth   
     * @return: void   
     * @throws
     */
    public void setImgWidth(Integer imgWidth) {
        this.imgWidth = imgWidth;
    }
    /**
     * 
     * @Title: getImgHeight
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: Integer   
     * @throws
     */
    public Integer getImgHeight() {
        return imgHeight;
    }
    /**
     * 
     * @Title: setImgHeight
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param imgHeight   
     * @return: void   
     * @throws
     */
    public void setImgHeight(Integer imgHeight) {
        this.imgHeight = imgHeight;
    }
    /**
     * 
     * @Title: getAttachmentId1
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getAttachmentId1() {
        return attachmentId1;
    }
    /**
     * 
     * @Title: setAttachmentId1
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param attachmentId1   
     * @return: void   
     * @throws
     */
    public void setAttachmentId1(String attachmentId1) {
        this.attachmentId1 = attachmentId1 == null ? null : attachmentId1.trim();
    }
    /**
     * 
     * @Title: getAttachmentName1
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getAttachmentName1() {
        return attachmentName1;
    }

    public void setAttachmentName1(String attachmentName1) {
        this.attachmentName1 = attachmentName1 == null ? null : attachmentName1.trim();
    }
    /**
     * 
     * @Title: getAvatarUpload
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getAvatarUpload() {
        return avatarUpload;
    }
    /**
     * 
     * @Title: setAvatarUpload
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param avatarUpload   
     * @return: void   
     * @throws
     */
    public void setAvatarUpload(String avatarUpload) {
        this.avatarUpload = avatarUpload == null ? null : avatarUpload.trim();
    }
    /**
     * 
     * @Title: getAvatarWidth
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: Integer   
     * @throws
     */
    public Integer getAvatarWidth() {
        return avatarWidth;
    }
    /**
     * 
     * @Title: setAvatarWidth
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param avatarWidth   
     * @return: void   
     * @throws
     */
    public void setAvatarWidth(Integer avatarWidth) {
        this.avatarWidth = avatarWidth;
    }
    /**
     * 
     * @Title: getAvatarHeight
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: Integer   
     * @throws
     */
    public Integer getAvatarHeight() {
        return avatarHeight;
    }
    /**
     * 
     * @Title: setAvatarHeight
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param avatarHeight   
     * @return: void   
     * @throws
     */
    public void setAvatarHeight(Integer avatarHeight) {
        this.avatarHeight = avatarHeight;
    }
    /**
     * 
     * @Title: getLoginInterface
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getLoginInterface() {
        return loginInterface;
    }
    /**
     * 
     * @Title: setLoginInterface
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param loginInterface   
     * @return: void   
     * @throws
     */
    public void setLoginInterface(String loginInterface) {
        this.loginInterface = loginInterface == null ? null : loginInterface.trim();
    }
    /**
     * 
     * @Title: getUi
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getUi() {
        return ui;
    }
    /**
     * 
     * @Title: setUi
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param ui   
     * @return: void   
     * @throws
     */
    public void setUi(String ui) {
        this.ui = ui == null ? null : ui.trim();
    }
    /**
     * 
     * @Title: getThemeSelect
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getThemeSelect() {
        return themeSelect;
    }
    /**
     * 
     * @Title: setThemeSelect
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param themeSelect   
     * @return: void   
     * @throws
     */
    public void setThemeSelect(String themeSelect) {
        this.themeSelect = themeSelect == null ? null : themeSelect.trim();
    }
    /**
     * 
     * @Title: getTheme
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getTheme() {
        return theme;
    }
    /**
     * 
     * @Title: setTheme
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param theme   
     * @return: void   
     * @throws
     */
    public void setTheme(String theme) {
        this.theme = theme == null ? null : theme.trim();
    }
    /**
     * 
     * @Title: getTemplate
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getTemplate() {
        return template;
    }
    /**
     * 
     * @Title: setTemplate
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param template   
     * @return: void   
     * @throws
     */
    public void setTemplate(String template) {
        this.template = template == null ? null : template.trim();
    }
    /**
     * 
     * @Title: getWeatherCity
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getWeatherCity() {
        return weatherCity;
    }
    /**
     * 
     * @Title: setWeatherCity
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param weatherCity   
     * @return: void   
     * @throws
     */
    public void setWeatherCity(String weatherCity) {
        this.weatherCity = weatherCity == null ? null : weatherCity.trim();
    }
    /**
     * 
     * @Title: getShowRss
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: String   
     * @throws
     */
    public String getShowRss() {
        return showRss;
    }
    /**
     * 
     * @Title: setShowRss
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param showRss   
     * @return: void   
     * @throws
     */
    public void setShowRss(String showRss) {
        this.showRss = showRss == null ? null : showRss.trim();
    }
    /**
     * 
     * @Title: getImgTos
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @return   
     * @return: Boolean   
     * @throws
     */
    public Boolean getImgTos() {
        return imgTos;
    }
    /**
     * 
     * @Title: setImgTos
     * @Description: TODO
     * @author(作者): 张丽军
     * @param: @param imgTos   
     * @return: void   
     * @throws
     */
    public void setImgTos(Boolean imgTos) {
        this.imgTos = imgTos;
    }
}