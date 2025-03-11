package com.xoa.model.daiban;

import java.util.List;

public class Daiban {

	private  Integer total;
	
	private List<TodoList> email;
	
	private List<TodoList> notify;

	private List<TodoList> workFlow;

	private List<TodoList> newsList;

	private List<TodoList>  documentList;

	private List<TodoList> toupiao;

	public List<TodoList> getToupiao() {
		return toupiao;
	}

	public void setToupiao(List<TodoList> toupiao) {
		this.toupiao = toupiao;
	}

	public List<TodoList> getDocumentList() {
		return documentList;
	}

	public void setDocumentList(List<TodoList> documentList) {
		this.documentList = documentList;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<TodoList> getNewsList() {
		return newsList;
	}

	public void setNewsList(List<TodoList> newsList) {
		this.newsList = newsList;
	}

	public List<TodoList> getEmail() {
		return email;
	}

	public void setEmail(List<TodoList> email) {
		this.email = email;
	}

	public List<TodoList> getNotify() {
		return notify;
	}

	public void setNotify(List<TodoList> notify) {
		this.notify = notify;
	}

	public List<TodoList> getWorkFlow() {
		return workFlow;
	}

	public void setWorkFlow(List<TodoList> workFlow) {
		this.workFlow = workFlow;
	}

	List<TodoList> emailPlus;
    public void setEmailPlus(List<TodoList> emailPlus) {
        this.emailPlus = emailPlus;
    }

	public List<TodoList> getEmailPlus() {
		return emailPlus;
	}
}
