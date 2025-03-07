package com.xoa.model.trainingPlan;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <p>
 * 培训计划
 * </p>
 *
 * @author ZLF
 * @since 2017-09-07
 */
@TableName("edu_training_plan")
public class EduTrainingPlan {

    private static final long serialVersionUID = 1L;

    /**
     * 自增字段
     */
	@TableId(value="T_PLAN_ID", type= IdType.AUTO)
	private Integer planId;
    /**
     * 创建者用户名
     */
	@TableField("CREATE_USER_ID")
	private String createUserId;
    /**
     * 创建者部门编号
     */
	@TableField("CREATE_DEPT_ID")
	private Integer createDeptId;
    /**
     * 培训计划编号
     */
	@TableField("T_PLAN_NO")
	private String planNo;
    /**
     * 培训计划名称
     */
	@TableField("T_PLAN_NAME")
	private String planName;
    /**
     * 培训渠道(0-内部培训,1-渠道培训)
     */
	@TableField("T_CHANNEL")
	private String channel;
	/**
	 * 培训渠道名称(0-内部培训,1-渠道培训)
	 */
	private String channelName;
    /**
     * 培训预算
     */
	@TableField("T_BCWS")
	private BigDecimal bcws;
    /**
     * 开课时间
     */
	@TableField("COURSE_START_TIME")
	private Date courseStartTime;
    /**
     * 结课时间
     */
	@TableField("COURSE_END_TIME")
	private Date courseEndTime;
    /**
     * 审批人
     */
	@TableField("ASSESSING_OFFICER")
	private String assessingOfficer;

	private String assessingOfficerName;
    /**
     * 审批时间
     */
	@TableField("ASSESSING_TIME")
	private Date assessingTime;
    /**
     * 审批意见
     */
	@TableField("ASSESSING_VIEW")
	private String assessingView;
    /**
     * 计划状态(1-批准,2-拒绝)
     */
	@TableField("ASSESSING_STATUS")
	private Integer assessingStatus;
	/**
	 * 计划状态(1-批准,2-拒绝)
	 */
	private String assessingStatuName;
    /**
     * 计划培训人数
     */
	@TableField("T_JOIN_NUM")
	private Integer joinNum;
    /**
     * 参与培训部门
     */
	@TableField("T_JOIN_DEPT")
	private String joinDept;

	private String joinDeptName;
    /**
     * 参与培训人员
     */
	@TableField("T_JOIN_PERSON")
	private String joinPerson;

	private String joinPersonName;
    /**
     * 培训要求
     */
	@TableField("T_REQUIRES")
	private String requires;
    /**
     * 培训机构名称
     */
	@TableField("T_INSTITUTION_NAME")
	private String institutionName;
    /**
     * 培训机构相关信息
     */
	@TableField("T_INSTITUTION_INFO")
	private String institutionInfo;
    /**
     * 培训机构联系人
     */
	@TableField("T_INSTITUTION_CONTACT")
	private String institutionContact;
    /**
     * 培训机构联系人相关信息
     */
	@TableField("T_INSTITU_CONTACT_INFO")
	private String instituContactInfo;
    /**
     * 培训课程名称
     */
	@TableField("T_COURSE_NAME")
	private String courseName;
    /**
     * 主办部门
     */
	@TableField("SPONSORING_DEPARTMENT")
	private String sponsoringDepartment;

	private String sponsoringDepartmentName;
    /**
     * 负责人
     */
	@TableField("CHARGE_PERSON")
	private String chargePerson;


	@TableField("REMID")
	private Integer remid;

	public Integer getRemid() {
		return remid;
	}

	public void setRemid(Integer remid) {
		this.remid = remid;
	}


	private String chargePersonName;
    /**
     * 总课时
     */
	@TableField("COURSE_HOURS")
	private String courseHours;
    /**
     * 实际费用
     */
	@TableField("COURSE_PAY")
	private BigDecimal coursePay;
    /**
     * 培训形式
     */
	@TableField("T_COURSE_TYPES")
	private String courseTypes;
	/**
	 * 培训形式名称
	 */
	private String courseTypesName;
    /**
     * 培训说明
     */
	@TableField("T_DESCRIPTION")
	private String description;
    /**
     * 培训备注
     */
	@TableField("REMARK")
	private String remark;
    /**
     * 培训地点
     */
	@TableField("T_ADDRESS")
	private String address;
    /**
     * 培训内容
     */
	@TableField("T_CONTENT")
	private String content;
    /**
     * 附件编号
     */
	@TableField("ATTACHMENT_ID")
	private String attachmentId;
    /**
     * 附件名称
     */
	@TableField("ATTACHMENT_NAME")
	private String attachmentName;
    /**
     * 登记时间
     */
	@TableField("ADD_TIME")
	private Date addTime;

	@TableField
	private int  remind;


	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public int getRemind() {
		return remind;
	}

	public void setRemind(int remind) {
		this.remind = remind;
	}

	public Integer getPlanId() {
		return planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}


	public String getAssessingOfficerName() {
		return assessingOfficerName==null?"":assessingOfficerName;
	}

	public void setAssessingOfficerName(String assessingOfficerName) {
		this.assessingOfficerName = assessingOfficerName;
	}

	public String getJoinDeptName() {
		return joinDeptName;
	}

	public void setJoinDeptName(String joinDeptName) {
		this.joinDeptName = joinDeptName;
	}

	public String getJoinPersonName() {
		return joinPersonName;
	}

	public void setJoinPersonName(String joinPersonName) {
		this.joinPersonName = joinPersonName;
	}

	public String getSponsoringDepartmentName() {
		return sponsoringDepartmentName==null?"":sponsoringDepartmentName;
	}

	public void setSponsoringDepartmentName(String sponsoringDepartmentName) {
		this.sponsoringDepartmentName = sponsoringDepartmentName;
	}

	public String getChargePersonName() {
		return chargePersonName==null?"":chargePersonName;
	}

	public void setChargePersonName(String chargePersonName) {
		this.chargePersonName = chargePersonName;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public Integer getCreateDeptId() {
		return createDeptId;
	}

	public void setCreateDeptId(Integer createDeptId) {
		this.createDeptId = createDeptId;
	}

	public String getCourseTypesName() {
		return courseTypesName==null?"":courseTypesName;
	}

	public void setCourseTypesName(String courseTypesName) {
		this.courseTypesName = courseTypesName;
	}

	public String getPlanNo() {
		return planNo;
	}

	public void setPlanNo(String planNo) {
		this.planNo = planNo;
	}

	public String getPlanName() {
		return planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public BigDecimal getBcws() {
		return bcws;
	}

	public void setBcws(BigDecimal bcws) {
		this.bcws = bcws;
	}

	public Date getCourseStartTime() {
		return courseStartTime;
	}

	public void setCourseStartTime(Date courseStartTime) {
		this.courseStartTime = courseStartTime;
	}

	public Date getCourseEndTime() {
		return courseEndTime;
	}

	public void setCourseEndTime(Date courseEndTime) {
		this.courseEndTime = courseEndTime;
	}

	public String getAssessingOfficer() {
		return assessingOfficer;
	}

	public void setAssessingOfficer(String assessingOfficer) {
		this.assessingOfficer = assessingOfficer;
	}

	public Date getAssessingTime() {
		return assessingTime;
	}

	public void setAssessingTime(Date assessingTime) {
		this.assessingTime = assessingTime;
	}

	public String getAssessingView() {
		return assessingView;
	}

	public void setAssessingView(String assessingView) {
		this.assessingView = assessingView;
	}

	public Integer getAssessingStatus() {
		return assessingStatus;
	}

	public void setAssessingStatus(Integer assessingStatus) {
		this.assessingStatus = assessingStatus;
	}

	public Integer getJoinNum() {
		return joinNum;
	}


	public void setJoinNum(Integer joinNum) {
		this.joinNum = joinNum;
	}

	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public String getAssessingStatuName() {
		return assessingStatuName;
	}

	public void setAssessingStatuName(String assessingStatuName) {
		this.assessingStatuName = assessingStatuName;
	}

	public String getJoinDept() {
		return joinDept;
	}

	public void setJoinDept(String joinDept) {
		this.joinDept = joinDept;
	}

	public String getJoinPerson() {
		return joinPerson;
	}

	public void setJoinPerson(String joinPerson) {
		this.joinPerson = joinPerson;
	}

	public String getRequires() {
		return requires;
	}

	public void setRequires(String requires) {
		this.requires = requires;
	}

	public String getInstitutionName() {
		return institutionName;
	}

	public void setInstitutionName(String institutionName) {
		this.institutionName = institutionName;
	}

	public String getInstitutionInfo() {
		return institutionInfo;
	}

	public void setInstitutionInfo(String institutionInfo) {
		this.institutionInfo = institutionInfo;
	}

	public String getInstitutionContact() {
		return institutionContact;
	}

	public void setInstitutionContact(String institutionContact) {
		this.institutionContact = institutionContact;
	}

	public String getInstituContactInfo() {
		return instituContactInfo;
	}

	public void setInstituContactInfo(String instituContactInfo) {
		this.instituContactInfo = instituContactInfo;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getSponsoringDepartment() {
		return sponsoringDepartment;
	}

	public void setSponsoringDepartment(String sponsoringDepartment) {
		this.sponsoringDepartment = sponsoringDepartment;
	}

	public String getChargePerson() {
		return chargePerson;
	}

	public void setChargePerson(String chargePerson) {
		this.chargePerson = chargePerson;
	}

	public String getCourseHours() {
		return courseHours;
	}

	public void setCourseHours(String courseHours) {
		this.courseHours = courseHours;
	}

	public BigDecimal getCoursePay() {
		return coursePay;
	}

	public void setCoursePay(BigDecimal coursePay) {
		this.coursePay = coursePay;
	}

	public String getCourseTypes() {
		return courseTypes;
	}

	public void setCourseTypes(String courseTypes) {
		this.courseTypes = courseTypes;
	}

	public String getDescription() {
		return description==null?"":description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
}
