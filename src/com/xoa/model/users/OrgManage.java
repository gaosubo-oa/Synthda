package com.xoa.model.users;

import com.xoa.util.common.StringUtils;

import java.io.Serializable;

public class OrgManage implements Serializable{
	/**
	 * 唯一自增ID
	 */
    private Integer oid;
    /**
     * 单位名称
     */
    private String version;
    /**
     * 版本信息
     */
    private String isOrg;
    /**
     * 是否组织
     */
    private String name;
    /**
     * 英文
     */
    private String enName;
    /**
     * 繁体
     */
    private String ftName;
    /**
     * 日文
     */
    private String jpName;
    /**
     * 韩文
     */
    private String krName;
	
    private String orgId;

    /**
     * 授权用户数
     */
    private Integer licenseUsers;

    /**
     * 系统用户数
     */
    private Integer usedUsers;

    /**
     * 授权存储空间G
     */
    private Integer licenseSpace;

    /**
     * 已使用存储空间G
     */
    private Integer usedSpace;

    /**
     * 开始时间
     */
    private String registTime;

    /**
     * 结束时间
     */
    private String endTime;

    /**
     * 提醒时间
     */
    private String remindTime;

    /**
     * 代理商ID
     */
    private Integer agentId;

    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }

    public String getFtName() {
        return ftName;
    }

    public void setFtName(String ftName) {
        this.ftName = ftName;
    }

    public String getJpName() {
        return jpName;
    }

    public void setJpName(String jpName) {
        this.jpName = jpName;
    }

    public String getKrName() {
        return krName;
    }

    public void setKrName(String krName) {
        this.krName = krName;
    }

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version == null ? null : version.trim();
    }

    public String getIsOrg() {
        return isOrg;
    }

    public void setIsOrg(String isOrg) {
        this.isOrg = isOrg == null ? null : isOrg.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
		
    }
	
	   public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public Integer getAgentId() {
        return agentId;
    }

    public void setAgentId(Integer agentId) {
        this.agentId = agentId;
    }

    public String getRemindTime() {
        return StringUtils.checkNull(remindTime) ? "" : remindTime;
    }

    public void setRemindTime(String remindTime) {
        this.remindTime = remindTime;
    }

    public String getEndTime() {
        return StringUtils.checkNull(endTime) ? "" : endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRegistTime() {
        return StringUtils.checkNull(registTime) ? "" : registTime;
    }

    public void setRegistTime(String registTime) {
        this.registTime = registTime;
    }

    public Integer getUsedSpace() {
        return usedSpace;
    }

    public void setUsedSpace(Integer usedSpace) {
        this.usedSpace = usedSpace;
    }

    public Integer getLicenseSpace() {
        return licenseSpace;
    }

    public void setLicenseSpace(Integer licenseSpace) {
        this.licenseSpace = licenseSpace;
    }

    public Integer getUsedUsers() {
        return usedUsers;
    }

    public void setUsedUsers(Integer usedUsers) {
        this.usedUsers = usedUsers;
    }

    public Integer getLicenseUsers() {
        return licenseUsers;
    }

    public void setLicenseUsers(Integer licenseUsers) {
        this.licenseUsers = licenseUsers;
    }
}