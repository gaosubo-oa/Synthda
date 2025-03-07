package com.xoa.model.fullTextSearch;

import java.util.List;
/**
 * Created by gsb on 2018/3/15.
 */
public class AllDaiban {

    private  Integer total;

    private List<AllTodoList> email;

    private List<AllTodoList> notify;

    private List<AllTodoList> workFlow;

    private List<AllTodoList> newsList;

    private List<AllTodoList>  documentList;

    private List<AllTodoList> toupiao;

    public List<AllTodoList> getToupiao() {
        return toupiao;
    }

    public void setToupiao(List<AllTodoList> toupiao) {
        this.toupiao = toupiao;
    }

    public List<AllTodoList> getDocumentList() {
        return documentList;
    }

    public void setDocumentList(List<AllTodoList> documentList) {
        this.documentList = documentList;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<AllTodoList> getNewsList() {
        return newsList;
    }

    public void setNewsList(List<AllTodoList> newsList) {
        this.newsList = newsList;
    }

    public List<AllTodoList> getEmail() {
        return email;
    }

    public void setEmail(List<AllTodoList> email) {
        this.email = email;
    }

    public List<AllTodoList> getNotify() {
        return notify;
    }

    public void setNotify(List<AllTodoList> notify) {
        this.notify = notify;
    }

    public List<AllTodoList> getWorkFlow() {
        return workFlow;
    }

    public void setWorkFlow(List<AllTodoList> workFlow) {
        this.workFlow = workFlow;
    }
}




