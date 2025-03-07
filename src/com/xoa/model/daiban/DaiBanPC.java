package com.xoa.model.daiban;

import com.xoa.model.sms.SmsBodyExtend;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by gsb on 2018/6/1.
 */
public class DaiBanPC {

    private Integer totalCount;

    private Integer emailCount;

    private Integer workFlowCount;

    private List<SmsBodyExtend> email=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> totalList=new ArrayList<>();

    public Integer getWorkFlowCount() {
        return workFlowCount;
    }

    public void setWorkFlowCount(Integer workFlowCount) {
        this.workFlowCount = workFlowCount;
    }

    public Integer getTotalCount() {
        return totalCount==null?0:totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Integer getEmailCount() {
        return emailCount==null?0:emailCount;
    }

    public void setEmailCount(Integer emailCount) {
        this.emailCount = emailCount;
    }

    public List<SmsBodyExtend> getTotalList() {
        return totalList;
    }

    public void setTotalList(List<SmsBodyExtend> totalList) {
        this.totalList = totalList;
    }

    public List<SmsBodyExtend> getEmail() {
        return email;
    }

    public void setEmail(List<SmsBodyExtend> email) {
        this.email = email;
    }
}
