package com.xoa.model.position;

import com.xoa.model.enclosure.Attachment;

import java.util.List;

public class UserJob {

    //岗位管理 自增id
    private Integer jobId;

   //岗位名称
   private  String jobName;

   //职能类型
   private  Integer type;

   //岗位级别
   private  String level;

   //岗位编号
   private  String jobNo;


   //所属部门
   private Integer deptId;

   //编制
   private String jobPlan;

   //职责
   private String duty;

  //入职要求
   private String description;

   //附件id
    private  String attachmentId;

    //附件名称
    private String  attachmentName;
    //附件
    private List<Attachment> attachment;
    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    private  String typeName;
    private String deptName;
    private Integer getcount;

    public Integer getGetcount() {
        return getcount;
    }

    public void setGetcount(Integer getcount) {
        this.getcount = getcount;
    }

    public String getDeptName() {
          return deptName==null?"":deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getTypeName() {
        return typeName==null?"":typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getJobId() {
        return jobId;
    }

    public void setJobId(Integer jobId) {
        this.jobId = jobId;
    }

    public String getJobName() {
        return jobName==null?"":jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
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

    public String getJobNo() {
        return jobNo==null?"":jobNo;
    }

    public void setJobNo(String jobNo) {
        this.jobNo = jobNo;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getJobPlan() {
        return jobPlan==null?"":jobPlan;
    }

    public void setJobPlan(String jobPlan) {
        this.jobPlan = jobPlan;
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

}
