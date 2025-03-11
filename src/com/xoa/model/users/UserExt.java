package com.xoa.model.users;

import java.io.Serializable;
import java.util.Date;

public class UserExt implements Serializable {
	/**
	 *对应user表的UID
	 */
    private Integer uid;
    /**
	 *对应user表的USER_ID
	 */
    private String userId;
    /**
	 *桌面图标ID串
	 */
    private String tableIcon;
    /**
	 *最近联系人
	 */
    private String emailRecentLinkman;
    /**
	 *昵称
	 */
    private String nickName;
    /**
	 *发表文章数
	 */
    private Integer bbsCounter;
    /**
	 *内部邮箱容量
	 */
    private Integer emailCapacity;
    /**
	 *个人文件柜容量
	 */
    private Integer folderCapacity;
    /**
	 *每个Internet邮箱容量
	 */
    private Integer webmailCapacity;
    /**
	 *可使用Internet邮箱数量
	 */
    private Integer webmailNum;
    /**
	 *OA知道积分
	 */
    private Integer score;
    /**
	 *OA知道管理员标识
	 */
    private String tderFlag;
    /**
	 *考勤排班类型(1-正常班,2-全日班,99-轮班制)
	 */
    private Short dutyType;
    /**
	 *是否启用POP3功能(1-是,0-否)
	 */
    private Integer usePop3;
    /**
	 *是否开启POP3功能(1-是,0-否)
	 */
    private Integer isUsePop3;
    /**
	 *密码验证
	 */
    private Integer pop3PassStyle;
    /**
	 *POP3密码
	 */
    private String pop3Pass;
    /**
	 *企业社区账号用户名
	 */
    private String ccUsername;
    /**
	 *密码
	 */
    private String ccPwd;
    /**
	 *null 无用
	 */
    private Integer isUseEmailsend;
    /**
	 *null 无用
	 */
    private Integer taskcenterOpenStart;
    /**
	 *null 无用
	 */
    private String emailGetbox;
    /**
	 *文件柜视图标志
	 */
    private Integer folderViewModel;
    /**
	 *是否启用邮件发送限制
	 */
    private Integer useEmail;
    /**
	 *讨论区签名档
	 */
    private String bbsSignature;
    /**
	 *我关注的用户ID串
	 */
    private String concernUser;
    /**
	 *用户菜单ID串
	 */
    private String uFuncIdStr;
    private Date lastPassTime;

    private String loginRestriction;
    private String loginTime;

    private String employmentType;//人员类型

    private String planCockpitSet;//计划管理运营驾驶舱自定义设置

    private String flowFavorites;

    /**
     * 主页导航面板 0-展开，1-隐藏
     */
    private String menuPanel;
    /**
     * 邮件面板（0-纵列，1-横列）
     */
    private String emailPanel;

    private String jobLevel;//岗级

    private String bankDeposit;

    private String bankCardNumber;

    /**
     * 公文面板（1-简洁，2-详细）
     */
    private String documentPanel;

    public String getDocumentPanel() {
        return documentPanel;
    }

    public void setDocumentPanel(String documentPanel) {
        this.documentPanel = documentPanel;
    }

    public String getJobLevel() {
        return jobLevel;
    }

    public void setJobLevel(String jobLevel) {
        this.jobLevel = jobLevel;
    }

    public String getEmailPanel() {
        return emailPanel;
    }

    public void setEmailPanel(String emailPanel) {
        this.emailPanel = emailPanel;
    }

    public String getMenuPanel() {
        return menuPanel;
    }

    public void setMenuPanel(String menuPanel) {
        this.menuPanel = menuPanel;
    }

    public String getFlowFavorites() {
        return flowFavorites;
    }

    public void setFlowFavorites(String flowFavorites) {
        this.flowFavorites = flowFavorites;
    }

    public String getPlanCockpitSet() {
        return planCockpitSet;
    }

    public void setPlanCockpitSet(String planCockpitSet) {
        this.planCockpitSet = planCockpitSet;
    }

    public String getEmploymentType() {
        return employmentType;
    }

    public void setEmploymentType(String employmentType) {
        this.employmentType = employmentType;
    }

    public String getLoginRestriction() {
        return loginRestriction;
    }

    public void setLoginRestriction(String loginRestriction) {
        this.loginRestriction = loginRestriction;
    }

    public String getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(String loginTime) {
        this.loginTime = loginTime;
    }

    public Date getLastPassTime() {
        return lastPassTime;
    }

    public void setLastPassTime(Date lastPassTime) {
        this.lastPassTime = lastPassTime;
    }
    public String getBbsSignature() {
		return bbsSignature == null?"":bbsSignature.trim();
	}

	public void setBbsSignature(String bbsSignature) {
		this.bbsSignature = bbsSignature;
	}

	public String getConcernUser() {
		return concernUser ==null?"":concernUser.trim();
	}

	public void setConcernUser(String concernUser) {
		this.concernUser = concernUser;
	}

	public String getuFuncIdStr() {
		return uFuncIdStr==null?"":uFuncIdStr.trim();
	}

	public void setuFuncIdStr(String uFuncIdStr) {
		this.uFuncIdStr = uFuncIdStr;
	}

	public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserId() {
        return userId== null ? "" : userId.trim();
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? "" : userId.trim();
    }

    public String getTableIcon() {
        return tableIcon== null ? "" : tableIcon.trim();
    }

    public void setTableIcon(String tableIcon) {
        this.tableIcon = tableIcon == null ? "" : tableIcon.trim();
    }

    public String getEmailRecentLinkman() {
        return emailRecentLinkman== null ? "" : emailRecentLinkman.trim();
    }

    public void setEmailRecentLinkman(String emailRecentLinkman) {
        this.emailRecentLinkman = emailRecentLinkman == null ? "" : emailRecentLinkman.trim();
    }

    public String getNickName() {
        return nickName== null ? "" : nickName.trim();
    }

    public void setNickName(String nickName) {
        this.nickName = nickName == null ? "" : nickName.trim();
    }

    public Integer getBbsCounter() {
        return bbsCounter;
    }

    public void setBbsCounter(Integer bbsCounter) {
        this.bbsCounter = bbsCounter;
    }

    public Integer getEmailCapacity() {
        return emailCapacity;
    }

    public void setEmailCapacity(Integer emailCapacity) {
        this.emailCapacity = emailCapacity;
    }

    public Integer getFolderCapacity() {
        return folderCapacity;
    }

    public void setFolderCapacity(Integer folderCapacity) {
        this.folderCapacity = folderCapacity;
    }

    public Integer getWebmailCapacity() {
        return webmailCapacity;
    }

    public void setWebmailCapacity(Integer webmailCapacity) {
        this.webmailCapacity = webmailCapacity;
    }

    public Integer getWebmailNum() {
        return webmailNum;
    }

    public void setWebmailNum(Integer webmailNum) {
        this.webmailNum = webmailNum;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getTderFlag() {
        return tderFlag== null ? "0" : tderFlag.trim();
    }

    public void setTderFlag(String tderFlag) {
        this.tderFlag = tderFlag == null ? "" : tderFlag.trim();
    }

    public Short getDutyType() {
        return dutyType;
    }

    public void setDutyType(Short dutyType) {
        this.dutyType = dutyType;
    }

    public Integer getUsePop3() {
        return usePop3;
    }

    public void setUsePop3(Integer usePop3) {
        this.usePop3 = usePop3;
    }

    public Integer getIsUsePop3() {
        return isUsePop3;
    }

    public void setIsUsePop3(Integer isUsePop3) {
        this.isUsePop3 = isUsePop3;
    }

    public Integer getPop3PassStyle() {
        return pop3PassStyle;
    }

    public void setPop3PassStyle(Integer pop3PassStyle) {
        this.pop3PassStyle = pop3PassStyle;
    }

    public String getPop3Pass() {
        return pop3Pass== null ? "" : pop3Pass.trim();
    }

    public void setPop3Pass(String pop3Pass) {
        this.pop3Pass = pop3Pass == null ? "" : pop3Pass.trim();
    }

    public String getCcUsername() {
        return ccUsername== null ? "" : ccUsername.trim();
    }

    public void setCcUsername(String ccUsername) {
        this.ccUsername = ccUsername == null ? "" : ccUsername.trim();
    }

    public String getCcPwd() {
        return ccPwd ==null?"":ccPwd.trim();
    }

    public void setCcPwd(String ccPwd) {
        this.ccPwd = ccPwd == null ? "" : ccPwd.trim();
    }

    public Integer getIsUseEmailsend() {
        return isUseEmailsend;
    }

    public void setIsUseEmailsend(Integer isUseEmailsend) {
        this.isUseEmailsend = isUseEmailsend;
    }

    public Integer getTaskcenterOpenStart() {
        return taskcenterOpenStart;
    }

    public void setTaskcenterOpenStart(Integer taskcenterOpenStart) {
        this.taskcenterOpenStart = taskcenterOpenStart;
    }

    public String getEmailGetbox() {
        return emailGetbox== null ? "" : emailGetbox.trim();
    }

    public void setEmailGetbox(String emailGetbox) {
        this.emailGetbox = emailGetbox == null ? "" : emailGetbox.trim();
    }

    public Integer getFolderViewModel() {
        return folderViewModel;
    }

    public void setFolderViewModel(Integer folderViewModel) {
        this.folderViewModel = folderViewModel;
    }

    public Integer getUseEmail() {
        return useEmail;
    }

    public void setUseEmail(Integer useEmail) {
        this.useEmail = useEmail;
    }

    public String getBankDeposit() {
        return bankDeposit;
    }

    public void setBankDeposit(String bankDeposit) {
        this.bankDeposit = bankDeposit;
    }

    public String getBankCardNumber() {
        return bankCardNumber;
    }

    public void setBankCardNumber(String bankCardNumber) {
        this.bankCardNumber = bankCardNumber;
    }
}