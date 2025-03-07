package com.xoa.model.sys;


import com.xoa.model.enclosure.Attachment;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class InterfaceModel implements Serializable {
    /**
     * IE浏览器窗口标题
     */
    private String ieTitle;

    /**
     * 状态栏文字
     */
    private String statusText;

    public String getStatusText() {
        return statusText;
    }

    public void setStatusText(String statusText) {
        this.statusText = statusText;
    }

    /**
     * 主界面顶部大标题文字
     */
    private String bannerText;

    /**
     * 字体
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
     * 是否允许用户选择界面主题(1-允许,0-不允许)
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

    private String weatherCity;

    /**
     * 允许用户使用今日资讯
     */
    private String showRss;

    /**
     * 在设置顶部图标时增加是否应用到tos
     */
    private Integer imgTos;

    private  String attachmentId2;

    private  String attachmentName2;

    private  String loginLiterals;

    private  String notifyText;

    private  String loginValidation;

    private  String attachmentId3;

    private  String attachmentName3;

    private  String attachmentId4;

    private  String attachmentName4;

    private  String judgeAttachmentUrl;

    private String mobileWatermark; // 是否开启或关闭移动端水印(1:开启  0:关闭)

    private String blackTheme; // 黑色主题（0-关，1-开）

    private String workFlowWaterMark; // 工作流相关界面开启水印 存储在sysPara表中

    public String getWorkFlowWaterMark() {
        return workFlowWaterMark;
    }

    public void setWorkFlowWaterMark(String workFlowWaterMark) {
        this.workFlowWaterMark = workFlowWaterMark;
    }

    public String getMobileWatermark() {
        return mobileWatermark;
    }

    public void setMobileWatermark(String mobileWatermark) {
        this.mobileWatermark = mobileWatermark;
    }

    public String getJudgeAttachmentUrl() {
        return judgeAttachmentUrl;
    }

    public void setJudgeAttachmentUrl(String judgeAttachmentUrl) {
        this.judgeAttachmentUrl = judgeAttachmentUrl;
    }

    public String getAttachmentId3() {
        return attachmentId3;
    }

    public void setAttachmentId3(String attachmentId3) {
        this.attachmentId3 = attachmentId3;
    }

    public String getAttachmentName3() {
        return attachmentName3;
    }

    public void setAttachmentName3(String attachmentName3) {
        this.attachmentName3 = attachmentName3;
    }

    public String getAttachmentId4() {
        return attachmentId4;
    }

    public void setAttachmentId4(String attachmentId4) {
        this.attachmentId4 = attachmentId4;
    }

    public String getAttachmentName4() {
        return attachmentName4;
    }

    public void setAttachmentName4(String attachmentName4) {
        this.attachmentName4 = attachmentName4;
    }

    //验证
    public String getLoginValidation() {
        return loginValidation;
    }

    public void setLoginValidation(String loginValidation) {
        this.loginValidation = loginValidation;
    }

    /**
     * 附件对象
     */
    private List<Attachment> attachment=new ArrayList<Attachment>();

    /**
     * 附件对象
     */
    private List<Attachment> attachment2=new ArrayList<Attachment>();

    /**
     * 附件对象
     */
    private List<Attachment> attachment3=new ArrayList<Attachment>();


    /**
     * 附件对象
     */
    private List<Attachment> attachment4=new ArrayList<Attachment>();

    public List<Attachment> getAttachment3() {
        return attachment3;
    }

    public void setAttachment3(List<Attachment> attachment3) {
        this.attachment3 = attachment3;
    }

    public List<Attachment> getAttachment4() {
        return attachment4;
    }

    public void setAttachment4(List<Attachment> attachment4) {
        this.attachment4 = attachment4;
    }

    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    public List<Attachment> getAttachment2() {
        return attachment2;
    }

    public void setAttachment2(List<Attachment> attachment2) {
        this.attachment2 = attachment2;
    }

    public String getAttachmentId2() {
        return attachmentId2;
    }

    public void setAttachmentId2(String attachmentId2) {
        this.attachmentId2 = attachmentId2;
    }

    public String getAttachmentName2() {
        return attachmentName2;
    }

    public void setAttachmentName2(String attachmentName2) {
        this.attachmentName2 = attachmentName2;
    }

    public String getLoginLiterals() {
        return loginLiterals;
    }

    public void setLoginLiterals(String loginLiterals) {
        this.loginLiterals = loginLiterals;
    }



    public String getNotifyText() {
        return notifyText==null ? "":notifyText.trim();
    }

    public void setNotifyText(String notifyText) {
        this.notifyText = notifyText;
    }

    public String getLogOutText() {
        return logOutText;
    }

    public void setLogOutText(String logOutText) {
        this.logOutText = logOutText;
    }

    /**
     * 添加一个字段interface表没有，用于封装数据,这个字段对应的数据在sys_para表
     */

    private String logOutText;

    private  String  fileNumber;

    private String title;

    private String userName; // 用户名
    private String mobilNo; // 手机号

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMobilNo() {
        return mobilNo;
    }

    public void setMobilNo(String mobilNo) {
        this.mobilNo = mobilNo;
    }

    public String getFileNumber() {
        return fileNumber;
    }

    public void setFileNumber(String fileNumber) {
        this.fileNumber = fileNumber;
    }

    private static final long serialVersionUID = 1L;

    public String getIeTitle() {
        return ieTitle;
    }

    public void setIeTitle(String ieTitle) {
        this.ieTitle = ieTitle == null ? "" : ieTitle.trim();
    }

    public String getBannerText() {
        return bannerText;
    }

    public void setBannerText(String bannerText) {
        this.bannerText = bannerText == null ? "" : bannerText.trim();
    }

    public String getBannerFont() {
        return bannerFont;
    }

    public void setBannerFont(String bannerFont) {
        this.bannerFont = bannerFont == null ? "" : bannerFont.trim();
    }

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId == null ? "" : attachmentId.trim();
    }

    public String getAttachmentName() {
        return attachmentName== null ? "" : attachmentName.trim();
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName == null ? "" : attachmentName.trim();
    }

    public Integer getImgWidth() {
        return imgWidth;
    }

    public void setImgWidth(Integer imgWidth) {
        this.imgWidth = imgWidth;
    }

    public Integer getImgHeight() {
        return imgHeight;
    }

    public void setImgHeight(Integer imgHeight) {
        this.imgHeight = imgHeight;
    }

    public String getAttachmentId1() {
        return attachmentId1== null ? "" : attachmentId1.trim();
    }

    public void setAttachmentId1(String attachmentId1) {
        this.attachmentId1 = attachmentId1 == null ? "" : attachmentId1.trim();
    }

    public String getAttachmentName1() {
        return attachmentName1== null ? "" : attachmentName1.trim();
    }

    public void setAttachmentName1(String attachmentName1) {
        this.attachmentName1 = attachmentName1 == null ? "" : attachmentName1.trim();
    }

    public String getAvatarUpload() {
        return avatarUpload== null ? "" : avatarUpload.trim();
    }

    public void setAvatarUpload(String avatarUpload) {
        this.avatarUpload = avatarUpload == null ? "" : avatarUpload.trim();
    }

    public Integer getAvatarWidth() {
        return avatarWidth;
    }

    public void setAvatarWidth(Integer avatarWidth) {
        this.avatarWidth = avatarWidth;
    }

    public Integer getAvatarHeight() {
        return avatarHeight;
    }

    public void setAvatarHeight(Integer avatarHeight) {
        this.avatarHeight = avatarHeight;
    }

    public String getLoginInterface() {
        return loginInterface== null ? "" : loginInterface.trim();
    }

    public void setLoginInterface(String loginInterface) {
        this.loginInterface = loginInterface == null ? "" : loginInterface.trim();
    }

    public String getUi() {
        return ui== null ? "" : ui.trim();
    }

    public void setUi(String ui) {
        this.ui = ui == null ? "" : ui.trim();
    }

    public String getThemeSelect() {
        return themeSelect== null ? "" : themeSelect.trim();
    }

    public void setThemeSelect(String themeSelect) {
        this.themeSelect = themeSelect == null ? "" : themeSelect.trim();
    }

    public String getTheme() {
        return theme == null ? "" : theme.trim();
    }

    public void setTheme(String theme) {
        this.theme = theme == null ? "" : theme.trim();
    }

    public String getTemplate() {
        return template== null ? "" : template.trim();
    }

    public void setTemplate(String template) {
        this.template = template == null ? "" : template.trim();
    }

    public String getWeatherCity() {
        return weatherCity== null ? "" : weatherCity.trim();
    }

    public void setWeatherCity(String weatherCity) {
        this.weatherCity = weatherCity == null ? "" : weatherCity.trim();
    }

    public String getShowRss() {
        return showRss == null ? "": showRss.trim();
    }

    public void setShowRss(String showRss) {
        this.showRss = showRss == null ? "": showRss.trim();
    }

    public Integer getImgTos() {
        return imgTos;
    }

    public void setImgTos(Integer imgTos) {
        this.imgTos = imgTos;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBlackTheme() {
        return blackTheme;
    }

    public void setBlackTheme(String blackTheme) {
        this.blackTheme = blackTheme;
    }
}