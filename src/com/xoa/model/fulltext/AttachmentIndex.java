package com.xoa.model.fulltext;

public class AttachmentIndex {
    private Integer aid; //附件ID
    private String AttachKeyWords; //附件关键词
    private String AttachContent; //附件内容

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public String getAttachKeyWords() {
        return AttachKeyWords;
    }

    public void setAttachKeyWords(String attachKeyWords) {
        AttachKeyWords = attachKeyWords;
    }

    public String getAttachContent() {
        return AttachContent;
    }

    public void setAttachContent(String attachContent) {
        AttachContent = attachContent;
    }
}
