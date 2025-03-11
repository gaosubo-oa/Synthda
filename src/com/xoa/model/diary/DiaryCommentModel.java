package com.xoa.model.diary;

import java.util.List;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017-7-5  14:48:29
 * 类介绍  :    工作日志评论表实体类
 * 构造参数:
 */
public class DiaryCommentModel {
    /**
     * 唯一自增ID
     */
    private Integer commentId;
    /**
     * 日志ID
     */
    private Integer diaId;
    /**
     * 点评用户的USER_ID
     */
    private String userId;
    /**
     * 点评保存时间
     */
    private String sendTime;
    /**
     *阅读标记（0--日志作者未读，1--日志作者已读）
     */
    private String commentFlag;
    /**
     * 点评内容
     */
    private String content;
    /**
     * 附件ID串
     */
    private String attachmentId;
    /**
     *附件名称串
     */
    private String attachmentName;

    /**
     *用户名
     */
    private String userName;

    /**
     *是否是当前登录人的评论
     */
    private boolean myDiaryComment;

    /**
     *评分
     */
    private Integer grade;

    /**
     *评论给谁
     */
    private String toId;

    /**
     *是否提醒
     */
    private String isRemind;

    /**
     *评论数量
     */
    private Integer count;

    private List<DiaryCommentReplyModel> diaryCommentReplyModelList;

    public List<DiaryCommentReplyModel> getDiaryCommentReplyModelList() {
        return diaryCommentReplyModelList;
    }

    public void setDiaryCommentReplyModelList(List<DiaryCommentReplyModel> diaryCommentReplyModelList) {
        this.diaryCommentReplyModelList = diaryCommentReplyModelList;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId == null ? null : attachmentId.trim();
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName == null ? null : attachmentName.trim();
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public Integer getDiaId() {
        return diaId;
    }

    public void setDiaId(Integer diaId) {
        this.diaId = diaId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }


    public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getCommentFlag() {
        return commentFlag;
    }

    public void setCommentFlag(String commentFlag) {
        this.commentFlag = commentFlag == null ? null : commentFlag.trim();
    }

    private String editFlag;
    public String getEditFlag() {
        return editFlag;
    }
    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }

    public boolean isMyDiaryComment() {
        return myDiaryComment;
    }

    public void setMyDiaryComment(boolean myDiaryComment) {
        this.myDiaryComment = myDiaryComment;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public String getToId() {
        return toId;
    }

    public void setToId(String toId) {
        this.toId = toId;
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