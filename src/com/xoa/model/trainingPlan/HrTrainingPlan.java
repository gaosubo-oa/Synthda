package com.xoa.model.trainingPlan;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
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
@TableName("hr_training_plan")
public class HrTrainingPlan extends Model<HrTrainingPlan> {

    private static final long serialVersionUID = 1L;

    /**
     * 自增字段
     */
	@TableId(value="T_PLAN_ID", type= IdType.AUTO)
	private Integer tPlanId;
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
	private String tPlanNo;
    /**
     * 培训计划名称
     */
	@TableField("T_PLAN_NAME")
	private String tPlanName;
    /**
     * 培训渠道(0-内部培训,1-渠道培训)
     */
	@TableField("T_CHANNEL")
	private String tChannel;
    /**
     * 培训预算
     */
	@TableField("T_BCWS")
	private BigDecimal tBcws;
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
     * 计划培训人数
     */
	@TableField("T_JOIN_NUM")
	private Integer tJoinNum;
    /**
     * 参与培训部门
     */
	@TableField("T_JOIN_DEPT")
	private String tJoinDept;
    /**
     * 参与培训人员
     */
	@TableField("T_JOIN_PERSON")
	private String tJoinPerson;
    /**
     * 培训要求
     */
	@TableField("T_REQUIRES")
	private String tRequires;
    /**
     * 培训机构名称
     */
	@TableField("T_INSTITUTION_NAME")
	private String tInstitutionName;
    /**
     * 培训机构相关信息
     */
	@TableField("T_INSTITUTION_INFO")
	private String tInstitutionInfo;
    /**
     * 培训机构联系人
     */
	@TableField("T_INSTITUTION_CONTACT")
	private String tInstitutionContact;
    /**
     * 培训机构联系人相关信息
     */
	@TableField("T_INSTITU_CONTACT_INFO")
	private String tInstituContactInfo;
    /**
     * 培训课程名称
     */
	@TableField("T_COURSE_NAME")
	private String tCourseName;
    /**
     * 主办部门
     */
	@TableField("SPONSORING_DEPARTMENT")
	private String sponsoringDepartment;
    /**
     * 负责人
     */
	@TableField("CHARGE_PERSON")
	private String chargePerson;
    /**
     * 总课时
     */
	@TableField("COURSE_HOURS")
	private Integer courseHours;
    /**
     * 实际费用
     */
	@TableField("COURSE_PAY")
	private BigDecimal coursePay;
    /**
     * 培训形式
     */
	@TableField("T_COURSE_TYPES")
	private String tCourseTypes;
    /**
     * 培训说明
     */
	@TableField("T_DESCRIPTION")
	private String tDescription;
    /**
     * 培训备注
     */
	@TableField("REMARK")
	private String remark;
    /**
     * 培训地点
     */
	@TableField("T_ADDRESS")
	private String tAddress;
    /**
     * 培训内容
     */
	@TableField("T_CONTENT")
	private String tContent;
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


	public Integer gettPlanId() {
		return tPlanId;
	}

	public void settPlanId(Integer tPlanId) {
		this.tPlanId = tPlanId;
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

	public String gettPlanNo() {
		return tPlanNo;
	}

	public void settPlanNo(String tPlanNo) {
		this.tPlanNo = tPlanNo;
	}

	public String gettPlanName() {
		return tPlanName;
	}

	public void settPlanName(String tPlanName) {
		this.tPlanName = tPlanName;
	}

	public String gettChannel() {
		return tChannel;
	}

	public void settChannel(String tChannel) {
		this.tChannel = tChannel;
	}

	public BigDecimal gettBcws() {
		return tBcws;
	}

	public void settBcws(BigDecimal tBcws) {
		this.tBcws = tBcws;
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

	public Integer gettJoinNum() {
		return tJoinNum;
	}

	public void settJoinNum(Integer tJoinNum) {
		this.tJoinNum = tJoinNum;
	}

	public String gettJoinDept() {
		return tJoinDept;
	}

	public void settJoinDept(String tJoinDept) {
		this.tJoinDept = tJoinDept;
	}

	public String gettJoinPerson() {
		return tJoinPerson;
	}

	public void settJoinPerson(String tJoinPerson) {
		this.tJoinPerson = tJoinPerson;
	}

	public String gettRequires() {
		return tRequires;
	}

	public void settRequires(String tRequires) {
		this.tRequires = tRequires;
	}

	public String gettInstitutionName() {
		return tInstitutionName;
	}

	public void settInstitutionName(String tInstitutionName) {
		this.tInstitutionName = tInstitutionName;
	}

	public String gettInstitutionInfo() {
		return tInstitutionInfo;
	}

	public void settInstitutionInfo(String tInstitutionInfo) {
		this.tInstitutionInfo = tInstitutionInfo;
	}

	public String gettInstitutionContact() {
		return tInstitutionContact;
	}

	public void settInstitutionContact(String tInstitutionContact) {
		this.tInstitutionContact = tInstitutionContact;
	}

	public String gettInstituContactInfo() {
		return tInstituContactInfo;
	}

	public void settInstituContactInfo(String tInstituContactInfo) {
		this.tInstituContactInfo = tInstituContactInfo;
	}

	public String gettCourseName() {
		return tCourseName;
	}

	public void settCourseName(String tCourseName) {
		this.tCourseName = tCourseName;
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

	public Integer getCourseHours() {
		return courseHours;
	}

	public void setCourseHours(Integer courseHours) {
		this.courseHours = courseHours;
	}

	public BigDecimal getCoursePay() {
		return coursePay;
	}

	public void setCoursePay(BigDecimal coursePay) {
		this.coursePay = coursePay;
	}

	public String gettCourseTypes() {
		return tCourseTypes;
	}

	public void settCourseTypes(String tCourseTypes) {
		this.tCourseTypes = tCourseTypes;
	}

	public String gettDescription() {
		return tDescription;
	}

	public void settDescription(String tDescription) {
		this.tDescription = tDescription;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String gettAddress() {
		return tAddress;
	}

	public void settAddress(String tAddress) {
		this.tAddress = tAddress;
	}

	public String gettContent() {
		return tContent;
	}

	public void settContent(String tContent) {
		this.tContent = tContent;
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

	@Override
	protected Serializable pkVal() {
		return this.tPlanId;
	}

	@Override
	public String toString() {
		return "HrTrainingPlan{" +
			"tPlanId=" + tPlanId +
			", createUserId=" + createUserId +
			", createDeptId=" + createDeptId +
			", tPlanNo=" + tPlanNo +
			", tPlanName=" + tPlanName +
			", tChannel=" + tChannel +
			", tBcws=" + tBcws +
			", courseStartTime=" + courseStartTime +
			", courseEndTime=" + courseEndTime +
			", assessingOfficer=" + assessingOfficer +
			", assessingTime=" + assessingTime +
			", assessingView=" + assessingView +
			", assessingStatus=" + assessingStatus +
			", tJoinNum=" + tJoinNum +
			", tJoinDept=" + tJoinDept +
			", tJoinPerson=" + tJoinPerson +
			", tRequires=" + tRequires +
			", tInstitutionName=" + tInstitutionName +
			", tInstitutionInfo=" + tInstitutionInfo +
			", tInstitutionContact=" + tInstitutionContact +
			", tInstituContactInfo=" + tInstituContactInfo +
			", tCourseName=" + tCourseName +
			", sponsoringDepartment=" + sponsoringDepartment +
			", chargePerson=" + chargePerson +
			", courseHours=" + courseHours +
			", coursePay=" + coursePay +
			", tCourseTypes=" + tCourseTypes +
			", tDescription=" + tDescription +
			", remark=" + remark +
			", tAddress=" + tAddress +
			", tContent=" + tContent +
			", attachmentId=" + attachmentId +
			", attachmentName=" + attachmentName +
			", addTime=" + addTime +
			"}";
	}
}
