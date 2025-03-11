package com.xoa.model.knowledge;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class KnowledgeCustomerUselog {
    private String customerName;

    private Integer logId;

    private String userId;

    private Integer docfileId;

    private String docfileNo;

    private String docfileName;

    private String useType;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date useTime;

    public Integer getLogId() {
        return logId;
    }

    public void setLogId(Integer logId) {
        this.logId = logId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getDocfileId() {
        return docfileId;
    }

    public void setDocfileId(Integer docfileId) {
        this.docfileId = docfileId;
    }

    public String getDocfileName() {
        return docfileName;
    }

    public void setDocfileName(String docfileName) {
        this.docfileName = docfileName == null ? null : docfileName.trim();
    }

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType == null ? null : useType.trim();
    }

    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getDocfileNo() {
        return docfileNo;
    }

    public void setDocfileNo(String docfileNo) {
        this.docfileNo = docfileNo;
    }
}