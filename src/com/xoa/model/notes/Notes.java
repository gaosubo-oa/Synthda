package com.xoa.model.notes;

/**
 * Created by gsb on 2017/10/9.
 */
public class Notes {


    private Integer noteId;// 主键

    private Integer uid;//所属用户UID

    private String content;//便签内容

    private String color;//便签颜色

    private String showFlag;//OA精灵固定显示标记(0-不显示，1-第一次显示，2-始终显示)

    private Integer createTime;//创建时间

    private Integer editTime;//最后修改时间

    public Integer getNoteId() {
        return noteId;
    }

    public void setNoteId(Integer noteId) {
        this.noteId = noteId;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getShowFlag() {
        return showFlag;
    }

    public void setShowFlag(String showFlag) {
        this.showFlag = showFlag;
    }

    public Integer getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Integer createTime) {
        this.createTime = createTime;
    }

    public Integer getEditTime() {
        return editTime;
    }

    public void setEditTime(Integer editTime) {
        this.editTime = editTime;
    }
}
