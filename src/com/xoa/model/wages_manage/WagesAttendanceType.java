package com.xoa.model.wages_manage;

import java.math.BigDecimal;
import java.util.List;

/**
 * 创建作者:   金帅强
 * 创建时间:   2021/11/26
 * 说明   ：   月考勤数据（考勤类型）
 */
public class WagesAttendanceType {
    private Integer attendTypeId;//自增唯一ID
    private String userId;//user表USER_ID
    private String userName;//姓名
    private String idNumber;//身份证号
    private String theYear;//年份
    private String theMonth;//月份
    private Integer jobManageId;//职务（薪岗）关联岗位薪资设置表ID
    private BigDecimal jobRatio;//薪岗比例
    private BigDecimal salaryTypea;//岗位薪资类型A
    private BigDecimal salaryTypeb;//岗位薪资类型B
    private BigDecimal salaryTypec;//岗位薪资类型C
    private BigDecimal salaryTyped;//岗位薪资类型D
    private BigDecimal salaryTypee;//岗位薪资类型E
    private BigDecimal salaryTypef;//岗位薪资类型F
    private String attendType1;//1日考勤类型(存储考勤类型设置表的类型代号TYPE_CODE)
    private String attendType2;//2日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType3;//3日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType4;//4日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType5;//5日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType6;//6日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType7;//7日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType8;//8日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType9;//9日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType10;//10日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType11;//11日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType12;//12日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType13;//13日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType14;//14日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType15;//15日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType16;//16日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType17;//17日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType18;//18日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType19;//19日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType20;//20日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType21;//21日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType22;//22日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType23;//23日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType24;//24日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType25;//25日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType26;//26日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType27;//27日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType28;//28日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType29;//29日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType30;//30日考勤类型(存储考勤类型设置表的类型代号)
    private String attendType31;//31日考勤类型(存储考勤类型设置表的类型代号)
    private String confirmStatus;//确认状态(0-待确认，1-已确认)
    private String remarks;//备注
    private List<WagesAttendanceTypeStatistics> list;//考勤类型合计List
    private List<WagesDailySalary> dailySalary;//考勤类型薪资合计List
    private String collection;

    public String getCollection() {
        return collection;
    }

    public void setCollection(String collection) {
        this.collection = collection;
    }

    public List<WagesDailySalary> getDailySalary() {
        return dailySalary;
    }

    public void setDailySalary(List<WagesDailySalary> dailySalary) {
        this.dailySalary = dailySalary;
    }

    private String oneAttendanceType;//某天的考勤类型
    private BigDecimal oneDaySalaryRatio;//某天的考勤比例
    private BigDecimal oneDayPerDiem;//某天的日薪
    private WagesAttendanceJob jobObject;//子表薪岗数据（用来确定是否排布）
    private String jobManageName;//薪岗名称
    private int attendTypeFlag1;
    private int attendTypeFlag2;
    private int attendTypeFlag3;
    private int attendTypeFlag4;
    private int attendTypeFlag5;
    private int attendTypeFlag6;
    private int attendTypeFlag7;
    private int attendTypeFlag8;
    private int attendTypeFlag9;
    private int attendTypeFlag10;
    private int attendTypeFlag11;
    private int attendTypeFlag12;
    private int attendTypeFlag13;
    private int attendTypeFlag14;
    private int attendTypeFlag15;
    private int attendTypeFlag16;
    private int attendTypeFlag17;
    private int attendTypeFlag18;
    private int attendTypeFlag19;
    private int attendTypeFlag20;
    private int attendTypeFlag21;
    private int attendTypeFlag22;
    private int attendTypeFlag23;
    private int attendTypeFlag24;
    private int attendTypeFlag25;
    private int attendTypeFlag26;
    private int attendTypeFlag27;
    private int attendTypeFlag28;
    private int attendTypeFlag29;
    private int attendTypeFlag30;
    private int attendTypeFlag31;

    public int getAttendTypeFlag1() {
        return attendTypeFlag1;
    }

    public void setAttendTypeFlag1(int attendTypeFlag1) {
        this.attendTypeFlag1 = attendTypeFlag1;
    }

    public int getAttendTypeFlag2() {
        return attendTypeFlag2;
    }

    public void setAttendTypeFlag2(int attendTypeFlag2) {
        this.attendTypeFlag2 = attendTypeFlag2;
    }

    public int getAttendTypeFlag3() {
        return attendTypeFlag3;
    }

    public void setAttendTypeFlag3(int attendTypeFlag3) {
        this.attendTypeFlag3 = attendTypeFlag3;
    }

    public int getAttendTypeFlag4() {
        return attendTypeFlag4;
    }

    public void setAttendTypeFlag4(int attendTypeFlag4) {
        this.attendTypeFlag4 = attendTypeFlag4;
    }

    public int getAttendTypeFlag5() {
        return attendTypeFlag5;
    }

    public void setAttendTypeFlag5(int attendTypeFlag5) {
        this.attendTypeFlag5 = attendTypeFlag5;
    }

    public int getAttendTypeFlag6() {
        return attendTypeFlag6;
    }

    public void setAttendTypeFlag6(int attendTypeFlag6) {
        this.attendTypeFlag6 = attendTypeFlag6;
    }

    public int getAttendTypeFlag7() {
        return attendTypeFlag7;
    }

    public void setAttendTypeFlag7(int attendTypeFlag7) {
        this.attendTypeFlag7 = attendTypeFlag7;
    }

    public int getAttendTypeFlag8() {
        return attendTypeFlag8;
    }

    public void setAttendTypeFlag8(int attendTypeFlag8) {
        this.attendTypeFlag8 = attendTypeFlag8;
    }

    public int getAttendTypeFlag9() {
        return attendTypeFlag9;
    }

    public void setAttendTypeFlag9(int attendTypeFlag9) {
        this.attendTypeFlag9 = attendTypeFlag9;
    }

    public int getAttendTypeFlag10() {
        return attendTypeFlag10;
    }

    public void setAttendTypeFlag10(int attendTypeFlag10) {
        this.attendTypeFlag10 = attendTypeFlag10;
    }

    public int getAttendTypeFlag11() {
        return attendTypeFlag11;
    }

    public void setAttendTypeFlag11(int attendTypeFlag11) {
        this.attendTypeFlag11 = attendTypeFlag11;
    }

    public int getAttendTypeFlag12() {
        return attendTypeFlag12;
    }

    public void setAttendTypeFlag12(int attendTypeFlag12) {
        this.attendTypeFlag12 = attendTypeFlag12;
    }

    public int getAttendTypeFlag13() {
        return attendTypeFlag13;
    }

    public void setAttendTypeFlag13(int attendTypeFlag13) {
        this.attendTypeFlag13 = attendTypeFlag13;
    }

    public int getAttendTypeFlag14() {
        return attendTypeFlag14;
    }

    public void setAttendTypeFlag14(int attendTypeFlag14) {
        this.attendTypeFlag14 = attendTypeFlag14;
    }

    public int getAttendTypeFlag15() {
        return attendTypeFlag15;
    }

    public void setAttendTypeFlag15(int attendTypeFlag15) {
        this.attendTypeFlag15 = attendTypeFlag15;
    }

    public int getAttendTypeFlag16() {
        return attendTypeFlag16;
    }

    public void setAttendTypeFlag16(int attendTypeFlag16) {
        this.attendTypeFlag16 = attendTypeFlag16;
    }

    public int getAttendTypeFlag17() {
        return attendTypeFlag17;
    }

    public void setAttendTypeFlag17(int attendTypeFlag17) {
        this.attendTypeFlag17 = attendTypeFlag17;
    }

    public int getAttendTypeFlag18() {
        return attendTypeFlag18;
    }

    public void setAttendTypeFlag18(int attendTypeFlag18) {
        this.attendTypeFlag18 = attendTypeFlag18;
    }

    public int getAttendTypeFlag19() {
        return attendTypeFlag19;
    }

    public void setAttendTypeFlag19(int attendTypeFlag19) {
        this.attendTypeFlag19 = attendTypeFlag19;
    }

    public int getAttendTypeFlag20() {
        return attendTypeFlag20;
    }

    public void setAttendTypeFlag20(int attendTypeFlag20) {
        this.attendTypeFlag20 = attendTypeFlag20;
    }

    public int getAttendTypeFlag21() {
        return attendTypeFlag21;
    }

    public void setAttendTypeFlag21(int attendTypeFlag21) {
        this.attendTypeFlag21 = attendTypeFlag21;
    }

    public int getAttendTypeFlag22() {
        return attendTypeFlag22;
    }

    public void setAttendTypeFlag22(int attendTypeFlag22) {
        this.attendTypeFlag22 = attendTypeFlag22;
    }

    public int getAttendTypeFlag23() {
        return attendTypeFlag23;
    }

    public void setAttendTypeFlag23(int attendTypeFlag23) {
        this.attendTypeFlag23 = attendTypeFlag23;
    }

    public int getAttendTypeFlag24() {
        return attendTypeFlag24;
    }

    public void setAttendTypeFlag24(int attendTypeFlag24) {
        this.attendTypeFlag24 = attendTypeFlag24;
    }

    public int getAttendTypeFlag25() {
        return attendTypeFlag25;
    }

    public void setAttendTypeFlag25(int attendTypeFlag25) {
        this.attendTypeFlag25 = attendTypeFlag25;
    }

    public int getAttendTypeFlag26() {
        return attendTypeFlag26;
    }

    public void setAttendTypeFlag26(int attendTypeFlag26) {
        this.attendTypeFlag26 = attendTypeFlag26;
    }

    public int getAttendTypeFlag27() {
        return attendTypeFlag27;
    }

    public void setAttendTypeFlag27(int attendTypeFlag27) {
        this.attendTypeFlag27 = attendTypeFlag27;
    }

    public int getAttendTypeFlag28() {
        return attendTypeFlag28;
    }

    public void setAttendTypeFlag28(int attendTypeFlag28) {
        this.attendTypeFlag28 = attendTypeFlag28;
    }

    public int getAttendTypeFlag29() {
        return attendTypeFlag29;
    }

    public void setAttendTypeFlag29(int attendTypeFlag29) {
        this.attendTypeFlag29 = attendTypeFlag29;
    }

    public int getAttendTypeFlag30() {
        return attendTypeFlag30;
    }

    public void setAttendTypeFlag30(int attendTypeFlag30) {
        this.attendTypeFlag30 = attendTypeFlag30;
    }

    public int getAttendTypeFlag31() {
        return attendTypeFlag31;
    }

    public void setAttendTypeFlag31(int attendTypeFlag31) {
        this.attendTypeFlag31 = attendTypeFlag31;
    }

    public Integer getAttendTypeId() {
        return attendTypeId;
    }

    public void setAttendTypeId(Integer attendTypeId) {
        this.attendTypeId = attendTypeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getTheYear() {
        return theYear;
    }

    public void setTheYear(String theYear) {
        this.theYear = theYear;
    }

    public String getTheMonth() {
        return theMonth;
    }

    public void setTheMonth(String theMonth) {
        this.theMonth = theMonth;
    }

    public Integer getJobManageId() {
        return jobManageId;
    }

    public void setJobManageId(Integer jobManageId) {
        this.jobManageId = jobManageId;
    }

    public BigDecimal getJobRatio() {
        return jobRatio;
    }

    public void setJobRatio(BigDecimal jobRatio) {
        this.jobRatio = jobRatio;
    }

    public BigDecimal getSalaryTypea() {
        return salaryTypea;
    }

    public void setSalaryTypea(BigDecimal salaryTypea) {
        this.salaryTypea = salaryTypea;
    }

    public BigDecimal getSalaryTypeb() {
        return salaryTypeb;
    }

    public void setSalaryTypeb(BigDecimal salaryTypeb) {
        this.salaryTypeb = salaryTypeb;
    }

    public BigDecimal getSalaryTypec() {
        return salaryTypec;
    }

    public void setSalaryTypec(BigDecimal salaryTypec) {
        this.salaryTypec = salaryTypec;
    }

    public BigDecimal getSalaryTyped() {
        return salaryTyped;
    }

    public void setSalaryTyped(BigDecimal salaryTyped) {
        this.salaryTyped = salaryTyped;
    }

    public BigDecimal getSalaryTypee() {
        return salaryTypee;
    }

    public void setSalaryTypee(BigDecimal salaryTypee) {
        this.salaryTypee = salaryTypee;
    }

    public BigDecimal getSalaryTypef() {
        return salaryTypef;
    }

    public void setSalaryTypef(BigDecimal salaryTypef) {
        this.salaryTypef = salaryTypef;
    }

    public String getAttendType1() {
        return attendType1;
    }

    public void setAttendType1(String attendType1) {
        this.attendType1 = attendType1;
    }

    public String getAttendType2() {
        return attendType2;
    }

    public void setAttendType2(String attendType2) {
        this.attendType2 = attendType2;
    }

    public String getAttendType3() {
        return attendType3;
    }

    public void setAttendType3(String attendType3) {
        this.attendType3 = attendType3;
    }

    public String getAttendType4() {
        return attendType4;
    }

    public void setAttendType4(String attendType4) {
        this.attendType4 = attendType4;
    }

    public String getAttendType5() {
        return attendType5;
    }

    public void setAttendType5(String attendType5) {
        this.attendType5 = attendType5;
    }

    public String getAttendType6() {
        return attendType6;
    }

    public void setAttendType6(String attendType6) {
        this.attendType6 = attendType6;
    }

    public String getAttendType7() {
        return attendType7;
    }

    public void setAttendType7(String attendType7) {
        this.attendType7 = attendType7;
    }

    public String getAttendType8() {
        return attendType8;
    }

    public void setAttendType8(String attendType8) {
        this.attendType8 = attendType8;
    }

    public String getAttendType9() {
        return attendType9;
    }

    public void setAttendType9(String attendType9) {
        this.attendType9 = attendType9;
    }

    public String getAttendType10() {
        return attendType10;
    }

    public void setAttendType10(String attendType10) {
        this.attendType10 = attendType10;
    }

    public String getAttendType11() {
        return attendType11;
    }

    public void setAttendType11(String attendType11) {
        this.attendType11 = attendType11;
    }

    public String getAttendType12() {
        return attendType12;
    }

    public void setAttendType12(String attendType12) {
        this.attendType12 = attendType12;
    }

    public String getAttendType13() {
        return attendType13;
    }

    public void setAttendType13(String attendType13) {
        this.attendType13 = attendType13;
    }

    public String getAttendType14() {
        return attendType14;
    }

    public void setAttendType14(String attendType14) {
        this.attendType14 = attendType14;
    }

    public String getAttendType15() {
        return attendType15;
    }

    public void setAttendType15(String attendType15) {
        this.attendType15 = attendType15;
    }

    public String getAttendType16() {
        return attendType16;
    }

    public void setAttendType16(String attendType16) {
        this.attendType16 = attendType16;
    }

    public String getAttendType17() {
        return attendType17;
    }

    public void setAttendType17(String attendType17) {
        this.attendType17 = attendType17;
    }

    public String getAttendType18() {
        return attendType18;
    }

    public void setAttendType18(String attendType18) {
        this.attendType18 = attendType18;
    }

    public String getAttendType19() {
        return attendType19;
    }

    public void setAttendType19(String attendType19) {
        this.attendType19 = attendType19;
    }

    public String getAttendType20() {
        return attendType20;
    }

    public void setAttendType20(String attendType20) {
        this.attendType20 = attendType20;
    }

    public String getAttendType21() {
        return attendType21;
    }

    public void setAttendType21(String attendType21) {
        this.attendType21 = attendType21;
    }

    public String getAttendType22() {
        return attendType22;
    }

    public void setAttendType22(String attendType22) {
        this.attendType22 = attendType22;
    }

    public String getAttendType23() {
        return attendType23;
    }

    public void setAttendType23(String attendType23) {
        this.attendType23 = attendType23;
    }

    public String getAttendType24() {
        return attendType24;
    }

    public void setAttendType24(String attendType24) {
        this.attendType24 = attendType24;
    }

    public String getAttendType25() {
        return attendType25;
    }

    public void setAttendType25(String attendType25) {
        this.attendType25 = attendType25;
    }

    public String getAttendType26() {
        return attendType26;
    }

    public void setAttendType26(String attendType26) {
        this.attendType26 = attendType26;
    }

    public String getAttendType27() {
        return attendType27;
    }

    public void setAttendType27(String attendType27) {
        this.attendType27 = attendType27;
    }

    public String getAttendType28() {
        return attendType28;
    }

    public void setAttendType28(String attendType28) {
        this.attendType28 = attendType28;
    }

    public String getAttendType29() {
        return attendType29;
    }

    public void setAttendType29(String attendType29) {
        this.attendType29 = attendType29;
    }

    public String getAttendType30() {
        return attendType30;
    }

    public void setAttendType30(String attendType30) {
        this.attendType30 = attendType30;
    }

    public String getAttendType31() {
        return attendType31;
    }

    public void setAttendType31(String attendType31) {
        this.attendType31 = attendType31;
    }

    public String getConfirmStatus() {
        return confirmStatus;
    }

    public void setConfirmStatus(String confirmStatus) {
        this.confirmStatus = confirmStatus;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public List<WagesAttendanceTypeStatistics> getList() {
        return list;
    }

    public void setList(List<WagesAttendanceTypeStatistics> list) {
        this.list = list;
    }

    public BigDecimal getOneDaySalaryRatio() {
        return oneDaySalaryRatio;
    }

    public void setOneDaySalaryRatio(BigDecimal oneDaySalaryRatio) {
        this.oneDaySalaryRatio = oneDaySalaryRatio;
    }

    public BigDecimal getOneDayPerDiem() {
        return oneDayPerDiem;
    }

    public void setOneDayPerDiem(BigDecimal oneDayPerDiem) {
        this.oneDayPerDiem = oneDayPerDiem;
    }

    public String getOneAttendanceType() {
        return oneAttendanceType;
    }

    public void setOneAttendanceType(String oneAttendanceType) {
        this.oneAttendanceType = oneAttendanceType;
    }

    public WagesAttendanceJob getJobObject() {
        return jobObject;
    }

    public void setJobObject(WagesAttendanceJob jobObject) {
        this.jobObject = jobObject;
    }

    public String getJobManageName() {
        return jobManageName;
    }

    public void setJobManageName(String jobManageName) {
        this.jobManageName = jobManageName;
    }
}
