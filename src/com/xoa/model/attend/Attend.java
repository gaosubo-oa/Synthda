package com.xoa.model.attend;

import com.alibaba.fastjson.annotation.JSONField;
import com.xoa.model.enclosure.Attachment;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 
 * 创建作者:   王曰岐
 * 创建日期:   2017-6-8 上午11:32:24
 * 类介绍  :    手机考勤
 * 构造参数:   
 *
 */
public class Attend {
	/**
	 * 唯一自增ID
	 */
    private Integer aid;
    /**
     * 登记uid
     */
    private Integer uid;
    /**
     * 登记日期
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date date;
    /**
     * 打卡次数
     */
    private String type;
    /**
     * 打卡类型
     */
    private String attendSetType;
    /**
     * 打卡时间
     */
    private Integer atime;
    /**
     * 规定工作时长
     */
    private String workHours;
    /**
     * 实际工作时长
     */
    private String actualWorkHours;
    /**
     * 是否全勤(仅针对弹性工时)
     */
    private boolean IsFullAttend;
    /**
     * 定位地点名称
     */
    private String address;
    /**
     * 备注
     */
    private String remark;
    /**
     *打卡手机ID号
     */
    private String phoneId;
    /**
     * 设备型号
     */
    private String device;
    /**
     * 附件ID
     */
    private String fileId;
    /**
     * 附件名字
     */
    private String fileName;
    /**
     * 打卡状态
     */
    private String typeSign;

    /**
     * 打卡信息对应的打卡类型
     */
    private AttendSet attendSet;

    /**
     * 打卡IP
     * @return
     */
    private String signIp;

    public String getSignIp() {
        return signIp;
    }

    public void setSignIp(String signIp) {
        this.signIp = signIp;
    }

    public String getTypeSign() {
        return typeSign;
    }

    public void setTypeSign(String typeSign) {
        this.typeSign = typeSign;
    }

    public AttendSet getAttendSet() {
        return attendSet;
    }

    public void setAttendSet(AttendSet attendSet) {
        this.attendSet = attendSet;
    }

    public List<Attend> getOverTimeWork() {
        return overTimeWork;
    }

    public String getAttendSetType() {
        return attendSetType;
    }

    public void setAttendSetType(String attendSetType) {
        this.attendSetType = attendSetType;
    }

    private String atimestate;//状态

    private String num;//第几次

    private String swi;//开关

    private String commute;//上班下班

    private  List<Attend> attendList;

    private  List<Attend> legwork;//外勤

    private  List<Attend> overTimeWork;//加班

    private  List<Attend> dutyWork;//值班开始

    private List<Attend> remarkList;//出勤list

    private List<Date> listDate;//详情登记时间


    private List<String> lists ;//详情打卡时间

    private List<String> start ;//打卡状态

    private String dateStr; //打卡日期

    public String getDateStr() {
        return dateStr;
    }

    public void setDateStr(String dateStr) {
        this.dateStr = dateStr;
    }

    public void setListDate(List<Date> listDate) {
        this.listDate = listDate;
    }

    public void setLists(List<String> lists) {
        this.lists = lists;
    }

    public void setStart(List<String> start) {
        this.start = start;
    }

    public List<Date> getListDate() {
        return listDate;
    }

    public List<String> getLists() {
        return lists;
    }

    public List<String> getStart() {
        return start;
    }

    private String week;

    private String sname;

    private String dateName;

    private String time;

    private String state;
    private Integer count;
    private String msg;
    private List<Attend> list;

    private List<AttendSet> switchList;

    public List<AttendSet> getSwitchList() {
        return switchList;
    }

    public void setSwitchList(List<AttendSet> switchList) {
        this.switchList = switchList;
    }

    private Integer userAll;//全部

    private Integer userSize;//实际

    private String ava;//头像

    private  String userName;//用户名字

    private  String depName;//部门名字

    private  Integer userPriv;


    private  String userPrivNo;


    private  String userPrivName;

    private String startTime;//第一次上班时间

    private String endTime;//最后一次下班时间

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public void setUserPriv(Integer userPriv) {
        this.userPriv = userPriv;
    }

    public void setUserPrivNo(String userPrivNo) {
        this.userPrivNo = userPrivNo;
    }

    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }

    public String getUserPrivNo() {
        return userPrivNo;
    }

    public String getUserPrivName() {
        return userPrivName;
    }

    public Integer getUserPriv() {
        return userPriv;
    }


    private  List<Attendance> attendances;//出勤
    private  List<Normal> normals;//正常
    private  List<Field> fields;//外勤
    private List<LeaveEarly> leaveEarlies;//早退
    private List<LackCard> lackCards;//缺卡
    private  List<Late> lates;//迟到
    private  List<Absenteeism> absenteeisms;//旷工
    private List<AttendanceOvertime> AttendanceOvertime;//加班
    private List<AttendEvection> AttendEvection;//出差
    private List<AttendLeave> AttendLeave;//请假
    private List<AttendOut> AttendOut;//外出
    private List<UnitException> unitExceptions;//设备异常
    private List<BaseAttend> remarksList=new ArrayList<BaseAttend>();//
    private List<BaseSupplement> baseSupplements=new ArrayList<BaseSupplement>();//

    private  List<AttendStatistics> attendStatistics= new ArrayList<>();

    public List<AttendStatistics> getAttendStatistics() {
        return attendStatistics;
    }

    public void setAttendStatistics(List<AttendStatistics> attendStatistics) {
        this.attendStatistics = attendStatistics;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public String getAva() {
        return ava;
    }

    public void setAva(String ava) {
        this.ava = ava;
    }

    public Integer getUserAll() {
        return userAll;
    }

    public void setUserAll(Integer userAll) {
        this.userAll = userAll;
    }

    public Integer getUserSize() {
        return userSize;
    }

    public void setUserSize(Integer userSize) {
        this.userSize = userSize;
    }

    public List<BaseSupplement> getBaseSupplements() {
        return baseSupplements;
    }

    public void setBaseSupplements(List<BaseSupplement> baseSupplements) {
        this.baseSupplements = baseSupplements;
    }

    public List<BaseAttend> getRemarksList() {
        return remarksList;
    }

    public void setRemarksList(List<BaseAttend> remarksList) {
        this.remarksList = remarksList;
    }

    public List<com.xoa.model.attend.AttendanceOvertime> getAttendanceOvertime() {
        return AttendanceOvertime;
    }

    public void setAttendanceOvertime(List<com.xoa.model.attend.AttendanceOvertime> attendanceOvertime) {
        AttendanceOvertime = attendanceOvertime;
    }

    public List<com.xoa.model.attend.AttendEvection> getAttendEvection() {
        return AttendEvection;
    }

    public void setAttendEvection(List<com.xoa.model.attend.AttendEvection> attendEvection) {
        AttendEvection = attendEvection;
    }

    public List<com.xoa.model.attend.AttendLeave> getAttendLeave() {
        return AttendLeave;
    }

    public void setAttendLeave(List<com.xoa.model.attend.AttendLeave> attendLeave) {
        AttendLeave = attendLeave;
    }

    public List<com.xoa.model.attend.AttendOut> getAttendOut() {
        return AttendOut;
    }

    public void setAttendOut(List<com.xoa.model.attend.AttendOut> attendOut) {
        AttendOut = attendOut;
    }

    public List<Attendance> getAttendances() {
        return attendances;
    }

    public void setAttendances(List<Attendance> attendances) {
        this.attendances = attendances;
    }

    public List<Normal> getNormals() {
        return normals;
    }

    public void setNormals(List<Normal> normals) {
        this.normals = normals;
    }

    public List<Field> getFields() {
        return fields;
    }

    public void setFields(List<Field> fields) {
        this.fields = fields;
    }

    public List<LeaveEarly> getLeaveEarlies() {
        return leaveEarlies;
    }

    public void setLeaveEarlies(List<LeaveEarly> leaveEarlies) {
        this.leaveEarlies = leaveEarlies;
    }

    public List<LackCard> getLackCards() {
        return lackCards;
    }

    public void setLackCards(List<LackCard> lackCards) {
        this.lackCards = lackCards;
    }

    public List<Late> getLates() {
        return lates;
    }

    public void setLates(List<Late> lates) {
        this.lates = lates;
    }

    public List<Absenteeism> getAbsenteeisms() {
        return absenteeisms;
    }

    public void setAbsenteeisms(List<Absenteeism> absenteeisms) {
        this.absenteeisms = absenteeisms;
    }

    public List<UnitException> getUnitExceptions() {
        return unitExceptions;
    }

    public void setUnitExceptions(List<UnitException> unitExceptions) {
        this.unitExceptions = unitExceptions;
    }

    public List<Attend> getList() {
        return list;
    }

    public void setList(List<Attend> list) {
        this.list = list;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }



    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDateName() {
        return dateName;
    }

    public void setDateName(String dateName) {
        this.dateName = dateName;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getSwi() {
        return swi;
    }

    public void setSwi(String swi) {
        this.swi = swi;
    }

    public String getCommute() {
        return commute;
    }

    public void setCommute(String commute) {
        this.commute = commute;
    }



    public List<Attend> getRemarkList() {
        return remarkList;
    }

    public void setRemarkList(List<Attend> remarkList) {
        this.remarkList = remarkList;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    /**
     * 附件对象
     */
    private List<Attachment> attachment;

    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    public List<Attend> getLegwork() {
        return legwork;
    }

    public void setLegwork(List<Attend> legwork) {
        this.legwork = legwork;
    }

    public List<Attend> getAttendList() {
        return attendList;
    }

    public void setAttendList(List<Attend> attendList) {
        this.attendList = attendList;
    }

    private List<AttendSet>  attendSetList;

    public List<AttendSet> getAttendSetList() {
        return attendSetList;
    }

    public void setAttendSetList(List<AttendSet> attendSetList) {
        this.attendSetList = attendSetList;
    }

    public String getAtimestate() {
        return atimestate;
    }

    public void setAtimestate(String atimestate) {
        this.atimestate = atimestate;
    }

    public String getWorkHours() {
        return workHours;
    }

    public void setWorkHours(String workHours) {
        this.workHours = workHours;
    }

    public String getActualWorkHours() {
        return actualWorkHours;
    }

    public void setActualWorkHours(String actualWorkHours) {
        this.actualWorkHours = actualWorkHours;
    }

    public boolean getIsFullAttend() {
        return IsFullAttend;
    }

    public void setIsFullAttend(boolean fullAttend) {
        IsFullAttend = fullAttend;
    }

    public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Integer getAtime() {
        return atime;
    }

    public void setAtime(Integer atime) {
        this.atime = atime;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getPhoneId() {
        return phoneId;
    }

    public void setPhoneId(String phoneId) {
        this.phoneId = phoneId == null ? null : phoneId.trim();
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device == null ? null : device.trim();
    }

    private String attendStatus;

    public String getAttendStatus() {
        return attendStatus;
    }

    public void setAttendStatus(String attendStatus) {
        this.attendStatus = attendStatus;
    }

    public List<Attend> getOverTimeWork1() {
        return overTimeWork;
    }

    public void setOverTimeWork(List<Attend> overTimeWork) {
        this.overTimeWork = overTimeWork;
    }

    public List<Attend> getDutyWork() {
        return dutyWork;
    }

    public void setDutyWork(List<Attend> dutyWork) {
        this.dutyWork = dutyWork;
    }

    /**
    * @创建作者:李然  Lr
    * @方法描述：
    * @创建时间：18:01 2019/3/11

    **/
    private String yTime;//应打卡时间
    private String aTime;//实际打卡时间

    public String getyTime() {
        return yTime;
    }

    public void setyTime(String yTime) {
        this.yTime = yTime;
    }

    public String getaTime() {
        return aTime;
    }

    public void setaTime(String aTime) {
        this.aTime = aTime;
    }
}