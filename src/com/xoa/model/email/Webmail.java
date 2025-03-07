package com.xoa.model.email;

import java.io.Serializable;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/12 11:38
 * 方法介绍:   外部邮箱基础信息
 * 参数说明:  
 * @return
 */
public class Webmail implements Serializable{
    private static final long serialVersionUID = -450070141895284911L;

    /**
     * 自增唯一ID
     */
    private Integer mailId;

    /**
     * 邮件地址
     */
    private String email;

    /**
     * 用户USER_ID
     */
    private String userId;

    /**
     * 接收服务器
     */
    private String popServer;

    /**
     * 发送服务器
     */
    private String smtpServer;

    /**
     * 登录类型
     */
    private String loginType;

    /**
     * SMTP需要身份验证
     */
    private String smtpPass;

    /**
     * 登录账户
     */
    private String emailUser;

    /**
     * 登录密码
     */
    private String emailPass;

    /**
     * 接受服务器端口 匹配各种邮箱类型的接收端口
     */
    private Integer pop3Port;

    /**
     * 发送服务器端口 匹配各种邮箱类型的发送端口
     */
    private Integer smtpPort;

    /**
     * 是否默认邮箱(1-是,0-不是) 默认为 0
     */
    private String isDefault;

    /**
     * 此服务器要求SSL安全连接(1-是,0-不是) 默认为 0
     */
    private String pop3Ssl;

    /**
     * 此服务器要求SSL安全连接(1-是,0-不是) 默认为 0
     */
    private String smtpSsl;

    /**
     * 邮箱容量 默认为0-不限制
     */
    private Integer quotaLimit;

    /**
     *  自动收取外部邮件(1-是,0-否)
     */
    private String checkFlag;

    /**
     * 优先级 默认为 0
     */
    private String priority;

    /**
     * 收信删设置 默认为 0
     */
    private String recvDel;

    /**
     * 新邮件提醒设置 默认为 1
     */
    private String recvRemind;

    /**
     * 转发设置
     */
    private String recvFw;

    /**
     * 创建者id  可为空
     */
    private String createUser;

    /**
     * 外部邮件ID串
     */
    private String emailUid;


    /**
     * 自增唯一ID
     * @return
     */
    public Integer getMailId() {
        return mailId;
    }

    /**
     * 自增唯一ID
     * @param mailId
     */
    public void setMailId(Integer mailId) {
        this.mailId = mailId;
    }

    /**
     * 邮件地址
     * @return
     */
    public String getEmail() {
        return email ;
    }

    /**
     *  邮件地址
     * @param email
     */
    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    /**
     *  用户USER_ID
     * @return
     */
    public String getUserId() {
        return userId ;
    }

    /**
     * 用户USER_ID
     * @param userId
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /**
     * 接收服务器
     * @return
     */
    public String getPopServer() {
        return popServer;
    }

    /**
     * 接收服务器
     * @param popServer
     */
    public void setPopServer(String popServer) {
        this.popServer = popServer == null ? null : popServer.trim();
    }

    /**
     * 发送服务器
     * @return
     */
    public String getSmtpServer() {
        return smtpServer;
    }

    /**
     * 发送服务器
     * @param smtpServer
     */
    public void setSmtpServer(String smtpServer) {
        this.smtpServer = smtpServer == null ? null : smtpServer.trim();
    }

    /**
     * 登录类型
     * @return
     */
    public String getLoginType() {
        return loginType == null ? "":loginType.trim();
    }

    /**
     * 登录类型
     * @param loginType
     */
    public void setLoginType(String loginType) {
        this.loginType = loginType == null ? null : loginType.trim();
    }

    /**
     * SMTP需要身份验证
     * @return
     */
    public String getSmtpPass() {
        return smtpPass;
    }

    /**
     * SMTP需要身份验证
     * @param smtpPass
     */
    public void setSmtpPass(String smtpPass) {
        this.smtpPass = smtpPass == null ? null : smtpPass.trim();
    }

    /**
     * 登录账户
     * @return
     */
    public String getEmailUser() {
        return emailUser;
    }

    /**
     * 登录账户
     * @param emailUser
     */
    public void setEmailUser(String emailUser) {
        this.emailUser = emailUser == null ? null : emailUser.trim();
    }

    /**
     * 登录密码
     * @return
     */
    public String getEmailPass() {
        return emailPass;
    }

    /**
     * 登录密码
     * @param emailPass
     */
    public void setEmailPass(String emailPass) {
        this.emailPass = emailPass == null ? null : emailPass.trim();
    }

    /**
     * 接受服务器端口 匹配各种邮箱类型的接收端口
     * @return
     */
    public Integer getPop3Port() {
        return pop3Port;
    }

    /**
     * 接受服务器端口 匹配各种邮箱类型的接收端口
     * @param pop3Port
     */
    public void setPop3Port(Integer pop3Port) {
        this.pop3Port = pop3Port;
    }

    /**
     * 发送服务器端口 匹配各种邮箱类型的发送端口
     * @return
     */
    public Integer getSmtpPort() {
        return smtpPort;
    }

    /**
     * 发送服务器端口 匹配各种邮箱类型的发送端口
     * @param smtpPort
     */
    public void setSmtpPort(Integer smtpPort) {
        this.smtpPort = smtpPort;
    }

    /**
     * 是否默认邮箱(1-是,0-不是) 默认为 0
     * @return
     */
    public String getIsDefault() {
        return isDefault == null ? "0":isDefault.trim();
    }

    /**
     * 是否默认邮箱(1-是,0-不是) 默认为 0
     * @param isDefault
     */
    public void setIsDefault(String isDefault) {
        this.isDefault = isDefault == null ? null : isDefault.trim();
    }

    /**
     * 此服务器要求SSL安全连接(1-是,0-不是) 默认为 0
     * @return
     */
    public String getPop3Ssl() {
        return pop3Ssl == null ? "0":pop3Ssl.trim();
    }

    /**
     *  此服务器要求SSL安全连接(1-是,0-不是) 默认为 0
     * @param pop3Ssl
     */
    public void setPop3Ssl(String pop3Ssl) {
        this.pop3Ssl = pop3Ssl == null ? null : pop3Ssl.trim();
    }

    /**
     *  此服务器要求SSL安全连接(1-是,0-不是) 默认为 0
     * @return
     */
    public String getSmtpSsl() {
        return smtpSsl == null ? "0" : smtpSsl.trim();
    }

    /**
     *  此服务器要求SSL安全连接(1-是,0-不是) 默认为 0
     * @param smtpSsl
     */
    public void setSmtpSsl(String smtpSsl) {
        this.smtpSsl = smtpSsl == null ? null : smtpSsl.trim();
    }

    /**
     * 邮箱容量 默认为0-不限制
     * @return
     */
    public Integer getQuotaLimit() {
        return quotaLimit == null ? 0:quotaLimit;
    }

    /**
     * 邮箱容量 默认为0-不限制
     * @param quotaLimit
     */
    public void setQuotaLimit(Integer quotaLimit) {
        this.quotaLimit = quotaLimit;
    }

    /**
     * 自动收取外部邮件(1-是,0-否)
     * @return
     */
    public String getCheckFlag() {
        return checkFlag;
    }

    /**
     * 自动收取外部邮件(1-是,0-否)
     * @param checkFlag
     */
    public void setCheckFlag(String checkFlag) {
        this.checkFlag = checkFlag == null ? null : checkFlag.trim();
    }

    /**
     * 优先级 默认为 0
     * @return
     */
    public String getPriority() {
        return priority == null ? "0":priority.trim();
    }

    /**
     * 优先级 默认为 0
     * @param priority
     */
    public void setPriority(String priority) {
        this.priority = priority == null ? null : priority.trim();
    }

    /**
     * 收信删设置 默认为 0
     * @return
     */
    public String getRecvDel() {
        return recvDel == null ? "0" : recvDel.trim();
    }

    /**
     * 收信删设置 默认为 0
     * @param recvDel
     */
    public void setRecvDel(String recvDel) {
        this.recvDel = recvDel == null ? null : recvDel.trim();
    }

    /**
     * 新邮件提醒设置 默认为 1
     * @return
     */
    public String getRecvRemind() {
        return recvRemind == null ? "1":recvRemind.trim();
    }

    /**
     * 新邮件提醒设置 默认为 1
     * @param recvRemind
     */
    public void setRecvRemind(String recvRemind) {
        this.recvRemind = recvRemind == null ? null : recvRemind.trim();
    }

    /**
     * 转发设置
     * @return
     */
    public String getRecvFw() {
        return recvFw == null ? "" : recvFw.trim();
    }

    /**
     * 转发设置
     * @param recvFw
     */
    public void setRecvFw(String recvFw) {
        this.recvFw = recvFw == null ? null : recvFw.trim();
    }

    /**
     * 创建者id 可为空
     * @return
     */
    public String getCreateUser() {
        return createUser == null ? "": createUser.trim();
    }

    /**
     * 创建者id 可为空
     * @param createUser
     */
    public void setCreateUser(String createUser) {
        this.createUser = createUser == null ? null : createUser.trim();
    }

    /**
     * 外部邮件ID串
     * @return
     */
    public String getEmailUid() {
        return emailUid == null ? "":emailUid.trim();
    }

    /**
     * 外部邮件ID串
     * @param emailUid
     */
    public void setEmailUid(String emailUid) {
        this.emailUid = emailUid == null ? null : emailUid.trim();
    }
}