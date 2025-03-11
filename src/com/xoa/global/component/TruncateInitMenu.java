package com.xoa.global.component;

import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by pfl on 2017/7/11.
 */
@Component
public class TruncateInitMenu {
    //    邮件、公告、新闻、日程、日志、工作流
    List<String> myTableList;
    List<String> workFlowList;
    List<String> erpList;
    List<String> knowledgeList;
    List<String> documentList;
    List<String> systemList;

    public List<String> getMyTableList() {
        return myTableList;
    }

    public void setMyTableList(List<String> myTableList) {
        this.myTableList = myTableList;
    }

    public List<String> getWorkFlowList() {
        return workFlowList;
    }

    public void setWorkFlowList(List<String> workFlowList) {
        this.workFlowList = workFlowList;
    }

    public List<String> getErpList() {
        return erpList;
    }

    public void setErpList(List<String> erpList) {
        this.erpList = erpList;
    }

    public List<String> getKnowledgeList() {
        return knowledgeList;
    }

    public void setKnowledgeList(List<String> knowledgeList) {
        this.knowledgeList = knowledgeList;
    }

    public List<String> getDocumentList() {
        return documentList;
    }

    public void setDocumentList(List<String> documentList) {
        this.documentList = documentList;
    }

    public List<String> getSystemList() {
        return systemList;
    }

    public void setSystemList(List<String> systemList) {
        this.systemList = systemList;
    }

}
