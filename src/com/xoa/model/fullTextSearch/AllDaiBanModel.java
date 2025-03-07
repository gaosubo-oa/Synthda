package com.xoa.model.fullTextSearch;

import com.xoa.model.sms.SmsBodyExtend;

import java.util.ArrayList;
import java.util.List;
/**
 * Created by gsb on 2018/3/15.
 */
public class AllDaiBanModel {

    private List<SmsBodyExtend> email=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> notify=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> workFlow=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> newsList=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend>  documentList=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> toupiao=new ArrayList<SmsBodyExtend>();

    public List<SmsBodyExtend> getEmail() {
        return email;
    }

    public void setEmail(List<SmsBodyExtend> email) {
        this.email = email;
    }

    public List<SmsBodyExtend> getNotify() {
        return notify;
    }

    public void setNotify(List<SmsBodyExtend> notify) {
        this.notify = notify;
    }

    public List<SmsBodyExtend> getWorkFlow() {
        return workFlow;
    }

    public void setWorkFlow(List<SmsBodyExtend> workFlow) {
        this.workFlow = workFlow;
    }

    public List<SmsBodyExtend> getNewsList() {
        return newsList;
    }

    public void setNewsList(List<SmsBodyExtend> newsList) {
        this.newsList = newsList;
    }

    public List<SmsBodyExtend> getDocumentList() {
        return documentList;
    }

    public void setDocumentList(List<SmsBodyExtend> documentList) {
        this.documentList = documentList;
    }

    public List<SmsBodyExtend> getToupiao() {
        return toupiao;
    }

    public void setToupiao(List<SmsBodyExtend> toupiao) {
        this.toupiao = toupiao;
    }


}



