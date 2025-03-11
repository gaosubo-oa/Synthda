package com.xoa.model.duties;

import com.xoa.model.enclosure.Attachment;

import java.util.ArrayList;
import java.util.List;

public class UserPost {

    //自增id
    private Integer postId;

    //职务名称
    private  String  postName;

   //职务类型
    private  Integer  type;

    //职务级别
    private  String   level;

    //职务编号
    private  String   postNo;

    //所属部门
    private  Integer  deptId;

    // 职责
    private  String   duty;

    //职务描述
    private  String   description;

    //附件id
    private  String   attachmentId;

   // 附件名称
    private  String   attachmentName;

    private  String   typeName;

    private  String   deptName;

    /**
     * 附件对象
     */
    private List<Attachment> attachment=new ArrayList<Attachment>();

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    public List<Attachment> getAttachment() {

        return attachment;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getPostName() {
        return postName==null?"":postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public Integer getType() {
        return type==null?0:type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getLevel() {
        return level==null?"":level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getPostNo() {
        return postNo==null?"":postNo;
    }

    public void setPostNo(String postNo) {
        this.postNo = postNo;
    }

    public Integer getDeptId() {
        return deptId==null?0:deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDuty() {
        return duty==null?"":duty;
    }

    public void setDuty(String duty) {
        this.duty = duty;
    }

    public String getDescription() {
        return description==null?"":description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAttachmentId() {
        return attachmentId==null?"":attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    public String getAttachmentName() {
        return attachmentName==null?"":attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public String getTypeName() {
        return typeName==null?"":typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getDeptName() {
        return deptName==null?"":deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}
