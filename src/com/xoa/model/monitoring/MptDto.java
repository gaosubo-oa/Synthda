package com.xoa.model.monitoring;

public class MptDto {

    private String mptInfoName;//断面名称

    private String mptCateName;//指标名称

    private MptCate references;//特征指标

    public String getMptCateName() {
        return mptCateName;
    }

    public void setMptCateName(String mptCateName) {
        this.mptCateName = mptCateName;
    }

    public String getMptInfoName() {
        return mptInfoName;
    }

    public void setMptInfoName(String mptInfoName) {
        this.mptInfoName = mptInfoName;
    }

    public MptCate getReferences() {
        return references;
    }

    public void setReferences(MptCate references) {
        this.references = references;
    }
}
