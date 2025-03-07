package com.xoa.model.voteItem;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.xoa.model.enclosure.Attachment;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 投票选项信息表
 * </p>
 *
 * @author ÕÅÀö¾ü
 * @since 2017-09-18
 */
@TableName("vote_item")
public class VoteItem extends Model<VoteItem> {

    private static final long serialVersionUID = 1L;

    /**
     * 唯一自增ID
     */
	@TableId(value="ITEM_ID", type= IdType.AUTO)
	private Integer itemId;
    /**
     * 投票ID
     */
	@TableField("VOTE_ID")
	private Integer voteId;
    /**
     * 选项名称
     */
	@TableField("ITEM_NAME")
	private String itemName;
    /**
     * 票数
     */
	@TableField("VOTE_COUNT")
	private Integer voteCount;
    /**
     * 投票人
     */
	@TableField("VOTE_USER")
	private String voteUser;
	/**
	 * 投票人姓名
	 */
	@TableField("ANONYMOUS")
	private String anonymous;

	private String voteUserName;

	private String voteReason;
	/**
	 * 附件id串
	 */
	@TableField("ATTACHMENT_ID")
	private String	attachmentId;
	/**
	 * 附件名称串
	 */
	@TableField("ATTACHMENT_NAME")
	private String  attachmentName;

	private List<Attachment> attachmentList;

	public String getVoteReason() {
		return voteReason;
	}

	public void setVoteReason(String voteReason) {
		this.voteReason = voteReason;
	}

	public String getVoteUserName() {
		return voteUserName==null?"":voteUserName;
	}

	public void setVoteUserName(String voteUserName) {
		this.voteUserName = voteUserName;
	}

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public Integer getVoteId() {
		return voteId;
	}

	public void setVoteId(Integer voteId) {
		this.voteId = voteId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getVoteCount() {
		return voteCount;
	}

	public void setVoteCount(Integer voteCount) {
		this.voteCount = voteCount;
	}

	public String getVoteUser() {
		return voteUser;
	}

	public void setVoteUser(String voteUser) {
		this.voteUser = voteUser;
	}

	public String getAnonymous() {
		return anonymous;
	}

	public void setAnonymous(String anonymous) {
		this.anonymous = anonymous;
	}

	@Override
	protected Serializable pkVal() {
		return this.itemId;
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

	public List<Attachment> getAttachmentList() {
		return attachmentList;
	}

	public void setAttachmentList(List<Attachment> attachmentList) {
		this.attachmentList = attachmentList;
	}

	@Override
	public String toString() {
		return "VoteItem{" +
			"itemId=" + itemId +
			", voteId=" + voteId +
			", itemName=" + itemName +
			", voteCount=" + voteCount +
			", voteUser=" + voteUser +
			"}";
	}
}
