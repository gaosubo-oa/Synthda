package com.xoa.model.diary;

import com.xoa.model.enclosure.Attachment;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;
/**
 * 
 * 创建作者:   杨 胜
 * 创建日期:   2017-4-19 上午10:58:29
 * 类介绍  :    工作日志表实体类 
 * 构造参数:   
 *
 */
public class DiaryModel {

    //权限查询
    private String userIds;
    private String userPrivs;
    private String deptIds;

    public String getUserIds() {
        return userIds;
    }

    public void setUserIds(String userIds) {
        this.userIds = userIds;
    }

    public String getUserPrivs() {
        return userPrivs;
    }

    public void setUserPrivs(String userPrivs) {
        this.userPrivs = userPrivs;
    }

    public String getDeptIds() {
        return deptIds;
    }

    public void setDeptIds(String deptIds) {
        this.deptIds = deptIds;
    }

    /**
     * 唯一自增ID
     */
    private Integer diaId;
    /**
     * 用户ID
     */
    private String userId;
    /**
     * 用户name
     */
    private String userName;
    private Integer  uid;

    private String editFlag;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName==null?"":userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    String sex;

    private Integer shareAll;
    private Integer sendRemind;

    public Integer getShareAll() {
        return shareAll;
    }

    public void setShareAll(Integer shareAll) {
        this.shareAll = shareAll;
    }

    public Integer getSendRemind() {
        return sendRemind;
    }

    public void setSendRemind(Integer sendRemind) {
        this.sendRemind = sendRemind;
    }
    /**
	 * @return the sex
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * @param sex the sex to set
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
     * 日志日期  '0000-00-00'
     */
    private String diaDate;
    //结束时间
    private String timeEnd;

    public String getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(String timeEnd) {
        this.timeEnd = timeEnd;
    }

    /**
     * 最近一次的编辑时间
     */
    private String diaTime;
    /**
     * 日志类型(1-工作日志,2-个人日志)
     */
    private String diaType;//diaType(日志类型(1-工作日志,2-个人日志))、 subject（日志标题）、content（日志内容）、toAll（是否全部共享(0-否,1-是)）、toId（共享用户ID串）、attachmentId（附件ID串）、attachmentName（附件名称串）
    /**
     * 日志标题
     */
    private String subject;
    /**
     * 日志内容
     */
    private String content;
    /**
     * 最近一次被点评的时间
     */
    private String lastCommentTime;
    /**
     * 是否全部共享(0-否,1-是)
     */
    private Integer toAll;
    /**
     * 是否CRM日志
     */
    private Integer crmDiary;
    /**
     * 附件ID串
     */
    private String attachmentId;
    /**
     * 附件名称串
     */
    private String attachmentName;
    /**
     * 共享用户ID串
     */
    private String toId;
    /**
     * 压缩后的日志内容
     */
    private String compressContent;
    /**
     * 阅读人员ID串
     */
    private String readers;
    /**
     * 标识
     */
    private String postType;

    // 该日志的总评论数
    private Integer comTotal;
    // 阅读人姓名
    private String readersName;
    // 是否他人允许评论 0 不允许 1允许
    private Integer isComments;

    private DiaryTop diaryTop;//置顶信息
    private String topFlag;//置顶标记，置顶为1，取消置顶为0
    // 角色名称
    private String userPrivName;
    // 部门id
    private Integer deptId;
    // 部门名称
    private String deptName;
    //汇报上级用户ID串
    private String userTopId;
    //汇报上级用户名称
    private String userTopIdName;
    //是否提交  0草稿 1已提交
    private String sFlag;
    //是否允许点评（1允许  0不允许）
    private Integer allowComment;

    //查询开始时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startTime;
    //查询结束时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endTime;
    //日志类型名称
    private String diaTypeName;
    //日志已汇报
    private Integer reported;
    //日志未汇报
    private Integer notReported;

    //全部日志数量
    private Integer allDiaryNumber;
    //我的日志数量
    private Integer myDiaryNumber;
    //他人日志数量
    private Integer othersDiaryNumber;
    //查询范围
    private Integer moduleId;
    //查询范围名称
    private String moduleIdName;

    //评论人
    private String commenter;
    //阅读状态
    private String readingStatus;
    //点评状态
    private String commentStatus;

    //一级部门
    public String oneDeptName;
    //二级部门
    public String twoDeptName;
    //三级部门
    public String threeDeptName;
    //四级部门
    public String fourDeptName;
    //用户工号
    public String byName;
    //辅助角色
    public String userPrivOther;
    //辅助角色名称
    public String userPrivOtherName;
    //区间时间内是否有提交日志，1-有
    public String isFlag;
    //评阅内容
    public String commentTxt;
    //评阅字数
    public Integer commentLength;
    //有无超过15个字
    public String commentLengthJudge;
    //序号
    public Integer serialNumber;

    //查阅数
    public Integer numberOfQueries;

    //下一篇日志id
    private Integer diaNextId;

    //下一篇日志名称
    private String diaNextTitle;

    //上一篇日志id
    private Integer diaPreId;

    //上一篇日志名称
    private String diaPreTitle;

    private List<DiaryRefer> diaryReferList;

    //是否在管理范围
    private String ismodulePrivUser;

    //是否是下属日志高级查询
    private String isSubordinateLog;

    //处理富文本后的内容
    private String contentStr;

    //是否使用中高管模板
    private String isZhongGaoGuan;

    // 密级：系统代码
    private String contentSecrecy;

    // 密级名称
    private String contentSecrecyName;

    private boolean isShowSecret;// 是否开启 系统参数：模块数据显示密级字段

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getDiaTypeName() {
        return diaTypeName;
    }

    public void setDiaTypeName(String diaTypeName) {
        this.diaTypeName = diaTypeName;
    }

    public Integer getReported() {
        return reported;
    }

    public void setReported(Integer reported) {
        this.reported = reported;
    }

    public Integer getNotReported() {
        return notReported;
    }

    public void setNotReported(Integer notReported) {
        this.notReported = notReported;
    }

    public String getUserTopId() {
        return userTopId;
    }

    public void setUserTopId(String userTopId) {
        this.userTopId = userTopId;
    }

    public String getUserTopIdName() {
        return userTopIdName;
    }

    public void setUserTopIdName(String userTopIdName) {
        this.userTopIdName = userTopIdName;
    }

    public String getsFlag() {
        return sFlag;
    }

    public void setsFlag(String sFlag) {
        this.sFlag = sFlag;
    }

    public Integer getAllowComment() {
        return allowComment;
    }

    public void setAllowComment(Integer allowComment) {
        this.allowComment = allowComment;
    }

    public Integer getAllDiaryNumber() {
        return allDiaryNumber;
    }

    public void setAllDiaryNumber(Integer allDiaryNumber) {
        this.allDiaryNumber = allDiaryNumber;
    }

    public Integer getMyDiaryNumber() {
        return myDiaryNumber;
    }

    public void setMyDiaryNumber(Integer myDiaryNumber) {
        this.myDiaryNumber = myDiaryNumber;
    }

    public Integer getOthersDiaryNumber() {
        return othersDiaryNumber;
    }

    public void setOthersDiaryNumber(Integer othersDiaryNumber) {
        this.othersDiaryNumber = othersDiaryNumber;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleIdName() {
        return moduleIdName;
    }

    public void setModuleIdName(String moduleIdName) {
        this.moduleIdName = moduleIdName;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public String getReadingStatus() {
        return readingStatus;
    }

    public void setReadingStatus(String readingStatus) {
        this.readingStatus = readingStatus;
    }

    public String getCommentStatus() {
        return commentStatus;
    }

    public void setCommentStatus(String commentStatus) {
        this.commentStatus = commentStatus;
    }

    public String getOneDeptName() {
        return oneDeptName;
    }

    public void setOneDeptName(String oneDeptName) {
        this.oneDeptName = oneDeptName;
    }

    public String getTwoDeptName() {
        return twoDeptName;
    }

    public void setTwoDeptName(String twoDeptName) {
        this.twoDeptName = twoDeptName;
    }

    public String getThreeDeptName() {
        return threeDeptName;
    }

    public void setThreeDeptName(String threeDeptName) {
        this.threeDeptName = threeDeptName;
    }

    public String getFourDeptName() {
        return fourDeptName;
    }

    public void setFourDeptName(String fourDeptName) {
        this.fourDeptName = fourDeptName;
    }

    public String getByName() {
        return byName;
    }

    public void setByName(String byName) {
        this.byName = byName;
    }

    public String getUserPrivOther() {
        return userPrivOther;
    }

    public void setUserPrivOther(String userPrivOther) {
        this.userPrivOther = userPrivOther;
    }

    public String getUserPrivOtherName() {
        return userPrivOtherName;
    }

    public void setUserPrivOtherName(String userPrivOtherName) {
        this.userPrivOtherName = userPrivOtherName;
    }

    public String getIsFlag() {
        return isFlag;
    }

    public void setIsFlag(String isFlag) {
        this.isFlag = isFlag;
    }

    public String getCommentTxt() {
        return commentTxt;
    }

    public void setCommentTxt(String commentTxt) {
        this.commentTxt = commentTxt;
    }

    public Integer getCommentLength() {
        return commentLength;
    }

    public void setCommentLength(Integer commentLength) {
        this.commentLength = commentLength;
    }

    public String getCommentLengthJudge() {
        return commentLengthJudge;
    }

    public void setCommentLengthJudge(String commentLengthJudge) {
        this.commentLengthJudge = commentLengthJudge;
    }

    public Integer getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(Integer serialNumber) {
        this.serialNumber = serialNumber;
    }

    public Integer getNumberOfQueries() {
        return numberOfQueries;
    }

    public void setNumberOfQueries(Integer numberOfQueries) {
        this.numberOfQueries = numberOfQueries;
    }

    //***************************************附件生成json转换***************************************
    private List<Attachment> attachment;

    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    /**
     * 返回共享人名字
     */
    String toIdName;

    String photo;//名片

    String avatar;//自定义小头像

    String searchValue; // 模糊查询参数
    //***************************************附件生成json转换***************************************


    public String getSearchValue() {
        return searchValue;
    }

    public void setSearchValue(String searchValue) {
        this.searchValue = searchValue;
    }

    public Integer getIsComments() {
        return isComments==null?0:isComments;
    }

    public void setIsComments(Integer isComments) {
        this.isComments = isComments;
    }

    public String getToIdName() {
        return toIdName==null?"":toIdName;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public void setToIdName(String toIdName) {
        this.toIdName = toIdName;
    }

    //***************************************标识发送请求方式 ，根据不同的参数进行不同的程序处理***************************************
    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }
    //***************************************标识发送请求方式***************************************

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:36:20
     * 方法介绍:   日志日期 '0000-00-00'
     * 参数说明:   @return
     *
     * @return String
     */
    public String getDiaDate() {
        return diaDate;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:40:07
     * 方法介绍:   日志日期 '0000-00-00'
     * 参数说明:   @param diaDate
     *
     * @return void
     */
    public void setDiaDate(String diaDate) {
        this.diaDate = diaDate;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:40:23
     * 方法介绍:   最近一次的编辑时间
     * 参数说明:   @return
     *
     * @return String
     */
    public String getDiaTime() {
        return diaTime==null?"":diaTime;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:40:36
     * 方法介绍:   最近一次的编辑时间
     * 参数说明:   @param diaTime
     *
     * @return void
     */
    public void setDiaTime(String diaTime) {
        this.diaTime = diaTime;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:40:49
     * 方法介绍:   最近一次的编辑时间
     * 参数说明:   @return
     *
     * @return String
     */
    public String getLastCommentTime() {
        return lastCommentTime==null?"":lastCommentTime;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:41:01
     * 方法介绍:   最近一次的编辑时间
     * 参数说明:   @param lastCommentTime
     *
     * @return void
     */
    public void setLastCommentTime(String lastCommentTime) {
        this.lastCommentTime = lastCommentTime;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:41:13
     * 方法介绍:   content
     * 参数说明:   @return
     *
     * @return String
     */
    public String getContent() {
        return content;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:41:21
     * 方法介绍:   日志内容
     * 参数说明:   @param content
     *
     * @return void
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:41:44
     * 方法介绍:   附件ID串
     * 参数说明:   @return
     *
     * @return String
     */
    public String getAttachmentId() {
        return attachmentId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:42:06
     * 方法介绍:   附件ID串
     * 参数说明:   @param attachmentId
     *
     * @return void
     */
    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId == null ? null : attachmentId.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:42:19
     * 方法介绍:   附件名称串
     * 参数说明:   @return
     *
     * @return String
     */
    public String getAttachmentName() {
        return attachmentName;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:42:32
     * 方法介绍:   附件名称串
     * 参数说明:   @param attachmentName
     *
     * @return void
     */
    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName == null ? null : attachmentName.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:42:45
     * 方法介绍:   共享用户ID串
     * 参数说明:   @return
     *
     * @return String
     */
    public String getToId() {
        return toId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:42:56
     * 方法介绍:   共享用户ID串
     * 参数说明:   @param toId
     *
     * @return void
     */
    public void setToId(String toId) {
        this.toId = toId == null ? null : toId.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:47:13
     * 方法介绍:   压缩后的日志内容
     * 参数说明:   @return
     *
     * @return byte[]
     */
    public String getCompressContent() {
        return compressContent;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:47:26
     * 方法介绍:   压缩后的日志内容
     * 参数说明:   @param compressContent
     *
     * @return void
     */
    public void setCompressContent(String compressContent) {
        this.compressContent = compressContent;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:47:46
     * 方法介绍:   阅读人员ID串
     * 参数说明:   @return
     *
     * @return String
     */
    public String getReaders() {
        return readers;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:47:58
     * 方法介绍:   阅读人员ID串
     * 参数说明:   @param readers
     *
     * @return void
     */
    public void setReaders(String readers) {
        this.readers = readers == null ? null : readers.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:11
     * 方法介绍:   唯一自增ID
     * 参数说明:   @return
     *
     * @return Integer
     */
    public Integer getDiaId() {
        return diaId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:24
     * 方法介绍:   唯一自增ID
     * 参数说明:   @param diaId
     *
     * @return void
     */
    public void setDiaId(Integer diaId) {
        this.diaId = diaId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:38
     * 方法介绍:   用户ID
     * 参数说明:   @return
     *
     * @return String
     */
    public String getUserId() {
        return userId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:50
     * 方法介绍:   用户ID
     * 参数说明:   @param userId
     *
     * @return void
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:49:04
     * 方法介绍:   日志类型(1-工作日志,2-个人日志)
     * 参数说明:   @return
     *
     * @return String
     */
    public String getDiaType() {
        return diaType;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:49:15
     * 方法介绍:   日志类型(1-工作日志,2-个人日志)
     * 参数说明:   @param diaType
     *
     * @return void
     */
    public void setDiaType(String diaType) {
        this.diaType = diaType == null ? null : diaType.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:56:05
     * 方法介绍:   日志类型(1-工作日志,2-个人日志)
     * 参数说明:   @return
     *
     * @return String
     */
    public String getSubject() {
        return subject;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:56:41
     * 方法介绍:   日志标题
     * 参数说明:   @param subject
     *
     * @return void
     */
    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:56:58
     * 方法介绍:   是否全部共享(0-否,1-是)
     * 参数说明:   @return
     *
     * @return Integer
     */
    public Integer getToAll() {
        return toAll;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:57:24
     * 方法介绍:   是否全部共享(0-否,1-是)
     * 参数说明:   @param toAll
     *
     * @return void
     */
    public void setToAll(Integer toAll) {
        this.toAll = toAll;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:57:47
     * 方法介绍:   是否CRM日志
     * 参数说明:   @return
     *
     * @return Integer
     */
    public Integer getCrmDiary() {
        return crmDiary;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:58:00
     * 方法介绍:   是否CRM日志
     * 参数说明:   @param crmDiary
     *
     * @return void
     */
    public void setCrmDiary(Integer crmDiary) {
        this.crmDiary = crmDiary;
    }

    public DiaryTop getDiaryTop() {
        return diaryTop;
    }

    public void setDiaryTop(DiaryTop diaryTop) {
        this.diaryTop = diaryTop;
    }

    public String getTopFlag() {
        return topFlag;
    }

    public void setTopFlag(String topFlag) {
        this.topFlag = topFlag;
    }

    public Integer getComTotal() {
        return comTotal;
    }

    public void setComTotal(Integer comTotal) {
        this.comTotal = comTotal;
    }

    public String getReadersName() {
        return readersName;
    }

    public void setReadersName(String readersName) {
        this.readersName = readersName;
    }

    public String getUserPrivName() {
        return userPrivName==null?"":userPrivName;
    }

    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }

    public String getDeptName() {
        return deptName==null?"":deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getEditFlag() {
        return editFlag;
    }

    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }
    private String sm;
    public void setSm(String sm) {
        this.sm = sm;
    }

    public String getSm() {
        return sm;
    }

    public Integer getDiaNextId() {
        return diaNextId;
    }

    public void setDiaNextId(Integer diaNextId) {
        this.diaNextId = diaNextId;
    }

    public String getDiaNextTitle() {
        return diaNextTitle;
    }

    public void setDiaNextTitle(String diaNextTitle) {
        this.diaNextTitle = diaNextTitle;
    }

    public Integer getDiaPreId() {
        return diaPreId;
    }

    public void setDiaPreId(Integer diaPreId) {
        this.diaPreId = diaPreId;
    }

    public String getDiaPreTitle() {
        return diaPreTitle;
    }

    public void setDiaPreTitle(String diaPreTitle) {
        this.diaPreTitle = diaPreTitle;
    }

    public List<DiaryRefer> getDiaryReferList() {
        return diaryReferList;
    }

    public void setDiaryReferList(List<DiaryRefer> diaryReferList) {
        this.diaryReferList = diaryReferList;
    }

    public String getIsmodulePrivUser() {
        return ismodulePrivUser;
    }

    public void setIsmodulePrivUser(String ismodulePrivUser) {
        this.ismodulePrivUser = ismodulePrivUser;
    }

    public String getIsSubordinateLog() {
        return isSubordinateLog;
    }

    public void setIsSubordinateLog(String isSubordinateLog) {
        this.isSubordinateLog = isSubordinateLog;
    }

    public String getContentStr() {
        return contentStr;
    }

    public void setContentStr(String contentStr) {
        this.contentStr = contentStr;
    }

    public String getIsZhongGaoGuan() {
        return isZhongGaoGuan;
    }

    public void setIsZhongGaoGuan(String isZhongGaoGuan) {
        this.isZhongGaoGuan = isZhongGaoGuan;
    }

    public String getContentSecrecy() {
        return contentSecrecy;
    }

    public void setContentSecrecy(String contentSecrecy) {
        this.contentSecrecy = contentSecrecy;
    }

    public String getContentSecrecyName() {
        return contentSecrecyName;
    }

    public void setContentSecrecyName(String contentSecrecyName) {
        this.contentSecrecyName = contentSecrecyName;
    }

    public boolean isShowSecret() {
        return isShowSecret;
    }

    public void setShowSecret(boolean showSecret) {
        isShowSecret = showSecret;
    }
}

