package com.xoa.model.diary;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017-7-5  14:48:29
 * 类介绍  :    工作日志评论回复表实体类
 * 构造参数:
 */
public class DiaryCommentReplyModel {
    /**
     * 唯一自增ID
     */
    private Integer replyId;
    /**
     * 回复时间
     */
    private String replyTime;
    /**
     *回复人
     */
    private String replyer;
    private String replyerName;//回复人名称
    /**
     *评论ID
     */
    private Integer commentId;
    private Integer replyComId;

    public Integer getReplyComId() {
        return replyComId;
    }

    public void setReplyComId(Integer replyComId) {
        this.replyComId = replyComId;
    }

    /**
     * 回复给谁
     */
    private String toId;
    private String toName;//回复给谁的名称
    /**
     * 回复内容
     */
    private String replyComment;

    /**
     *是否提醒
     */
    private String isRemind;

    /**
     *回复点评数量
     */
    private Integer count;

    public String getReplyerName() {
        return replyerName;
    }

    public void setReplyerName(String replyerName) {
        this.replyerName = replyerName;
    }

    public String getToName() {
        return toName;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public Integer getReplyId() {
        return replyId;
    }

    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
    }

    public String getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

    public String getReplyer() {
        return replyer;
    }

    public void setReplyer(String replyer) {
        this.replyer = replyer == null ? null : replyer.trim();
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public String getToId() {
        return toId;
    }

    public void setToId(String toId) {
        this.toId = toId == null ? null : toId.trim();
    }

    public String getReplyComment() {
        return replyComment;
    }

    public void setReplyComment(String replyComment) {
        this.replyComment = replyComment == null ? null : replyComment.trim();
    }

    private Integer diaId;
    public void setDiaId(Integer diaId) {
        this.diaId = diaId;
    }

    public Integer getDiaId() {
        return diaId;
    }
    private String editFlag;
    public String getEditFlag() {
        return editFlag;
    }
    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }

    public String getIsRemind() {
        return isRemind;
    }

    public void setIsRemind(String isRemind) {
        this.isRemind = isRemind;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}