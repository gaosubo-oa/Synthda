package com.xoa.model.widget;

/**
 * Created by gsb on 2017/7/13.
 */
public class WidgetModel {

    // 主键
    private Integer id;

    // 模块中文名称
    private String name;

    // 对应的app模块
    private Integer aid;

    // 所属类别
    private Integer tid;

    // 该widget请求数据的时候英文参数
    private String data;

    // 是否允许其他类别使用1允许0不允许
    private String isSet;

    // IS_ON
    private String isOn;

    // NO
    private Integer no;

    // 图标
    private String img;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getIsSet() {
        return isSet;
    }

    public void setIsSet(String isSet) {
        this.isSet = isSet;
    }

    public String getIsOn() {
        return isOn;
    }

    public void setIsOn(String isOn) {
        this.isOn = isOn;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        WidgetModel that = (WidgetModel) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (aid != null ? !aid.equals(that.aid) : that.aid != null) return false;
        if (tid != null ? !tid.equals(that.tid) : that.tid != null) return false;
        if (data != null ? !data.equals(that.data) : that.data != null) return false;
        if (isSet != null ? !isSet.equals(that.isSet) : that.isSet != null) return false;
        if (isOn != null ? !isOn.equals(that.isOn) : that.isOn != null) return false;
        if (no != null ? !no.equals(that.no) : that.no != null) return false;
        return img != null ? img.equals(that.img) : that.img == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (aid != null ? aid.hashCode() : 0);
        result = 31 * result + (tid != null ? tid.hashCode() : 0);
        result = 31 * result + (data != null ? data.hashCode() : 0);
        result = 31 * result + (isSet != null ? isSet.hashCode() : 0);
        result = 31 * result + (isOn != null ? isOn.hashCode() : 0);
        result = 31 * result + (no != null ? no.hashCode() : 0);
        result = 31 * result + (img != null ? img.hashCode() : 0);
        return result;
    }
}
