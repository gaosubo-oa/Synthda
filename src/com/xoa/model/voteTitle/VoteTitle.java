package com.xoa.model.voteTitle;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.voteItem.VoteItem;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 投票基本信息表
 * </p>
 *
 * @author
 * @since 2017-09-15
 */
@TableName("vote_title")
public class VoteTitle extends Model<VoteTitle> {

    private static final long serialVersionUID = 1L;

    /**
     * 唯一自增ID
     */
    @TableId(value = "VOTE_ID", type = IdType.AUTO)
    private Integer voteId;

    private Integer countNum;
    /**
     * 投票项的上一级VOTE_ID
     */
    @TableField("PARENT_ID")
    private Integer parentId;
    /**
     * 投票新建人USER_ID
     */
    @TableField("FROM_ID")
    private String fromId;
    /**
     * 发布部门
     */
    @TableField("TO_ID")
    private String toId;
    /**
     * 发布角色
     */
    @TableField("PRIV_ID")
    private String privId;
    /**
     * 发布用户
     */
    @TableField("USER_ID")
    private String userId;
    private String usersName;
    /**
     * 标题
     */
    @TableField("SUBJECT")
    private String subject;
    /**
     * 投票描述
     */
    @TableField("CONTENT")
    private String content;
    /**
     * 类型
     */
    @TableField("TYPE")
    private String type;
    /**
     * 选择最大项数
     */
    @TableField("MAX_NUM")
    private Integer maxNum;
    /**
     * 选择最小项数
     */
    @TableField("MIN_NUM")
    private Integer minNum;
    /**
     * 是否匿名(0-不允许匿名,1-允许匿名)
     */
    @TableField("ANONYMITY")
    private String anonymity;
    /**
     * 查看投票结果选项(0-投票后允许查看,1-投票前允许查看,2-不允许查看)
     */
    @TableField("VIEW_PRIV")
    private String viewPriv;
    /**
     * 发布时间
     */
    @TableField("SEND_TIME")
    private String sendTime;
    /**
     * 投票开始日期
     */
    @TableField("BEGIN_DATE")
    private String beginDate;
    /**
     * 投票结束日期
     */
    @TableField("END_DATE")
    private String endDate;
    /**
     * 发布标记(0-未发布,1-已发布)
     */
    @TableField("PUBLISH")
    private String publish;
    /**
     * 投票者
     */
    @TableField("READERS")
    private String readers;
    /**
     * 排序号
     */
    @TableField("VOTE_NO")
    private String voteNo;
    /**
     * 附件ID串
     */
    @TableField("ATTACHMENT_ID")
    private String attachmentId;
    /**
     * 附件名称串
     */
    @TableField("ATTACHMENT_NAME")
    private String attachmentName;
    /**
     * 置顶标记(0-不置顶,1-置顶)
     */
    @TableField("TOP")
    private String top;
    /**
     * 有查看投票信息权限的角色
     */
    @TableField("VIEW_RESULT_PRIV_ID")
    private String viewResultPrivId;
    /**
     * 有查看投票信息权限的人物
     */
    @TableField("VIEW_RESULT_USER_ID")
    private String viewResultUserId;
    private String viewResultUserName;

    private String toUserName;

    private String toPrivName;

    private String toDeptName;

    //投票总人数
    private Integer sum;
    //投票总条数
    private Integer getCount;

    //是否对当前的投票具有查看权限
    private boolean isRight = false;

    public boolean isRight() {
        return isRight;
    }

    public void setRight(boolean right) {
        isRight = right;
    }

    private Integer uid;
    private String avatar;
    private String userName;
    private String photo;
    private String deptName;
    private String itemName;
    private Integer itemId;
    private String voteUser;
    private Integer voteCount;
    private Integer count;
    private Integer remind;
    private Integer smsRemind;
    private List<Attachment> attachment;


    public Integer getSmsRemind() {
        return smsRemind;
    }

    public void setSmsRemind(Integer smsRemind) {
        this.smsRemind = smsRemind;
    }

    public Integer getRemind() {
        return remind;
    }

    public void setRemind(Integer remind) {
        this.remind = remind;
    }

    public Integer getUid() {
        return uid;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    private String A;
    private String B;
    private String C;
    private String D;
    private String E;

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getA() {
        return A;
    }

    public String getB() {
        return B;
    }

    public String getC() {
        return C;
    }

    public String getD() {
        return D;
    }

    public String getE() {
        return E;
    }

    public void setA(String a) {
        A = a;
    }

    public void setB(String b) {
        B = b;
    }

    public void setC(String c) {
        C = c;
    }

    public void setD(String d) {
        D = d;
    }

    public void setE(String e) {
        E = e;
    }

    //投票选项信息
    private List<VoteItem> voteItemList;

    public List<VoteItem> getVoteItemList() {
        return voteItemList == null ? new ArrayList<VoteItem>() : voteItemList;
    }

    public void setVoteItemList(List<VoteItem> voteItemList) {
        this.voteItemList = voteItemList;
    }

    //子投票信息
    private List<VoteTitle> voteTitleList;

    public List<VoteTitle> getVoteTitleList() {
        return voteTitleList == null ? new ArrayList<VoteTitle>() : voteTitleList;
    }

    public void setVoteTitleList(List<VoteTitle> voteTitleList) {
        this.voteTitleList = voteTitleList;
    }

    public String getUserPrivName() {
        return userPrivName;
    }

    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }

    private String userPrivName;

    private boolean isHave;

    private String toIdName;

    private String privIdName;

    public Integer getSum() {
        return sum == null ? 0 : sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }

    public Integer getGetCount() {
        return getCount == null ? 0 : getCount;
    }

    public void setGetCount(Integer getCount) {
        this.getCount = getCount;
    }

    public Integer getCountNum() {
        return countNum;
    }

    public void setCountNum(Integer countNum) {
        this.countNum = countNum;
    }

    public String getPrivIdName() {
        return privIdName;
    }

    public void setPrivIdName(String privIdName) {
        this.privIdName = privIdName;
    }

    public String getToIdName() {
        return toIdName;
    }

    public void setToIdName(String toIdName) {
        this.toIdName = toIdName;
    }

    public boolean isHave() {
        return isHave;
    }

    public void setHave(boolean have) {
        isHave = have;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getItemName() {
        return itemName;
    }

    public String getVoteUser() {
        return voteUser;
    }

    public Integer getVoteCount() {
        return voteCount == null ? 0 : voteCount;
    }

    public String getUserName() {
        return userName == null ? "" : userName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public void setVoteUser(String voteUser) {
        this.voteUser = voteUser;
    }

    public void setVoteCount(Integer voteCount) {
        this.voteCount = voteCount;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getVoteId() {
        return voteId;
    }

    public void setVoteId(Integer voteId) {
        this.voteId = voteId;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getFromId() {
        return fromId;
    }

    public void setFromId(String fromId) {
        this.fromId = fromId;
    }

    public String getToId() {
        return toId;
    }

    public void setToId(String toId) {
        this.toId = toId;
    }

    public String getPrivId() {
        return privId;
    }

    public void setPrivId(String privId) {
        this.privId = privId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getMaxNum() {
        return maxNum;
    }

    public void setMaxNum(Integer maxNum) {
        this.maxNum = maxNum;
    }

    public Integer getMinNum() {
        return minNum;
    }

    public void setMinNum(Integer minNum) {
        this.minNum = minNum;
    }

    public String getAnonymity() {
        return anonymity;
    }

    public void setAnonymity(String anonymity) {
        this.anonymity = anonymity;
    }

    public String getViewPriv() {
        return viewPriv;
    }

    public void setViewPriv(String viewPriv) {
        this.viewPriv = viewPriv;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate == "" ? "0000-00-00 00:00:00" : endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getPublish() {
        return publish;
    }

    public void setPublish(String publish) {
        this.publish = publish;
    }

    public String getReaders() {
        return readers;
    }

    public void setReaders(String readers) {
        this.readers = readers;
    }

    public String getVoteNo() {
        return voteNo;
    }

    public void setVoteNo(String voteNo) {
        this.voteNo = voteNo;
    }

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public String getTop() {
        return top;
    }

    public String getViewResultUserName() {
        return viewResultUserName;
    }

    public void setViewResultUserName(String viewResultUserName) {
        this.viewResultUserName = viewResultUserName;
    }

    public void setTop(String top) {
        this.top = top;
    }

    public String getViewResultPrivId() {
        return viewResultPrivId;
    }

    public void setViewResultPrivId(String viewResultPrivId) {
        this.viewResultPrivId = viewResultPrivId;
    }

    public String getViewResultUserId() {
        return viewResultUserId;
    }

    public void setViewResultUserId(String viewResultUserId) {
        this.viewResultUserId = viewResultUserId;
    }

    @Override
    protected Serializable pkVal() {
        return this.voteId;
    }

    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    @Override
    public String toString() {
        return "VoteTitle{" +
                "voteId=" + voteId +
                ", parentId=" + parentId +
                ", fromId=" + fromId +
                ", toId=" + toId +
                ", privId=" + privId +
                ", userId=" + userId +
                ", subject=" + subject +
                ", content=" + content +
                ", type=" + type +
                ", maxNum=" + maxNum +
                ", minNum=" + minNum +
                ", anonymity=" + anonymity +
                ", viewPriv=" + viewPriv +
                ", sendTime=" + sendTime +
                ", beginDate=" + beginDate +
                ", endDate=" + endDate +
                ", publish=" + publish +
                ", readers=" + readers +
                ", voteNo=" + voteNo +
                ", attachmentId=" + attachmentId +
                ", attachmentName=" + attachmentName +
                ", top=" + top +
                ", viewResultPrivId=" + viewResultPrivId +
                ", viewResultUserId=" + viewResultUserId +
                "}";
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getToUserName() {
        return toUserName == null ? "" : toUserName;
    }

    public void setToUserName(String toUserName) {
        this.toUserName = toUserName;
    }

    public String getToPrivName() {
        return toPrivName == null ? "" : toPrivName;
    }

    public void setToPrivName(String toPrivName) {
        this.toPrivName = toPrivName;
    }

    public String getToDeptName() {
        return toDeptName == null ? "" : toDeptName;
    }

    public void setToDeptName(String toDeptName) {
        this.toDeptName = toDeptName;
    }

    private String name;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    private String fromName;

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public String getFromName() {
        return fromName;
    }

    public String getUsersName() {
        return usersName;
    }

    public void setUsersName(String usersName) {
        this.usersName = usersName;
    }
}
