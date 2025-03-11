package com.xoa.model.im;


public class ImRoom{
	
    private Integer rid;//PRIMARY KEY (`RID`)
    private String rnamr;//房间名
    private String rsetUid;//创建人ID
    private String rsetOfid;//创建人openforeID
    private String rtime;//创建时间
    private String rmemberUid;//房间成员ID
    private String rmemberOfid;//房间成员openfireID
    private String routUid;//已离开房间人员ID
    private String routOfid;//已离开房间成员openfireID
    private String rinvite;//邀请权限(1为有权限，0为无权限)
    private String rchange;//修改房间名称的权限
    private String roomOf;//房间openfirId
    private Integer roomStatus;//群状态（0：正常，-1：群解散）
    private Integer roomNo; //排序号
    private String roomRemark;//群公告
    private String roomIntroduce;//群简介


    public Integer getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(Integer roomNo) {
        this.roomNo = roomNo;
    }

    public String getRoomRemark() {
        return roomRemark;
    }

    public void setRoomRemark(String roomRemark) {
        this.roomRemark = roomRemark;
    }

    public String getRoomIntroduce() {
        return roomIntroduce;
    }

    public void setRoomIntroduce(String roomIntroduce) {
        this.roomIntroduce = roomIntroduce;
    }

    public String getRoomOf() {
		return roomOf;
	}

	public void setRoomOf(String roomOf) {
		this.roomOf = roomOf;
	}

	
    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getRnamr() {
        return rnamr;
    }

    public void setRnamr(String rnamr) {
        this.rnamr = rnamr == null ? null : rnamr.trim();
    }

    public String getRsetUid() {
        return rsetUid;
    }

    public void setRsetUid(String rsetUid) {
        this.rsetUid = rsetUid == null ? null : rsetUid.trim();
    }

    public String getRsetOfid() {
        return rsetOfid;
    }

    public void setRsetOfid(String rsetOfid) {
        this.rsetOfid = rsetOfid == null ? null : rsetOfid.trim();
    }

    public String getRtime() {
        return rtime;
    }

    public void setRtime(String rtime) {
        this.rtime = rtime == null ? null : rtime.trim();
    }

    public String getRmemberUid() {
        return rmemberUid;
    }

    public void setRmemberUid(String rmemberUid) {
        this.rmemberUid = rmemberUid == null ? null : rmemberUid.trim();
    }

    public String getRmemberOfid() {
        return rmemberOfid;
    }

    public void setRmemberOfid(String rmemberOfid) {
        this.rmemberOfid = rmemberOfid == null ? null : rmemberOfid.trim();
    }

    public String getRoutUid() {
        return routUid;
    }

    public void setRoutUid(String routUid) {
        this.routUid = routUid == null ? null : routUid.trim();
    }

    public String getRoutOfid() {
        return routOfid;
    }

    public void setRoutOfid(String routOfid) {
        this.routOfid = routOfid == null ? null : routOfid.trim();
    }

    public String getRinvite() {
        return rinvite==null?"":rinvite;
    }

    public void setRinvite(String rinvite) {
        this.rinvite = rinvite == null ? null : rinvite.trim();
    }

    public String getRchange() {
        return rchange;
    }

    public void setRchange(String rchange) {
        this.rchange = rchange == null ? null : rchange.trim();
    }

    public Integer getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(Integer roomStatus) {
        this.roomStatus = roomStatus;
    }
}