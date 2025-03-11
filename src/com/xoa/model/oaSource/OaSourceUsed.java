package com.xoa.model.oaSource;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

//资源申请记录
public class OaSourceUsed {

    private Integer sourceid;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date applyDate;
    private String applyDatestr;

    private String userId;

    private String startingtime; //临时封装字段，用于记录查询开始时间

    private String endtime; //临时封装字段，用于记录查询结束时间

    //临时封装字段，用于前台返回日期时间和周几
    private String applyDateWeek;

    public String getApplyDatestr() {
        return applyDatestr;
    }

    public void setApplyDatestr(String applyDatestr) {
        this.applyDatestr = applyDatestr;
    }

    public String getApplyDateWeek() {
        return applyDateWeek;
    }

    public void setApplyDateWeek(String applyDateWeek) {
        this.applyDateWeek = applyDateWeek;
    }

    public String getStartingtime() {
        return startingtime;
    }

    public void setStartingtime(String startingtime) {
        this.startingtime = startingtime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public Integer getSourceid() {
        return sourceid;
    }

    public void setSourceid(Integer sourceid) {
        this.sourceid = sourceid;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
